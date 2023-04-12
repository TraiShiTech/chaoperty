import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../ChaoArea/ChaoAreaRenew_Screen.dart';
import '../PeopleChao/Bills_.dart';

class Pdfgen_Quotation {
  //////////---------------------------------------------------->(ใบเสนอราคา)
  static void exportPDF_Quotation(context) async {
    ////
    //// ------------>(ใบเสนอราคา)
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

    final ttf = pw.Font.ttf(font);

    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    final tableHeaders = [
      'รายการ',
      'ราคา(บาท)',
      'จำนวน',
      'รวม(บาท)',
      // 'Total',
    ];

    final tableData = [
      for (int i = 0; i < 8; i++)
        [
          'XXXXXX ${i + 1}',
          '7',
          '\200',
          '\1000',
        ],
    ];
    ///////////////////////------------------------------------------------->
    final List<String> _digitThai = [
      'ศูนย์',
      'หนึ่ง',
      'สอง',
      'สาม',
      'สี่',
      'ห้า',
      'หก',
      'เจ็ด',
      'แปด',
      'เก้า'
    ];

    final List<String> _positionThai = [
      '',
      'สิบ',
      'ร้อย',
      'พัน',
      'หมื่น',
      'แสน',
      'ล้าน'
    ];
/////////////////////////////------------------------>(จำนวนเต็ม)
    String convertNumberToText(int number) {
      String result = '';
      int numberIntPart = number.toInt();
      int numberDecimalPart = ((number - numberIntPart) * 100).toInt();
      final List<String> digits = numberIntPart.toString().split('');
      int position = digits.length - 1;
      for (int i = 0; i < digits.length; i++) {
        final int digit = int.parse(digits[i]);
        if (digit != 0) {
          if (position == 6) {
            result = '$result${_positionThai[6]}';
          }
          if (position != 6 && position != 8) {
            if (digit == 1 && position == 1) {
              // result = '$resultเอ็ด';
              result = '$resultสิบ';
            } else {
              result =
                  '$result${_digitThai[digit]}${_positionThai[position % 6]}';
            }
          } else if (position == 8) {
            result = '$result${_digitThai[digit]}${_positionThai[6]}';
          }
        }
        position--;
      }
      // final String decimalText =
      //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
      return result;
    }

/////////////////////////////------------------------>(จำนวนทศนิยม สตางค์)
    String convertNumberToText2(int number2) {
      String result = '';
      int numberIntPart = number2.toInt();
      int numberDecimalPart = ((number2 - numberIntPart) * 100).toInt();
      final List<String> digits = numberIntPart.toString().split('');
      int position = digits.length - 1;
      for (int i = 0; i < digits.length; i++) {
        final int digit = int.parse(digits[i]);
        if (digit != 0) {
          if (position == 6) {
            result = '$result${_positionThai[6]}';
          }
          if (position != 6 && position != 8) {
            if (digit == 1 && position == 1) {
              // result = '$resultเอ็ด';
              result = '$resultสิบ';
            } else {
              result =
                  '$result${_digitThai[digit]}${_positionThai[position % 6]}';
            }
          } else if (position == 8) {
            result = '$result${_digitThai[digit]}${_positionThai[6]}';
          }
        }
        position--;
      }
      // final String decimalText =
      //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
      return result;
    }

////////////////----------------------------->(ตัด หน้าจุดกับหลังจุดออกจากกัน)
    var number_ = "14250.51";
    var parts = number_.split('.');
    var front = parts[0];
    var back = parts[1];

////////////////--------------------------------->(บาท)
    double number = double.parse(front);
    final int numberIntPart = number.toInt();
    final double numberDecimalPart = (number - numberIntPart) * 100;
    final String numberText = convertNumberToText(numberIntPart);
    final String decimalText = convertNumberToText(numberDecimalPart.toInt());
////////////////---------------------------------->(สตางค์)
    double number2 = double.parse(number_);
    final int numberIntPart2 = number.toInt();
    final int numberDecimalPart2 = ((number2 - numberIntPart2) * 100).round();
    final String numberText2 = convertNumberToText2(numberIntPart2);
    final String decimalText2 =
        convertNumberToText2(numberDecimalPart2.toInt());
////////////////------------------------------->(เช็คและเพิ่มตัวอักษร)
    final String formattedNumber = (decimalText2.replaceAll(
                _digitThai[0], "") ==
            '')
        ? '$numberTextบาทถ้วน'
        : (back[0].toString() == '0')
            ? '$numberTextบาทศูนย์${decimalText2.replaceAll(_digitThai[0], "")}สตางค์'
            : '$numberTextบาท${decimalText2.replaceAll(_digitThai[0], "")}สตางค์';

    String text_Number1 = formattedNumber;
    RegExp exp1 = RegExp(r"สองสิบ");
    if (exp1.hasMatch(text_Number1)) {
      text_Number1 = text_Number1.replaceAll(exp1, 'ยี่สิบ');
    }
    String text_Number2 = text_Number1;
    RegExp exp2 = RegExp(r"สิบหนึ่ง");
    if (exp2.hasMatch(text_Number2)) {
      text_Number2 = text_Number2.replaceAll(exp2, 'สิบเอ็ด');
    }
///////////////////////------------------------------------------------->
    pdf.addPage(
      pw.MultiPage(
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
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'บริษัทดีเซนทริค จำกัด(Dzentric co., ltd.)',
                      style: pw.TextStyle(
                        fontSize: 14.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                    pw.Text(
                      '1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        color: PdfColors.grey700,
                        font: ttf,
                      ),
                    ),
                  ],
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
                        'โทรศัพท์:0-5341-2616-9 ต่อ 123',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      ),
                      pw.Text(
                        'อีเมล: dzentric.com@gmail.com',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      ),
                      pw.Text(
                        'เลขประจำตัวผู้เสียภาษี: 1212312121',
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
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
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ใบเสนอราคา',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 11.0,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                  ),
                ),
              ],
            ),

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
                        'ชื่อผู้ซื้อ',
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'ทัศนะ คล้ายมณี',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      ),
                      pw.Text(
                        'ที่อยู่ : 50/167 หมู่บ้าน พฤกษวิลล์ 46/1 ต.xxxxx อ.xxxx จ.เชียงใหม่',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      ),
                      pw.Text(
                        'Tax ID: 999999999999',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      ),
                      pw.Text(
                        'Email : Dzebtric.com@gmail.com',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
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
                        'เลขที่อ้างอิง(Reference ID)',
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      ),
                      pw.Text(
                        'Payment-123456789',
                        style: pw.TextStyle(
                          fontSize: 12.00,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'วันที่ทำรายการ(Transation Date)',
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      ),
                      pw.Text(
                        ' ${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
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
            // pw.Text(
            //   'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
            //   textAlign: pw.TextAlign.justify,
            // ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(children: [
              pw.Text(
                'กรุณาชำระเงิน  ',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                  fontSize: 10.0,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ]),
            pw.Row(children: [
              pw.Text(
                'please pay : ',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                  fontSize: 10.0,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ]),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.Stack(
              children: [
                pw.Positioned(
                    left: 0,
                    bottom: 120,
                    child: pw.Transform.rotate(
                      angle: 15 * math.pi / 190,
                      child: pw.Text(
                        '© 2023  Dzentric Co.,Ltd. All Rights Reserved',
                        style: pw.TextStyle(
                            fontSize: 40, color: PdfColors.grey300),
                      ),
                      //         pw.Image(
                      //     pw.MemoryImage(iconImage),
                      //     height: 300,
                      //     width: 400,
                      //   ),
                      // )
                    )),
                pw.Container(
                  child: pw.Column(
                    children: [
                      pw.Table.fromTextArray(
                        headers: tableHeaders,
                        data: tableData,
                        border: null,
                        headerStyle: pw.TextStyle(
                            fontSize: 10.0,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.blue900),
                        headerDecoration: const pw.BoxDecoration(
                          color: PdfColors.blue100,
                          border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.blue900),
                          ),
                        ),
                        cellStyle: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                        cellHeight: 25.0,
                        cellAlignments: {
                          0: pw.Alignment.centerLeft,
                          1: pw.Alignment.centerRight,
                          2: pw.Alignment.centerRight,
                          3: pw.Alignment.centerRight,
                          4: pw.Alignment.centerRight,
                        },
                      ),
                      pw.Divider(color: PdfColors.grey),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Row(
                          children: [
                            pw.Spacer(flex: 6),
                            pw.Expanded(
                              flex: 4,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.Expanded(
                                        child: pw.Text(
                                          'รวมราคาสินค้า/Sub Total',
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              fontWeight: pw.FontWeight.bold,
                                              font: ttf,
                                              color: PdfColors.blue900),
                                        ),
                                      ),
                                      pw.Text(
                                        '\2000',
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: PdfColors.blue900),
                                      ),
                                    ],
                                  ),
                                  pw.Row(
                                    children: [
                                      pw.Expanded(
                                        child: pw.Text(
                                          'ส่วนลดพิเศษ/Discount',
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              fontWeight: pw.FontWeight.bold,
                                              font: ttf,
                                              color: PdfColors.blue900),
                                        ),
                                      ),
                                      pw.Text(
                                        '\2000',
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: PdfColors.blue900),
                                      ),
                                    ],
                                  ),
                                  pw.Divider(color: PdfColors.grey),
                                  pw.Row(
                                    children: [
                                      pw.Expanded(
                                        child: pw.Text(
                                          'ภาษีมูลค่าเพิ่ม/Vat',
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              fontWeight: pw.FontWeight.bold,
                                              font: ttf,
                                              color: PdfColors.blue900),
                                        ),
                                      ),
                                      pw.Text(
                                        '\ -30.00',
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: PdfColors.blue900),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Container(
                          height: 25,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.blue100,
                            border: pw.Border(
                              top: pw.BorderSide(color: PdfColors.blue900),
                            ),
                          ),
                          alignment: pw.Alignment.centerRight,
                          child: pw.Center(
                            child: pw.Row(
                              children: [
                                pw.SizedBox(width: 2 * PdfPageFormat.mm),
                                pw.Text(
                                  'ตัวอักษร ',
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      fontStyle: pw.FontStyle.italic,
                                      color: PdfColors.blue900),
                                ),
                                pw.Expanded(
                                  flex: 4,
                                  child: pw.Text(
                                    '(~${text_Number2}~)',
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      fontStyle: pw.FontStyle.italic,
                                      // decoration:
                                      //     pw.TextDecoration.lineThrough,
                                      color: PdfColors.blue900,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                        children: [
                                          pw.Expanded(
                                            flex: 2,
                                            child: pw.Text(
                                              'ยอดชำระ/Grand Total',
                                              textAlign: pw.TextAlign.left,
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  font: ttf,
                                                  fontSize: 10,
                                                  color: PdfColors.blue900),
                                            ),
                                          ),
                                          pw.Text(
                                            '\ 14250.51',
                                            style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                                font: ttf,
                                                fontSize: 10,
                                                color: PdfColors.blue900),
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
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'ผู้สั่งซื้อบริการ',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'ลงชื่อ',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 7 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '..........................................',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'ตรัยรัตน์ ซีฟูด',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '(................................)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '(ตรัยรัตน์ ซีฟูด)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'วันที่........../........../..........)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'วันที่24/1/2023',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
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
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.SizedBox(width: 2 * PdfPageFormat.mm),
                          pw.Text(
                            'หมายเหตุ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: PdfColors.grey800,
                                fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Bullet(
                        text: 'เอกสารฉบับนี้xxxxxxxxxxxxxxxxx',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10, font: ttf, color: PdfColors.grey800),
                      ),
                      pw.Bullet(
                        text: 'เอกสารฉบับนี้xxxxxxxxxxxxxxxxx',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10, font: ttf, color: PdfColors.grey800),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                    ],
                  )),
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
    ///////----------------------------------------->
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
          builder: (context) => PreviewPdfgen_Bills(
            doc: pdf,
          ),
        ));
  }
}
