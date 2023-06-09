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
import '../PeopleChao/Bills_.dart';
import '../PeopleChao/Pays_.dart';
import '../Style/ThaiBaht.dart';

class PdfgenReceipt {
  //////////---------------------------------------------------->(ใบเสร็จรับเงินชั่วคราว paySrsscreen_)
  static void exportPDF_Receipt(
      tableData00,
      context,
      Slip_status,
      _TransModels,
      Num_cid,
      Namenew,
      sum_pvat,
      sum_vat,
      sum_wht,
      Sum_SubTotal,
      sum_disp,
      sum_disamt,
      Total,
      renTal_name,
      Form_bussshop,
      Form_address,
      Form_tel,
      Form_email,
      Form_tax,
      Form_nameshop,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      pamentpage,
      paymentName1,
      paymentName2,
      Form_payment1,
      Form_payment2,
      cFinn,
      Value_newDateD) async {
    ////
    //// ------------>(ใบเสร็จรับเงินชั่วคราว paySrsscreen_)
    ///////
    final pdf = pw.Document();
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    var Colors_pd = PdfColors.black;

    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }

    final tableHeaders = [
      'ลำดับ',
      'กำหนดชำระ',
      'รายการ',
      'จำนวน',
      'หน่วย',
      'ราคาต่อหน่วย',
      'ราคารวม',
    ];

    final tableData = [
      for (int index = 0; index < _TransModels.length; index++)
        [
          '${index + 1}',
          '${_TransModels[index].date}',
          '${_TransModels[index].name}',
          '${_TransModels[index].tqty}',
          '${_TransModels[index].unit_con}',
          _TransModels[index].qty_con == '0.00'
              ? '${nFormat.format(double.parse(_TransModels[index].amt_con!))}'
              : '${nFormat.format(double.parse(_TransModels[index].qty_con!))}',
          '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
        ],
    ];
///////////////////////------------------------------------------------->
    // final List<String> _digitThai = [
    //   'ศูนย์',
    //   'หนึ่ง',
    //   'สอง',
    //   'สาม',
    //   'สี่',
    //   'ห้า',
    //   'หก',
    //   'เจ็ด',
    //   'แปด',
    //   'เก้า'
    // ];

    // final List<String> _positionThai = [
    //   '',
    //   'สิบ',
    //   'ร้อย',
    //   'พัน',
    //   'หมื่น',
    //   'แสน',
    //   'ล้าน'
    // ];
/////////////////////////////------------------------>(จำนวนเต็ม)
    // String convertNumberToText(int number) {
    //   String result = '';
    //   int numberIntPart = number.toInt();
    //   int numberDecimalPart = ((number - numberIntPart) * 100).toInt();
    //   final List<String> digits = numberIntPart.toString().split('');
    //   int position = digits.length - 1;
    //   for (int i = 0; i < digits.length; i++) {
    //     final int digit = int.parse(digits[i]);
    //     if (digit != 0) {
    //       if (position == 6) {
    //         result = '$result${_positionThai[6]}';
    //       }
    //       if (position != 6 && position != 8) {
    //         if (digit == 1 && position == 1) {
    //           // result = '$resultเอ็ด';
    //           result = '$resultสิบ';
    //         } else {
    //           result =
    //               '$result${_digitThai[digit]}${_positionThai[position % 6]}';
    //         }
    //       } else if (position == 8) {
    //         result = '$result${_digitThai[digit]}${_positionThai[6]}';
    //       }
    //     }
    //     position--;
    //   }
    //   // final String decimalText =
    //   //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
    //   return result;
    // }

/////////////////////////////------------------------>(จำนวนทศนิยม สตางค์)
    // String convertNumberToText2(int number2) {
    //   String result = '';
    //   int numberIntPart = number2.toInt();
    //   int numberDecimalPart = ((number2 - numberIntPart) * 100).toInt();
    //   final List<String> digits = numberIntPart.toString().split('');
    //   int position = digits.length - 1;
    //   for (int i = 0; i < digits.length; i++) {
    //     final int digit = int.parse(digits[i]);
    //     if (digit != 0) {
    //       if (position == 6) {
    //         result = '$result${_positionThai[6]}';
    //       }
    //       if (position != 6 && position != 8) {
    //         if (digit == 1 && position == 1) {
    //           // result = '$resultเอ็ด';
    //           result = '$resultสิบ';
    //         } else {
    //           result =
    //               '$result${_digitThai[digit]}${_positionThai[position % 6]}';
    //         }
    //       } else if (position == 8) {
    //         result = '$result${_digitThai[digit]}${_positionThai[6]}';
    //       }
    //     }
    //     position--;
    //   }
    //   // final String decimalText =
    //   //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
    //   return result;
    // }

////////////////----------------------------->(ตัด หน้าจุดกับหลังจุดออกจากกัน)
    // var number_ = "${nFormat2.format(double.parse(Total.toString()))}";
    // var parts = number_.split('.');
    // var front = parts[0];
    // var back = parts[1];

////////////////--------------------------------->(บาท)
    // double number = double.parse(front);
    // final int numberIntPart = number.toInt();
    // final double numberDecimalPart = (number - numberIntPart) * 100;
    // final String numberText = convertNumberToText(numberIntPart);
    // final String decimalText = convertNumberToText(numberDecimalPart.toInt());
////////////////---------------------------------->(สตางค์)
    // double number2 = double.parse(number_);
    // final int numberIntPart2 = number.toInt();
    // final int numberDecimalPart2 = ((number2 - numberIntPart2) * 100).round();
    // final String numberText2 = convertNumberToText2(numberIntPart2);
    // final String decimalText2 =
    //     convertNumberToText2(numberDecimalPart2.toInt());
////////////////------------------------------->(เช็คและเพิ่มตัวอักษร)
    // final String formattedNumber = (decimalText2.replaceAll(
    //             _digitThai[0], "") ==
    //         '')
    //     ? '$numberTextบาทถ้วน'
    //     : (back[0].toString() == '0')
    //         ? '$numberTextบาทศูนย์${decimalText2.replaceAll(_digitThai[0], "")}สตางค์'
    //         : '$numberTextบาท${decimalText2.replaceAll(_digitThai[0], "")}สตางค์';

