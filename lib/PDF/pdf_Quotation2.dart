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

import '../ChaoArea/ChaoAreaBid_Screen.dart';
import '../ChaoArea/ChaoAreaRenew_Screen.dart';
import '../Constant/Myconstant.dart';
import '../Responsive/responsive.dart';

class Pdfgen_Quotation2 {
  static void exportPDF_Quotation2(
      context,
      NumberArea_,
      QtyArea,
      Sdate_,
      ldate_,
      rental_type_,
      Value_rental_type_,
      Form_nameshop_,
      Form_bussshop_,
      _Form_address_,
      Form_tel_,
      Form_email_,
      Form_tax_,
      expTypeModels_,
      quotxSelectModels_,
      fname_user_,
      renTal_name,
      newValue,
      newValuePDFimg,
      newValuePDFimg2,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      docno,
      _route) async {
    ////
    //// ------------>(ใบเสนอราคา)
    ///////
    int Value_AreaSer_ = 0;
    bool foundNonMatching = false;
    var nFormat = NumberFormat("#,##0.00", "en_US");
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");

    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    ///////////////////////------------------------------------------------->
    String urlcheck =
        'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg';
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    List netImage2 = [];

    for (int i = 0; i < newValuePDFimg2.length; i++) {
      netImage2.add(await networkImage('${newValuePDFimg2[i]}'));
    }
    final tableHeaders = [
      'ประเภทค่าบริการ',
      'ความถี่',
      'จำนวนงวด',
      'วันเริ่มต้น',
      'วันยอด(บาท)',
      'VAT',
      'ยอดสุทธิ(บาท)',
    ];
    final tableHeaders2 = [
      'ประเภทค่าบริการที่ต้องการปรับ',
      'ความถี่',
      'จำนวนวันที่ช้ากว่ากำหนด',
      'วิธีคิดค่าปรับ',
      'ยอดปรับ',
      // 'VAT',
      // 'ยอดสุทธิ(บาท)',
    ];

    final tableHeaders3 = [
      'งวด',
      'วันที่',
      'รายการ',
      'ยอดงวด',
      'ยอด',
      // 'VAT฿',
      // '',
      // 'WHT%',
      // 'WHT%฿',
      // 'ยอดสุทธิ',
    ];

    pdf.addPage(
      pw.MultiPage(
        maxPages: 200,
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
                // pw.Column(
                //   mainAxisSize: pw.MainAxisSize.min,
                //   crossAxisAlignment: pw.CrossAxisAlignment.start,
                //   children: [
                //     pw.Text(
                //       'บริษัทดีเซนทริค จำกัด(Dzentric co., ltd.)',
                //       style: pw.TextStyle(
                //         fontSize: 14.0,
                //         fontWeight: pw.FontWeight.bold,
                //         font: ttf,
                //       ),
                //     ),
                //     pw.Text(
                //       '1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                //       style: pw.TextStyle(
                //         fontSize: 10.0,
                //         color: PdfColors.grey700,
                //         font: ttf,
                //       ),
                //     ),
                //   ],
                // ),
                pw.Spacer(),
                pw.Container(
                  width: 180,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'ใบเสนอราคา',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 11.0,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.black),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'เลขที่:$docno',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey900),
                      ),
                      // pw.Text(
                      //   'วันที่: ${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
                      //   textAlign: pw.TextAlign.right,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0,
                      //       font: ttf,
                      //       color: PdfColors.grey900),
                      // ),
                      pw.Text(
                        'ณ วันที่:  $thaiDate ${DateTime.now().year + 543}',
                        maxLines: 2,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
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
                        '$renTal_name',
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.green),
                      ),
                      pw.Text(
                        'ที่อยู่ : $bill_addr',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey900),
                      ),
                      pw.Text(
                        'อีเมล: $bill_email',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey900),
                      ),
                      pw.Text(
                        'เบอร์โทร: $bill_tel',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey900),
                      ),
                      pw.Text(
                        'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey900),
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
                        'ผู้เสนอราคา',
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.green),
                      ),
                      pw.Text(
                        '$fname_user_',
                        style: pw.TextStyle(
                          fontSize: 12.00,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(children: [
              pw.Text(
                'เรียน: $Form_bussshop_',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                    fontSize: 10.0,
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey900),
              ),
            ]),
            pw.Row(children: [
              pw.Text(
                'ชื่อร้านค้า: $Form_nameshop_',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                    fontSize: 10.0,
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey900),
              ),
            ]),
            pw.Row(children: [
              pw.Text(
                'ที่อยู่:$_Form_address_',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                    fontSize: 10.0,
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey900),
              ),
            ]),
            pw.Row(children: [
              pw.Text(
                'Tel: $Form_tel_ E-mail: $Form_email_',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                    fontSize: 10.0,
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey900),
              ),
            ]),
            pw.Row(children: [
              pw.Text(
                'เลขประจำตัวผู้เสียภาษี: $Form_tax_',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                    fontSize: 10.0,
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey900),
              ),
            ]),
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
                        'โซนพื้นที่: $NumberArea_',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                      pw.Text(
                        'รหัสพื้นที่: $NumberArea_ ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                      pw.Text(
                        'ชื้อพื้นที่: $NumberArea_',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'พื้นที่เช่า: ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'รวมพื้นที่เช่า: $QtyArea ตร.ม.',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'ระยะเวลาการเช่า: ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'ประเภทการเช่า: $Value_rental_type_ ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                      pw.Text(
                        'อายุสัญญา: $rental_type_',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                      pw.Text(
                        'วันที่เริ่มสัญญา: $Sdate_',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                      pw.Text(
                        'วันที่หมดสัญญา: $ldate_ ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                    ],
                  )),
              pw.Expanded(
                  flex: 1,
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'ภาพตัวอย่างพื้นที่เบื้องต้น',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey900),
                      ),
                      pw.Row(
                        children: [
                          if (newValuePDFimg.length >= 1 &&
                              newValuePDFimg[0].toString() !=
                                  urlcheck.toString())
                            pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Image((netImage[0]),
                                    height: 60, width: 60)),
                          if (newValuePDFimg.length >= 1 &&
                              newValuePDFimg[0].toString() ==
                                  urlcheck.toString())
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2),
                              child: pw.Container(
                                height: 60,
                                width: 60,
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
                            ),
                          if (newValuePDFimg.length >= 2 &&
                              newValuePDFimg[1].toString() !=
                                  urlcheck.toString())
                            pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Image((netImage[1]),
                                    height: 60, width: 60)),
                          if (newValuePDFimg.length >= 2 &&
                              newValuePDFimg[1].toString() ==
                                  urlcheck.toString())
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2),
                              child: pw.Container(
                                height: 60,
                                width: 60,
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
                            ),
                          if (newValuePDFimg.length >= 3 &&
                              newValuePDFimg[2].toString() !=
                                  urlcheck.toString())
                            pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Image((netImage[2]),
                                    height: 60, width: 60)),
                          if (newValuePDFimg.length >= 3 &&
                              newValuePDFimg[2].toString() ==
                                  urlcheck.toString())
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2),
                              child: pw.Container(
                                height: 60,
                                width: 60,
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
                            ),
                        ],
                      )
                    ],
                  )),
            ]),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Text(
              'ค่าบริการ: ',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: 10.0,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green),
            ),
            pw.SizedBox(height: 8 * PdfPageFormat.mm),

            // /
            // / PDF Table Create
            // /
            for (int Ser_Sub = 0; Ser_Sub < expTypeModels_.length; Ser_Sub++)
              pw.Container(
                child: pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          '3.${expTypeModels_[Ser_Sub].ser} ${expTypeModels_[Ser_Sub].bills}',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    // for (int index = 0;
                    //     index < quotxSelectModels_.length;
                    //     index++)
                    // (expTypeModels_[Ser_Sub].ser ==
                    //         quotxSelectModels_[index].exptser)
                    //     ?
                    pw.Table.fromTextArray(
                      headers: tableHeaders,
                      data: [
                        for (int index = 0;
                            index < quotxSelectModels_.length;
                            index++)
                          (expTypeModels_[Ser_Sub].ser ==
                                  quotxSelectModels_[index].exptser)
                              ? [
                                  '${quotxSelectModels_[index].expname}',

                                  //////////---------------------------------------->
                                  '${quotxSelectModels_[index].unit}',
                                  //////////////------------------->
                                  '${quotxSelectModels_[index].term}',
                                  /////////---------------------------------->
                                  '${DateFormat('dd').format(DateTime.parse('${quotxSelectModels_[index].sdate!} 00:00:00'))}',
                                  ////////////---------------------------------------->
                                  (int.parse(quotxSelectModels_[index]
                                              .sunit!) ==
                                          6)
                                      ? '0.00'
                                      : '${nFormat.format(double.parse(quotxSelectModels_[index].amt!))}',
                                  //////////-------------------------------------->
                                  (expTypeModels_[Ser_Sub].ser !=
                                          quotxSelectModels_[index].exptser)
                                      ? ''
                                      : '${quotxSelectModels_[index].vat}',
                                  /////////////////-------------------------------------->
                                  (expTypeModels_[Ser_Sub].ser !=
                                          quotxSelectModels_[index].exptser)
                                      ? ''
                                      : '${nFormat.format(double.parse(quotxSelectModels_[index].total!))}',
                                ]
                              : []
                      ],
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
                        1: pw.Alignment.centerRight,
                        2: pw.Alignment.centerRight,
                        3: pw.Alignment.centerRight,
                        4: pw.Alignment.centerRight,
                        5: pw.Alignment.centerRight,
                        6: pw.Alignment.centerRight,
                        7: pw.Alignment.centerRight,
                        8: pw.Alignment.centerRight,
                      },
                    ),
                    pw.SizedBox(height: 4 * PdfPageFormat.mm),
                    // pw.Divider(color: PdfColors.grey),
                    pw.SizedBox(height: 8 * PdfPageFormat.mm),
                  ],
                ),
              ),
            pw.SizedBox(height: 8 * PdfPageFormat.mm),
            pw.Container(
              child: pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'ตารางสรุปรายละเอียดค่าบริการ',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                  // for (int index = 0;
                  //     index < quotxSelectModels_.length;
                  //     index++)
                  // (expTypeModels_[Ser_Sub].ser ==
                  //         quotxSelectModels_[index].exptser)
                  //     ?
                  // pw.Table.fromTextArray(
                  //   headers: tableHeaders3,
                  //   data: [
                  //     for (int index = 0; index < newValue.length; index++)
                  //       [
                  //         '${newValue[index]['serial']}',
                  //         '${newValue[index]['date']}',
                  //         '${newValue[index]['expname']}',
                  //         '${newValue[index]['vtype']}',
                  //         '${newValue[index]['nvat']}',
                  //         '${newValue[index]['vat']}',
                  //         '${newValue[index]['pvat']}',
                  //         '${newValue[index]['nwht']}',
                  //         '${newValue[index]['wht']}',
                  //         '${newValue[index]['total']}',
                  //       ]

                  //     // for (int index = 0;
                  //     //     index < quotxSelectModels_.length;
                  //     //     index++)
                  //     //   for (var i = 0;
                  //     //       i < int.parse(quotxSelectModels_[index].term!);
                  //     //       i++)
                  //     //     [
                  //     //       // '${quotxSelectModels_[index].unit} / ${quotxSelectModels_[index].term} (งวด)',
                  //     //       // '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels_[index].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels_[index].ldate!} 00:00:00'))}',
                  //     //       // '${quotxSelectModels_[index].expname}',
                  //     //       // '${nFormat.format(double.parse(quotxSelectModels_[index].total!))}',
                  //     //       // '${nFormat.format(int.parse(quotxSelectModels_[index].term!) * double.parse(quotxSelectModels_[index].total!))}',

                  //     //       '${(i + 1)}',
                  //     //       '${DateFormat('dd').format(DateTime.parse('${quotxSelectModels_[index].sdate!} 00:00:00'))}-${DateFormat('MM-yyyy').format(DateTime.parse('${quotxSelectModels_[index].sdate!} 00:00:00').add(Duration(days: int.parse('${quotxSelectModels_[index].day}') * i)))}',
                  //     //       '${quotxSelectModels_[index].expname!}',
                  //     //       '${quotxSelectModels_[index].vtype!}',
                  //     //       '${quotxSelectModels_[index].nvat!} %',
                  //     //       '${quotxSelectModels_[index].vat!}',
                  //     //       '${nFormat.format(double.parse(quotxSelectModels_[index].pvat!))}',
                  //     //       '${quotxSelectModels_[index].nwht!}',
                  //     //       '${quotxSelectModels_[index].wht!}',
                  //     //       '${nFormat.format(double.parse(quotxSelectModels_[index].total!))}',
                  //     //     ]
                  //   ],
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
                  //   cellDecoration:
                  //       (int rowIndex, dynamic record, int columnIndex) {
                  //     return pw.BoxDecoration(
                  //       color: (rowIndex % 2 == 0)
                  //           ? PdfColors.grey100
                  //           : PdfColors.white,
                  //       border: const pw.Border(
                  //         bottom: pw.BorderSide(color: PdfColors.grey300),
                  //       ),
                  //     );
                  //   },
                  //   cellStyle: pw.TextStyle(
                  //       fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  //   cellHeight: 25.0,
                  //   cellAlignments: {
                  //     0: pw.Alignment.centerLeft,
                  //     1: pw.Alignment.center,
                  //     2: pw.Alignment.center,
                  //     3: pw.Alignment.center,
                  //     4: pw.Alignment.center,
                  //     5: pw.Alignment.center,
                  //     6: pw.Alignment.center,
                  //     7: pw.Alignment.center,
                  //     8: pw.Alignment.centerRight,
                  //   },
                  // ),
                  pw.Container(
                    height: 25,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.green100,
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.green900),
                      ),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text(
                            'งวด',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'วันที่ชำระ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'ประเภทค่าบริการ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'VAT',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'VAT(%)',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'VAT(฿)',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            '',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'WHT (%)',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'WHT (฿)',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'ยอดสุทธิ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.green900),
                          ),
                        ),
                      ],
                    ),
                  ),

                  for (int index = 0; index < newValue.length; index++)
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            height: 25,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.grey100,
                              border: const pw.Border(
                                bottom: pw.BorderSide(color: PdfColors.grey300),
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                '${newValue[index]['serial']}',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 8.0,
                                    font: ttf,
                                    // fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.black),
                              ),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            height: 25,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: const pw.Border(
                                bottom: pw.BorderSide(color: PdfColors.grey300),
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                '${newValue[index]['date']}',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 8.0,
                                    font: ttf,
                                    // fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.black),
                              ),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 25,
                              decoration: pw.BoxDecoration(
                                color: PdfColors.grey100,
                                border: const pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  '${newValue[index]['expname']}',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      fontSize: 8.0,
                                      font: ttf,
                                      // fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              )),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 25,
                              decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  '${newValue[index]['vtype']}',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 8.0,
                                      font: ttf,
                                      // fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              )),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 25,
                              decoration: pw.BoxDecoration(
                                color: PdfColors.grey100,
                                border: const pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  '${newValue[index]['nvat']}',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 8.0,
                                      font: ttf,
                                      // fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              )),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 25,
                              decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  '${newValue[index]['vat']}',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 8.0,
                                      font: ttf,
                                      // fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              )),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 25,
                              decoration: pw.BoxDecoration(
                                color: PdfColors.grey100,
                                border: const pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  '${newValue[index]['pvat']}',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 8.0,
                                      font: ttf,
                                      // fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              )),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 25,
                              decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  '${newValue[index]['nwht']}',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 8.0,
                                      font: ttf,
                                      // fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              )),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 25,
                              decoration: pw.BoxDecoration(
                                color: PdfColors.grey100,
                                border: const pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  '${newValue[index]['wht']}',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 8.0,
                                      font: ttf,
                                      // fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              )),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 25,
                              decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  '${newValue[index]['total']}',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: 8.0,
                                      font: ttf,
                                      // fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              )),
                        ),
                      ],
                    ),

                  pw.SizedBox(height: 4 * PdfPageFormat.mm),
                  // pw.Divider(color: PdfColors.grey),
                  pw.SizedBox(height: 8 * PdfPageFormat.mm),
                ],
              ),
            ),
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
          builder: (context) => PreviewPdfgen_quotationChoarea(
              doc: pdf,
              renTal_name: renTal_name,
              route_: _route,
              docno_: docno),
        ));
  }
}
