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

class Pdfgen_DailyReport_cm {
  /////////////////////////////////////-------------------->(รายงานประจำวัน PDF)
  static void displayPdf_DailyReport_cm(
      context,
      renTal_name,
      Value_Report,
      Pre_and_Dow,
      _verticalGroupValue_NameFile,
      NameFile_,
      _TransReBillModels,
      TransReBillModels,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      Value_selectDate) async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();
    var nFormat = NumberFormat("#,##0.00", "en_US");
    final tableHeaders = [
      'ลำดับ',
      'วันที่',
      'รูปแบบชำระ',
      'รายการ',
      'Vat%',
      'หน่วย',
      'VAT',
      '70%',
      '30%',
      'ราคาก่อนVat',
      'ราคารวมVat',
    ];
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    // final tableData1 = [
    //   for (int i = 0; i < 10; i++)
    //     [
    //       '1',
    //       '2',
    //       '3',
    //       '4',
    //       '5',
    //       '6',
    //       '7',
    //       '8',
    //       '9',
    //       '10',
    //     ],
    // ];
    double Sum_Ramt_ = 0.0;
    double Sum_Ramtd_ = 0.0;
    double Sum_Amt_ = 0.0;
    double Sum_Total_ = 0.0;

    for (int indexsum1 = 0;
        indexsum1 < _TransReBillModels.length;
        indexsum1++) {
      Sum_Ramt_ = Sum_Ramt_ + double.parse(_TransReBillModels[indexsum1].ramt!);

      Sum_Ramtd_ =
          Sum_Ramtd_ + double.parse(_TransReBillModels[indexsum1].ramtd!);

      Sum_Amt_ = Sum_Amt_ + double.parse(_TransReBillModels[indexsum1].amt!);

      Sum_Total_ =
          Sum_Total_ + double.parse(_TransReBillModels[indexsum1].total_bill!);
    }
    doc.addPage(
      pw.MultiPage(
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(
                // PdfPageFormat.a4.width, PdfPageFormat.a4.height,
                //   marginAll: 20
                PdfPageFormat.a4.height,
                PdfPageFormat.a4.width,
                marginAll: 20),
        header: (context) {
          return pw.Row(
            children: [
              (netImage.isEmpty)
                  ? pw.Container(
                      height: 72,
                      width: 70,
                      color: PdfColors.grey200,
                      child: pw.Center(
                        child: pw.Text(
                          '$renTal_name ',
                          maxLines: 1,
                          style: pw.TextStyle(
                            fontSize: 8,
                            font: ttf,
                            color: PdfColors.grey300,
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
                      '$renTal_name',
                      maxLines: 2,
                      style: pw.TextStyle(
                        fontSize: 14.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                    pw.Text(
                      '$bill_addr',
                      maxLines: 3,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        color: PdfColors.grey800,
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
                    // pw.Text(
                    //   'ใบเสนอราคา',
                    //   style: pw.TextStyle(
                    //     fontSize: 12.00,
                    //     fontWeight: pw.FontWeight.bold,
                    //     font: ttf,
                    //   ),
                    // ),
                    // pw.Text(
                    //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                    //   textAlign: pw.TextAlign.right,
                    //   style: pw.TextStyle(
                    //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                    // ),
                    pw.Text(
                      'โทรศัพท์: $bill_tel',
                      textAlign: pw.TextAlign.right,
                      maxLines: 1,
                      style: pw.TextStyle(
                          fontSize: 10.0, font: ttf, color: PdfColors.grey800),
                    ),
                    pw.Text(
                      'อีเมล: $bill_email',
                      maxLines: 1,
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 10.0, font: ttf, color: PdfColors.grey800),
                    ),
                    pw.Text(
                      'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                      maxLines: 2,
                      style: pw.TextStyle(
                          fontSize: 10.0, font: ttf, color: PdfColors.grey800),
                    ),
                    pw.Text(
                      'วันที่:  $Value_selectDate',
                      maxLines: 2,
                      style: pw.TextStyle(
                          fontSize: 10.0, font: ttf, color: PdfColors.grey800),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        build: (context) {
          return [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                pw.Divider(),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'รายงานประจำวัน',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 15.0,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.black),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                // pw.Center(
                //   child: pw.Container(
                //     child: pw.Column(
                //       children: [
                //         pw.Text(
                //           '${Value_Report}',
                //           style: pw.TextStyle(
                //             fontSize: 20.0,
                //             font: ttf,
                //             color: PdfColors.grey900,
                //             fontWeight: pw.FontWeight.bold,
                //           ),
                //           // style: pw.TextStyle(fontSize: 30),
                //         ),
                //         pw.Text(
                //           '${renTal_name}',
                //           style: pw.TextStyle(
                //             fontSize: 14.0,
                //             font: ttf,
                //             color: PdfColors.grey900,
                //             // fontWeight: pw.FontWeight.bold,
                //           ),
                //         ),
                //         pw.Text(
                //           'วันที่:  $thaiDate ${DateTime.now().year + 543}',
                //           style: pw.TextStyle(
                //             fontSize: 12.0,
                //             font: ttf,
                //             color: PdfColors.grey900,
                //             // fontWeight: pw.FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // pw.Row(
                //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                //   children: [
                //     pw.Column(
                //       children: [
                //         pw.Image(
                //           pw.MemoryImage(iconImage),
                //           height: 70,
                //           width: 70,
                //         ),
                //         pw.Text('${renTal_name}',
                //             style: pw.TextStyle(
                //                 fontSize: 10.0,
                //                 font: ttf,
                //                 color: PdfColors.grey900)
                //             // style: pw.TextStyle(fontSize: 30),
                //             ),
                //       ],
                //     ),
                //     pw.Text('${Value_Report}',
                //         style: pw.TextStyle(
                //           fontSize: 20.0,
                //           font: ttf,
                //           color: PdfColors.grey900,
                //           fontWeight: pw.FontWeight.bold,
                //         )
                //         // style: pw.TextStyle(fontSize: 30),
                //         ),
                //     pw.Column(
                //       children: [
                //         pw.Text('วันที่ : ${day_}',
                //             style: pw.TextStyle(
                //                 fontSize: 10.0,
                //                 font: ttf,
                //                 color: PdfColors.grey900)
                //             // style: pw.TextStyle(fontSize: 30),
                //             ),
                //         pw.Text('เวลา : ${Tim_}',
                //             style: pw.TextStyle(
                //                 fontSize: 10.0,
                //                 font: ttf,
                //                 color: PdfColors.grey900)
                //             // style: pw.TextStyle(fontSize: 30),
                //             ),
                //       ],
                //     )
                //   ],
                // ),
                // pw.SizedBox(height: 1 * PdfPageFormat.mm),
                // pw.Divider(),
                // pw.SizedBox(height: 1 * PdfPageFormat.mm),
                // pw.Table.fromTextArray(
                //   headers: tableHeaders,
                //   data: tableData1,
                //   border: null,
                //   headerStyle: pw.TextStyle(
                //       fontSize: 10.0,
                //       fontWeight: pw.FontWeight.bold,
                //       font: ttf,
                //       color: PdfColors.green900),
                //   headerDecoration: const pw.BoxDecoration(
                //     color: PdfColors.green100,
                //     border: pw.Border(
                //       bottom: pw.BorderSide(color: PdfColors.green900),
                //     ),
                //   ),
                //   cellStyle: pw.TextStyle(
                //       fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                //   cellHeight: 25.0,
                //   cellAlignments: {
                //     0: pw.Alignment.centerLeft,
                //     1: pw.Alignment.centerRight,
                //     2: pw.Alignment.centerRight,
                //     3: pw.Alignment.centerRight,
                //     4: pw.Alignment.centerRight,
                //     5: pw.Alignment.centerRight,
                //     6: pw.Alignment.centerRight,
                //     7: pw.Alignment.centerRight,
                //     8: pw.Alignment.centerRight,
                //     9: pw.Alignment.centerRight,
                //     10: pw.Alignment.centerRight,
                //     11: pw.Alignment.centerRight,
                //   },
                // ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Container(
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Container(
                              // decoration: const pw.BoxDecoration(
                              //   color: PdfColors.green100,
                              // ),
                              padding: const pw.EdgeInsets.all(4.0),
                              child: pw.Text(
                                'ยอดรวม',
                                style: pw.TextStyle(
                                    fontSize: 14.0,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.green900),
                              ),
                            ),
                          ],
                        ),
                        pw.Container(
                          height: 25.0,
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
                                child: pw.Text('รวม 70%',
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        color: PdfColors.green900)),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Text('รวม 30%',
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        color: PdfColors.green900)),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Text('รวมราคาก่อน Vat',
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        color: PdfColors.green900)),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Text('รวมราคารวม Vat',
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        color: PdfColors.green900)),
                              ),
                            ],
                          ),
                        ),
                        pw.Container(
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  height: 25,
                                  decoration: const pw.BoxDecoration(
                                    color: PdfColors.grey100,
                                    border: pw.Border(
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey300),
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      '${nFormat.format(Sum_Ramt_)}',
                                      textAlign: pw.TextAlign.center,
                                      maxLines: 2,
                                      style: pw.TextStyle(
                                          fontSize: 10.0,
                                          font: ttf,
                                          color: PdfColors.grey900),
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
                                    border: pw.Border(
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey300),
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      '${nFormat.format(Sum_Ramtd_)}',
                                      textAlign: pw.TextAlign.center,
                                      maxLines: 2,
                                      style: pw.TextStyle(
                                          fontSize: 10.0,
                                          font: ttf,
                                          color: PdfColors.grey900),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  height: 25,
                                  decoration: const pw.BoxDecoration(
                                    color: PdfColors.grey100,
                                    border: pw.Border(
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey300),
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      '${nFormat.format(Sum_Amt_)}',
                                      textAlign: pw.TextAlign.center,
                                      maxLines: 2,
                                      style: pw.TextStyle(
                                          fontSize: 10.0,
                                          font: ttf,
                                          color: PdfColors.grey900),
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
                                    border: pw.Border(
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey300),
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      '${nFormat.format(Sum_Total_)}',
                                      textAlign: pw.TextAlign.center,
                                      maxLines: 2,
                                      style: pw.TextStyle(
                                          fontSize: 10.0,
                                          font: ttf,
                                          color: PdfColors.grey900),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Container(
                      // decoration: const pw.BoxDecoration(
                      //   color: PdfColors.green100,
                      // ),
                      padding: const pw.EdgeInsets.all(4.0),
                      child: pw.Text(
                        'รายละเอียด',
                        style: pw.TextStyle(
                            fontSize: 14.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green900),
                      ),
                    ),
                  ],
                ),

                for (int index1 = 0;
                    index1 < _TransReBillModels.length;
                    index1++)
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(4, 0, 4, 4),
                    child: pw.Container(
                      child: pw.Column(
                        children: [
                          pw.Container(
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Container(
                                  // decoration: const pw.BoxDecoration(
                                  //   color: PdfColors.green100,
                                  // ),
                                  padding: const pw.EdgeInsets.all(4.0),
                                  child: pw.Text(
                                    _TransReBillModels[index1].doctax == ''
                                        ? '${index1 + 1}. เลขที่ใบเสร็จ: ${_TransReBillModels[index1].docno}'
                                        : '${index1 + 1}. เลขที่ใบเสร็จ: ${_TransReBillModels[index1].doctax}',
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColors.green900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            height: 25.0,
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.green100,
                              border: pw.Border(
                                bottom:
                                    pw.BorderSide(color: PdfColors.green900),
                              ),
                            ),
                            child: pw.Row(
                              children: [
                                for (int i = 0; i < tableHeaders.length; i++)
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Text('${tableHeaders[i]}',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: PdfColors.green900)),
                                  ),
                              ],
                            ),
                          ),
                          for (int index2 = 0;
                              index2 < TransReBillModels[index1].length;
                              index2++)
                            pw.Container(
                              // color: PdfColors.grey200,
                              // padding: const pw.EdgeInsets.all(4.0),
                              child: pw.Row(
                                children: [
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      height: 25,
                                      decoration: const pw.BoxDecoration(
                                        color: PdfColors.grey100,
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          '${index1 + 1}.${index2 + 1}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
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
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          '${TransReBillModels[index1][index2].date}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      height: 25,
                                      decoration: const pw.BoxDecoration(
                                        color: PdfColors.grey100,
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          '${TransReBillModels[index1][index2].type}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      height: 25,
                                      decoration: const pw.BoxDecoration(
                                        color: PdfColors.grey100,
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          '${TransReBillModels[index1][index2].expname}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
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
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          '${TransReBillModels[index1][index2].nvat}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      height: 25,
                                      decoration: const pw.BoxDecoration(
                                        color: PdfColors.grey100,
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          '${TransReBillModels[index1][index2].vtype}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
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
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          '${nFormat.format(double.parse(TransReBillModels[index1][index2].vat!))}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      height: 25,
                                      decoration: const pw.BoxDecoration(
                                        color: PdfColors.grey100,
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          (TransReBillModels[index1][index2]
                                                      .ramt
                                                      .toString() ==
                                                  'null')
                                              ? '-'
                                              : '${nFormat.format(double.parse(TransReBillModels[index1][index2].ramt!))}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
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
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          (TransReBillModels[index1][index2]
                                                      .ramtd
                                                      .toString() ==
                                                  'null')
                                              ? '-'
                                              : '${nFormat.format(double.parse(TransReBillModels[index1][index2].ramtd!))}',
                                          maxLines: 2,
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      height: 25,
                                      decoration: const pw.BoxDecoration(
                                        color: PdfColors.grey100,
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          maxLines: 2,
                                          '${nFormat.format(double.parse(TransReBillModels[index1][index2].amt!))}',
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
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
                                        border: pw.Border(
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey300),
                                        ),
                                      ),
                                      child: pw.Center(
                                        child: pw.Text(
                                          maxLines: 2,
                                          '${nFormat.format(double.parse(TransReBillModels[index1][index2].total!))}',
                                          style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              color: PdfColors.grey900),
                                        ),
                                      ),
                                    ),
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
          ];
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              // pw.Text(
              //   '{fname_}',
              //   textAlign: pw.TextAlign.right,
              //   style: pw.TextStyle(
              //     fontSize: 10,
              //     font: ttf,
              //     color: PdfColors.grey800,
              //     // fontWeight: pw.FontWeight.bold
              //   ),
              // ),
              pw.Text(
                'หน้า ${context.pageNumber} / ${context.pagesCount} ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 10,
                  font: ttf,
                  color: PdfColors.grey800,
                  // fontWeight: pw.FontWeight.bold
                ),
              ),
            ],
          );
        },
      ),
    );
    ////////////---------------------------------------------->
    final List<int> bytes = await doc.save();
    final Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.PDF;
    ////////////---------------------------------------------->
    if (Pre_and_Dow == 'Download') {
      ////////////---------------------------------------------->
      if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
        final dir = await FileSaver.instance.saveFile(
            "${Value_Report}(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
            data,
            "pdf",
            mimeType: type);
      } else {
        final dir = await FileSaver.instance
            .saveFile("${NameFile_}", data, "pdf", mimeType: type);
      }
      ////////////---------------------------------------------->
    } else {
      // open Preview Screen
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) =>
      //           PreviewReportScreen(doc: doc, Status_: '${Value_Report}'),
      //     ));
    }
    ////////////---------------------------------------------->
  }
}