    // String text_Number1 = formattedNumber;
    // RegExp exp1 = RegExp(r"สองสิบ");
    // if (exp1.hasMatch(text_Number1)) {
    //   text_Number1 = text_Number1.replaceAll(exp1, 'ยี่สิบ');
    // }
    // String text_Number2 = text_Number1;
    // RegExp exp2 = RegExp(r"สิบหนึ่ง");
    // if (exp2.hasMatch(text_Number2)) {
    //   text_Number2 = text_Number2.replaceAll(exp2, 'สิบเอ็ด');
    // }
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
                (netImage.isEmpty)
                    ? pw.Container(
                        height: 72,
                        width: 70,
                        color: PdfColors.grey200,
                        child: pw.Center(
                          child: pw.Text(
                            '$bill_name ',
                            maxLines: 2,
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
                          fontSize: 10.0,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
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
                      pw.Text(
                        (Slip_status.toString() == '1')
                            ? 'ใบรับเงินชั่วคราว'
                            : 'ใบเสร็จรับเงิน/ใบกำกับภาษี',
                        style: pw.TextStyle(
                          fontSize: 10.00,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                      //   textAlign: pw.TextAlign.right,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      // pw.Text(
                      //   'โทรศัพท์: $bill_tel',
                      //   textAlign: pw.TextAlign.right,
                      //   maxLines: 1,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0,
                      //       font: ttf,
                      //       color: PdfColors.grey800),
                      // ),
                      // pw.Text(
                      //   'อีเมล: $bill_email',
                      //   maxLines: 1,
                      //   textAlign: pw.TextAlign.right,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0,
                      //       font: ttf,
                      //       color: PdfColors.grey800),
                      // ),
                      pw.Text(
                        (Slip_status.toString() == '1')
                            ? 'เลขที่ใบแจ้งหนี้: $cFinn '
                            : 'เลขที่รับชำระ: $cFinn ',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'วันที่ออกบิล: $thaiDate ${DateTime.now().year + 543}',
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
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                // pw.Expanded(
                //   flex: 4,
                //   child: pw.Column(
                //     mainAxisSize: pw.MainAxisSize.min,
                //     crossAxisAlignment: pw.CrossAxisAlignment.start,
                //     children: [
                //       pw.Text(
                //         'ผู้ขาย',
                //         style: pw.TextStyle(
                //           fontSize: 10.0,
                //           fontWeight: pw.FontWeight.bold,
                //           font: ttf,
                //         ),
                //       ),
                //       pw.Text(
                //         '$renTal_name',
                //         textAlign: pw.TextAlign.justify,
                //         style: pw.TextStyle(
                //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
                //       ),
                //       // pw.Text(
                //       //   'ที่อยู่:$bill_addr',
                //       //   textAlign: pw.TextAlign.left,
                //       //   style: pw.TextStyle(
                //       //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                //       // ),
                //       // pw.Text(
                //       //   'เลขประจำตัวผู้เสียภาษี:$bill_tax,',
                //       //   textAlign: pw.TextAlign.justify,
                //       //   style: pw.TextStyle(
                //       //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                //       // ),
                //       pw.Text(
                //         (bill_addr.toString() == '' || bill_addr == null)
                //             ? 'ที่อยู่:-'
                //             : 'ที่อยู่:$bill_addr',
                //         textAlign: pw.TextAlign.left,
                //         style: pw.TextStyle(
                //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
                //       ),
                //       pw.Text(
                //         (bill_tax.toString() == '' || bill_tax == null)
                //             ? 'เลขประจำตัวผู้เสียภาษี:0'
                //             : 'เลขประจำตัวผู้เสียภาษี:$bill_tax',
                //         textAlign: pw.TextAlign.justify,
                //         style: pw.TextStyle(
                //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
                //       ),
                //     ],
                //   ),
                // ),
                // pw.SizedBox(width: 10 * PdfPageFormat.mm),
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
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (Form_bussshop.toString() == '' ||
                                Form_bussshop == null ||
                                Form_bussshop.toString() == 'null')
                            ? '-'
                            : '$Form_bussshop',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'ที่อยู่:$Form_address',
                      //   textAlign: pw.TextAlign.left,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      // pw.Text(
                      //   'เลขประจำตัวผู้เสียภาษี:$Form_tax',
                      //   textAlign: pw.TextAlign.justify,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      pw.Text(
                        (Form_address.toString() == '' ||
                                Form_address == null ||
                                Form_address.toString() == 'null')
                            ? 'ที่อยู่: -'
                            : 'ที่อยู่: $Form_address',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (Form_tax.toString() == '' ||
                                Form_tax == null ||
                                Form_tax.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี: 0'
                            : 'เลขประจำตัวผู้เสียภาษี: $Form_tax',
                        textAlign: pw.TextAlign.justify,
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
            // pw.Text(
            //   'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
            //   textAlign: pw.TextAlign.justify,
            // ),
            if (Slip_status.toString() != '1')
              pw.SizedBox(height: 5 * PdfPageFormat.mm),

            if (Slip_status.toString() != '1')
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 4,
                              child: pw.Text(
                                'รูปแบบชำระ',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: Colors_pd,
                                ),
                              ),
                            ),
                            pw.SizedBox(width: 10 * PdfPageFormat.mm),
                            pw.Expanded(
                              flex: 4,
                              child: pw.Column(
                                mainAxisSize: pw.MainAxisSize.min,
                                crossAxisAlignment: pw.CrossAxisAlignment.end,
                                children: [
                                  if (Value_newDateD.toString() == '' ||
                                      Value_newDateD.toString() == 'null')
                                    pw.Text(
                                      'วันที่ชำระ : - ',
                                      style: pw.TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  if (Value_newDateD.toString() != '' ||
                                      Value_newDateD.toString() != 'null')
                                    pw.Text(
                                      'วันที่ชำระ : $Value_newDateD',
                                      textAlign: pw.TextAlign.justify,
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
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Row(children: [
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // decoration: pw.BoxDecoration(
                                //   color: PdfColors.green100,
                                //   // border: pw.Border(
                                //   //   bottom: pw.BorderSide(
                                //   //       color: PdfColors.green900),
                                //   // ),
                                // ),
                                child:
                                    (paymentName1.toString().trim() ==
                                                'เงินโอน' ||
                                            paymentName1.toString().trim() ==
                                                'เงินโอน' ||
                                            paymentName1.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName1.toString().trim() ==
                                                'Online Payment')
                                        ? pw.Text(
                                            (Form_payment1 == null ||
                                                    Form_payment1.toString() ==
                                                        'null' ||
                                                    Form_payment1.toString() ==
                                                        '')
                                                ? '1.เงินโอน : -'
                                                : '1.เงินโอน : ${nFormat.format(double.parse(Form_payment1.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment1.toString()))}~)',
                                            textAlign: pw.TextAlign.justify,
                                            style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          )
                                        : pw.Text(
                                            (Form_payment1 == null ||
                                                    Form_payment1.toString() ==
                                                        'null' ||
                                                    Form_payment1.toString() ==
                                                        '')
                                                ? '1.$paymentName1 : -'
                                                : '1.$paymentName1 : ${nFormat.format(double.parse(Form_payment1.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment1.toString()))}~)',
                                            textAlign: pw.TextAlign.justify,
                                            style: pw.TextStyle(
                                              fontSize: 10.0,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                              )),
                        ]),
                        // pw.Row(children: [
                        //   pw.Text(
                        //     (paymentName1.toString().trim() == 'เงินโอน' ||
                        //             paymentName1.toString().trim() ==
                        //                 'เงินโอน' ||
                        //             paymentName1.toString().trim() ==
                        //                 'Online Payment' ||
                        //             paymentName1.toString().trim() ==
                        //                 'Online Payment')
                        //         ? '1.เงินโอน : '
                        //         : '1.$paymentName1 : ',
                        //     textAlign: pw.TextAlign.justify,
                        //     style: pw.TextStyle(
                        //       fontSize: 10.0,
                        //       font: ttf,
                        //       fontWeight: pw.FontWeight.bold,
                        //       color: Colors_pd,
                        //     ),
                        //   ),
                        //   pw.Expanded(
                        //     flex: 4,
                        //     child: pw.Text(
                        //       (Form_payment1 == null ||
                        //               Form_payment1.toString() == 'null' ||
                        //               Form_payment1.toString() == '')
                        //           ? '-'
                        //           : '${nFormat.format(double.parse(Form_payment1.toString()))} บาท',
                        //       //'${Form_payment1.toString()} บาท',
                        //       // textAlign: pw.TextAlign.justify,
                        //       style: pw.TextStyle(
                        //         fontSize: 10.0,
                        //         font: ttf,
                        //         color: Colors_pd,
                        //       ),
                        //     ),
                        //   ),
                        // ]),

                        if (pamentpage != 0)
                          // pw.Row(children: [
                          //   pw.Text(
                          //     (paymentName2.toString().trim() == 'เงินโอน' ||
                          //             paymentName2.toString().trim() ==
                          //                 'เงินโอน' ||
                          //             paymentName2.toString().trim() ==
                          //                 'Online Payment' ||
                          //             paymentName2.toString().trim() ==
                          //                 'Online Payment')
                          //         ? '2.เงินโอน : '
                          //         : '2.$paymentName2 : ',
                          //     textAlign: pw.TextAlign.justify,
                          //     style: pw.TextStyle(
                          //       fontSize: 10.0,
                          //       font: ttf,
                          //       fontWeight: pw.FontWeight.bold,
                          //       color: Colors_pd,
                          //     ),
                          //   ),
                          //   pw.Expanded(
                          //     flex: 4,
                          //     child: pw.Text(
                          //       (Form_payment2 == null ||
                          //               Form_payment2.toString() == 'null' ||
                          //               Form_payment2.toString() == '')
                          //           ? '-'
                          //           : '${nFormat.format(double.parse(Form_payment2.toString()))} บาท',
                          //       //  '${Form_payment2.toString()} บาท',
                          //       // textAlign: pw.TextAlign.justify,
                          //       style: pw.TextStyle(
                          //         fontSize: 10.0,
                          //         font: ttf,
                          //         color: Colors_pd,
                          //       ),
                          //     ),
                          //   ),
                          // ]),
                          pw.Row(children: [
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  // decoration: pw.BoxDecoration(
                                  //   color: PdfColors.green100,
                                  //   // border: pw.Border(
                                  //   //   bottom: pw.BorderSide(
                                  //   //       color: PdfColors.green900),
                                  //   // ),
                                  // ),
                                  child:
                                      (paymentName2.toString().trim() ==
                                                  'เงินโอน' ||
                                              paymentName2.toString().trim() ==
                                                  'เงินโอน' ||
                                              paymentName2.toString().trim() ==
                                                  'Online Payment' ||
                                              paymentName2.toString().trim() ==
                                                  'Online Payment')
                                          ? pw.Text(
                                              (Form_payment2 == null ||
                                                      Form_payment2
                                                              .toString() ==
                                                          'null' ||
                                                      Form_payment2
                                                              .toString() ==
                                                          '')
                                                  ? '2.เงินโอน : -'
                                                  : '2.เงินโอน : ${nFormat.format(double.parse(Form_payment2.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment2.toString()))}~)',
                                              textAlign: pw.TextAlign.justify,
                                              style: pw.TextStyle(
                                                fontSize: 10.0,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                                color: Colors_pd,
                                              ),
                                            )
                                          : pw.Text(
                                              (Form_payment2 == null ||
                                                      Form_payment2
                                                              .toString() ==
                                                          'null' ||
                                                      Form_payment2
                                                              .toString() ==
                                                          '')
                                                  ? '2.$paymentName2 : -'
                                                  : '2.$paymentName2 : ${nFormat.format(double.parse(Form_payment2.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment2.toString()))}~)',
                                              textAlign: pw.TextAlign.justify,
                                              style: pw.TextStyle(
                                                fontSize: 10.0,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                                color: Colors_pd,
                                              ),
                                            ),
                                )),
                          ]),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 10 * PdfPageFormat.mm),
                  // pw.Expanded(
                  //   flex: 4,
                  //   child: pw.Column(
                  //     mainAxisSize: pw.MainAxisSize.min,
                  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //     children: [
                  //       pw.Text(
                  //         'วันที่ชำระ',
                  //         style: pw.TextStyle(
                  //           fontSize: 10.0,
                  //           fontWeight: pw.FontWeight.bold,
                  //           font: ttf,
                  //           color: Colors_pd,
                  //         ),
                  //       ),
                  //       pw.Text(
                  //         (Value_newDateD.toString() == '' ||
                  //                 Value_newDateD.toString() == 'null')
                  //             ? '-'
                  //             : '$Value_newDateD',
                  //         textAlign: pw.TextAlign.justify,
                  //         style: pw.TextStyle(
                  //           fontSize: 10.0,
                  //           font: ttf,
                  //           color: Colors_pd,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),

//////////////---------------------------------->
            // pw.SizedBox(height: 5 * PdfPageFormat.mm),

            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Stack(
              children: [
                // pw.Positioned(
                //     left: 0,
                //     bottom: 120,
                //     child: pw.Transform.rotate(
                //       angle: 15 * math.pi / 190,
                //       child: pw.Text(
                //         '$renTal_name $renTal_name $renTal_name ',
                //         style: pw.TextStyle(
                //           fontSize: 40,
                //           color: PdfColors.grey200,
                //           font: ttf,
                //         ),
                //       ),
                //       //         pw.Image(
                //       //     pw.MemoryImage(iconImage),
                //       //     height: 300,
                //       //     width: 400,
                //       //   ),
                //       // )
                //     )),
                pw.Container(
                  child: pw.Column(
                    children: [
                      pw.Table.fromTextArray(
                        headers: tableHeaders,
                        data: tableData00,
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
                          5: pw.Alignment.centerRight,
                          6: pw.Alignment.centerRight,
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
                                        // '${sum_pvat}',
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
                                        '${sum_vat}',
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
                                        '${sum_wht}',
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
                                        '${nFormat.format(double.parse(Sum_SubTotal.toString()))}',
                                        // '${Sum_SubTotal}',
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
                                          // 'ส่วนลด/Discount(${sum_disp}%)',
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              fontWeight: pw.FontWeight.bold,
                                              font: ttf,
                                              color: PdfColors.green900),
                                        ),
                                      ),
                                      pw.Text(
                                        '${sum_disamt}',
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
                                        '${nFormat.format(double.parse(Total.toString()))}',
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
                                    //"${nFormat2.format(double.parse(Total.toString()))}";
                                    ' (~${convertToThaiBaht(double.parse(Total.toString()))}~)',
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
                                // pw.Spacer(flex: 6),
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
                                              'ยอดรวมสุทธิ',
                                              textAlign: pw.TextAlign.left,
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  font: ttf,
                                                  fontSize: 10,
                                                  color: PdfColors.green900),
                                            ),
                                          ),
                                          pw.Text(
                                            '${nFormat.format(double.parse(Total.toString()))}',
                                            // '${Total}',
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
                      pw.SizedBox(height: 5 * PdfPageFormat.mm),
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
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(4.0),
                                child: pw.Column(
                                  children: [
                                    pw.Text(
                                      'หมายเหตุ',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          font: ttf,
                                          color: Colors_pd,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      '................................................................................................................................................................................',
                                      textAlign: pw.TextAlign.center,
                                      // maxLines: 1,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  ],
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(4.0),
                                child: pw.Column(
                                  children: [
                                    pw.Text(
                                      'ผู้รับเงิน',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          font: ttf,
                                          color: Colors_pd,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      ' (..............................................)',
                                      textAlign: pw.TextAlign.left,
                                      maxLines: 1,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      'วันที่........../........../..........',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  ],
                                ),
                              ),
                            ),
                          ]),
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
                    color: Colors_pd,
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
    ///-------------------------------------------------->
    // final List<int> bytes = await pdf.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    // final dir = await FileSaver.instance.saveFile(
    //     "ใบเสร็จรับเงิน(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPdfgen_Billsplay(
              doc: pdf,
              title: (Slip_status.toString() == '1')
                  ? 'ใบรับเงินชั่วคราว(รายการยังไม่ได้วางบิล)'
                  : 'ใบเสร็จรับเงิน/ใบกำกับภาษี(รายการยังไม่ได้วางบิล)'),
        ));
  }

/////////////--------------------------------------------------->
  static void exportPDF_Receipt1(
      numinvoice,
      tableData00,
      context,
      Slip_status,
      _InvoiceHistoryModels,
      Num_cid,
      Namenew,
      sum_pvat,
      sum_vat,
      sum_wht,
      Sum_SubTotal,
      sum_disp,
      sum_disamt,
      Total,
      renTal_name,
      Form_bussshop,
      Form_address,
      Form_tel,
      Form_email,
      Form_tax,
      Form_nameshop,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      pamentpage,
      paymentName1,
      paymentName2,
      Form_payment1,
      Form_payment2) async {
    ////
    //// ------------>(ใบเสร็จรับเงินชั่วคราว paySrsscreen_)
    ///////
    final pdf = pw.Document();
    //final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    var Colors_pd = PdfColors.black;
    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }

    final tableHeaders = [
      'ลำดับ',
      'กำหนดชำระ',
      'รายการ',
      'จำนวน',
      'หน่วย',
      'vat',
      'ราคารวม',
      'ราคารวมvat',
    ];

    // final tableData = [
    //   for (int index = 0; index < _InvoiceHistoryModels.length; index++)
    //     [
    //       '${index + 1}',
    //       '${_InvoiceHistoryModels[index].date}',
    //       '${_InvoiceHistoryModels[index].descr}',
    //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].qty!))}',
    //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].nvat!))}',
    //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].vat!))}',
    //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].pvat!))}',
    //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].amt!))}',
    //     ],
    // ];
///////////////////////------------------------------------------------->
    // final List<String> _digitThai = [
    //   'ศูนย์',
    //   'หนึ่ง',
    //   'สอง',
    //   'สาม',
    //   'สี่',
    //   'ห้า',
    //   'หก',
    //   'เจ็ด',
    //   'แปด',
    //   'เก้า'
    // ];

    // final List<String> _positionThai = [
    //   '',
    //   'สิบ',
    //   'ร้อย',
    //   'พัน',
    //   'หมื่น',
    //   'แสน',
    //   'ล้าน'
    // ];
/////////////////////////////------------------------>(จำนวนเต็ม)
    // String convertNumberToText(int number) {
    //   String result = '';
    //   int numberIntPart = number.toInt();
    //   int numberDecimalPart = ((number - numberIntPart) * 100).toInt();
    //   final List<String> digits = numberIntPart.toString().split('');
    //   int position = digits.length - 1;
    //   for (int i = 0; i < digits.length; i++) {
    //     final int digit = int.parse(digits[i]);
    //     if (digit != 0) {
    //       if (position == 6) {
    //         result = '$result${_positionThai[6]}';
    //       }
    //       if (position != 6 && position != 8) {
    //         if (digit == 1 && position == 1) {
    //           // result = '$resultเอ็ด';
    //           result = '$resultสิบ';
    //         } else {
    //           result =
    //               '$result${_digitThai[digit]}${_positionThai[position % 6]}';
    //         }
    //       } else if (position == 8) {
    //         result = '$result${_digitThai[digit]}${_positionThai[6]}';
    //       }
    //     }
    //     position--;
    //   }
    //   // final String decimalText =
    //   //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
    //   return result;
    // }

/////////////////////////////------------------------>(จำนวนทศนิยม สตางค์)
    // String convertNumberToText2(int number2) {
    //   String result = '';
    //   int numberIntPart = number2.toInt();
    //   int numberDecimalPart = ((number2 - numberIntPart) * 100).toInt();
    //   final List<String> digits = numberIntPart.toString().split('');
    //   int position = digits.length - 1;
    //   for (int i = 0; i < digits.length; i++) {
    //     final int digit = int.parse(digits[i]);
    //     if (digit != 0) {
    //       if (position == 6) {
    //         result = '$result${_positionThai[6]}';
    //       }
    //       if (position != 6 && position != 8) {
    //         if (digit == 1 && position == 1) {
    //           // result = '$resultเอ็ด';
    //           result = '$resultสิบ';
    //         } else {
    //           result =
    //               '$result${_digitThai[digit]}${_positionThai[position % 6]}';
    //         }
    //       } else if (position == 8) {
    //         result = '$result${_digitThai[digit]}${_positionThai[6]}';
    //       }
    //     }
    //     position--;
    //   }
    //   // final String decimalText =
    //   //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
    //   return result;
    // }

////////////////----------------------------->(ตัด หน้าจุดกับหลังจุดออกจากกัน)
    // var number_ = "${nFormat2.format(double.parse(Total.toString()))}";
    // var parts = number_.split('.');
    // var front = parts[0];
    // var back = parts[1];

////////////////--------------------------------->(บาท)
    // double number = double.parse(front);
    // final int numberIntPart = number.toInt();
    // final double numberDecimalPart = (number - numberIntPart) * 100;
    // final String numberText = convertNumberToText(numberIntPart);
    // final String decimalText = convertNumberToText(numberDecimalPart.toInt());
////////////////---------------------------------->(สตางค์)
    // double number2 = double.parse(number_);
    // final int numberIntPart2 = number.toInt();
    // final int numberDecimalPart2 = ((number2 - numberIntPart2) * 100).round();
    // final String numberText2 = convertNumberToText2(numberIntPart2);
    // final String decimalText2 =
    //     convertNumberToText2(numberDecimalPart2.toInt());
////////////////------------------------------->(เช็คและเพิ่มตัวอักษร)
    // final String formattedNumber = (decimalText2.replaceAll(
    //             _digitThai[0], "") ==
    //         '')
    //     ? '$numberTextบาทถ้วน'
    //     : (back[0].toString() == '0')
    //         ? '$numberTextบาทศูนย์${decimalText2.replaceAll(_digitThai[0], "")}สตางค์'
    //         : '$numberTextบาท${decimalText2.replaceAll(_digitThai[0], "")}สตางค์';

    // String text_Number1 = formattedNumber;
    // RegExp exp1 = RegExp(r"สองสิบ");
    // if (exp1.hasMatch(text_Number1)) {
    //   text_Number1 = text_Number1.replaceAll(exp1, 'ยี่สิบ');
    // }
    // String text_Number2 = text_Number1;
    // RegExp exp2 = RegExp(r"สิบหนึ่ง");
    // if (exp2.hasMatch(text_Number2)) {
    //   text_Number2 = text_Number2.replaceAll(exp2, 'สิบเอ็ด');
    // }
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
                            maxLines: 2,
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
                          color: Colors_pd,
                          fontSize: 10.0,
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
                      pw.Text(
                        (Slip_status.toString() == '1')
                            ? 'ใบรับเงินชั่วคราว'
                            : 'ใบเสร็จรับเงิน/ใบกำกับภาษี',
                        style: pw.TextStyle(
                          fontSize: 10.00,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                      //   textAlign: pw.TextAlign.right,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      // pw.Text(
                      //   'โทรศัพท์: $bill_tel',
                      //   textAlign: pw.TextAlign.right,
                      //   maxLines: 1,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0,
                      //       font: ttf,
                      //       color: PdfColors.grey800),
                      // ),
                      // pw.Text(
                      //   'อีเมล: $bill_email',
                      //   maxLines: 1,
                      //   textAlign: pw.TextAlign.right,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0,
                      //       font: ttf,
                      //       color: PdfColors.grey800),
                      // ),
                      pw.Text(
                        'รหัสอ้างอิง: $numinvoice ',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'วันที่: $thaiDate ${DateTime.now().year + 543}',
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
            pw.Row(
              children: [
                // pw.Expanded(
                //   flex: 4,
                //   child: pw.Column(
                //     mainAxisSize: pw.MainAxisSize.min,
                //     crossAxisAlignment: pw.CrossAxisAlignment.start,
                //     children: [
                //       pw.Text(
                //         'ผู้ขาย',
                //         style: pw.TextStyle(
                //           fontSize: 10.0,
                //           fontWeight: pw.FontWeight.bold,
                //           font: ttf,
                //         ),
                //       ),
                //       pw.Text(
                //         '$renTal_name',
                //         textAlign: pw.TextAlign.justify,
                //         style: pw.TextStyle(
                //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
                //       ),
                //       pw.Text(
                //         (bill_addr.toString() == '' || bill_tax == null)
                //             ? 'ที่อยู่:-'
                //             : 'ที่อยู่:$bill_addr',
                //         textAlign: pw.TextAlign.left,
                //         style: pw.TextStyle(
                //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
                //       ),
                //       pw.Text(
                //         (bill_tax.toString() == '' || bill_tax == null)
                //             ? 'เลขประจำตัวผู้เสียภาษี:0'
                //             : 'เลขประจำตัวผู้เสียภาษี:$bill_tax',
                //         textAlign: pw.TextAlign.justify,
                //         style: pw.TextStyle(
                //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
                //       ),
                //     ],
                //   ),
                // ),
                // pw.SizedBox(width: 10 * PdfPageFormat.mm),
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
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (Form_bussshop.toString() == '' ||
                                Form_bussshop == null ||
                                Form_bussshop.toString() == 'null')
                            ? '-'
                            : '$Form_bussshop',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'ที่อยู่:$Form_address',
                      //   textAlign: pw.TextAlign.left,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      // pw.Text(
                      //   'เลขประจำตัวผู้เสียภาษี:$Form_tax',
                      //   textAlign: pw.TextAlign.justify,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      pw.Text(
                        (Form_address.toString() == '' ||
                                Form_address == null ||
                                Form_address.toString() == 'null')
                            ? 'ที่อยู่: -'
                            : 'ที่อยู่: $Form_address',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (Form_tax.toString() == '' ||
                                Form_tax == null ||
                                Form_tax.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี: 0'
                            : 'เลขประจำตัวผู้เสียภาษี: $Form_tax',
                        textAlign: pw.TextAlign.justify,
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
            // pw.Text(
            //   'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
            //   textAlign: pw.TextAlign.justify,
            // ),
            if (Slip_status.toString() != '1')
              pw.SizedBox(height: 5 * PdfPageFormat.mm),
            if (Slip_status.toString() != '1')
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 4,
                    child: pw.Text(
                      'รูปแบบชำระ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                        color: Colors_pd,
                      ),
                    ),
                  ),
                  pw.SizedBox(width: 10 * PdfPageFormat.mm),
                  // pw.Expanded(
                  //   flex: 4,
                  //   child: pw.Column(
                  //     mainAxisSize: pw.MainAxisSize.min,
                  //     crossAxisAlignment: pw.CrossAxisAlignment.end,
                  //     children: [
                  //       if (Value_newDateD.toString() == '' ||
                  //           Value_newDateD.toString() == 'null')
                  //         pw.Text(
                  //           'วันที่ชำระ : - ',
                  //           style: pw.TextStyle(
                  //             fontSize: 10.0,
                  //             fontWeight: pw.FontWeight.bold,
                  //             font: ttf,
                  //             color: Colors_pd,
                  //           ),
                  //         ),
                  //       if (Value_newDateD.toString() != '' ||
                  //           Value_newDateD.toString() != 'null')
                  //         pw.Text(
                  //           'วันที่ชำระ : $Value_newDateD',
                  //           textAlign: pw.TextAlign.justify,
                  //           style: pw.TextStyle(
                  //             fontSize: 10.0,
                  //             font: ttf,
                  //             color: Colors_pd,
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            if (Slip_status.toString() != '1')
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
//////////////---------------------------------->
            if (Slip_status.toString() != '1')
              pw.Row(children: [
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      // decoration: pw.BoxDecoration(
                      //   color: PdfColors.green100,
                      //   // border: pw.Border(
                      //   //   bottom: pw.BorderSide(
                      //   //       color: PdfColors.green900),
                      //   // ),
                      // ),
                      child: (paymentName1.toString().trim() == 'เงินโอน' ||
                              paymentName1.toString().trim() == 'เงินโอน' ||
                              paymentName1.toString().trim() ==
                                  'Online Payment' ||
                              paymentName1.toString().trim() ==
                                  'Online Payment')
                          ? pw.Text(
                              (Form_payment1 == null ||
                                      Form_payment1.toString() == 'null' ||
                                      Form_payment1.toString() == '')
                                  ? '1.เงินโอน : -'
                                  : '1.เงินโอน : ${nFormat.format(double.parse(Form_payment1.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment1.toString()))}~)',
                              textAlign: pw.TextAlign.justify,
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            )
                          : pw.Text(
                              (Form_payment1 == null ||
                                      Form_payment1.toString() == 'null' ||
                                      Form_payment1.toString() == '')
                                  ? '1.$paymentName1 : -'
                                  : '1.$paymentName1 : ${nFormat.format(double.parse(Form_payment1.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment1.toString()))}~)',
                              textAlign: pw.TextAlign.justify,
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                    )),
              ]),
            // pw.Row(children: [
            //   pw.Text(
            //     (paymentName1.toString().trim() == 'เงินโอน' ||
            //             paymentName1.toString().trim() == 'เงินโอน' ||
            //             paymentName1.toString().trim() == 'Online Payment' ||
            //             paymentName1.toString().trim() == 'Online Payment')
            //         ? '1.เงินโอน : '
            //         : '1.$paymentName1 : ',
            //     textAlign: pw.TextAlign.justify,
            //     style: pw.TextStyle(
            //       fontSize: 10.0,
            //       font: ttf,
            //       color: Colors_pd,
            //       fontWeight: pw.FontWeight.bold,
            //     ),
            //   ),
            //   pw.Expanded(
            //     flex: 4,
            //     child: pw.Text(
            //       (Form_payment1 == null ||
            //               Form_payment1.toString() == 'null' ||
            //               Form_payment1.toString() == '')
            //           ? '-'
            //           : '${nFormat.format(double.parse(Form_payment1.toString()))} บาท',
            //       // '${Form_payment1.toString()} บาท',
            //       // textAlign: pw.TextAlign.justify,
            //       style: pw.TextStyle(
            //         fontSize: 10.0,
            //         font: ttf,
            //         color: Colors_pd,
            //       ),
            //     ),
            //   ),
            // ]),

//////////////---------------------------------->
            if (Slip_status.toString() != '1')
              if (pamentpage != 0)
                pw.Row(children: [
                  pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        // decoration: pw.BoxDecoration(
                        //   color: PdfColors.green100,
                        //   // border: pw.Border(
                        //   //   bottom: pw.BorderSide(
                        //   //       color: PdfColors.green900),
                        //   // ),
                        // ),
                        child: (paymentName2.toString().trim() == 'เงินโอน' ||
                                paymentName2.toString().trim() == 'เงินโอน' ||
                                paymentName2.toString().trim() ==
                                    'Online Payment' ||
                                paymentName2.toString().trim() ==
                                    'Online Payment')
                            ? pw.Text(
                                (Form_payment2 == null ||
                                        Form_payment2.toString() == 'null' ||
                                        Form_payment2.toString() == '')
                                    ? '2.เงินโอน : -'
                                    : '2.เงินโอน : ${nFormat.format(double.parse(Form_payment2.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment2.toString()))}~)',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: Colors_pd,
                                ),
                              )
                            : pw.Text(
                                (Form_payment2 == null ||
                                        Form_payment2.toString() == 'null' ||
                                        Form_payment2.toString() == '')
                                    ? '2.$paymentName2 : -'
                                    : '2.$paymentName2 : ${nFormat.format(double.parse(Form_payment2.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment2.toString()))}~)',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: Colors_pd,
                                ),
                              ),
                      )),
                ]),
            // pw.Row(children: [
            //   pw.Text(
            //     (paymentName2.toString().trim() == 'เงินโอน' ||
            //             paymentName2.toString().trim() == 'เงินโอน' ||
            //             paymentName2.toString().trim() ==
            //                 'Online Payment' ||
            //             paymentName2.toString().trim() == 'Online Payment')
            //         ? '2.เงินโอน : '
            //         : '2.$paymentName2 : ',
            //     textAlign: pw.TextAlign.justify,
            //     style: pw.TextStyle(
            //       fontSize: 10.0,
            //       font: ttf,
            //       color: Colors_pd,
            //       fontWeight: pw.FontWeight.bold,
            //     ),
            //   ),
            //   pw.Expanded(
            //     flex: 4,
            //     child: pw.Text(
            //       (Form_payment2 == null ||
            //               Form_payment2.toString() == 'null' ||
            //               Form_payment2.toString() == '')
            //           ? '-'
            //           : '${nFormat.format(double.parse(Form_payment2.toString()))} บาท',
            //       // '${Form_payment2.toString()} บาท',
            //       // textAlign: pw.TextAlign.justify,
            //       style: pw.TextStyle(
            //         fontSize: 10.0,
            //         font: ttf,
            //         color: Colors_pd,
            //       ),
            //     ),
            //   ),
            // ]),
//////////////---------------------------------->
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

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
                      child: pw.Center(
                        child: pw.Text(
                          'ลำดับ',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          'กำหนดชำระ',
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
                      child: pw.Center(
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
                      child: pw.Center(
                        child: pw.Text(
                          'VAT%',
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
                      child: pw.Center(
                        child: pw.Text(
                          'หน่วย',
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
                      child: pw.Center(
                        child: pw.Text(
                          'VAT',
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
                      child: pw.Center(
                        child: pw.Text(
                          'ราคารวมก่อนVAT',
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
                      child: pw.Center(
                        child: pw.Text(
                          'ราคารวมVAT',
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
                ],
              ),
            ),
            for (int index = 0; index < tableData00.length; index++)
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00[index][0]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00[index][1]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00[index][2]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00[index][3]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00[index][4]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00[index][5]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00[index][6]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00[index][7]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                              // '${sum_pvat}',
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
                              // '${sum_vat}',
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
                              // '${sum_wht}',
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
                              '${nFormat.format(double.parse(Sum_SubTotal.toString()))}',
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
                              '${nFormat.format(double.parse(sum_disamt.toString()))}',
                              // '${sum_disamt}',
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
                              '${nFormat.format(double.parse(Total.toString()))}',
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
                          //"${nFormat2.format(double.parse(Total.toString()))}";
                          '(~${convertToThaiBaht(double.parse(Total.toString()))}~)',
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
                                  flex: 2,
                                  child: pw.Text(
                                    'ยอดรวมสุทธิ',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        fontSize: 10,
                                        color: PdfColors.green900),
                                  ),
                                ),
                                pw.Text(
                                  '${nFormat.format(double.parse(Total.toString()))}',
                                  // '${Total}',
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
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
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
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(4.0),
                                child: pw.Column(
                                  children: [
                                    pw.Text(
                                      'หมายเหตุ',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          font: ttf,
                                          color: Colors_pd,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      '................................................................................................................................................................................',
                                      textAlign: pw.TextAlign.center,
                                      // maxLines: 1,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  ],
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(4.0),
                                child: pw.Column(
                                  children: [
                                    pw.Text(
                                      'ผู้รับเงิน',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          font: ttf,
                                          color: Colors_pd,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      ' (..............................................)',
                                      textAlign: pw.TextAlign.left,
                                      maxLines: 1,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      'วันที่........../........../..........',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  ],
                                ),
                              ),
                            ),
                          ]),
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
                    color: Colors_pd,
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
    ///-------------------------------------------------->
    // final List<int> bytes = await pdf.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    // final dir = await FileSaver.instance.saveFile(
    //     "ใบเสร็จรับเงิน(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPdfgen_Billsplay(
              doc: pdf,
              title: (Slip_status.toString() == '1')
                  ? 'ใบรับเงินชั่วคราว(รายการวางบิล)'
                  : 'ใบเสร็จรับเงิน/ใบกำกับภาษี(รายการวางบิล)'),
        ));
  }

/////////////--------------------------------------------------->(exportPDF_Receipt2)
  static void exportPDF_Receipt2(
      context,
      Slip_status,
      _TransReBillHistoryModels,
      Num_cid,
      Namenew,
      sum_pvat,
      sum_vat,
      sum_wht,
      Sum_SubTotal,
      sum_disp,
      sum_disamt,
      Total,
      renTal_name,
      Form_bussshop,
      Form_address,
      Form_tel,
      Form_email,
      Form_tax,
      Form_nameshop,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      pamentpage,
      paymentName1,
      paymentName2,
      Form_payment1,
      Form_payment2,
      numinvoice,
      cFinn) async {
    ////
    //// ------------>(ใบเสร็จรับเงินชั่วคราว paySrsscreen_)
    ///////
    final pdf = pw.Document();
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    var Colors_pd = PdfColors.black;
    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }

    final tableHeaders = [
      'ลำดับ',
      'กำหนดชำระ',
      'รายการ',
      'จำนวน',
      'หน่วย',
      'vat',
      'ราคารวม',
      'ราคารวมvat',
    ];

    final tableData = [
      for (int index = 0; index < _TransReBillHistoryModels.length; index++)
        [
          '${index + 1}',
          '${_TransReBillHistoryModels[index].date}',
          '${_TransReBillHistoryModels[index].expname}',
          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].tqty!))}',
          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].nvat!))}',
          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].vat!))}',
          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].pvat!))}',
          '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
        ],
    ];
