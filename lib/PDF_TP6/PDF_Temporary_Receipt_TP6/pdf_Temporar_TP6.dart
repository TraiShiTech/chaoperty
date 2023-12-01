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
import '../../PeopleChao/Pays_.dart';
import '../../Style/ThaiBaht.dart';

class Pdfgen_Temporary_receipt_TP6 {
  static void exportPDF_Temporary_receipt_TP6(
      foder,
      tableData00,
      tableData01,
      context,
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
      sname,
      cname,
      addr,
      tax,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      numinvoice,
      numdoctax,
      finnancetransModels,
      date_Transaction,
      dayfinpay,
      type_bills,
      dis_sum_Matjum,
      TitleType_Default_Receipt_Name) async {
    ////
    //// ------------>(ใบเสร็จรับเงินชั่วคราว paySrsscreen_)
    ///////
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

    int pageCount = 1; // Initialize the page count
    final ttf = pw.Font.ttf(font);

    double font_Size = 10.0;
    //////--------------------------------------------->
    // DateTime date = DateTime.now();
    // // var formatter = new DateFormat.MMMMd('th_TH');
    // // String thaiDate = formatter.format(date);
    // final thaiDate = DateTime.parse(date_Transaction);
    // final formatter = DateFormat('d MMMM', 'th_TH');
    // final formattedDate = formatter.format(thaiDate);
    // //////--------------->พ.ศ.
    // DateTime dateTime = DateTime.parse(date_Transaction);
    // int newYear = dateTime.year + 543;
    //////--------------------------------------------->
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    List netImage_QR = [];

    // String total_QR = '${nFormat.format(double.parse('${Total}'))}';
    String total_QR =
        '${nFormat.format(finnancetransModels.where((model) => model.type.toString() == 'OP' && model.dtype.toString() != 'MM').fold<double>(0.0, (double sum, model) => sum + (double.parse(model.total ?? '0.00'))))}';

    String newTotal_QR = total_QR.replaceAll(RegExp(r'[^0-9]'), '');

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    for (int i = 0; i < finnancetransModels.length; i++) {
      if (finnancetransModels[i].img == null ||
          finnancetransModels[i].img.toString() == '') {
        netImage_QR.add(iconImage);
      } else {
        netImage_QR.add(await networkImage(
            '${MyConstant().domain}/files/$foder/payment/${finnancetransModels[i].img}'));
      }
    }
    bool hasNonCashTransaction = finnancetransModels.any((transaction) {
      return transaction.type.toString() != 'CASH';
    });
    bool hasNonCashTransaction2 = finnancetransModels.any((transaction) {
      return transaction.ptser.toString() == '6';
    });

//////////---------------------------------->
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 4.00,
          marginLeft: 8.00,
          marginRight: 8.00,
          marginTop: 8.00,
        ),
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
                              fontSize: 10,
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
                        // fit: pw.BoxFit.fill,
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
                          color: Colors_pd,
                          fontSize: font_Size,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        (bill_addr == null ||
                                bill_addr.toString() == 'null' ||
                                bill_addr.toString() == '')
                            ? 'ที่อยู่ : -'
                            : 'ที่อยู่ : $bill_addr',
                        maxLines: 3,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          color: Colors_pd,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'โทรศัพท์ : $bill_tel',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'อีเมล : $bill_email',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (bill_tax.toString() == '' || bill_tax == null)
                            ? 'เลขประจำตัวผู้เสียภาษี : 0'
                            : 'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                        // textAlign: pw.TextAlign.justify,
                        textAlign: pw.TextAlign.right,
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
                      if (TitleType_Default_Receipt_Name != null)
                        pw.Text(
                          '[ $TitleType_Default_Receipt_Name ]',
                          maxLines: 1,
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey400,
                          ),
                        ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        'ใบรับเงินชั่วคราว',
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (numdoctax.toString() == '')
                            ? 'เลขที่ : $numinvoice'
                            : 'เลขที่ : $numdoctax',
                        maxLines: 2,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        '',
                        // 'วันที่ทำรายการ : $formattedDate ${newYear}',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
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
          ]);
        },
        build: (context) {
          return [
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
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (sname.toString() == null ||
                                sname.toString() == '' ||
                                sname.toString() == 'null')
                            ? ' -'
                            : '$sname',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (addr.toString() == null ||
                                addr.toString() == '' ||
                                addr.toString() == 'null')
                            ? 'ที่อยู่ : -'
                            : 'ที่อยู่ : $addr',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (tax == null ||
                                tax.toString() == '' ||
                                tax.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี : 0'
                            : 'เลขประจำตัวผู้เสียภาษี : $tax',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  ),
                ),
                if (type_bills.toString().trim() != '' || type_bills != null)
                  pw.SizedBox(width: 10 * PdfPageFormat.mm),
                pw.Expanded(
                  flex: 4,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        (type_bills.toString().trim() == '' ||
                                type_bills == null)
                            ? ''
                            : 'ประเภท ( ล็อคเสียบ )',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Row(children: [
                      //   pw.Text(
                      //     'พื้นที่ : ',
                      //     textAlign: pw.TextAlign.justify,
                      //     style: pw.TextStyle(
                      //       fontSize: 8,
                      //       font: ttf,
                      //       fontWeight: pw.FontWeight.bold,
                      //       color: Colors_pd,
                      //     ),
                      //   ),
                      //   pw.Expanded(
                      //     flex: 4,
                      //     child: pw.Text(
                      //       (area_ == null || area_.toString() == '')
                      //           ? '-'
                      //           : '${area_}',
                      //       // textAlign: pw.TextAlign.justify,
                      //       style: pw.TextStyle(
                      //         fontSize: 8,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //   ),
                      // ]),
                    ],
                  ),
                ),
              ],
            ),

            // pw.SizedBox(height: 3 * PdfPageFormat.mm),
            // pw.Row(
            //   children: [
            //     pw.Expanded(
            //       flex: 4,
            //       child: pw.Text(
            //         'รูปแบบชำระ',
            //         textAlign: pw.TextAlign.justify,
            //         style: pw.TextStyle(
            //           fontSize: font_Size,
            //           font: ttf,
            //           fontWeight: pw.FontWeight.bold,
            //           color: Colors_pd,
            //         ),
            //       ),
            //     ),
            //     pw.SizedBox(width: 10 * PdfPageFormat.mm),
            //     pw.Expanded(
            //       flex: 4,
            //       child: pw.Column(
            //         mainAxisSize: pw.MainAxisSize.min,
            //         crossAxisAlignment: pw.CrossAxisAlignment.end,
            //         children: [
            //           pw.Text(
            //             (dayfinpay.toString() == '' ||
            //                     dayfinpay.toString() == 'null' ||
            //                     dayfinpay == null)
            //                 ? 'วันที่ชำระ : - '
            //                 : 'วันที่ชำระ : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${dayfinpay}'))} ',
            //             style: pw.TextStyle(
            //               fontSize: font_Size,
            //               fontWeight: pw.FontWeight.bold,
            //               font: ttf,
            //               color: Colors_pd,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            // pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // // pw.Row(children: [
            // //   for (var i = 0; i < finnancetransModels.length; i++)
            // //     pw.Row(
            // //       children: [
            // //         if (finnancetransModels[i].type.toString() == 'CASH')
            // //           pw.Text(
            // //             '${i + 1}.เงินสด : ',
            // //             textAlign: pw.TextAlign.justify,
            // //             style: pw.TextStyle(
            // //               fontSize: 10.0,
            // //               font: ttf,
            // //               fontWeight: pw.FontWeight.bold,
            // //             ),
            // //           ),
            // //         if (finnancetransModels[i].type.toString() != 'CASH')
            // //           pw.Text(
            // //             '${i + 1}.เงินโอน : ',
            // //             textAlign: pw.TextAlign.justify,
            // //             style: pw.TextStyle(
            // //               fontSize: 10.0,
            // //               font: ttf,
            // //               fontWeight: pw.FontWeight.bold,
            // //             ),
            // //           ),
            // //         pw.Text(
            // //           '${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท',
            // //           // '${Form_payment1.toString()} บาท',
            // //           // textAlign: pw.TextAlign.justify,
            // //           style: pw.TextStyle(
            // //               fontSize: 10.0, font: ttf, color: PdfColors.grey),
            // //         ),
            // //         // pw.Expanded(
            // //         //   flex: 4,
            // //         //   child:
            // //         // pw.Text(
            // //         //     '${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท',
            // //         //     // '${Form_payment1.toString()} บาท',
            // //         //     // textAlign: pw.TextAlign.justify,
            // //         //     style: pw.TextStyle(
            // //         //         fontSize: 10.0, font: ttf, color: PdfColors.grey),
            // //         //   ),
            // //         // ),
            // //       ],
            // //     )
            // // ]),

            // pw.Row(
            //   children: [
            //     pw.Expanded(
            //       flex: 4,
            //       child: pw.Column(
            //         mainAxisSize: pw.MainAxisSize.min,
            //         crossAxisAlignment: pw.CrossAxisAlignment.start,
            //         children: [
            //           for (var i = 0; i < finnancetransModels.length; i++)
            //             pw.Row(
            //               children: [
            //                 (finnancetransModels[i].dtype.toString() == 'KP')
            //                     ? pw.Expanded(
            //                         flex: 1,
            //                         child: pw.Container(
            //                           // decoration: pw.BoxDecoration(
            //                           //   color: PdfColors.green100,
            //                           //   // border: pw.Border(
            //                           //   //   bottom: pw.BorderSide(
            //                           //   //       color: PdfColors.green900),
            //                           //   // ),
            //                           // ),
            //                           child: pw.Text(
            //                             (finnancetransModels[i]
            //                                         .type
            //                                         .toString() ==
            //                                     'CASH')
            //                                 ? '${i + 1}.เงินสด : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)'
            //                                 : '${i + 1}.เงินโอน : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท  (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)',
            //                             textAlign: pw.TextAlign.justify,
            //                             style: pw.TextStyle(
            //                               fontSize: font_Size,
            //                               font: ttf,
            //                               fontWeight: pw.FontWeight.bold,
            //                               color: Colors_pd,
            //                             ),
            //                           ),
            //                         ))
            //                     : pw.Expanded(
            //                         flex: 1,
            //                         child: pw.Container(
            //                           // decoration: pw.BoxDecoration(
            //                           //   color: PdfColors.green100,
            //                           //   // border: pw.Border(
            //                           //   //   bottom: pw.BorderSide(
            //                           //   //       color: PdfColors.green900),
            //                           //   // ),
            //                           // ),
            //                           child: pw.Text(
            //                             '${i + 1}.${finnancetransModels[i].remark} : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท  (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)',
            //                             textAlign: pw.TextAlign.justify,
            //                             style: pw.TextStyle(
            //                               fontSize: font_Size,
            //                               font: ttf,
            //                               fontWeight: pw.FontWeight.bold,
            //                               color: Colors_pd,
            //                             ),
            //                           ),
            //                         )),
            //               ],
            //             )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),

            pw.Container(
              // decoration: const pw.BoxDecoration(
              //   // color: PdfColors.green100,
              //   border: pw.Border(
              //     top: pw.BorderSide(color: PdfColors.grey800),
              //     bottom: pw.BorderSide(color: PdfColors.grey800),
              //   ),
              // ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey800),
                          top: pw.BorderSide(color: PdfColors.grey800),
                          bottom: pw.BorderSide(color: PdfColors.grey800),
                        ),
                      ),
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'ลำดับ',
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
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey800),
                          top: pw.BorderSide(color: PdfColors.grey800),
                          bottom: pw.BorderSide(color: PdfColors.grey800),
                        ),
                      ),
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'กำหนดชำระ',
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey800),
                          top: pw.BorderSide(color: PdfColors.grey800),
                          bottom: pw.BorderSide(color: PdfColors.grey800),
                        ),
                      ),
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'รายการ',
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey800),
                          right: pw.BorderSide(color: PdfColors.grey800),
                          top: pw.BorderSide(color: PdfColors.grey800),
                          bottom: pw.BorderSide(color: PdfColors.grey800),
                        ),
                      ),
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'ยอดสุทธิ',
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int index = 0; index < tableData00.length; index++)
              pw.Container(
                // decoration: const pw.BoxDecoration(
                //   // color: PdfColors.green100,
                //   border: pw.Border(
                //     bottom: pw.BorderSide(color: PdfColors.grey800),
                //   ),
                // ),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        // height: 25,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            bottom: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Center(
                          child: pw.Text(
                            '${index + 1}',
                            maxLines: 2,
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
                        padding: const pw.EdgeInsets.all(2.0),
                        // height: 25,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            bottom: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            '${tableData00[index][1]}',
                            maxLines: 2,
                            textAlign: pw.TextAlign.center,
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
                        padding: const pw.EdgeInsets.all(2.0),
                        // height: 25,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            bottom: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '${tableData00[index][2]}',
                            maxLines: 2,
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
                        padding: const pw.EdgeInsets.all(2.0),
                        // height: 25,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            right: pw.BorderSide(color: PdfColors.grey600),
                            bottom: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${tableData00[index][6]}',
                            maxLines: 2,
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
            for (int index = 0; index < tableData01.length; index++)
              pw.Container(
                // decoration: const pw.BoxDecoration(
                //   // color: PdfColors.green100,
                //   border: pw.Border(
                //     bottom: pw.BorderSide(color: PdfColors.grey800),
                //   ),
                // ),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        // height: 25,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            bottom: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Center(
                          child: pw.Text(
                            '${tableData00.length + 1}',
                            maxLines: 2,
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
                        padding: const pw.EdgeInsets.all(2.0),
                        // height: 25,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            bottom: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            '${tableData01[index][1]}',
                            maxLines: 2,
                            textAlign: pw.TextAlign.center,
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
                        padding: const pw.EdgeInsets.all(2.0),
                        // height: 25,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            bottom: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '${tableData01[index][2]}',
                            maxLines: 2,
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
                        padding: const pw.EdgeInsets.all(2.0),
                        // height: 25,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            right: pw.BorderSide(color: PdfColors.grey600),
                            bottom: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${tableData01[index][6]}',
                            maxLines: 2,
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
            pw.Container(
              padding: const pw.EdgeInsets.fromLTRB(0, 4, 0, 0),
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
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_pvat.toString()))}',
                              // '${sum_pvat}',
                              // '$SubTotal',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ภาษีมูลค่าเพิ่ม/Vat',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_vat.toString()))}',
                              // '${sum_vat}',
                              // '$Vat',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'หัก ณ ที่จ่าย',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_wht.toString()))}',
                              // '${sum_wht}',
                              // '$Deduct',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดรวม',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(Sum_SubTotal.toString()))}',
                              // '$Sum_SubTotal',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ส่วนลด/Discount',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_disamt.toString()))}',
                              // '${sum_disamt}',
                              // '$DisC',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ],
                        ),
                        if (nFormat
                                .format(double.parse(dis_sum_Matjum.toString()))
                                .toString() !=
                            '0.00')
                          pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'เงินมัดจำ(ตัดมัดจำ)',
                                  //  'เงินมัดจำ(${nFormat.format(sum_matjum)})',
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                              pw.Text(
                                dis_sum_Matjum == 0.00
                                    ? '${nFormat.format(double.parse(dis_sum_Matjum.toString()))}'
                                    : '${nFormat.format(double.parse(dis_sum_Matjum.toString()))}',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ],
                          ),
                        pw.Divider(color: PdfColors.grey600),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดชำระ',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(Total.toString()) - double.parse(dis_sum_Matjum.toString()))}',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.grey800),
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
                  // color: PdfColors.green100,
                  border: pw.Border(
                    top: pw.BorderSide(color: PdfColors.grey600),
                    bottom: pw.BorderSide(color: PdfColors.grey600),
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
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColors.grey800),
                      ),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          /// "${nFormat2.format(double.parse(Total.toString()))}",
                          ///
                          ///       '(~${convertToThaiBaht(double.parse(Total.toString()) - double.parse(dis_sum_Matjum.toString()))}~)',
                          '(~${convertToThaiBaht(double.parse(Total.toString()))}~)',
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
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
                                        fontSize: font_Size,
                                        color: PdfColors.grey800),
                                  ),
                                ),
                                pw.Text(
                                  '${nFormat.format(double.parse(Total.toString()))}',
                                  // '${Total}',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      fontSize: font_Size,
                                      color: PdfColors.grey800),
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
                padding: pw.EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(4.0),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                'หมายเหตุ ',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: Colors_pd,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(height: 2 * PdfPageFormat.mm),
                              pw.Text(
                                '.....................................................................................................................................................................................................................................................................................................................',
                                textAlign: pw.TextAlign.center,
                                maxLines: 2,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
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
                                    fontSize: font_Size,
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
                                  fontSize: font_Size,
                                  font: ttf,
                                  color: Colors_pd,
                                ),
                              ),
                              pw.SizedBox(height: 2 * PdfPageFormat.mm),
                              pw.Text(
                                'วันที่........../........../..........',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: font_Size,
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
              ),
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
    // pageCount++;
    // pdf.addPage(pw.MultiPage(build: (context) {
    //   return [
    //     pw.Center(
    //       child: pw.Column(
    //         mainAxisAlignment: pw.MainAxisAlignment.center,
    //         children: [
    //           pw.Text(
    //             'Sheet $pageCount',
    //             style: pw.TextStyle(fontSize: 20),
    //           ),
    //           pw.Text(
    //             'Page $pageCount',
    //             style: pw.TextStyle(fontSize: 16),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ];
    // }, footer: (context) {
    //   return pw.Align(
    //     alignment: pw.Alignment.bottomRight,
    //     child: pw.Text(
    //       'หน้า ${context.pageNumber} / ${context.pagesCount} ',
    //       textAlign: pw.TextAlign.left,
    //       style: pw.TextStyle(
    //         fontSize: 10,
    //         font: ttf,
    //         color: Colors_pd,
    //         // fontWeight: pw.FontWeight.bold
    //       ),
    //     ),
    //   );
    // }));
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
          builder: (context) =>
              PreviewPdfgen_Billsplay(doc: pdf, title: 'ใบรับเงินชั่วคราว'),
        ));
  }
}
