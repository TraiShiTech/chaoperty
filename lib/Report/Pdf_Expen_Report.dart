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

import 'Report_Screen.dart';

class Pdfgen_ExpenseReport {
  /////////////////////////////////////-------------------->(รายงานรายจ่าย)
  static void displayPdf_ExpenseReport(context, renTal_name, Value_Report,
      Pre_and_Dow, _verticalGroupValue_NameFile, NameFile_) async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();

    final tableHeaders = [
      'ลำดับ',
      'หมวด',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 1 (รายงานรายจ่าย)',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 2',
      // 'ต.ค.',
      // 'พ.ย.',
      // 'ธ.ค.',
      // 'ผลรวมไตรมาส 3',
      // 'ต.ค.',
      // 'พ.ย.',
      // 'ธ.ค.',
      // 'ผลรวมไตรมาส 4',
      // 'รวม',
    ];
    final tableHeaders2 = [
      'ลำดับ',
      'หมวด',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 3',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 4',
    ];
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    final tableData1 = [
      for (int i = 0; i < 5; i++)
        [
          '${i + 1}',
          'สามารถนํารายรับจากรายงานเงินสดรับ-จ่าย',
          '300000',
          '400000',
          '500000',
          '600000',
          '700000',
          '800000',
          '900000',
          '1000000',
        ],
    ];

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
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Image(
                          pw.MemoryImage(iconImage),
                          height: 70,
                          width: 70,
                        ),
                        pw.Text('${renTal_name}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    ),
                    pw.Text('${Value_Report}',
                        style: pw.TextStyle(
                          fontSize: 20.0,
                          font: ttf,
                          color: PdfColors.grey900,
                          fontWeight: pw.FontWeight.bold,
                        )
                        // style: pw.TextStyle(fontSize: 30),
                        ),
                    pw.Column(
                      children: [
                        pw.Text('วันที่ : ${day_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                        pw.Text('เวลา : ${Tim_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    )
                  ],
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('ไตรมาสที่ 1 และ 2',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 12.0,
                        font: ttf,
                        color: PdfColors.grey900,
                        fontWeight: pw.FontWeight.bold,
                      )
                      // style: pw.TextStyle(fontSize: 30),
                      ),
                ),
                pw.Table.fromTextArray(
                  headers: tableHeaders,
                  data: tableData1,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.green900),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.green900),
                    ),
                  ),
                  cellDecoration:
                      (int rowIndex, dynamic record, int columnIndex) {
                    return pw.BoxDecoration(
                      color: (rowIndex % 2 == 0)
                          ? PdfColors.grey100
                          : PdfColors.white,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    );
                  },
                  cellStyle: pw.TextStyle(
                      fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  cellHeight: 25.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                  },
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('ไตรมาสที่ 3 และ 4',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 12.0,
                        font: ttf,
                        color: PdfColors.grey900,
                        fontWeight: pw.FontWeight.bold,
                      )
                      // style: pw.TextStyle(fontSize: 30),
                      ),
                ),
                pw.Table.fromTextArray(
                  headers: tableHeaders2,
                  data: tableData1,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.green900),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.green900),
                    ),
                  ),
                  cellDecoration:
                      (int rowIndex, dynamic record, int columnIndex) {
                    return pw.BoxDecoration(
                      color: (rowIndex % 2 == 0)
                          ? PdfColors.grey100
                          : PdfColors.white,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    );
                  },
                  cellStyle: pw.TextStyle(
                      fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  cellHeight: 25.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                  },
                ),
              ],
            ),
          ];
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount} ',
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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PreviewReportScreen(doc: doc, Status_: '${Value_Report}'),
          ));
    }
    ////////////---------------------------------------------->
  }
}
