import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../ChaoArea/ChaoAreaRenew_Screen.dart';

class Pdfgen_DataChaoArea {
  static void exportPDF_DataChaoArea(
      context,
      NumberArea_,
      QtyArea,
      fname_user_,
      renTal_name,
      newValuePDFimg,
      newValuePDFimg2,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name) async {
    ////
    //// ------------>(ใบเสนอราคา),
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    var Colors_pd = PdfColors.black;

    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    List netImage2 = [];

    for (int i = 0; i < newValuePDFimg2.length; i++) {
      netImage2.add(await networkImage('${newValuePDFimg2[i]}'));
    }
    String urlcheck =
        'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg';
    ///////////////////////------------------------------------------------->
    final tableHeaders = [
      'ประเภท',
      'ความถี่',
      'จำนวนงวด',
      'วันที่เริ่ม',
      'VAT',
      'WHT ',
      'ยอดสุทธิ',
    ];

    final tableData1 = [
      for (int i = 0; i < 5; i++)
        [
          'XXXXXX ${i + 1}',
          '7',
          '\200',
          '\1000',
          '\1000',
          '\1000',
          '\1000',
        ],
    ];
    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          return pw.Column(children: [
            pw.Row(
              children: [
                // pw.Image(
                //   pw.MemoryImage(iconImage),
                //   height: 72,
                //   width: 72,
                // ),
                (netImage2.isEmpty)
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
                        (netImage2[0]),
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
                          fontSize: 10.0,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'ที่อยู่: $bill_addr',
                        maxLines: 3,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          color: Colors_pd,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'โทรศัพท์: $bill_tel',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'อีเมล: $bill_email',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (bill_tax.toString() == '' ||
                                bill_tax == null ||
                                bill_tax.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี: 0'
                            : 'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10.0,
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
                        'ข้อมูลพื้นที่',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: 11.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'รหัสพื้นที่: ${NumberArea_}',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),

                      pw.Text(
                        'ณ วันที่:  $thaiDate ${DateTime.now().year + 543}',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]);
        },
        build: (context) {
          return [
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Expanded(
                  flex: 2,
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'ข้อมูลพื้นที่',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'โซนพื้นที่ : ${NumberArea_}',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'รหัสพื้นที่: ${NumberArea_}',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'ชื้อพื้นที่ : ${NumberArea_}',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'พื้นที่เช่า : ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'รวมพื้นที่เช่า (ตร.ม.) : $QtyArea',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'ระยะเวลาการเช่ามาตราฐาน : ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'ประเภทการเช่า : รายเดือน ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'อายุสัญญา : 12 เดือน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  )),
              pw.Expanded(
                  flex: 1,
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      // pw.Image(
                      //   pw.MemoryImage(iconImage),
                      //   height: 200,
                      //   width: 200,
                      // ),
                      // pw.Image(
                      //   pw.MemoryImage(iconImage),
                      //   height: 200,
                      //   width: 200,
                      // ),
                      // pw.Image(
                      //   pw.MemoryImage(iconImage),
                      //   height: 200,
                      //   width: 200,
                      // ),
                      // pw.Image(
                      //   pw.MemoryImage(iconImage),
                      //   height: 200,
                      //   width: 200,
                      // ),
                      // pw.Image(
                      //   pw.MemoryImage(iconImage),
                      //   height: 200,
                      //   width: 200,
                      // ),
                    ],
                  )),
            ]),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Text(
              'ค่าบริการหลัก : ',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: 10.0,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ค่าเช่าต่องวด : 20,000',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: 10.0,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ภาพตัวอย่างพื้นที่เบื้องต้น',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 10.0,
                      font: ttf,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.green),
                ),
              ],
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Container(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      if (newValuePDFimg[0].toString() != urlcheck.toString())
                        if (newValuePDFimg.length >= 1 ||
                            netImage[0].toString() != 'null' ||
                            netImage[0].toString() != '' ||
                            newValuePDFimg[0].toString() != urlcheck.toString())
                          pw.SizedBox(
                            child: pw.Image((netImage[0]),
                                height: 100, width: 150, fit: pw.BoxFit.cover),
                          ),
                      // if (newValuePDFimg.length >= 1)
                      if (newValuePDFimg.length >= 1 ||
                          netImage[0].toString() == 'null' ||
                          netImage[0].toString() == '' ||
                          newValuePDFimg[0].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),

                      if (newValuePDFimg.length >= 2 &&
                          newValuePDFimg[1].toString() != urlcheck.toString())
                        pw.SizedBox(
                          child: pw.Image((netImage[1]),
                              height: 100, width: 150, fit: pw.BoxFit.cover),
                        ),

                      if (newValuePDFimg.length >= 2 &&
                          newValuePDFimg[1].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),

                      if (newValuePDFimg.length >= 3 &&
                          newValuePDFimg[2].toString() != urlcheck.toString())
                        pw.SizedBox(
                          child: pw.Image((netImage[2]),
                              height: 100, width: 150, fit: pw.BoxFit.cover),
                        ),

                      if (newValuePDFimg.length >= 3 &&
                          newValuePDFimg[2].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      if (newValuePDFimg.length >= 4 &&
                          newValuePDFimg[3].toString() != urlcheck.toString())
                        pw.SizedBox(
                          child: pw.Image((netImage[3]),
                              height: 100, width: 150, fit: pw.BoxFit.cover),
                        ),
                      if (newValuePDFimg.length >= 4 &&
                          newValuePDFimg[3].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),
                      if (newValuePDFimg.length >= 5 &&
                          newValuePDFimg[4].toString() != urlcheck.toString())
                        pw.SizedBox(
                          child: pw.Image((netImage[4]),
                              height: 100, width: 150, fit: pw.BoxFit.cover),
                        ),
                      if (newValuePDFimg.length >= 5 &&
                          newValuePDFimg[4].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),
                      if (newValuePDFimg.length >= 6 &&
                          newValuePDFimg[5].toString() != urlcheck.toString())
                        pw.SizedBox(
                          child: pw.Image((netImage[5]),
                              height: 100, width: 150, fit: pw.BoxFit.cover),
                        ),
                      if (newValuePDFimg.length >= 6 &&
                          newValuePDFimg[5].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      if (newValuePDFimg.length >= 7 &&
                          newValuePDFimg[6].toString() != urlcheck.toString())
                        pw.SizedBox(
                          child: pw.Image((netImage[6]),
                              height: 100, width: 150, fit: pw.BoxFit.cover),
                        ),
                      if (newValuePDFimg.length >= 7 &&
                          newValuePDFimg[6].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),
                      if (newValuePDFimg.length >= 8 &&
                          newValuePDFimg[7].toString() != urlcheck.toString())
                        pw.SizedBox(
                          child: pw.Image((netImage[7]),
                              height: 100, width: 150, fit: pw.BoxFit.cover),
                        ),
                      if (newValuePDFimg.length >= 8 &&
                          newValuePDFimg[7].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),
                      if (newValuePDFimg.length >= 9 &&
                          newValuePDFimg[8].toString() != urlcheck.toString())
                        pw.SizedBox(
                          child: pw.Image((netImage[8]),
                              height: 100, width: 150, fit: pw.BoxFit.cover),
                        ),
                      if (newValuePDFimg.length >= 9 &&
                          newValuePDFimg[8].toString() == urlcheck.toString())
                        pw.Container(
                          height: 100,
                          width: 150,
                          color: PdfColors.grey,
                          child: pw.Center(
                            child: pw.Text(
                              'No Image',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
    // final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/name');
    // await file.writeAsBytes(bytes);
    // return file;
    //----------------------------------------->
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
          builder: (context) =>
              PreviewPdfgen_Agreement(doc: pdf, renTal_name: renTal_name),
        ));
  }
}
