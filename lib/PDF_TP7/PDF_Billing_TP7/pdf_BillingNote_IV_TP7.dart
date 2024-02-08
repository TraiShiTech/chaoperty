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

import '../../CRC_16_Prompay/generate_qrcode.dart';
import '../../ChaoArea/ChaoAreaRenew_Screen.dart';
import '../../Constant/Myconstant.dart';
import '../../PeopleChao/Bills_.dart';
import '../../Style/ThaiBaht.dart';

class Pdfgen_BillingNoteInvlice_TP7 {
  //////////---------------------------------------------------->(ใบวางบิล แจ้งหนี้)  ใช้  ++
  static void exportPDF_BillingNoteInvlice_TP7(
      foder,

      ///(ser_BillingNote 1 = วางบิล  /// 2 = ประวัติวางบิล )
      // ser_BillingNote,
      tableData003,
      context,
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
      cFinn,
      date_Transaction,
      paymentName1,
      paymentName2,
      selectedValue_bank_bno,
      payment_Ptser1,
      bank1,
      img1,
      btype1,
      ptser1,
      ptname1,
      Preview_ser) async {
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    var nFormat3 = NumberFormat("###-##-##0", "en_US");
    // double percen =
    //     (double.parse('$DisC') / double.parse(' $Sum_SubTotal')) * 100.00;
    final ttf = pw.Font.ttf(font);
    double font_Size = 10.0;
    //////---------------------------------------------> (วางบิล)
    // DateTime date = DateTime.now();
    // var formatter = new DateFormat.MMMMd('th_TH');
    // String thaiDate = formatter.format(date);
    // //////--------------------------------------------->(ประวัติวางบิล)

    var formatter = new DateFormat.MMMMd('th_TH');
    // String thaiDate = formatter.format(date);
    final thaiDate2 = DateTime.parse(date_Transaction);
    final formatter2 = DateFormat('d MMMM', 'th_TH');
    final formattedDate2 = formatter.format(thaiDate2);
    //////--------------->พ.ศ.
    DateTime dateTime2 = DateTime.parse(date_Transaction);
    int newYear2 = dateTime2.year + 543;
    //////--------------------------------------------->
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    String total_QR = '${nFormat.format(double.parse('${Total}'))}';
    String newTotal_QR = total_QR.replaceAll(RegExp(r'[^0-9]'), '');
    List netImage = [];
    List netImage_QR = [];
    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    if (img1 == null || img1.toString() == '') {
      netImage_QR.add(await networkImage(
          '${MyConstant().domain}/Awaitdownload/imagenot.png'));
      // netImage_QR.add(iconImage);
    } else {
      netImage_QR.add(await networkImage(
          '${MyConstant().domain}/files/$foder/payment/${img1}'));
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

    pw.Widget Header(int serpang) {
      return pw.Column(children: [
        pw.Row(
          children: [
            pw.Container(
              width: 200,
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  (netImage.isEmpty)
                      ? pw.Container(
                          height: 30,
                          width: 40,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.grey200,
                            border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.grey300),
                              left: pw.BorderSide(color: PdfColors.grey300),
                              top: pw.BorderSide(color: PdfColors.grey300),
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              '$bill_name ',
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ))
                      : pw.Container(
                          height: 30,
                          width: 40,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.grey200,
                            border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.grey300),
                              left: pw.BorderSide(color: PdfColors.grey300),
                              top: pw.BorderSide(color: PdfColors.grey300),
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Image(
                            (netImage[0]),
                            height: 30,
                            width: 40,
                          ),
                        ),
                  pw.SizedBox(height: 1 * PdfPageFormat.mm),
                  pw.Text(
                    '${bill_name.toString().trim()}',
                    maxLines: 1,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                    ),
                  ),
                  pw.Text(
                    'ที่อยู่ : $bill_addr',
                    maxLines: 1,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      color: Colors_pd,
                      font: ttf,
                    ),
                  ),
                  pw.Text(
                    (bill_tax.toString() == '' ||
                            bill_tax == null ||
                            bill_tax.toString() == 'null')
                        ? 'เลขประจำตัวผู้เสียภาษี : 0'
                        : 'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'โทร : $bill_tel',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'ลูกค้า(Customer)',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    (sname_.toString() == '' ||
                            sname_ == null ||
                            sname_.toString() == 'null')
                        ? '-'
                        : '${sname_}',
                    textAlign: pw.TextAlign.right, maxLines: 1,
                    // textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    (addr_.toString() == '' ||
                            addr_ == null ||
                            addr_.toString() == 'null')
                        ? 'ที่อยู่ : -'
                        : 'ที่อยู่ : ${addr_}',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    (tax_.toString() == '' ||
                            tax_ == null ||
                            tax_.toString() == 'null')
                        ? 'เลขประจำตัวผู้เสียภาษี : 0'
                        : 'เลขประจำตัวผู้เสียภาษี : ${tax_}',
                    textAlign: pw.TextAlign.justify,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
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
                    'ใบวางบิล/ใบแจ้งหนี้ (Invoice)',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    (serpang == 1) ? 'ต้นฉบับ (Original)' : 'สำเนา (Copy)',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    (cFinn.toString() == '' ||
                            cFinn == null ||
                            cFinn.toString() == 'null')
                        ? 'เลขที่(ID) : -'
                        : 'เลขที่(ID) : ${cFinn}',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    (date_Transaction == null)
                        ? 'วันที่ : '
                        : 'วันที่ : $formattedDate2 ${newYear2}',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // pw.SizedBox(height: 1 * PdfPageFormat.mm),
        // pw.Divider(),
        // pw.SizedBox(height: 1 * PdfPageFormat.mm),
      ]);
    }

    pw.Widget footer_data_sub(int i) {
      return (btype1.toString() == 'CASH')
          ? pw.Expanded(
              child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(0),
                  child: pw.Text(
                    '1. ขอความกรุณาชำระค่าบริการ/ค่าเช่าให้ตรงตามยอด เพื่อความถูกต้อง',
                    textAlign: pw.TextAlign.left,
                    maxLines: 1,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: font_Size,
                        color: PdfColors.grey800),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(0),
                  child: pw.Text(
                    '2. หากเกิดข้อผิดพลาดโปรดเก็บหลักฐานการชำระไว้ เพื่อติดต่อเจ้าหน้าที่',
                    textAlign: pw.TextAlign.left,
                    maxLines: 1,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: font_Size,
                        color: PdfColors.red400),
                  ),
                ),
              ],
            ))
          : pw.Expanded(
              child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(0),
                  child: pw.Text(
                    '1. ขอความกรุณาชำระค่าบริการ/ค่าเช่าให้ตรงตามยอด เพื่อความถูกต้อง',
                    textAlign: pw.TextAlign.left,
                    maxLines: 1,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: font_Size,
                        color: PdfColors.grey800),
                  ),
                ),
                // (payment_Ptser1 == '6')
                //     ?
                if (ptser1.toString() == '2' ||
                    ptser1.toString() == '5' ||
                    ptser1.toString() == '6')
                  pw.Padding(
                    padding: pw.EdgeInsets.all(0),
                    child: pw.Text(
                      '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${bank1} เลขที่บัญชี ${selectedValue_bank_bno} [ ${(ptname1 == 'Online Payment') ? 'PromptPay QR' : (ptname1 == 'เงินโอน') ? 'เลขบัญชี' : 'Online Standard QR'} ]',
                      //  '2. การชำระเงิน ท่านสามารถโอนเข้าเลขที่บัญชี ${finnancetransModels.where((model) => model.ptser == '6' && model.dtype != 'MM').map((model) => model.bno).join(', ')}',
                      textAlign: pw.TextAlign.left,
                      maxLines: 1,
                      style: pw.TextStyle(
                          font: ttf,
                          fontSize: font_Size,
                          color: PdfColors.grey800),
                    ),
                  ),
                // : pw.Padding(
                //     padding: pw.EdgeInsets.all(0),
                //     child: pw.Text(
                //       (payment_Ptser1 == '2')
                //           ? '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${bank1} เลขที่บัญชี ${selectedValue_bank_bno} '
                //           : '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${bank1}  เลขที่บัญชี ${selectedValue_bank_bno} ($paymentName1)',
                //       textAlign: pw.TextAlign.left,
                //       maxLines: 1,
                //       style: pw.TextStyle(
                //           font: ttf,
                //           fontSize: font_Size,
                //           color: PdfColors.grey800),
                //     ),
                //   ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(0),
                  child: pw.Text(
                    '3. หากเกิดข้อผิดพลาดโปรดเก็บหลักฐานการชำระไว้ เพื่อติดต่อเจ้าหน้าที่',
                    textAlign: pw.TextAlign.left,
                    maxLines: 1,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: font_Size,
                        color: PdfColors.red400),
                  ),
                ),
              ],
            ));
    }

    pw.Widget footer_data(int serpang) {
      return pw.Align(
        alignment: pw.Alignment.bottomCenter,
        child: pw.Container(
          // decoration: new pw.BoxDecoration(
          //     border: pw.Border(
          //         bottom: pw.BorderSide(
          //             color: PdfColors.grey600,
          //             width: 2.0,
          //             style: pw.BorderStyle.none))),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'หมายเหตุ(Note)',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          fontSize: font_Size,
                          color: PdfColors.grey800),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'ลงชื่อ.......................................................................',
                          textAlign: pw.TextAlign.left,
                          maxLines: 1,
                          style: pw.TextStyle(
                              // fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              fontSize: font_Size,
                              color: PdfColors.grey800),
                        ),
                        pw.Text(
                          '(........................................................)',
                          textAlign: pw.TextAlign.left,
                          maxLines: 1,
                          style: pw.TextStyle(
                              // fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              fontSize: font_Size,
                              color: PdfColors.grey800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.Row(children: [
                pw.Expanded(child: footer_data_sub(0)),
                if (ptser1.toString() == '6')
                  pw.Container(
                      child: pw.Column(
                    children: [
                      pw.BarcodeWidget(
                        data:
                            '|$selectedValue_bank_bno\r$cFinn\r${DateFormat('ddMM').format(DateTime.parse(date_Transaction))}${DateTime.parse('${date_Transaction}').year + 543}\r${newTotal_QR}\r',
                        barcode: pw.Barcode.qrCode(),
                        height: 35,
                        width: 40,
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(0),
                        child: pw.Text(
                          'สแกน (Scan me)',
                          textAlign: pw.TextAlign.left,
                          maxLines: 1,
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: font_Size,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ],
                  )),
                if (ptser1.toString() == '5')
                  pw.Container(
                      child: pw.Column(
                    children: [
                      pw.BarcodeWidget(
                        data: generateQRCode(
                            promptPayID: "$selectedValue_bank_bno",
                            amount: double.parse((Total == null || Total == '')
                                ? '0'
                                : '$Total')),
                        barcode: pw.Barcode.qrCode(),
                        height: 35,
                        width: 40,
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(0),
                        child: pw.Text(
                          'สแกน (Scan me)',
                          textAlign: pw.TextAlign.left,
                          maxLines: 1,
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: font_Size,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ],
                  )),
                if (img1.toString() != '')
                  if (ptser1.toString() == '2')
                    pw.Container(
                        child: pw.Column(
                      children: [
                        pw.Image(
                          (netImage_QR[0]),
                          height: 35,
                          width: 40,
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(0),
                          child: pw.Text(
                            'สแกน (Scan me)',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: font_Size,
                                color: PdfColors.grey800),
                          ),
                        ),
                      ],
                    )),
              ]),
              // pw.Row(
              //   children: (btype1.toString() == 'CASH')
              //       ? [pw.Expanded(child: footer_data_sub(0))]
              //       : (payment_Ptser1.toString() == '6')
              //           ? [
              //               footer_data_sub(0),
              //               pw.Column(children: [
              //                 pw.Container(
              //                   child: pw.BarcodeWidget(
              //                     data:
              //                         '|${selectedValue_bank_bno}\r$cFinn\r${DateFormat('dd-MM-yyyy').format(DateTime.parse('${date_Transaction}'))}\r${newTotal_QR}\r',
              //                     barcode: pw.Barcode.qrCode(),
              //                     height: 35,
              //                     width: 40,
              //                   ),
              //                 ),
              //                 pw.Padding(
              //                   padding: pw.EdgeInsets.all(0),
              //                   child: pw.Text(
              //                     'สแกน (Scan me)',
              //                     textAlign: pw.TextAlign.left,
              //                     maxLines: 1,
              //                     style: pw.TextStyle(
              //                         font: ttf,
              //                         fontSize: font_Size,
              //                         color: PdfColors.grey800),
              //                   ),
              //                 ),
              //               ]),
              //             ]
              //           : [
              //               footer_data_sub(0),
              //               // for (var i = 0; i < finnancetransModels.length; i++)
              //               if (payment_Ptser1.toString() != '1')
              //                 pw.Column(children: [
              //                   pw.Container(
              //                     child: (payment_Ptser1.toString() == '5')
              //                         ? pw.BarcodeWidget(
              //                             data: generateQRCode(
              //                                 promptPayID:
              //                                     "${selectedValue_bank_bno}",
              //                                 amount: double.parse((Total ==
              //                                             null ||
              //                                         Total.toString() == '')
              //                                     ? '0'
              //                                     : '${Total}')),
              //                             barcode: pw.Barcode.qrCode(),
              //                             height: 35,
              //                             width: 40,
              //                           )
              //                         : (netImage_QR.length == 0)
              //                             ? pw.Text('')
              //                             : pw.Image(
              //                                 (netImage_QR[0]),
              //                                 height: 35,
              //                                 width: 40,
              //                               ),
              //                   ),
              //                   pw.Padding(
              //                     padding: pw.EdgeInsets.all(0),
              //                     child: pw.Text(
              //                       'สแกน (Scan me)',
              //                       textAlign: pw.TextAlign.left,
              //                       maxLines: 1,
              //                       style: pw.TextStyle(
              //                           font: ttf,
              //                           fontSize: font_Size,
              //                           color: PdfColors.grey800),
              //                     ),
              //                   ),
              //                 ]),
              //             ],
              // ),

              if (serpang == 1 && tableData003.length < 7)
                pw.Padding(
                  padding: pw.EdgeInsets.all(0),
                  child: pw.Text(
                    '...' * 140,
                    maxLines: 1,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: font_Size,
                        color: PdfColors.grey500),
                  ),
                ),
              if (tableData003.length > 6)
                pw.SizedBox(height: 2.2 * PdfPageFormat.mm),
            ],
          ),
        ),
      );
    }

    pw.Widget Body_data(int serpang) {
      return pw.Container(
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Align(
              alignment: pw.Alignment.topCenter,
              child: pw.Container(
                  child: pw.Column(
                children: [
                  pw.Container(
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        top: pw.BorderSide(color: PdfColors.grey800),
                        bottom: pw.BorderSide(color: PdfColors.grey800),
                      ),
                    ),
                    // padding: const pw.EdgeInsets.all(1.0),
                    child: pw.Row(
                      children: [
                        pw.Container(
                          width: 50,
                          decoration: const pw.BoxDecoration(
                            // color: PdfColors.green100,
                            border: pw.Border(
                                // left: pw.BorderSide(color: PdfColors.grey800),
                                // top: pw.BorderSide(color: PdfColors.grey800),
                                // bottom: pw.BorderSide(color: PdfColors.grey800),
                                ),
                          ),
                          // height: 25,
                          child: pw.Text(
                            'ลำดับ(#)',
                            maxLines: 1,
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.black),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'กำหนดชำระ(Due date)',
                              maxLines: 1,
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'รายการชำระ (Description)',
                              textAlign: pw.TextAlign.left,
                              maxLines: 1,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'ส่วนลด (Dis)',
                              textAlign: pw.TextAlign.right,
                              maxLines: 1,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'ราคา (Price)',
                              textAlign: pw.TextAlign.right,
                              maxLines: 1,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  for (int index = 0; index < tableData003.length; index++)
                    pw.Container(
                      // decoration: const pw.BoxDecoration(
                      //   // color: PdfColors.green100,
                      //   border: pw.Border(
                      //     bottom: pw.BorderSide(color: PdfColors.grey800),
                      //   ),
                      // ),
                      child: pw.Row(
                        children: [
                          pw.Container(
                            width: 50,
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.white,
                              border: const pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey600),
                                  // bottom: pw.BorderSide(color: PdfColors.grey600),
                                  ),
                            ),
                            // padding: const pw.EdgeInsets.all(1.0),
                            child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                '${index + 1}',
                                maxLines: 1,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              // padding: const pw.EdgeInsets.all(1.0),
                              child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  (tableData003[index][1] == null)
                                      ? '${tableData003[index][1]}'
                                      : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${tableData003[index][1]}'))}',
                                  // '${tableData003[index][1]}',
                                  maxLines: 1,
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 4,
                            child: pw.Container(
                              // padding: const pw.EdgeInsets.all(1.0),
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  '${tableData003[index][2]}',
                                  maxLines: 1,
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              // padding: const pw.EdgeInsets.all(1.0),
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // right: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  '0.00',
                                  maxLines: 1,
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              // padding: const pw.EdgeInsets.all(1.0),
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // right: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  '${tableData003[index][6]}',
                                  maxLines: 1,
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // pw.Divider(color: PdfColors.grey),

                  // pw.SizedBox(height: 1 * PdfPageFormat.mm),
                  pw.Container(
                    // height: 25,
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        top: pw.BorderSide(color: PdfColors.grey600),
                        // bottom: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    padding: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
                    alignment: pw.Alignment.centerRight,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            //"${nFormat2.format(double.parse(Total.toString()))}";
                            '(~${convertToThaiBaht(double.parse(Total.toString()))}~)',
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              // fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              fontStyle: pw.FontStyle.italic,
                              // decoration:
                              //     pw.TextDecoration.lineThrough,
                              color: PdfColors.grey800,
                            ),
                          ),
                        ),
                        // pw.Spacer(flex: 6),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                // top: pw.BorderSide(color: PdfColors.grey600),
                                bottom: pw.BorderSide(color: PdfColors.grey600),
                              ),
                            ),
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Text(
                                        'ส่วนลด(Discount)',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                            // fontWeight:
                                            //     pw.FontWeight.bold,
                                            font: ttf,
                                            fontSize: font_Size,
                                            color: PdfColors.grey800),
                                      ),
                                    ),
                                    pw.Text(
                                      '${nFormat.format(double.parse(DisC.toString()))}',
                                      textAlign: pw.TextAlign.right,
                                      style: pw.TextStyle(
                                          // fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          fontSize: font_Size,
                                          color: PdfColors.grey800),
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Text(
                                        'จำนวนเงินรวมทั้งสิ้น(Total amount)',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                            // fontWeight:
                                            //     pw.FontWeight.bold,
                                            font: ttf,
                                            fontSize: font_Size,
                                            color: PdfColors.grey800),
                                      ),
                                    ),
                                    pw.Text(
                                      '${nFormat.format(double.parse(Total.toString()) - double.parse(DisC.toString()))}',
                                      textAlign: pw.TextAlign.right,
                                      style: pw.TextStyle(
                                          // fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          fontSize: font_Size,
                                          color: PdfColors.grey800),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // pw.SizedBox(height: 1 * PdfPageFormat.mm),
                ],
              )),
            ),
            if (tableData003.length < 11) footer_data(serpang)
          ],
        ),
      );
    }

    if (tableData003.length < 11)
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.copyWith(
            marginBottom: 4.00,
            marginLeft: 8.00,
            marginRight: 8.00,
            marginTop: 8.00,
          ),
          build: (context) {
            return [
              pw.Container(
                  height: PdfPageFormat.a4.height / 2.05,
                  decoration: const pw.BoxDecoration(
                    // color: PdfColors.green50,
                    border: pw.Border(
                        // top: pw.BorderSide(color: PdfColors.grey800),
                        // bottom: pw.BorderSide(color: PdfColors.grey800),
                        ),
                  ),
                  child: pw.Column(
                    children: [
                      Header(1),
                      pw.Expanded(child: Body_data(1)),
                    ],
                  )),
              pw.Container(
                  height: PdfPageFormat.a4.height / 2.05,
                  decoration: const pw.BoxDecoration(
                    // color: PdfColors.red50,
                    border: pw.Border(
                        // top: pw.BorderSide(color: PdfColors.grey800),
                        // bottom: pw.BorderSide(color: PdfColors.grey800),
                        ),
                  ),
                  child: pw.Column(
                    children: [
                      Header(2),
                      pw.Expanded(child: Body_data(2)),
                    ],
                  )),
            ];
          },
          // footer: (context) {
          //   return pw.Align(
          //     alignment: pw.Alignment.bottomRight,
          //     child: pw.Text(
          //       'หน้า ${context.pageNumber} / ${context.pagesCount} ',
          //       textAlign: pw.TextAlign.left,
          //       style: pw.TextStyle(
          //         fontSize: 10.0,
          //         font: ttf,
          //         color: Colors_pd,
          //         // fontWeight: pw.FontWeight.bold
          //       ),
          //     ),
          //   );
          // },
        ),
      );

    if (tableData003.length > 10)
      pdf.addPage(
        pw.MultiPage(
            pageFormat: PdfPageFormat.a4.copyWith(
              marginBottom: 4.00,
              marginLeft: 8.00,
              marginRight: 8.00,
              marginTop: 8.00,
            ),
            header: (context) {
              return Header(1);
            },
            build: (context) {
              return [Body_data(1)];
            },
            footer: (tableData003.length < 10)
                ? null
                : (context) {
                    return footer_data(1);
                  }),
      );
    if (tableData003.length > 10)
      pdf.addPage(
        pw.MultiPage(
            pageFormat: PdfPageFormat.a4.copyWith(
              marginBottom: 4.00,
              marginLeft: 8.00,
              marginRight: 8.00,
              marginTop: 8.00,
            ),
            header: (context) {
              return Header(2);
            },
            build: (context) {
              return [Body_data(2)];
            },
            footer: (tableData003.length < 10)
                ? null
                : (context) {
                    return footer_data(2);
                  }),
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
    if (Preview_ser.toString() == '1') {
      final List<int> bytes = await pdf.save();
      final Uint8List data = Uint8List.fromList(bytes);
      MimeType type = MimeType.PDF;
      final dir = await FileSaver.instance
          .saveFile('ใบวางบิล/ใบแจ้งหนี้${cFinn}', data, "pdf", mimeType: type);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewPdfgen_Bills(
                doc: pdf, nameBills: 'ใบวางบิล/ใบแจ้งหนี้${cFinn}'),
          ));
    }
  }
}