///////////////////////------------------------------------------------->
    // final List<String> _digitThai = [
    //   'ศูนย์',
    //   'หนึ่ง',
    //   'สอง',
    //   'สาม',
    //   'สี่',
    //   'ห้า',
    //   'หก',
    //   'เจ็ด',
    //   'แปด',
    //   'เก้า'
    // ];

    // final List<String> _positionThai = [
    //   '',
    //   'สิบ',
    //   'ร้อย',
    //   'พัน',
    //   'หมื่น',
    //   'แสน',
    //   'ล้าน'
    // ];
/////////////////////////////------------------------>(จำนวนเต็ม)
    // String convertNumberToText(int number) {
    //   String result = '';
    //   int numberIntPart = number.toInt();
    //   int numberDecimalPart = ((number - numberIntPart) * 100).toInt();
    //   final List<String> digits = numberIntPart.toString().split('');
    //   int position = digits.length - 1;
    //   for (int i = 0; i < digits.length; i++) {
    //     final int digit = int.parse(digits[i]);
    //     if (digit != 0) {
    //       if (position == 6) {
    //         result = '$result${_positionThai[6]}';
    //       }
    //       if (position != 6 && position != 8) {
    //         if (digit == 1 && position == 1) {
    //           // result = '$resultเอ็ด';
    //           result = '$resultสิบ';
    //         } else {
    //           result =
    //               '$result${_digitThai[digit]}${_positionThai[position % 6]}';
    //         }
    //       } else if (position == 8) {
    //         result = '$result${_digitThai[digit]}${_positionThai[6]}';
    //       }
    //     }
    //     position--;
    //   }
    //   // final String decimalText =
    //   //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
    //   return result;
    // }

