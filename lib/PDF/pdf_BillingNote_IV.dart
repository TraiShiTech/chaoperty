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

import '../ChaoArea/ChaoAreaRenew_Screen.dart';
import '../Constant/Myconstant.dart';
import '../PeopleChao/Bills_.dart';

class Pdfgen_BillingNoteInvlice {
  //////////---------------------------------------------------->(ใบวางบิล แจ้งหนี้)
  static void exportPDF_BillingNoteInvlice(
      tableData003,
      context,
      _TransModels,
      Num_cid,
      Namenew,
      SubTotal,
      Vat,
      Deduct,
      Sum_SubTotal,
      DisC,
      Total,
      renTal_name,
      sname_,
      addr_,
      tel_,
      email_,
      tax_,
      cname_,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      cFinn) async {
    ////
    //// ------------>(ใบเสนอราคา)
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/Sarabun-Light.ttf");
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    var nFormat3 = NumberFormat("###-##-##0", "en_US");
    // double percen =
    //     (double.parse('$DisC') / double.parse(' $Sum_SubTotal')) * 100.00;
    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    // final iconImage =
    //     (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    final tableHeaders = [
      'ลำดับ',
      'รายการ',
      'กำหนดชำระ',
      'จำนวน',
      'หน่วย',
      'ราคาต่อหน่วย',
      'ราคารวม',
      // 'Total',
    ];

