import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import '../CRC_16_Prompay/generate_qrcode.dart';
import '../ChaoArea/ChaoAreaRenew_Screen.dart';
import '../Constant/Myconstant.dart';
import '../PeopleChao/Bills_.dart';
import '../PeopleChao/Pays_.dart';
import '../Style/ThaiBaht.dart';

class PdfgeCancel_Rental {
  static void exportPDF_Cancel_Rental(
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
      TeNant_ciddoc,
      TeNant_qutser,
      TeNant_verticalGroupValue,
      newValuePDFimg,
      Formbecause_cancel,
      quotxSelectModels,
      transKonModels,
      TitleType_Default_Receipt_Name,
      cc_date,
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
    final thaiDate = DateTime.parse(cc_date.toString());
    final formatter = DateFormat('d MMMM', 'th_TH');
    final formattedDate = formatter.format(thaiDate);
    //////--------------->พ.ศ.
    DateTime dateTime = DateTime.parse(cc_date.toString());
    int newYear = dateTime.year + 543;
    //////--------------------------------------------->
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    List netImage_QR = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }

////////////////------------------------------->
    double total_ = 0.0;
    for (int index = 0; index < quotxSelectModels.length; index++)
      total_ = total_ +
          (int.parse(quotxSelectModels[index].term!) *
              double.parse(quotxSelectModels[index].total!));
////////////////------------------------------->

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
                      if (TitleType_Default_Receipt_Name != null)
                        pw.Text(
                          '[ $TitleType_Default_Receipt_Name ]',
                          maxLines: 1,
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey400,
                          ),
                        ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        'ใบยกเลิกสัญญาเช่า',
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
                        'เลขที่ : $TeNant_ciddoc',
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
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ใบยกเลิกสัญญาเช่าพื้นที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: 14,
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 4 * PdfPageFormat.mm),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Text(
                '# ข้อมูลเกี่ยวกับผู้ให้เช่า',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 12.00,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                    color: PdfColors.black),
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          right: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          top: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          bottom: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                        ),
                      ),
                      // decoration: const pw.BoxDecoration(
                      //     color: PdfColors.green100,
                      //     // color: PdfColors.grey200,
                      //     border: pw.Border(
                      //         bottom: pw.BorderSide(
                      //       color: PdfColors.grey600,
                      //       width: 1.0, // Underline thickness
                      //     ))),
                      padding: const pw.EdgeInsets.all(4.0),
                      child: pw.Text(
                        'ข้อมูลผู้ให้เช่า',
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
              padding: const pw.EdgeInsets.fromLTRB(1.0, 0, 1.0, 1.0),
              child: pw.Container(
                  decoration: const pw.BoxDecoration(
                    // color: PdfColors.green100,
                    border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      right:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      // top: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      bottom:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                    ),
                  ),
                  // decoration: const pw.BoxDecoration(
                  //     color: PdfColors.green100,
                  //     // color: PdfColors.grey200,
                  //     border: pw.Border(
                  //         bottom: pw.BorderSide(
                  //       color: PdfColors.grey600,
                  //       width: 1.0, // Underline thickness
                  //     ))),
                  padding: const pw.EdgeInsets.all(5.0),
                  child: pw.Column(
                    children: [
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ชื่อผู้ให้เช่า/บริษัท : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$bill_name',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ID/TAX ID : ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                (bill_tax.toString() == '' || bill_tax == null)
                                    ? '0'
                                    : '$bill_tax',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'เบอร์โทร : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$bill_tel',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'อีเมล : ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$bill_email',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ที่อยู่ : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                (bill_addr == null ||
                                        bill_addr.toString() == 'null' ||
                                        bill_addr.toString() == '')
                                    ? '-'
                                    : '$bill_addr',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    ],
                  )),
            ),
            pw.SizedBox(height: 4 * PdfPageFormat.mm),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Text(
                '# ข้อมูลเกี่ยวกับผู้เช่า และพื้นที่เช่า',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 12.00,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                    color: PdfColors.black),
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          right: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          top: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          bottom: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                        ),
                      ),
                      padding: const pw.EdgeInsets.all(4.0),
                      child: pw.Text(
                        'ข้อมูลผู้เช่า/พื้นที่เช่า',
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
              padding: const pw.EdgeInsets.fromLTRB(1.0, 0, 1.0, 1.0),
              child: pw.Container(
                  decoration: const pw.BoxDecoration(
                    // color: PdfColors.green100,
                    border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      right:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      // top: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      bottom:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                    ),
                  ),
                  // decoration: const pw.BoxDecoration(
                  //     color: PdfColors.green100,
                  //     // color: PdfColors.grey200,
                  //     border: pw.Border(
                  //         bottom: pw.BorderSide(
                  //       color: PdfColors.grey600,
                  //       width: 1.0, // Underline thickness
                  //     ))),
                  padding: const pw.EdgeInsets.all(5.0),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      // pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      // pw.Container(
                      //   decoration: const pw.BoxDecoration(
                      //     // color: PdfColors.green100,
                      //     border: pw.Border(
                      //       left: pw.BorderSide(
                      //           color: PdfColors.grey600, width: 0.5),
                      //       right: pw.BorderSide(
                      //           color: PdfColors.grey600, width: 0.5),
                      //       top: pw.BorderSide(
                      //           color: PdfColors.grey600, width: 0.5),
                      //       bottom: pw.BorderSide(
                      //           color: PdfColors.grey600, width: 0.5),
                      //     ),
                      //   ),
                      //   padding: const pw.EdgeInsets.all(2.0),
                      //   // width: 100,
                      //   child: pw.Text(
                      //     '# ข้อมูลผู้เช่า ',
                      //     style: pw.TextStyle(
                      //       fontSize: font_Size,
                      //       fontWeight: pw.FontWeight.bold,
                      //       font: ttf,
                      //       color: Colors_pd,
                      //     ),
                      //   ),
                      // ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ประเภท : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_verticalGroupValue',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'เลขที่สัญญา : ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_ciddoc',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ชื่อร้าน : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_nameshop',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ประเภทร้านค้า :',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_typeshop',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ชื่อผู้เช่า/บริษัท : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_bussshop',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ชื่อผู้ติดต่อ :',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_bussscontact',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ที่อยู่ : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_address',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'เบอร์โทร : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_tel',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'อีเมล :',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_email',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ID/TAX ID : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              // decoration: pw.BoxDecoration(
                              //     border: pw.Border(
                              //         bottom: pw.BorderSide(
                              //   color: Colors_pd,
                              //   width: 1.0, // Underline thickness
                              // ))),
                              child: pw.Text(
                                '$TeNant_tax',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      // pw.Container(
                      //   decoration: const pw.BoxDecoration(
                      //     // color: PdfColors.green100,
                      //     border: pw.Border(
                      //       left: pw.BorderSide(
                      //         color: PdfColors.grey600,
                      //         width: 0.2,
                      //       ),
                      //       right: pw.BorderSide(
                      //           color: PdfColors.grey600, width: 0.2),
                      //       top: pw.BorderSide(
                      //           color: PdfColors.grey600, width: 0.2),
                      //       bottom: pw.BorderSide(
                      //           color: PdfColors.grey600, width: 0.2),
                      //     ),
                      //   ),
                      //   padding: const pw.EdgeInsets.all(2.0),
                      //   // width: 100,
                      //   child: pw.Text(
                      //     '# พื้นที่เช่า ',
                      //     style: pw.TextStyle(
                      //       fontSize: font_Size,
                      //       fontWeight: pw.FontWeight.bold,
                      //       font: ttf,
                      //       color: Colors_pd,
                      //     ),
                      //   ),
                      // ),
                      pw.SizedBox(height: 6 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'รหัสพื้นที่เช่า : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_ln',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'โซนพื้นที่เช่า :',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_zn',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'รวมพื้นที่เช่า: ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_area (ตร.ม.)',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'จำนวนพื้นที่ :',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_qty ',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // pw.SizedBox(height: 4 * PdfPageFormat.mm),
                      // pw.Row(children: [
                      //   pw.Expanded(
                      //     flex: 1,
                      //     child: pw.Container(
                      //       decoration: pw.BoxDecoration(
                      //           color: PdfColors.green100,
                      //           border: pw.Border(
                      //               bottom: pw.BorderSide(
                      //             color: PdfColors.green900,
                      //             width: 1.0, // Underline thickness
                      //           ))),
                      //       padding: const pw.EdgeInsets.all(8.0),
                      //       child: pw.Text(
                      //         'ข้อมูลสัญญา/เสนอราคา',
                      //         textAlign: pw.TextAlign.center,
                      //         style: pw.TextStyle(
                      //             fontSize: 10.0,
                      //             fontWeight: pw.FontWeight.bold,
                      //             font: ttf,
                      //             color: PdfColors.green900),
                      //       ),
                      //     ),
                      //   )
                      // ]),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'วันที่เริ่มสัญญา/เสนอราคา : ',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_sdate',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'วันที่สิ้นสุดสัญญา/เสนอราคา :',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_ldate',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ประเภทการเช่า :',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_rtname',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Container(
                            width: 100,
                            child: pw.Text(
                              'ระยะเวลาการเช่า :',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                color: PdfColors.grey200,
                                width: 1.0, // Underline thickness
                              ))),
                              child: pw.Text(
                                '$TeNant_period',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    ],
                  )),
            ),
            pw.SizedBox(height: 4 * PdfPageFormat.mm),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Text(
                '# เหตุผล/หมายเหตุ ของการยกเลิกสัญญาเช่ากับผู้เช่า',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 12.00,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                    color: PdfColors.black),
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          right: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          top: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                          bottom: pw.BorderSide(
                              color: PdfColors.grey600, width: 0.5),
                        ),
                      ),
                      padding: const pw.EdgeInsets.all(4.0),
                      child: pw.Text(
                        'เหตุผล/หมายเหตุ การยกเลิกสัญญาเช่า',
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
              padding: const pw.EdgeInsets.fromLTRB(1.0, 0, 1.0, 1.0),
              child: pw.Container(
                  decoration: const pw.BoxDecoration(
                    // color: PdfColors.green100,
                    border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      right:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      // top: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      bottom:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                    ),
                  ),
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 2 * PdfPageFormat.mm),
                              pw.Text(
                                'เหตุผล/หมายเหตุ :  $Formbecause_cancel',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  // decoration: pw.TextDecoration.underline,
                                  fontSize: font_Size,
                                  // fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                              pw.SizedBox(height: 2 * PdfPageFormat.mm),
                            ]),
                      )
                    ],
                  )),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
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
      ),
    );
    pageCount++;
    pdf.addPage(pw.MultiPage(
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
                      'ใบยกเลิกสัญญาเช่า',
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
                      'เลขที่ : $TeNant_ciddoc',
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
          pw.Padding(
            padding: const pw.EdgeInsets.all(1.0),
            child: pw.Text(
              '# รายละเอียดรายการที่ผู้เช่าค้างชำระ',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                  fontSize: 12.00,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                  color: PdfColors.black),
            ),
          ),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Center(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                pw.Container(
                  height: 25,
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      right:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      top: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      bottom:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                    ),
                  ),
                  // decoration: const pw.BoxDecoration(
                  //   color: PdfColors.green100,
                  //   border: pw.Border(
                  //     bottom: pw.BorderSide(color: PdfColors.green900),
                  //   ),
                  // ),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 35,
                        // decoration: const pw.BoxDecoration(
                        //   color: PdfColors.grey100,
                        //   border: const pw.Border(
                        //     bottom: pw.BorderSide(color: PdfColors.grey300),
                        //   ),
                        // ),
                        child: pw.Center(
                          child: pw.Text(
                            'ลำดับ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: Colors_pd,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'เลขที่สัญญา',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'รหัสพื้นที่',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'ชื่อผู้เช่า/บริษัท',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'ชื่อผู้ติดต่อ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.white,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'รายการค้างชำระ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.white,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'จำนวนเงินค้างชำระ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Table(
                    border: const pw.TableBorder(
                        left:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        right:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        verticalInside: pw.BorderSide(
                            width: 0.5,
                            color: PdfColors.grey600,
                            style: pw.BorderStyle.solid)),
                    children: [
                      for (int index = 0; index < 1; index++)
                        pw.TableRow(children: [
                          pw.Container(
                            width: 35,
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
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  '$TeNant_ciddoc',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: Colors_pd,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  '$TeNant_ln',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: Colors_pd,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Align(
                                  alignment: pw.Alignment.topCenter,
                                  child: pw.Text(
                                    '$TeNant_bussshop',
                                    //  '${transKonModels[index].daterec}',
                                    maxLines: 2,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                ),
                              )),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Align(
                                  alignment: pw.Alignment.topCenter,
                                  child: pw.Text(
                                    '$TeNant_bussscontact',
                                    maxLines: 2,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                ),
                              )),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Align(
                                  alignment: pw.Alignment.topCenter,
                                  child: pw.Text(
                                    '0',
                                    maxLines: 2,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                ),
                              )),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Align(
                                  alignment: pw.Alignment.topRight,
                                  child: pw.Text(
                                    '0.00',
                                    maxLines: 2,
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                ),
                              )),
                        ]),
                    ]),
                pw.Container(
                    height: 20,
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        left:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        right:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        top:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        bottom:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      ),
                    ),
                    padding: const pw.EdgeInsets.all(2.0),
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
                                color: PdfColors.black),
                          ),
                          pw.Expanded(
                            flex: 5,
                            child: pw.Text(
                              //"${nFormat2.format(double.parse(Total.toString()))}";
                              '(~${convertToThaiBaht(0.00)}~)',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                fontStyle: pw.FontStyle.italic,
                                // decoration:
                                //     pw.TextDecoration.lineThrough,
                                color: PdfColors.black,
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
                                      flex: 1,
                                      child: pw.Text(
                                        'ยอดรวมสุทธิ',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            fontSize: font_Size,
                                            color: PdfColors.black),
                                      ),
                                    ),
                                    pw.Text(
                                      '${nFormat.format(0.00)}',
                                      // '${Total}',
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          fontSize: font_Size,
                                          color: PdfColors.black),
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
              ])),
          pw.Padding(
            padding: const pw.EdgeInsets.all(1.0),
            child: pw.Text(
              '# รายละเอียดการคืนเงินประกันกับผู้เช่า',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                  fontSize: 12.00,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                  color: PdfColors.black),
            ),
          ),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Center(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                pw.Container(
                  height: 25,
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      right:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      top: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      bottom:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                    ),
                  ),
                  // decoration: const pw.BoxDecoration(
                  //   color: PdfColors.green100,
                  //   border: pw.Border(
                  //     bottom: pw.BorderSide(color: PdfColors.green900),
                  //   ),
                  // ),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 35,
                        // decoration: const pw.BoxDecoration(
                        //   color: PdfColors.grey100,
                        //   border: const pw.Border(
                        //     bottom: pw.BorderSide(color: PdfColors.grey300),
                        //   ),
                        // ),
                        child: pw.Center(
                          child: pw.Text(
                            'ลำดับ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: Colors_pd,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'เลขที่ใบเสร็จ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'วันที่',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'สัญญา',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'ชื่อผู้เช่า/บริษัท',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.white,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'ช่องทางชำระ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.white,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'จำนวนเงิน',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Table(
                    border: pw.TableBorder(
                        left:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        right:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        verticalInside: pw.BorderSide(
                            width: 0.5,
                            color: PdfColors.grey600,
                            style: pw.BorderStyle.solid)),
                    children: [
                      if (transKonModels.length == 0)
                        pw.TableRow(children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  'ไม่พบข้อมูล',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: Colors_pd,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      if (transKonModels.length != 0)
                        for (int index = 0;
                            index < transKonModels.length;
                            index++)
                          pw.TableRow(children: [
                            pw.Container(
                              width: 35,
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
                                    color: Colors_pd,
                                  ),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Align(
                                  alignment: pw.Alignment.topCenter,
                                  child: pw.Text(
                                    '${transKonModels[index].docno}',
                                    maxLines: 2,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topCenter,
                                    child: pw.Text(
                                      '${DateFormat('dd-MM').format(DateTime.parse('${transKonModels[index].daterec}'))}-${DateTime.parse('${transKonModels[index].daterec}').year + 543}',
                                      //  '${transKonModels[index].daterec}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topCenter,
                                    child: pw.Text(
                                      '${transKonModels[index].cid}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topCenter,
                                    child: pw.Text(
                                      '${transKonModels[index].cname}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topCenter,
                                    child: pw.Text(
                                      '${transKonModels[index].type}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topRight,
                                    child: pw.Text(
                                      '${nFormat.format(double.parse(transKonModels[index].total!))}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.right,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                          ]),
                    ]),
                pw.Container(
                    height: 20,
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        left:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        right:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        top:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        bottom:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      ),
                    ),
                    padding: const pw.EdgeInsets.all(2.0),
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
                                color: PdfColors.black),
                          ),
                          pw.Expanded(
                            flex: 5,
                            child: pw.Text(
                              //"${nFormat2.format(double.parse(Total.toString()))}";
                              '(~${convertToThaiBaht(0.00)}~)',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                fontStyle: pw.FontStyle.italic,
                                // decoration:
                                //     pw.TextDecoration.lineThrough,
                                color: PdfColors.black,
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
                                      flex: 1,
                                      child: pw.Text(
                                        'ยอดรวมสุทธิ',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            fontSize: font_Size,
                                            color: PdfColors.black),
                                      ),
                                    ),
                                    pw.Text(
                                      '${nFormat.format(0.00)}',
                                      // '${Total}',
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          fontSize: font_Size,
                                          color: PdfColors.black),
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
              ])),
          pw.Padding(
            padding: const pw.EdgeInsets.all(1.0),
            child: pw.Text(
              '# รายละเอียดค่าบริการ ตลอดสัญญาเช่ากับผู้เช่า',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                  fontSize: 12.00,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                  color: PdfColors.black),
            ),
          ),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  height: 25,
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      right:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      top: pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      bottom:
                          pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                    ),
                  ),
                  // decoration: const pw.BoxDecoration(
                  //   color: PdfColors.green100,
                  //   border: pw.Border(
                  //     bottom: pw.BorderSide(color: PdfColors.green900),
                  //   ),
                  // ),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 35,
                        // decoration: const pw.BoxDecoration(
                        //   color: PdfColors.grey100,
                        //   border: const pw.Border(
                        //     bottom: pw.BorderSide(color: PdfColors.grey300),
                        //   ),
                        // ),
                        child: pw.Center(
                          child: pw.Text(
                            'ลำดับ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: Colors_pd,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'งวด',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 5,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.white,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'รายการ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'วันที่',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.white,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'ยอด/งวด',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          // decoration: const pw.BoxDecoration(
                          //   color: PdfColors.grey100,
                          //   border: const pw.Border(
                          //     bottom: pw.BorderSide(color: PdfColors.grey300),
                          //   ),
                          // ),
                          child: pw.Center(
                            child: pw.Text(
                              'ยอด',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Table(
                    border: pw.TableBorder(
                        left:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        right:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        verticalInside: pw.BorderSide(
                            width: 0.5,
                            color: PdfColors.grey600,
                            style: pw.BorderStyle.solid)),
                    children: [
                      if (quotxSelectModels.length == 0)
                        pw.TableRow(children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  'ไม่พบข้อมูล',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: Colors_pd,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      if (quotxSelectModels.length != 0)
                        for (int index = 0;
                            index < quotxSelectModels.length;
                            index++)
                          pw.TableRow(children: [
                            pw.Container(
                              width: 35,
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  '${index + 1}',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: Colors_pd,
                                  ),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Align(
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Text(
                                    '${quotxSelectModels[index].unit} / ${quotxSelectModels[index].term} (งวด)',
                                    maxLines: 2,
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            pw.Expanded(
                                flex: 5,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topLeft,
                                    child: pw.Text(
                                      '${quotxSelectModels[index].expname}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topCenter,
                                    child: pw.Text(
                                      '${DateFormat('dd-MM').format(DateTime.parse('${quotxSelectModels[index].sdate}'))}-${DateTime.parse('${quotxSelectModels[index].sdate}').year + 543} - ${DateFormat('dd-MM').format(DateTime.parse('${quotxSelectModels[index].ldate}'))}-${DateTime.parse('${quotxSelectModels[index].ldate}').year + 543} ',
                                      //  '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].ldate!} 00:00:00'))}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topRight,
                                    child: pw.Text(
                                      '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.right,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topRight,
                                    child: pw.Text(
                                      '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
                                      maxLines: 2,
                                      textAlign: pw.TextAlign.right,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ),
                                )),
                          ]),
                    ]),
                pw.Container(
                    height: 20,
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        left:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        right:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        top:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                        bottom:
                            pw.BorderSide(color: PdfColors.grey600, width: 0.5),
                      ),
                    ),
                    padding: const pw.EdgeInsets.all(2.0),
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
                                color: PdfColors.black),
                          ),
                          pw.Expanded(
                            flex: 5,
                            child: pw.Text(
                              //"${nFormat2.format(double.parse(Total.toString()))}";
                              '(~${convertToThaiBaht(total_)}~)',
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                fontStyle: pw.FontStyle.italic,
                                // decoration:
                                //     pw.TextDecoration.lineThrough,
                                color: PdfColors.black,
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
                                      flex: 1,
                                      child: pw.Text(
                                        'ยอดรวมสุทธิ',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            fontSize: font_Size,
                                            color: PdfColors.black),
                                      ),
                                    ),
                                    pw.Text(
                                      '${nFormat.format(total_)}',
                                      // '${Total}',
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          fontSize: font_Size,
                                          color: PdfColors.black),
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
              ],
            ),
          ),
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
    ));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPdfgen_Billsplay(
              doc: pdf, title: 'ใบยกเลิกสัญญาเช่า($TeNant_ciddoc)'),
        ));
  }
}
