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

class PdfgenReceipt_PayPakan {
  //////////---------------------------------------------------->(ใบเสร็จรับเงินคืนเงินประกัน Chao_Return)
  static void exportPDF_Receipt_PayPakan(
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
      Value_newDateD,
      sum_Pakan,
      sum_ST,
      sum_Pakan_KF,
      transPakanKFModels,
      transPakanModels) async {
    ////
    //// ------------>(ใบเสร็จรับเงินคืนเงินประกัน Chao_Return)
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
      '', '', '', '', '', '', ''
      // for (int index = 0; index < _TransModels.length; index++)
      //   [
      //     '${index + 1}',
      //     '${_TransModels[index].date}',
      //     '${_TransModels[index].name}',
      //     '${_TransModels[index].tqty}',
      //     '${_TransModels[index].unit_con}',
      //     _TransModels[index].qty_con == '0.00'
      //         ? '${nFormat.format(double.parse(_TransModels[index].amt_con!))}'
      //         : '${nFormat.format(double.parse(_TransModels[index].qty_con!))}',
      //     '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
      //   ],
    ];
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
                        'ใบเสร็จคืนเงินประกัน',
                        style: pw.TextStyle(
                          fontSize: 10.00,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
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
                        '',
                        // 'วันที่ออกบิล: $thaiDate ${DateTime.now().year + 543}',
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
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    'รูปแบบชำระ ',
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
              ],
            ),
            pw.Row(children: [
              pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    //  nFormat.format(double.parse(
                    //                                 Form_payment1.text)) ==
                    //                             '0.00'
                    //                         ? '${nFormat.format(sum_Pakan - sum_ST)}'
                    //                         : '${nFormat.format(double.parse(Form_payment1.text))}'
                    child: (paymentName1.toString().trim() == 'เงินโอน' ||
                            paymentName1.toString().trim() == 'เงินโอน' ||
                            paymentName1.toString().trim() ==
                                'Online Payment' ||
                            paymentName1.toString().trim() == 'Online Payment')
                        ? pw.Text(
                            (Form_payment1 == null ||
                                    Form_payment1.toString() == 'null' ||
                                    Form_payment1.toString() == '')
                                ? '1.เงินโอน : -'
                                : '1.เงินโอน : ${nFormat.format(double.parse('${sum_Pakan_KF + sum_ST}'))} บาท     (~${convertToThaiBaht(double.parse('${sum_Pakan_KF + sum_ST}'))}~)',
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
                                : '1.$paymentName1 : ${nFormat.format(double.parse(Form_payment1.text)) == '0.00' ? '${nFormat.format(sum_Pakan - sum_ST)}' : '${nFormat.format(double.parse(Form_payment1.text))}'} บาท     (~${convertToThaiBaht(double.parse('${nFormat.format(double.parse(Form_payment1.text)) == '0.00' ? sum_Pakan - sum_ST : Form_payment1.text}'))}~)',
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
                          'ยอดเงิน',
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
            for (int i = 0; i < transPakanKFModels.length; i++)
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
                          '${i + 1}',
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
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            'ค่าบริการค้างชำระ (${DateFormat('dd-MM-').format(DateTime.parse('${transPakanKFModels[i].date} 00:00:00'))}${int.parse(DateFormat('y').format(DateTime.parse('${transPakanKFModels[i].date} 00:00:00'))) + 543})',
                            maxLines: 2,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        )),
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
                            '${nFormat.format(double.parse(transPakanKFModels[i].total!))}',
                            maxLines: 2,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        )),
                  ),
                ],
              ),
            for (int x = 0; x < _TransModels.length; x++)
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
                          '${x + 1 + transPakanKFModels.length}',
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
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${_TransModels[x].name}',
                            maxLines: 2,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        )),
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
                            '${nFormat.format(double.parse(_TransModels[x].total!))}',
                            maxLines: 2,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        )),
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
                              '${nFormat.format(sum_Pakan_KF + sum_ST)}',
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
                              '${nFormat.format(0)}',
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
                              '${nFormat.format(0)}',
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
                              '${nFormat.format(sum_Pakan_KF + sum_ST)}',
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
                              '${nFormat.format(0)}',
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
                        // nFormat.format(double.parse(Form_payment1.text)) ==
                        //         '0.00'
                        //     ? '${nFormat.format(sum_Pakan - sum_ST)}'
                        //     : '${nFormat.format(double.parse(Form_payment1.text))}',
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดคืนเงินประกัน',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              transPakanModels.length == 0
                                  ? _TransModels.length == 0
                                      ? '0.00'
                                      : sum_Pakan - sum_ST < 0
                                          ? '0.00'
                                          : '${nFormat.format(sum_Pakan - sum_ST)}'
                                  : sum_Pakan - sum_ST < 0
                                      ? '0.00'
                                      : '${nFormat.format(sum_Pakan - sum_ST)}',
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
                                'ยอดชำระ',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              nFormat.format(sum_Pakan - sum_ST > 0
                                          ? 0
                                          : (sum_ST - sum_Pakan)) ==
                                      '0.00'
                                  ? '${nFormat.format(sum_Pakan - sum_ST > 0 ? 0 : sum_ST - sum_Pakan)}'
                                  : '${nFormat.format(sum_ST - sum_Pakan)}',
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
                          double.parse(transPakanModels.length == 0
                                      ? _TransModels.length == 0
                                          ? '0.00'
                                          : sum_Pakan - sum_ST < 0
                                              ? '0.00'
                                              : '${sum_Pakan - sum_ST}'
                                      : sum_Pakan - sum_ST < 0
                                          ? '0.00'
                                          : '${sum_Pakan - sum_ST}') ==
                                  0.00
                              ? '(~${convertToThaiBaht(double.parse(('${nFormat.format(sum_Pakan - sum_ST > 0 ? 0 : (sum_ST - sum_Pakan))}' == '0.00 ') ? '${sum_Pakan - sum_ST > 0 ? 0 : sum_ST - sum_Pakan}' : '${sum_ST - sum_Pakan}'))}~)'
                              : '(~${convertToThaiBaht(double.parse(transPakanModels.length == 0 ? _TransModels.length == 0 ? '0.00' : sum_Pakan - sum_ST < 0 ? '0.00' : '${sum_Pakan - sum_ST}' : sum_Pakan - sum_ST < 0 ? '0.00' : '${sum_Pakan - sum_ST}'))}~)',
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
                                  double.parse(transPakanModels.length == 0
                                              ? _TransModels.length == 0
                                                  ? '0.00'
                                                  : sum_Pakan - sum_ST < 0
                                                      ? '0.00'
                                                      : '${sum_Pakan - sum_ST}'
                                              : sum_Pakan - sum_ST < 0
                                                  ? '0.00'
                                                  : '${sum_Pakan - sum_ST}') ==
                                          0.00
                                      ? '${nFormat.format(double.parse(('${nFormat.format(sum_Pakan - sum_ST > 0 ? 0 : (sum_ST - sum_Pakan))}' == '0.00 ') ? '${sum_Pakan - sum_ST > 0 ? 0 : sum_ST - sum_Pakan}' : '${sum_ST - sum_Pakan}'))}'
                                      : '${nFormat.format(double.parse(transPakanModels.length == 0 ? _TransModels.length == 0 ? '0.00' : sum_Pakan - sum_ST < 0 ? '0.00' : '${sum_Pakan - sum_ST}' : sum_Pakan - sum_ST < 0 ? '0.00' : '${sum_Pakan - sum_ST}'))}',

                                  //  '${nFormat.format(double.parse('${sum_Pakan_KF + sum_ST}'))}',

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
                  ? 'ใบเสร็จคืนเงินประกัน'
                  : 'ใบเสร็จคืนเงินประกัน'),
        ));
  }

/////////////--------------------------------------------------->
}