/////////////////////////////------------------------>(จำนวนทศนิยม สตางค์)
    // String convertNumberToText2(int number2) {
    //   String result = '';
    //   int numberIntPart = number2.toInt();
    //   int numberDecimalPart = ((number2 - numberIntPart) * 100).toInt();
    //   final List<String> digits = numberIntPart.toString().split('');
    //   int position = digits.length - 1;
    //   for (int i = 0; i < digits.length; i++) {
    //     final int digit = int.parse(digits[i]);
    //     if (digit != 0) {
    //       if (position == 6) {
    //         result = '$result${_positionThai[6]}';
    //       }
    //       if (position != 6 && position != 8) {
    //         if (digit == 1 && position == 1) {
    //           // result = '$resultเอ็ด';
    //           result = '$resultสิบ';
    //         } else {
    //           result =
    //               '$result${_digitThai[digit]}${_positionThai[position % 6]}';
    //         }
    //       } else if (position == 8) {
    //         result = '$result${_digitThai[digit]}${_positionThai[6]}';
    //       }
    //     }
    //     position--;
    //   }
    //   // final String decimalText =
    //   //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
    //   return result;
    // }

////////////////----------------------------->(ตัด หน้าจุดกับหลังจุดออกจากกัน)
    // var number_ = "${nFormat2.format(double.parse(Total.toString()))}";
    // var parts = number_.split('.');
    // var front = parts[0];
    // var back = parts[1];

