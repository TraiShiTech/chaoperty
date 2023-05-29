import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:printing/printing.dart';

import '../Report/Report_Screen.dart';
import 'PeopleChao_Screen.dart';
import 'Rental_Information.dart';

class Pdfgen_QR_ {
  /////////////////////////////////////-------------------->(รายงานรายจ่าย)
  static void displayPdf_QR(
      context, renTal_name, teNantModels, netImage, zone_name) async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(
          // PdfPageFormat.a4.width, PdfPageFormat.a4.height,
          //   marginAll: 20
          PdfPageFormat.a4.height,
          PdfPageFormat.a4.width,
          // marginAll: 20
        ),
        header: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(4.0),
                child: pw.Text(
                  zone_name == null
                      ? 'โซนพื้นที่เช่า : ทั้งหมด'
                      : 'โซนพื้นที่เช่า : $zone_name',
                  maxLines: 1,
                  style: pw.TextStyle(
                    fontSize: 14.0,
                    font: ttf,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4.0),
                child: pw.Text(
                  ' ทั้งหมด : ${teNantModels.length}',
                  maxLines: 1,
                  style: pw.TextStyle(
                    fontSize: 14.0,
                    font: ttf,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ],
          );
        },
        build: (context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: List.generate((netImage.length / 3).ceil(), (rowIndex) {
                int indexx_ = 0;
                int startIndex = rowIndex * 3;
                int endIndex = startIndex + 3;
                if (endIndex > netImage.length) {
                  endIndex = netImage.length;
                }
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: List.generate(endIndex - startIndex, (index) {
                    return pw.Padding(
                        padding: const pw.EdgeInsets.all(4.0),
                        child: pw.Stack(
                          children: [
                            pw.Container(
                              width:
                                  270, // Adjust the width as per your requirement
                              // height:
                              //     200, // Adjust the height as per your requirement
                              decoration: pw.BoxDecoration(
                                // color:
                                //     PdfColor.fromInt(0xFF000000), // Black frame color
                                border: pw.Border.all(
                                  color: PdfColor.fromInt(
                                      0xFF666464), // White border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(4.0),
                              child: pw.Image(
                                  pw.MemoryImage(netImage[startIndex + index])),
                            ),
                            // pw.Positioned(
                            //   top: 0,
                            //   left: 0,
                            //   child: pw.Container(
                            //     width: 15.0,
                            //     height: 15.0,
                            //     decoration: pw.BoxDecoration(
                            //       color: PdfColor.fromInt(0xFF5A5858),
                            //       shape: pw.BoxShape.circle,
                            //     ),
                            //     child: pw.Center(
                            //       child: pw.Text('${(startIndex + index) + 1}',
                            //           style: pw.TextStyle(
                            //             color: PdfColor.fromInt(0xFFF3F1F1),
                            //           )),
                            //     ),
                            //   ),
                            // )
                          ],
                        ));
                  }),
                );
              }),
            )
          ];
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
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
    // final dir = await FileSaver.instance.saveFile(
    //     "QRRRRR(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);
    ////////////---------------------------------------------->
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewChaoAreaScreen(doc: doc, Status_: 'Generator QR'),
        ));
  }
}
