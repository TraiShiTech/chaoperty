// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
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
  /////////////////////////////////////-------------------->(QR)
  static void displayPdf_QR(
      context, renTal_name, zone_name, teNantModels, name) async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    var Colors_pd = PdfColors.black;
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();
    final iconImage =
        (await rootBundle.load('images/pngegg2.png')).buffer.asUint8List();
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
                      : 'โซนพื้นที่เช่า : $name',
                  maxLines: 1,
                  style: pw.TextStyle(
                    fontSize: 14.0,
                    font: ttf,
                    color: Colors_pd,
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
                    color: Colors_pd,
                  ),
                ),
              ),
            ],
          );
        },
        build: (context) {
          return [
            //  for (int index = 0; index < teNantModels.length; index++)

            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children:
                  List.generate((teNantModels.length / 3).ceil(), (rowIndex) {
                int indexx_ = 0;
                int startIndex = rowIndex * 3;
                int endIndex = startIndex + 3;
                if (endIndex > teNantModels.length) {
                  endIndex = teNantModels.length;
                }

                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: List.generate(endIndex - startIndex, (index) {
                    return pw.Container(
                      width: 240, // Adjust the width as per your requirement
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
                      child: pw.Padding(
                          padding: pw.EdgeInsets.all(8.0),
                          child: pw.Container(
                            width: 240,
                            // height: 135,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.only(
                                  topLeft: pw.Radius.circular(10),
                                  topRight: pw.Radius.circular(10),
                                  bottomLeft: pw.Radius.circular(10),
                                  bottomRight: pw.Radius.circular(10)),
                              border: pw.Border.all(
                                color: PdfColor.fromInt(
                                    0xFF666464), // White border color
                                width: 1.0, // Border width
                              ),
                            ),
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Container(
                                    height: 110,
                                    width: 193,
                                    // height: 135,
                                    decoration: pw.BoxDecoration(
                                      borderRadius: pw.BorderRadius.only(
                                          topLeft: pw.Radius.circular(10),
                                          topRight: pw.Radius.circular(0),
                                          bottomLeft: pw.Radius.circular(10),
                                          bottomRight: pw.Radius.circular(0)),
                                      color: PdfColors.white,
                                      image: pw.DecorationImage(
                                        image: pw.MemoryImage(iconImage),
                                        fit: pw.BoxFit.cover,
                                      ),
                                    ),
                                    child: pw.Column(
                                      children: [
                                        pw.Container(
                                          color: PdfColors.white,
                                          // width: 120,
                                          child: pw.Text(
                                            '$renTal_name',
                                            maxLines: 1,
                                            style: pw.TextStyle(
                                              fontSize: 8.0,
                                              color: PdfColors.black,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          color: PdfColors.white,
                                          // width: 60,
                                          child: pw.Text(
                                            ' ${teNantModels[startIndex + index].sdate} ถึง ${teNantModels[startIndex + index].ldate}',
                                            maxLines: 1,
                                            style: pw.TextStyle(
                                              fontSize: 7.0,
                                              color: PdfColors.black,
                                              font: ttf,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        // pw.Container(
                                        //   // width: 120,
                                        //   child: pw.Text(
                                        //     ' ${teNantModels[startIndex + index].sdate} ถึง ${teNantModels[startIndex + index].ldate}',
                                        //     maxLines: 2,
                                        //     style: pw.TextStyle(
                                        //       fontSize: 5.0,
                                        //       color: PdfColors.black,
                                        //       font: ttf,
                                        //       // fontWeight: FontWeight.bold,
                                        //     ),
                                        //   ),
                                        // ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.center,
                                          children: [
                                            pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                              child: pw.Container(
                                                color: PdfColors.white,
                                                child: pw.Column(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.center,
                                                  children: [
                                                    pw.Align(
                                                      alignment:
                                                          pw.Alignment.topLeft,
                                                      child: pw.Container(
                                                        child: pw.BarcodeWidget(
                                                            data:
                                                                "${teNantModels[startIndex + index].cid}",
                                                            barcode: pw.Barcode
                                                                .qrCode(),
                                                            width: 65,
                                                            height: 70),

                                                        //  pw.PrettyQr(
                                                        //   // typeNumber: 3,
                                                        //   image: const AssetImage(
                                                        //     "images/Icon-chao.png",
                                                        //   ),
                                                        //   size: 110,
                                                        //   data: '${teNantModels[index].cid}',
                                                        //   errorCorrectLevel: QrErrorCorrectLevel.M,
                                                        //   roundEdges: true,
                                                        // ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.fromLTRB(
                                                      4, 0, 0, 4),
                                              child: pw.Container(
                                                // decoration:
                                                //     BoxDecoration(
                                                //   image:
                                                //       DecorationImage(
                                                //     image: NetworkImage("https://www.kindpng.com/picc/m/266-2660257_dotted-background-png-image-free-download-searchpng-white.png"),
                                                //     fit: BoxFit.cover,
                                                //   ),
                                                // ),
                                                width: 90,
                                                child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    // pw.SizedBox(
                                                    //   height: 5.0,
                                                    // ),
                                                    // const Text(
                                                    //   'เลขสัญญา',
                                                    //   style: TextStyle(
                                                    //     fontSize: 10.0,
                                                    //     color: PeopleChaoScreen_Color.Colors_Text1_,
                                                    //     // fontWeight: FontWeight.bold,
                                                    //     fontFamily: Font_.Fonts_T,
                                                    //   ),
                                                    // ),
                                                    pw.Text(
                                                      '${teNantModels[startIndex + index].cid}',
                                                      style: pw.TextStyle(
                                                        fontSize: 9.0,
                                                        color: PdfColors.black,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                        font: ttf,
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      'ชื่อผู้ติดต่อ',
                                                      style: pw.TextStyle(
                                                        fontSize: 8.0,
                                                        color: PdfColors.black,
                                                        font: ttf,
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      '${teNantModels[startIndex + index].cname}',
                                                      maxLines: 1,
                                                      style: pw.TextStyle(
                                                        fontSize: 9.0,
                                                        color: PdfColors.black,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                        font: ttf,
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      'ชื่อร้านค้า',
                                                      style: pw.TextStyle(
                                                        fontSize: 8.0,
                                                        color: PdfColors.black,
                                                        font: ttf,
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      '${teNantModels[startIndex + index].sname}',
                                                      maxLines: 1,
                                                      style: pw.TextStyle(
                                                        fontSize: 9.0,
                                                        color: PdfColors.black,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                        font: ttf,
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      teNantModels[startIndex +
                                                                      index]
                                                                  .ln_c ==
                                                              null
                                                          ? teNantModels[startIndex +
                                                                          index]
                                                                      .ln_q ==
                                                                  null
                                                              ? ''
                                                              : 'พื้นที่ :${teNantModels[startIndex + index].ln_q}( ${teNantModels[startIndex + index].zn} )'
                                                          : 'พื้นที่ :${teNantModels[startIndex + index].ln_c}( ${teNantModels[startIndex + index].zn} )',

                                                      // 'พื้นที่ : ${teNantModels[startIndex + index].ln} ( ${teNantModels[startIndex + index].zn} )',
                                                      maxLines: 1,
                                                      style: pw.TextStyle(
                                                        fontSize: 8.0,
                                                        color: PdfColors.black,
                                                        font: ttf,
                                                      ),
                                                    ),
                                                    // Text(
                                                    //   ' ${teNantModels[index].sdate} ถึง ${teNantModels[index].ldate}',
                                                    //   maxLines: 2,
                                                    //   style: const TextStyle(
                                                    //     fontSize: 8.0,
                                                    //     color: PeopleChaoScreen_Color.Colors_Text1_,
                                                    //     // fontWeight: FontWeight.bold,
                                                    //     fontFamily: Font_.Fonts_T,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // pw.Align(
                                        //   alignment: pw.Alignment.centerLeft,
                                        //   child: pw.Container(
                                        //     // width: 120,
                                        //     child: pw.Text(
                                        //       ' ${teNantModels[startIndex + index].sdate} ถึง ${teNantModels[startIndex + index].ldate}',
                                        //       maxLines: 2,
                                        //       style: pw.TextStyle(
                                        //         fontSize: 6.0,
                                        //         color: PdfColors.black,
                                        //         font: ttf,
                                        //         // fontWeight: FontWeight.bold,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    )),
                                pw.Container(
                                  height: 110,
                                  width: 23.5,
                                  decoration: const pw.BoxDecoration(
                                    color: PdfColors.green300,
                                    borderRadius: pw.BorderRadius.only(
                                      topLeft: pw.Radius.circular(0),
                                      topRight: pw.Radius.circular(10),
                                      bottomLeft: pw.Radius.circular(0),
                                      bottomRight: pw.Radius.circular(10),
                                    ),
                                  ),
                                  // child: pw.Align(
                                  //   alignment: pw.Alignment.center,
                                  //   child: pw.Transform.rotate(
                                  //     angle: -math.pi / 2,
                                  //     child: pw.Align(
                                  //       alignment: pw.Alignment.center,
                                  //       child: pw.Container(
                                  //           child: pw.Row(
                                  //         children: [
                                  //           pw.Text(
                                  //             '$renTal_name',
                                  //             maxLines: 1,
                                  //             style: pw.TextStyle(
                                  //               fontSize: 8.0,
                                  //               color: PdfColors.white,
                                  //               font: ttf,
                                  //               fontWeight: pw.FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )),
                                  //     ),
                                  //   ),
                                  // ),
                                )
                              ],
                            ),
                          )),
                    );
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
                  color: Colors_pd,
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
    // final dir = await FileSaver.instance
    //     .saveFile("Generator QR $name", data, "pdf", mimeType: type);
    ////////////---------------------------------------------->
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewChaoAreaScreen(doc: doc, Status_: 'Generator QR $name'),
        ));
  }
}