////////////////--------------------------------->(บาท)
    // double number = double.parse(front);
    // final int numberIntPart = number.toInt();
    // final double numberDecimalPart = (number - numberIntPart) * 100;
    // final String numberText = convertNumberToText(numberIntPart);
    // final String decimalText = convertNumberToText(numberDecimalPart.toInt());
////////////////---------------------------------->(สตางค์)
    // double number2 = double.parse(number_);
    // final int numberIntPart2 = number.toInt();
    // final int numberDecimalPart2 = ((number2 - numberIntPart2) * 100).round();
    // final String numberText2 = convertNumberToText2(numberIntPart2);
    // final String decimalText2 =
    //     convertNumberToText2(numberDecimalPart2.toInt());
////////////////------------------------------->(เช็คและเพิ่มตัวอักษร)
    // final String formattedNumber = (decimalText2.replaceAll(
    //             _digitThai[0], "") ==
    //         '')
    //     ? '$numberTextบาทถ้วน'
    //     : (back[0].toString() == '0')
    //         ? '$numberTextบาทศูนย์${decimalText2.replaceAll(_digitThai[0], "")}สตางค์'
    //         : '$numberTextบาท${decimalText2.replaceAll(_digitThai[0], "")}สตางค์';

    // String text_Number1 = formattedNumber;
    // RegExp exp1 = RegExp(r"สองสิบ");
    // if (exp1.hasMatch(text_Number1)) {
    //   text_Number1 = text_Number1.replaceAll(exp1, 'ยี่สิบ');
    // }
    // String text_Number2 = text_Number1;
    // RegExp exp2 = RegExp(r"สิบหนึ่ง");
    // if (exp2.hasMatch(text_Number2)) {
    //   text_Number2 = text_Number2.replaceAll(exp2, 'สิบเอ็ด');
    // }
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
                            maxLines: 2,
                            style: pw.TextStyle(
                              fontSize: 8,
                              font: ttf,
                              // color: PdfColors.grey300,
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
                        //'$',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'ที่อยู่: $bill_addr',
                        maxLines: 3,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          // color: PdfColors.grey800,
                          font: ttf,
                          color: Colors_pd,
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
                          color: Colors_pd,
                        ),
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
                      pw.Text(
                        (Slip_status.toString() == '1')
                            ? 'ใบรับเงินชั่วคราว'
                            : 'ใบเสร็จรับเงิน/ใบกำกับภาษี',
                        style: pw.TextStyle(
                          fontSize: 10.00,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        (Slip_status.toString() == '1')
                            ? 'เลขที่ใบแจ้งหนี้:$numinvoice '
                            : 'เลขที่รับชำระ:$cFinn ',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (Slip_status.toString() == '1')
                            ? 'วันที่ออกบิล:  $thaiDate ${DateTime.now().year + 543}'
                            : 'วันที่ออกบิล:  $thaiDate ${DateTime.now().year + 543}',
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
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (Form_bussshop == null ||
                                Form_bussshop.toString() == 'null' ||
                                Form_bussshop.toString() == '')
                            ? '-'
                            : '$Form_bussshop',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (Form_address == null ||
                                Form_address.toString() == 'null' ||
                                Form_address.toString() == '')
                            ? 'ที่อยู่: -'
                            : 'ที่อยู่:$Form_address',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (Form_tax == null ||
                                Form_tax.toString() == 'null' ||
                                Form_tax.toString() == '')
                            ? 'เลขประจำตัวผู้เสียภาษี: 0'
                            : 'เลขประจำตัวผู้เสียภาษี: $Form_tax',
                        textAlign: pw.TextAlign.justify,
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
            // pw.Text(
            //   'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
            //   textAlign: pw.TextAlign.justify,
            // ),
            if (Slip_status.toString() != '1')
              pw.SizedBox(height: 5 * PdfPageFormat.mm),
            if (Slip_status.toString() != '1')
              // pw.Text(
              //   'รูปแบบชำระ',
              //   textAlign: pw.TextAlign.justify,
              //   style: pw.TextStyle(
              //     fontSize: 10.0,
              //     font: ttf,
              //     fontWeight: pw.FontWeight.bold,
              //     color: Colors_pd,
              //   ),
              // ),

              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 4,
                    child: pw.Text(
                      'รูปแบบชำระ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                        color: Colors_pd,
                      ),
                    ),
                  ),
                  pw.SizedBox(width: 10 * PdfPageFormat.mm),
                  // pw.Expanded(
                  //   flex: 4,
                  //   child: pw.Column(
                  //     mainAxisSize: pw.MainAxisSize.min,
                  //     crossAxisAlignment: pw.CrossAxisAlignment.end,
                  //     children: [
                  //       if (Value_newDateD.toString() == '' ||
                  //           Value_newDateD.toString() == 'null')
                  //         pw.Text(
                  //           'วันที่ชำระ : - ',
                  //           style: pw.TextStyle(
                  //             fontSize: 10.0,
                  //             fontWeight: pw.FontWeight.bold,
                  //             font: ttf,
                  //             color: Colors_pd,
                  //           ),
                  //         ),
                  //       if (Value_newDateD.toString() != '' ||
                  //           Value_newDateD.toString() != 'null')
                  //         pw.Text(
                  //           'วันที่ชำระ : $Value_newDateD',
                  //           textAlign: pw.TextAlign.justify,
                  //           style: pw.TextStyle(
                  //             fontSize: 10.0,
                  //             font: ttf,
                  //             color: Colors_pd,
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            if (Slip_status.toString() != '1')
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
//////////////---------------------------------->
            if (Slip_status.toString() != '1')
              pw.Row(children: [
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      // decoration: pw.BoxDecoration(
                      //   color: PdfColors.green100,
                      //   // border: pw.Border(
                      //   //   bottom: pw.BorderSide(
                      //   //       color: PdfColors.green900),
                      //   // ),
                      // ),
                      child: (paymentName1.toString().trim() == 'เงินโอน' ||
                              paymentName1.toString().trim() == 'เงินโอน' ||
                              paymentName1.toString().trim() ==
                                  'Online Payment' ||
                              paymentName1.toString().trim() ==
                                  'Online Payment')
                          ? pw.Text(
                              (Form_payment1 == null ||
                                      Form_payment1.toString() == 'null' ||
                                      Form_payment1.toString() == '')
                                  ? '1.เงินโอน : -'
                                  : '1.เงินโอน : ${nFormat.format(double.parse(Form_payment1.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment1.toString()))}~)',
                              textAlign: pw.TextAlign.justify,
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            )
                          : pw.Text(
                              (Form_payment1 == null ||
                                      Form_payment1.toString() == 'null' ||
                                      Form_payment1.toString() == '')
                                  ? '1.$paymentName1 : -'
                                  : '1.$paymentName1 : ${nFormat.format(double.parse(Form_payment1.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment1.toString()))}~)',
                              textAlign: pw.TextAlign.justify,
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                fontWeight: pw.FontWeight.bold,
                                color: Colors_pd,
                              ),
                            ),
                    )),
              ]),
            // pw.Row(children: [
            //   pw.Text(
            //     (paymentName1.toString().trim() == 'เงินโอน' ||
            //             paymentName1.toString().trim() == 'เงินโอน' ||
            //             paymentName1.toString().trim() == 'Online Payment' ||
            //             paymentName1.toString().trim() == 'Online Payment')
            //         ? '1.เงินโอน : '
            //         : '1.$paymentName1 : ',
            //     textAlign: pw.TextAlign.justify,
            //     style: pw.TextStyle(
            //       fontSize: 10.0,
            //       font: ttf,
            //       fontWeight: pw.FontWeight.bold,
            //       color: Colors_pd,
            //     ),
            //   ),
            //   pw.Expanded(
            //     flex: 4,
            //     child: pw.Text(
            //       (Form_payment1 == null ||
            //               Form_payment1.toString() == 'null' ||
            //               Form_payment1.toString() == '')
            //           ? '-'
            //           : '${nFormat.format(double.parse(Form_payment1.toString()))} บาท',
            //       // '${Form_payment1.toString()} บาท',
            //       // textAlign: pw.TextAlign.justify,
            //       style: pw.TextStyle(
            //         fontSize: 10.0,
            //         font: ttf,
            //         color: Colors_pd,
            //       ),
            //     ),
            //   ),
            // ]),