    // final tableData = [
    //   for (int index = 0; index < _TransModels.length; index++)
    //     [
    //       '${index + 1}',
    //       '${_TransModels[index].name}',
    //       '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${_TransModels[index].date} 00:00:00'))}',
    //       "${nFormat.format(double.parse('${_TransModels[index].tqty}'))}",
    //       // '${_TransModels[index].tqty}',
    //       '${_TransModels[index].unit_con}',
    //       _TransModels[index].qty_con == '0.00'
    //           ? "${nFormat.format(double.parse('${_TransModels[index].amt_con}'))}"
    //           // '${_TransModels[index].amt_con}'
    //           : "${nFormat.format(double.parse('${_TransModels[index].qty_con}'))}",
    //       //  '${_TransModels[index].qty_con}',
    //       "${nFormat.format(double.parse('${_TransModels[index].pvat}'))}",
    //       // '${_TransModels[index].pvat}',
    //     ],
    // ];
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
    var number_ = "${nFormat2.format(double.parse('$Total'))}";
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
        header: (context) {
          return pw.Column(children: [
            pw.Row(
              children: [
                (netImage.isEmpty)
                    ? pw.Container(
                        height: 72,
                        width: 70,
                        color: PdfColors.grey200,
                        child: pw.Center(
                          child: pw.Text(
                            '$bill_name ',
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
                        '$bill_name',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 11.0,
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
                      pw.Text(
                        'โทรศัพท์: $bill_tel',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (bill_email.toString() == '' ||
                                bill_email == null ||
                                bill_email.toString() == 'null')
                            ? 'อีเมล: '
                            : 'อีเมล: $bill_email',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
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
                            color: PdfColors.grey800),
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
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ใบวางบิล/ใบแจ้งหนี้',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 12.0,
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
                        'ลูกค้า',
                        style: pw.TextStyle(
                          fontSize: 12.0,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        (sname_.toString() == '' ||
                                sname_ == null ||
                                sname_.toString() == 'null')
                            ? ' '
                            : '${sname_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (addr_.toString() == '' ||
                                addr_ == null ||
                                addr_.toString() == 'null')
                            ? 'ที่อยู่ : -'
                            : 'ที่อยู่ : ${addr_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      // pw.Text(
                      //   'โทรศัพท์: ${tel_}',
                      //   // 'Tel:   ${tel_.substring(0, 3)}-${tel_.substring(3, 6)}-${tel_.substring(6)} ',
                      //   textAlign: pw.TextAlign.justify,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0,
                      //       font: ttf,
                      //       color: PdfColors.grey800),
                      // ),
                      pw.Text(
                        (email_.toString() == '' ||
                                email_ == null ||
                                email_.toString() == 'null')
                            ? 'อีเมล : -'
                            : 'อีเมล : ${email_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (tax_.toString() == '' ||
                                tax_ == null ||
                                tax_.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี : 0'
                            : 'เลขประจำตัวผู้เสียภาษี : ${tax_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
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
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (cFinn.toString() == '' ||
                                cFinn == null ||
                                cFinn.toString() == 'null')
                            ? ' '
                            : '${cFinn}',
                        style: pw.TextStyle(
                          fontSize: 12.00,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'วันที่ทำรายการ(Transation Date)',
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (thaiDate.toString() == '' ||
                                thaiDate == null ||
                                thaiDate.toString() == 'null')
                            ? ' '
                            : '$thaiDate ${DateTime.now().year + 543}',
                        //'${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}',
                        style: pw.TextStyle(
                          fontSize: 12.00,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.black,
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
                'รับบิลไว้ตรวจสอบตามรายการข้างล่างนี้ถูกต้องแล้ว  ',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                  fontSize: 10.0,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey800,
                ),
              ),
            ]),
            // pw.Row(children: [
            //   pw.Text(
            //     'please pay : ',
            //     textAlign: pw.TextAlign.justify,
            //     style: pw.TextStyle(
            //       fontSize: 10.0,
            //       font: ttf,
            //       fontWeight: pw.FontWeight.bold,
            //     ),
            //   ),
            // ]),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),

            pw.Container(
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
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'ลำดับ',
                          maxLines: 1,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'รายการ',
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'กำหนดชำระ',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'จำนวน',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'หน่วย',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'VAT',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'ราคารวม',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'ราคารวมVAT',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int index = 0; index < tableData003.length; index++)
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          '${tableData003[index][0]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          '${tableData003[index][1]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][2]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][3]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][4]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][5]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][6]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][7]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                ],
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
                        // SubTotal, Vat, Deduct, Sum_SubTotal, DisC, Total
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'รวมราคาสินค้า/Sub Total',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse('$SubTotal'))}',
                              // '$SubTotal',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ภาษีมูลค่าเพิ่ม/Vat',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse('$Vat'))}',
                              // '$Vat',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'หัก ณ ที่จ่าย',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse('$Deduct'))}',
                              // '$Deduct',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดรวม',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse('$Sum_SubTotal'))}',
                              // '$Sum_SubTotal',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ส่วนลด/Discount',
                                // 'ส่วนลด/Discount(${(double.parse('$DisC') / double.parse(' $Sum_SubTotal')) * 100.00} %)',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse('$DisC'))}',
                              // '$DisC',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Divider(color: PdfColors.grey),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดชำระ',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse('$Total'))}',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
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
                  color: PdfColors.green100,
                  border: pw.Border(
                    top: pw.BorderSide(color: PdfColors.green900),
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
                            color: PdfColors.green900),
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
                            color: PdfColors.green900,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                    'ยอดชำระทั้งหมด/Total',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        fontSize: 10,
                                        color: PdfColors.green900),
                                  ),
                                ),
                                pw.Text(
                                  // '$Total',
                                  '${nFormat.format(double.parse('$Total'))}',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      fontSize: 10,
                                      color: PdfColors.green900),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            pw.SizedBox(height: 10 * PdfPageFormat.mm),

            // pw.Stack(
            //   children: [
            //     pw.Positioned(
            //         left: 0,
            //         bottom: 120,
            //         child: pw.Transform.rotate(
            //           angle: 15 * math.pi / 190,
            //           child: pw.Text(
            //             '$renTal_name $renTal_name $renTal_name ',
            //             style: pw.TextStyle(
            //               fontSize: 40,
            //               color: PdfColors.grey200,
            //               font: ttf,
            //             ),
            //           ),
            //           //         pw.Image(
            //           //     pw.MemoryImage(iconImage),
            //           //     height: 300,
            //           //     width: 400,
            //           //   ),
            //           // )
            //         )),
            //     pw.Container(
            //       child: pw.Column(
            //         children: [
            //           pw.Table.fromTextArray(
            //             headers: tableHeaders,
            //             data: tableData003,
            //             border: null,
            //             headerStyle: pw.TextStyle(
            //                 fontSize: 10.0,
            //                 fontWeight: pw.FontWeight.bold,
            //                 font: ttf,
            //                 color: PdfColors.green900),
            //             headerDecoration: const pw.BoxDecoration(
            //               color: PdfColors.green100,
            //               border: pw.Border(
            //                 bottom: pw.BorderSide(color: PdfColors.green900),
            //               ),
            //             ),
            //             cellStyle: pw.TextStyle(
            //                 fontSize: 10.0,
            //                 font: ttf,
            //                 color: PdfColors.grey800),
            //             cellHeight: 25.0,
            //             cellAlignments: {
            //               0: pw.Alignment.centerLeft,
            //               1: pw.Alignment.centerRight,
            //               2: pw.Alignment.centerRight,
            //               3: pw.Alignment.centerRight,
            //               4: pw.Alignment.centerRight,
            //               5: pw.Alignment.centerRight,
            //               6: pw.Alignment.centerRight,
            //               7: pw.Alignment.centerRight,
            //             },
            //           ),
            //           pw.Divider(color: PdfColors.grey),
            //           pw.Container(
            //             alignment: pw.Alignment.centerRight,
            //             child: pw.Row(
            //               children: [
            //                 pw.Spacer(flex: 6),
            //                 pw.Expanded(
            //                   flex: 4,
            //                   child: pw.Column(
            //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
            //                     children: [
            //                       // SubTotal, Vat, Deduct, Sum_SubTotal, DisC, Total
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'รวมราคาสินค้า/Sub Total',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse('$SubTotal'))}',
            //                             // '$SubTotal',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'ภาษีมูลค่าเพิ่ม/Vat',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse('$Vat'))}',
            //                             // '$Vat',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'หัก ณ ที่จ่าย',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse('$Deduct'))}',
            //                             // '$Deduct',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'ยอดรวม',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse('$Sum_SubTotal'))}',
            //                             // '$Sum_SubTotal',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'ส่วนลด/Discount',
            //                               // 'ส่วนลด/Discount(${(double.parse('$DisC') / double.parse(' $Sum_SubTotal')) * 100.00} %)',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse('$DisC'))}',
            //                             // '$DisC',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Divider(color: PdfColors.grey),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'ยอดชำระ',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse('$Total'))}',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
            //           pw.Container(
            //               height: 25,
            //               decoration: const pw.BoxDecoration(
            //                 color: PdfColors.green100,
            //                 border: pw.Border(
            //                   top: pw.BorderSide(color: PdfColors.green900),
            //                 ),
            //               ),
            //               alignment: pw.Alignment.centerRight,
            //               child: pw.Center(
            //                 child: pw.Row(
            //                   children: [
            //                     pw.SizedBox(width: 2 * PdfPageFormat.mm),
            //                     pw.Text(
            //                       'ตัวอักษร ',
            //                       style: pw.TextStyle(
            //                           fontSize: 10,
            //                           fontWeight: pw.FontWeight.bold,
            //                           font: ttf,
            //                           fontStyle: pw.FontStyle.italic,
            //                           color: PdfColors.green900),
            //                     ),
            //                     pw.Expanded(
            //                       flex: 4,
            //                       child: pw.Text(
            //                         '(~${text_Number2}~)',
            //                         style: pw.TextStyle(
            //                           fontSize: 10,
            //                           fontWeight: pw.FontWeight.bold,
            //                           font: ttf,
            //                           fontStyle: pw.FontStyle.italic,
            //                           // decoration:
            //                           //     pw.TextDecoration.lineThrough,
            //                           color: PdfColors.green900,
            //                         ),
            //                       ),
            //                     ),
            //                     pw.Expanded(
            //                       flex: 2,
            //                       child: pw.Column(
            //                         mainAxisAlignment:
            //                             pw.MainAxisAlignment.center,
            //                         crossAxisAlignment:
            //                             pw.CrossAxisAlignment.start,
            //                         children: [
            //                           pw.Row(
            //                             children: [
            //                               pw.Expanded(
            //                                 flex: 2,
            //                                 child: pw.Text(
            //                                   'ยอดชำระทั้งหมด/Total',
            //                                   textAlign: pw.TextAlign.left,
            //                                   style: pw.TextStyle(
            //                                       fontWeight:
            //                                           pw.FontWeight.bold,
            //                                       font: ttf,
            //                                       fontSize: 10,
            //                                       color: PdfColors.green900),
            //                                 ),
            //                               ),
            //                               pw.Text(
            //                                 // '$Total',
            //                                 '${nFormat.format(double.parse('$Total'))}',
            //                                 style: pw.TextStyle(
            //                                     fontWeight: pw.FontWeight.bold,
            //                                     font: ttf,
            //                                     fontSize: 10,
            //                                     color: PdfColors.green900),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               )),
            //           pw.SizedBox(height: 10 * PdfPageFormat.mm),
            //         ],
            //       ),
            //     ),
            //   ],
            // )
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
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'ผู้รับวางบิล',
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
                              'ผู้รับเงิน',
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
                              'ผู้ตรวจสอบ',
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
                              'ผู้อนุมัติ',
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
                      pw.SizedBox(height: 4 * PdfPageFormat.mm),
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
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '..........................................',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '..........................................',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '..........................................',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
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
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '(................................)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '(................................)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '(................................)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
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
                              'วันที่........../........../..........',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'วันที่........../........../..........',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'วันที่........../........../..........',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'วันที่........../........../..........',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: PdfColors.grey800,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            '  ...............................................................................................................................................................................................',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            '  ...............................................................................................................................................................................................',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        ],
                      ),
                      // pw.Bullet(
                      //   text:
                      //       '.................................................................................................................................................................................',
                      //   textAlign: pw.TextAlign.left,
                      //   style: pw.TextStyle(
                      //       fontSize: 10, font: ttf, color: PdfColors.grey800),
                      // ),
                      // pw.Bullet(
                      //   text:
                      //       '..................................................................................................',
                      //   textAlign: pw.TextAlign.left,
                      //   style: pw.TextStyle(
                      //       fontSize: 10, font: ttf, color: PdfColors.grey800),
                      // ),
                      pw.SizedBox(height: 3 * PdfPageFormat.mm),
                    ],
                  )),
              pw.SizedBox(height: 3 * PdfPageFormat.mm),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Text(
                  'หน้า ${context.pageNumber} / ${context.pagesCount} ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: 10,
                    font: ttf,
                    color: PdfColors.grey800,
                    // fontWeight: pw.FontWeight.bold
                  ),
                ),
              )
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
              doc: pdf, nameBills: 'ใบวางบิล/ใบแจ้งหนี้${cFinn}'),
        ));
  }

  ///////////////----------------------------------------------------------------->
  //////////---------------------------------------------------->(ประวัติใบวางบิล แจ้งหนี้)
  static void exportPDF_HisBillingNoteInvlice(
      context,
      _InvoiceHistoryModels,
      numinvoice,
      renTal_name,
      Namenew,
      sum_pvat,
      sum_vat,
      sum_wht,
      sum_amt,
      sum_disp,
      sum_disamt,
      sname_,
      addr_,
      tel_,
      email_,
      tax_,
      cname_,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg) async {
    ////
    //// ------------>(ใบเสนอราคา)
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/Sarabun-Light.ttf");
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    // double percen =
    //     (double.parse('$DisC') / double.parse(' $Sum_SubTotal')) * 100.00;
    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);

    // final iconImage =
    //     (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    // final netImage = await networkImage(img_Value.toString());
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    final tableHeaders = [
      'ลำดับ',
      'รายการ',
      'กำหนดชำระ',
      'จำนวน',
      'หน่วย',
      'Vat',
      'ราคารวม',
      'ราคารวมVat',
      // 'Total',
    ];

    final tableData = [
      for (int index = 0; index < _InvoiceHistoryModels.length; index++)
        [
          '${index + 1}',
          '${_InvoiceHistoryModels[index].descr}',
          '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_InvoiceHistoryModels[index].date} 00:00:00'))}',
          "${nFormat.format(double.parse('${_InvoiceHistoryModels[index].qty}'))}",
          "${nFormat.format(double.parse('${_InvoiceHistoryModels[index].nvat}'))}",
          "${nFormat.format(double.parse('${_InvoiceHistoryModels[index].vat}'))}",
          "${nFormat.format(double.parse('${_InvoiceHistoryModels[index].pvat}'))}",
          "${nFormat.format(double.parse('${_InvoiceHistoryModels[index].amt}'))}"
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

    var number_ =
        "${nFormat2.format(double.parse(sum_amt) - double.parse(sum_disamt))}";

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
        header: (context) {
          return pw.Column(children: [
            pw.Row(
              children: [
                (netImage.isEmpty)
                    ? pw.Container(
                        height: 72,
                        width: 70,
                        color: PdfColors.grey200,
                        child: pw.Center(
                          child: pw.Text(
                            '$bill_name ',
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
                        '$bill_name ',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 11.0,
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
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (bill_email.toString() == '' ||
                                bill_email == null ||
                                bill_email.toString() == 'null')
                            ? 'อีเมล: '
                            : 'อีเมล: $bill_email',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (bill_tax.toString() == '' ||
                                bill_tax == null ||
                                bill_tax.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี: 0'
                            : 'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                        // textAlign: pw.TextAlign.justify,
                        textAlign: pw.TextAlign.right,
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
          ]);
        },
        build: (context) {
          return [
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ใบวางบิล/ใบแจ้งหนี้',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 11.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.black),
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
                        'ลูกค้า',
                        style: pw.TextStyle(
                          fontSize: 12.0,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        (sname_.toString() == '' ||
                                sname_ == null ||
                                sname_.toString() == 'null')
                            ? ' '
                            : '${sname_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (addr_.toString() == '' ||
                                addr_ == null ||
                                addr_.toString() == 'null')
                            ? 'ที่อยู่ : -'
                            : 'ที่อยู่ : ${addr_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      // pw.Text(
                      //   'โทรศัพท์: ${tel_}',
                      //   // 'Tel:   ${tel_.substring(0, 3)}-${tel_.substring(3, 6)}-${tel_.substring(6)} ',
                      //   textAlign: pw.TextAlign.justify,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0,
                      //       font: ttf,
                      //       color: PdfColors.grey800),
                      // ),
                      pw.Text(
                        (email_.toString() == '' ||
                                email_ == null ||
                                email_.toString() == 'null')
                            ? 'อีเมล : -'
                            : 'อีเมล : ${email_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        (tax_.toString() == '' ||
                                tax_ == null ||
                                tax_.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี : 0'
                            : 'เลขประจำตัวผู้เสียภาษี : ${tax_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
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
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        '${numinvoice}',
                        style: pw.TextStyle(
                            fontSize: 12.00,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.black),
                      ),
                      pw.Text(
                        'วันที่ทำรายการ(Transation Date)',
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        '$thaiDate ${DateTime.now().year + 543}',
                        //'${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}',
                        style: pw.TextStyle(
                          fontSize: 12.00,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.black,
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
                'รับบิลไว้ตรวจสอบตามรายการข้างล่างนี้ถูกต้องแล้ว  ',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                  fontSize: 10.0,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey800,
                ),
              ),
            ]),
            // pw.Row(children: [
            //   pw.Text(
            //     'please pay : ',
            //     textAlign: pw.TextAlign.justify,
            //     style: pw.TextStyle(
            //       fontSize: 10.0,
            //       font: ttf,
            //       fontWeight: pw.FontWeight.bold,
            //     ),
            //   ),
            // ]),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Container(
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
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'ลำดับ',
                          maxLines: 1,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'รายการ',
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'กำหนดชำระ',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'จำนวน',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'หน่วย',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'VAT',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'ราคารวม',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'ราคารวมVAT',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int index = 0; index < tableData.length; index++)
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          '${tableData[index][0]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          '${tableData[index][1]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData[index][2]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData[index][3]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData[index][4]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData[index][5]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData[index][6]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
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
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData[index][7]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                ],
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
                        // SubTotal, Vat, Deduct, Sum_SubTotal, DisC, Total
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'รวมราคาสินค้า/Sub Total',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_pvat.toString()))}',
                              // '$sum_pvat',
                              // '$SubTotal',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ภาษีมูลค่าเพิ่ม/Vat',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_vat.toString()))}',
                              // '$sum_vat',
                              // '$Vat',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'หัก ณ ที่จ่าย',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_wht.toString()))}',
                              //'$sum_wht',
                              // '$Deduct',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดรวม',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_amt))}',
                              //'$sum_amt',
                              // '$Sum_SubTotal',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ส่วนลด/Discount',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_disp.toString()))}',
                              //'$sum_disp',
                              // '$DisC',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Divider(color: PdfColors.grey),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดชำระ',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_amt) - double.parse(sum_disamt))}',
                              // '${nFormat.format(double.parse(sum_disamt.toString()))}',
                              //'$sum_disamt',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
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
                  color: PdfColors.green100,
                  border: pw.Border(
                    top: pw.BorderSide(color: PdfColors.green900),
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
                            color: PdfColors.green900),
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
                            color: PdfColors.green900,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                    'ยอดชำระทั้งหมด/Total',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        fontSize: 10,
                                        color: PdfColors.green900),
                                  ),
                                ),
                                pw.Text(
                                  '${nFormat.format(double.parse(sum_amt) - double.parse(sum_disamt))}',
                                  // '${int.parse(sum_amt) - int.parse(sum_disamt)}',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      fontSize: 10,
                                      color: PdfColors.green900),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            pw.SizedBox(height: 10 * PdfPageFormat.mm),
            // pw.Stack(
            //   children: [
            //     pw.Positioned(
            //         left: 0,
            //         bottom: 120,
            //         child: pw.Transform.rotate(
            //           angle: 15 * math.pi / 190,
            //           child: pw.Text(
            //             '$renTal_name $renTal_name $renTal_name ',
            //             style: pw.TextStyle(
            //               fontSize: 40,
            //               color: PdfColors.grey200,
            //               font: ttf,
            //             ),
            //           ),
            //           //         pw.Image(
            //           //     pw.MemoryImage(iconImage),
            //           //     height: 300,
            //           //     width: 400,
            //           //   ),
            //           // )
            //         )),
            //     pw.Container(
            //       child: pw.Column(
            //         children: [
            //           pw.Table.fromTextArray(
            //             headers: tableHeaders,
            //             data: tableData,
            //             border: null,
            //             headerStyle: pw.TextStyle(
            //                 fontSize: 10.0,
            //                 fontWeight: pw.FontWeight.bold,
            //                 font: ttf,
            //                 color: PdfColors.green900),
            //             headerDecoration: const pw.BoxDecoration(
            //               color: PdfColors.green100,
            //               border: pw.Border(
            //                 bottom: pw.BorderSide(color: PdfColors.green900),
            //               ),
            //             ),
            //             cellStyle: pw.TextStyle(
            //                 fontSize: 10.0,
            //                 font: ttf,
            //                 color: PdfColors.grey800),
            //             cellHeight: 25.0,
            //             cellAlignments: {
            //               0: pw.Alignment.centerLeft,
            //               1: pw.Alignment.centerRight,
            //               2: pw.Alignment.centerRight,
            //               3: pw.Alignment.centerRight,
            //               4: pw.Alignment.centerRight,
            //               5: pw.Alignment.centerRight,
            //               6: pw.Alignment.centerRight,
            //               7: pw.Alignment.centerRight,
            //               7: pw.Alignment.centerRight,
            //             },
            //           ),
            //           pw.Divider(color: PdfColors.grey),
            //           pw.Container(
            //             alignment: pw.Alignment.centerRight,
            //             child: pw.Row(
            //               children: [
            //                 pw.Spacer(flex: 6),
            //                 pw.Expanded(
            //                   flex: 4,
            //                   child: pw.Column(
            //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
            //                     children: [
            //                       // SubTotal, Vat, Deduct, Sum_SubTotal, DisC, Total
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'รวมราคาสินค้า/Sub Total',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse(sum_pvat.toString()))}',
            //                             // '$sum_pvat',
            //                             // '$SubTotal',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'ภาษีมูลค่าเพิ่ม/Vat',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse(sum_vat.toString()))}',
            //                             // '$sum_vat',
            //                             // '$Vat',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'หัก ณ ที่จ่าย',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse(sum_wht.toString()))}',
            //                             //'$sum_wht',
            //                             // '$Deduct',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'ยอดรวม',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse(sum_amt))}',
            //                             //'$sum_amt',
            //                             // '$Sum_SubTotal',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'ส่วนลด/Discount()',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse(sum_disp.toString()))}',
            //                             //'$sum_disp',
            //                             // '$DisC',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                       pw.Divider(color: PdfColors.grey),
            //                       pw.Row(
            //                         children: [
            //                           pw.Expanded(
            //                             child: pw.Text(
            //                               'ยอดชำระ',
            //                               style: pw.TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: pw.FontWeight.bold,
            //                                   font: ttf,
            //                                   color: PdfColors.green900),
            //                             ),
            //                           ),
            //                           pw.Text(
            //                             '${nFormat.format(double.parse(sum_disamt.toString()))}',
            //                             //'$sum_disamt',
            //                             style: pw.TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: pw.FontWeight.bold,
            //                                 font: ttf,
            //                                 color: PdfColors.green900),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
            //           pw.Container(
            //               height: 25,
            //               decoration: const pw.BoxDecoration(
            //                 color: PdfColors.green100,
            //                 border: pw.Border(
            //                   top: pw.BorderSide(color: PdfColors.green900),
            //                 ),
            //               ),
            //               alignment: pw.Alignment.centerRight,
            //               child: pw.Center(
            //                 child: pw.Row(
            //                   children: [
            //                     pw.SizedBox(width: 2 * PdfPageFormat.mm),
            //                     pw.Text(
            //                       'ตัวอักษร ',
            //                       style: pw.TextStyle(
            //                           fontSize: 10,
            //                           fontWeight: pw.FontWeight.bold,
            //                           font: ttf,
            //                           fontStyle: pw.FontStyle.italic,
            //                           color: PdfColors.green900),
            //                     ),
            //                     pw.Expanded(
            //                       flex: 4,
            //                       child: pw.Text(
            //                         '(~${text_Number2}~)',
            //                         style: pw.TextStyle(
            //                           fontSize: 10,
            //                           fontWeight: pw.FontWeight.bold,
            //                           font: ttf,
            //                           fontStyle: pw.FontStyle.italic,
            //                           // decoration:
            //                           //     pw.TextDecoration.lineThrough,
            //                           color: PdfColors.green900,
            //                         ),
            //                       ),
            //                     ),
            //                     pw.Expanded(
            //                       flex: 2,
            //                       child: pw.Column(
            //                         mainAxisAlignment:
            //                             pw.MainAxisAlignment.center,
            //                         crossAxisAlignment:
            //                             pw.CrossAxisAlignment.start,
            //                         children: [
            //                           pw.Row(
            //                             children: [
            //                               pw.Expanded(
            //                                 flex: 2,
            //                                 child: pw.Text(
            //                                   'ยอดชำระทั้งหมด/Total',
            //                                   textAlign: pw.TextAlign.left,
            //                                   style: pw.TextStyle(
            //                                       fontWeight:
            //                                           pw.FontWeight.bold,
            //                                       font: ttf,
            //                                       fontSize: 10,
            //                                       color: PdfColors.green900),
            //                                 ),
            //                               ),
            //                               pw.Text(
            //                                 '${nFormat.format(double.parse(sum_amt) - double.parse(sum_disamt))}',
            //                                 // '${int.parse(sum_amt) - int.parse(sum_disamt)}',
            //                                 style: pw.TextStyle(
            //                                     fontWeight: pw.FontWeight.bold,
            //                                     font: ttf,
            //                                     fontSize: 10,
            //                                     color: PdfColors.green900),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               )),
            //           pw.SizedBox(height: 10 * PdfPageFormat.mm),
            //         ],
            //       ),
            //     ),
            //   ],
            // )
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
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'ผู้รับวางบิล',
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
                              'ผู้รับเงิน',
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
                              'ผู้ตรวจสอบ',
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
                              'ผู้อนุมัติ',
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
                      pw.SizedBox(height: 4 * PdfPageFormat.mm),
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
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '..........................................',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '..........................................',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '..........................................',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
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
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '(................................)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '(................................)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              '(................................)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
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
                              'วันที่........../........../..........',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'วันที่........../........../..........',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'วันที่........../........../..........',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(
                              'วันที่........../........../..........',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                        ],
                      ),
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
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            '  ...............................................................................................................................................................................................',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        ],
                      ),

                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            '  ...............................................................................................................................................................................................',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        ],
                      ),
                      // pw.Bullet(
                      //   text:
                      //       '.................................................................................................................................................................................',
                      //   textAlign: pw.TextAlign.left,
                      //   style: pw.TextStyle(
                      //       fontSize: 10, font: ttf, color: PdfColors.grey800),
                      // ),
                      // pw.Bullet(
                      //   text:
                      //       '..................................................................................................',
                      //   textAlign: pw.TextAlign.left,
                      //   style: pw.TextStyle(
                      //       fontSize: 10, font: ttf, color: PdfColors.grey800),
                      // ),
                      pw.SizedBox(height: 3 * PdfPageFormat.mm),
                    ],
                  )),
              pw.SizedBox(height: 3 * PdfPageFormat.mm),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Text(
                  'หน้า ${context.pageNumber} / ${context.pagesCount} ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: 10,
                    font: ttf,
                    color: PdfColors.grey800,
                    // fontWeight: pw.FontWeight.bold
                  ),
                ),
              )
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
              doc: pdf, nameBills: 'ประวัติใบวางบิล/ใบแจ้งหนี้${numinvoice}'),
        ));
  }
}