//////////////---------------------------------->
            if (Slip_status.toString() != '1')
              if (pamentpage != 0)
                pw.Row(children: [
                  pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        // decoration: pw.BoxDecoration(
                        //   color: PdfColors.green100,
                        //   // border: pw.Border(
                        //   //   bottom: pw.BorderSide(
                        //   //       color: PdfColors.green900),
                        //   // ),
                        // ),
                        child: (paymentName2.toString().trim() == 'เงินโอน' ||
                                paymentName2.toString().trim() == 'เงินโอน' ||
                                paymentName2.toString().trim() ==
                                    'Online Payment' ||
                                paymentName2.toString().trim() ==
                                    'Online Payment')
                            ? pw.Text(
                                (Form_payment2 == null ||
                                        Form_payment2.toString() == 'null' ||
                                        Form_payment2.toString() == '')
                                    ? '2.เงินโอน : -'
                                    : '2.เงินโอน : ${nFormat.format(double.parse(Form_payment2.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment2.toString()))}~)',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: Colors_pd,
                                ),
                              )
                            : pw.Text(
                                (Form_payment2 == null ||
                                        Form_payment2.toString() == 'null' ||
                                        Form_payment2.toString() == '')
                                    ? '2.$paymentName2 : -'
                                    : '2.$paymentName2 : ${nFormat.format(double.parse(Form_payment2.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment2.toString()))}~)',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: Colors_pd,
                                ),
                              ),
                      )),
                ]),
            // pw.Row(children: [
            //   pw.Text(
            //     (paymentName2.toString().trim() == 'เงินโอน' ||
            //             paymentName2.toString().trim() == 'เงินโอน' ||
            //             paymentName2.toString().trim() ==
            //                 'Online Payment' ||
            //             paymentName2.toString().trim() == 'Online Payment')
            //         ? '2.เงินโอน : '
            //         : '2.$paymentName2 : ',
            //     textAlign: pw.TextAlign.justify,
            //     style: pw.TextStyle(
            //       fontSize: 10.0,
            //       font: ttf,
            //       fontWeight: pw.FontWeight.bold,
            //       color: Colors_pd,
            //     ),
            //   ),
            //   pw.Expanded(
            //     flex: 4,
            //     child: pw.Text(
            //       (Form_payment2 == null ||
            //               Form_payment2.toString() == 'null' ||
            //               Form_payment2.toString() == '')
            //           ? '-'
            //           : '${nFormat.format(double.parse(Form_payment2.toString()))} บาท',
            //       // '${Form_payment2.toString()} บาท',
            //       // textAlign: pw.TextAlign.justify,
            //       style: pw.TextStyle(
            //         fontSize: 10.0,
            //         font: ttf,
            //         color: Colors_pd,
            //       ),
            //     ),
            //   ),
            // ]),
//////////////---------------------------------->
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            //            'ลำดับ',
            // 'กำหนดชำระ',
            // 'รายการ',
            // 'VAT%',
            // 'หน่วย',
            // 'VAT',
            // 'ราคารวมก่อนVAT',
            // 'ราคารวมvat',
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
                      child: pw.Center(
                        child: pw.Text(
                          'ลำดับ',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            fontWeight: pw.FontWeight.bold,
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
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'กำหนดชำระ',
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
                      child: pw.Center(
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
                      child: pw.Center(
                        child: pw.Text(
                          'VAT%',
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
                      child: pw.Center(
                        child: pw.Text(
                          'หน่วย',
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
                      child: pw.Center(
                        child: pw.Text(
                          'VAT',
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
                      child: pw.Center(
                        child: pw.Text(
                          'ราคารวมก่อนVAT',
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
                      child: pw.Center(
                        child: pw.Text(
                          'ราคารวมVAT',
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData[index][0]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData[index][1]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData[index][2]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData[index][3]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData[index][4]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData[index][5]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData[index][6]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData[index][7]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
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
                              // '${sum_pvat}',
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
                              // '${sum_vat}',
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
                              // '${sum_wht}',
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
                              '${nFormat.format(double.parse(Sum_SubTotal.toString()))}',
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
                              '${nFormat.format(double.parse(sum_disamt.toString()))}',
                              // '${sum_disamt}',
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
                              '${nFormat.format(double.parse(Total.toString()))}',
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
                          //"${nFormat2.format(double.parse(Total.toString()))}";
                          '(~${convertToThaiBaht(double.parse(Total.toString()))}~)',
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
                                  flex: 2,
                                  child: pw.Text(
                                    'ยอดรวมสุทธิ',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        fontSize: 10,
                                        color: PdfColors.green900),
                                  ),
                                ),
                                pw.Text(
                                  '${nFormat.format(double.parse(Total.toString()))}',
                                  // '${Total}',
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
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
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
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(4.0),
                                child: pw.Column(
                                  children: [
                                    pw.Text(
                                      'หมายเหตุ',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          font: ttf,
                                          color: Colors_pd,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      '................................................................................................................................................................................',
                                      textAlign: pw.TextAlign.center,
                                      // maxLines: 1,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  ],
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(4.0),
                                child: pw.Column(
                                  children: [
                                    pw.Text(
                                      'ผู้รับเงิน',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          font: ttf,
                                          color: Colors_pd,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      ' (..............................................)',
                                      textAlign: pw.TextAlign.left,
                                      maxLines: 1,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                    pw.Text(
                                      'วันที่........../........../..........',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  ],
                                ),
                              ),
                            ),
                          ]),
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
                    color: Colors_pd,
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
    ///-------------------------------------------------->
    // final List<int> bytes = await pdf.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    // final dir = await FileSaver.instance.saveFile(
    //     "ใบเสร็จรับเงิน(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPdfgen_Billsplay(
              doc: pdf,
              title: (Slip_status.toString() == '1')
                  ? 'ใบรับเงินชั่วคราว(รายละเอียดบิลใบเสร็จชั่วคราว)'
                  : 'ใบเสร็จรับเงิน/ใบกำกับภาษี(รายละเอียดบิลใบเสร็จชั่วคราว)'),
        ));
  }
}
