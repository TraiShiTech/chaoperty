import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../PeopleChao/Pays_.dart';
import '../../Style/ThaiBaht.dart';
import '../../Style/loadAndCacheImage.dart';

class Pdfgen_Reduce_debt_TP9 {
  static void exportPDF_Reduce_debt_TP9(
      TitleType_Default_Receipt_Name,
      context,
      foder,
      renTal_name,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      sname,
      cname,
      addr,
      tax,
      Cust_no,
      cid_s,
      Zone_s,
      Ln_s,
      fname,
      tableData003,
      _TransHisDisInvModels,
      inv_num,
      docno_inv,
      Datex_invoice,
      amt_inv,
      vat_inv,
      wht_inv,
      nwht_inv,
      nvat_inv,
      sum_total,
      fonts_pdf) async {
    //////--------------------------------------------->

    final pdf = pw.Document();
    final font = await rootBundle.load("${fonts_pdf}");
    var Colors_pd = PdfColors.black;
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

    int pageCount = 1; // Initialize the page count
    final ttf = pw.Font.ttf(font);
    double font_Size = 10.0;
    //////--------------------------------------------->
    DateTime date = DateTime.now();
    // var formatter = new DateFormat.MMMMd('th_TH');
    // String thaiDate = formatter.format(date);
    final thaiDate = DateTime.parse(date.toString());
    final formatter = DateFormat('d MMMM', 'th_TH');
    final formattedDate = formatter.format(thaiDate);
    //////--------------->พ.ศ.
    DateTime dateTime = DateTime.parse(date.toString());
    int newYear = dateTime.year + 543;
    //////--------------------------------------------->
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    List netImage_QR = [];
    Uint8List? resizedLogo = await getResizedLogo();
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   netImage.add(await networkImage('${newValuePDFimg[i]}'));
    // }

//////////---------------------------------->
    pw.Widget Header(context) {
      return pw.Column(children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              height: 60,
              width: 60,
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: resizedLogo != null
                  ? pw.Image(
                      pw.MemoryImage(resizedLogo),
                      height: 60,
                      width: 60,
                    )
                  : pw.Center(
                      child: pw.Text(
                        '$bill_name ',
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: 10,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ),
            ),
            // (netImage.isEmpty)
            //     ? pw.Container(
            //         height: 60,
            //         width: 60,
            //         decoration: const pw.BoxDecoration(
            //           color: PdfColors.grey200,
            //           border: pw.Border(
            //             right: pw.BorderSide(color: PdfColors.grey300),
            //             left: pw.BorderSide(color: PdfColors.grey300),
            //             top: pw.BorderSide(color: PdfColors.grey300),
            //             bottom: pw.BorderSide(color: PdfColors.grey300),
            //           ),
            //         ),
            //         child: pw.Center(
            //           child: pw.Text(
            //             '$bill_name ',
            //             maxLines: 1,
            //             style: pw.TextStyle(
            //               fontSize: 10,
            //               font: ttf,
            //               color: Colors_pd,
            //             ),
            //           ),
            //         ))

            //     // pw.Image(
            //     //     pw.MemoryImage(iconImage),
            //     //     height: 72,
            //     //     width: 70,
            //     //   )
            //     : pw.Container(
            //         height: 60,
            //         width: 60,
            //         decoration: const pw.BoxDecoration(
            //           color: PdfColors.grey200,
            //           border: pw.Border(
            //             right: pw.BorderSide(color: PdfColors.grey300),
            //             left: pw.BorderSide(color: PdfColors.grey300),
            //             top: pw.BorderSide(color: PdfColors.grey300),
            //             bottom: pw.BorderSide(color: PdfColors.grey300),
            //           ),
            //         ),
            //         child: pw.Image(
            //           (netImage[0]),
            //           // fit: pw.BoxFit.fill,
            //           height: 60,
            //           width: 60,
            //         )),
            pw.SizedBox(width: 1 * PdfPageFormat.mm),
            pw.Container(
              // color: PdfColors.grey200,
              width: 400,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
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
                    (bill_tax.toString() == '' || bill_tax == null)
                        ? 'หมายเลขประจำตัวผู้เสียภาษี : 0'
                        : 'หมายเลขประจำตัวผู้เสียภาษี : $bill_tax',
                    // textAlign: pw.TextAlign.justify,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
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
                ],
              ),
            ),
            pw.Spacer(),
            // pw.Column(
            //   crossAxisAlignment: pw.CrossAxisAlignment.end,
            //   mainAxisAlignment: pw.MainAxisAlignment.end,
            //   children: [
            //     pw.SizedBox(height: 10),
            //     pw.Container(
            //       child: pw.BarcodeWidget(
            //           data: (numdoctax.toString() == '')
            //               ? '$numinvoice '
            //               : '$numdoctax ',
            //           barcode: pw.Barcode.code128(),
            //           width: 100,
            //           height: 35),
            //     ),
            //   ],
            // )
          ],
        ),
        pw.SizedBox(height: 1 * PdfPageFormat.mm + 3),
        // pw.SizedBox(height: 1 * PdfPageFormat.mm),
        // pw.Divider(),
        // pw.SizedBox(height: 1 * PdfPageFormat.mm),
      ]);
    }

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 4.00,
        marginLeft: 8.00,
        marginRight: 8.00,
        marginTop: 8.00,
      ),
      header: (context) {
        return Header(context);
      },
      build: (context) {
        return [
          pw.Container(
            height: 85,
            child: pw.Row(
              children: [
                pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      height: 85,
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          top: pw.BorderSide(color: PdfColors.grey600),
                          right: pw.BorderSide(color: PdfColors.grey600),
                          left: pw.BorderSide(color: PdfColors.grey600),
                          bottom: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                padding: pw.EdgeInsets.fromLTRB(2, 4, 2, 2),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      (sname.toString() == null ||
                                              sname.toString() == '' ||
                                              sname.toString() == 'null')
                                          ? 'นามลูกค้า /Name : -'
                                          : 'นามลูกค้า /Name : $sname',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.Text(
                                      (addr.toString() == null ||
                                              addr.toString() == '' ||
                                              addr.toString() == 'null')
                                          ? 'ที่อยู่ /Address : -'
                                          : 'ที่อยู่ /Address  : $addr',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.Text(
                                      (tax == null ||
                                              tax.toString() == '' ||
                                              tax.toString() == 'null')
                                          ? 'เลขที่ผู้เสียภาษี /Tax : 0'
                                          : 'เลขที่ผู้เสียภาษี /Tax : $tax',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.Text(
                                      'เลขสัญญา /No. : $cid_s ',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.Text(
                                      'โซน /Zone : $Zone_s',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.Text(
                                      'หมายเหตุ /Note : ',
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    )),
                pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                      children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              height: 10,
                              decoration: const pw.BoxDecoration(
                                // color: PdfColors.green100,
                                border: pw.Border(
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              child: pw.Row(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            // 'ใบลดหนี้',
                                            (TitleType_Default_Receipt_Name !=
                                                    null)
                                                ? 'ใบลดหนี้ [ $TitleType_Default_Receipt_Name ]'
                                                : 'ใบลดหนี้',
                                            textAlign: pw.TextAlign.center,
                                            style: pw.TextStyle(
                                              fontSize: 14,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                          pw.Text(
                                            // 'Reduce Debt',
                                            (TitleType_Default_Receipt_Name !=
                                                    null)
                                                ? (TitleType_Default_Receipt_Name
                                                            .toString() ==
                                                        'ต้นฉบับ')
                                                    ? 'Credit Note Original'
                                                    : 'Credit Note Copy'
                                                : 'Credit Note',
                                            textAlign: pw.TextAlign.center,
                                            style: pw.TextStyle(
                                              fontSize: 14,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            )),
                        pw.Row(
                          children: [
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  height: 40,
                                  decoration: const pw.BoxDecoration(
                                    // color: PdfColors.green100,
                                    border: pw.Border(
                                      right: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      top: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey600),
                                    ),
                                  ),
                                  child: pw.Row(
                                    // crossAxisAlignment:
                                    //     pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.center,
                                            children: [
                                              pw.Text(
                                                'วันที่ทำรายการ',
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                              pw.Text(
                                                'Date',
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                              pw.Text(
                                                //'xxx-xxxx-xx',
                                                '${DateFormat('dd/MM').format(DateTime.parse(Datex_invoice!))}/${DateTime.parse('${Datex_invoice}').year + 543}',
                                                //'$date_Transaction',
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                )),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  height: 40,
                                  decoration: const pw.BoxDecoration(
                                    // color: PdfColors.green100,
                                    border: pw.Border(
                                      right: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      top: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey600),
                                    ),
                                  ),
                                  child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.center,
                                            children: [
                                              pw.Text(
                                                'เลขที่ใบกำกับ',
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                              pw.Text(
                                                'Order no.',
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                              pw.Text(
                                                '$docno_inv',
                                                // (numdoctax.toString() == '')
                                                //     ? '$numinvoice '
                                                //     : '$numdoctax ',
                                                textAlign: pw.TextAlign.center,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
          pw.Container(
            height: 35,
            child: pw.Row(
              children: [
                pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      height: 35,
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          // right: pw.BorderSide(color: PdfColors.grey600),
                          left: pw.BorderSide(color: PdfColors.grey600),
                          bottom: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // pw.Expanded(
                          //   flex: 2,
                          //   child: pw.Container(
                          //       height: 35,
                          //       decoration: const pw.BoxDecoration(
                          //         // color: PdfColors.green100,
                          //         border: pw.Border(
                          //           right:
                          //               pw.BorderSide(color: PdfColors.grey600),
                          //           bottom:
                          //               pw.BorderSide(color: PdfColors.grey800),
                          //         ),
                          //       ),
                          //       padding: const pw.EdgeInsets.all(2.0),
                          //       child: pw.Column(
                          //         mainAxisAlignment:
                          //             pw.MainAxisAlignment.center,
                          //         crossAxisAlignment:
                          //             pw.CrossAxisAlignment.center,
                          //         children: [
                          //           pw.Text(
                          //             'พนักงาน /Sales No.',
                          //             // 'ลดหนี้ /Reduce debt.',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //           pw.Text(
                          //             '$fname',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //         ],
                          //       )),
                          // ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                height: 35,
                                decoration: const pw.BoxDecoration(
                                  // color: PdfColors.green100,
                                  border: pw.Border(
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey800),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      'ลดหนี้ /Reduce debt.',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.Text(
                                      'ลดหนี้',
                                      // (type_bills.toString().trim() == '' ||
                                      //         type_bills == null)
                                      //     ? 'สัญญา'
                                      //     : 'ล็อคเสียบ',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                height: 35,
                                decoration: const pw.BoxDecoration(
                                  // color: PdfColors.green100,
                                  border: pw.Border(
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      'รหัสลูกค้า /Code',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.Text(
                                      (Cust_no.toString() == '' ||
                                              Cust_no == null)
                                          ? '-'
                                          : '$Cust_no',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 35,
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.grey600),
                          // left: pw.BorderSide(color: PdfColors.grey800),
                          bottom: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                height: 35,
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      'อ้างอิงถึงเลขที่บิล / Ref No.',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                    pw.Text(
                                      '$inv_num',
                                      // (dayfinpay.toString() == '' ||
                                      //         dayfinpay.toString() == 'null' ||
                                      //         dayfinpay == null)
                                      //     ? '-'
                                      //     : '${DateFormat('dd/MM').format(DateTime.parse(dayfinpay!))}/${DateTime.parse('${dayfinpay}').year + 543}',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: font_Size,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Colors_pd,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
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
                pw.Container(
                  width: 30,
                  decoration: const pw.BoxDecoration(
                    // color: PdfColors.green100,
                    border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.grey600),
                      right: pw.BorderSide(color: PdfColors.grey600),
                      bottom: pw.BorderSide(color: PdfColors.grey600),
                    ),
                  ),
                  height: 30,
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        'ลำดับ',
                        maxLines: 1,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.black),
                      ),
                      pw.Text(
                        'No.',
                        maxLines: 1,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.black),
                      ),
                    ],
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        right: pw.BorderSide(color: PdfColors.grey600),
                        // top: pw.BorderSide(color: PdfColors.grey800),
                        bottom: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    height: 30,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'รหัสสินค้า',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'Produet Code',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 4,
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        right: pw.BorderSide(color: PdfColors.grey600),
                        // top: pw.BorderSide(color: PdfColors.grey800),
                        bottom: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    height: 30,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'รายละเอียด',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'Description',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        right: pw.BorderSide(color: PdfColors.grey600),
                        // top: pw.BorderSide(color: PdfColors.grey800),
                        bottom: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    height: 30,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'ยอด',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'Amount',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        right: pw.BorderSide(color: PdfColors.grey600),
                        top: pw.BorderSide(color: PdfColors.grey600),
                        bottom: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    height: 30,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'ภาษีมูลค่าเพิ่ม',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'Vat',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        right: pw.BorderSide(color: PdfColors.grey600),
                        top: pw.BorderSide(color: PdfColors.grey600),
                        bottom: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    height: 30,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'หัก ณ ที่จ่าย',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'Wht',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ],
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
                        right: pw.BorderSide(color: PdfColors.grey600),
                        top: pw.BorderSide(color: PdfColors.grey600),
                        bottom: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    height: 30,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'จำนวนเงิน ',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'Total Amount ',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
              // height: 800,
              // color: PdfColors.green100,
              child: pw.Table(
                  border: const pw.TableBorder(
                      left: pw.BorderSide(color: PdfColors.grey800, width: 1),
                      right: pw.BorderSide(color: PdfColors.grey800, width: 1),
                      verticalInside: pw.BorderSide(
                          width: 1,
                          color: PdfColors.grey800,
                          style: pw.BorderStyle.solid)),
                  children: [
                for (int index = 0; index < tableData003.length; index++)
                  pw.TableRow(children: [
                    pw.Container(
                      width: 30,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.topCenter,
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
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Text(
                            '${tableData003[index][1]}',
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
                      flex: 4,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Text(
                            '${tableData003[index][2]}',
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
                        flex: 1,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2.0),
                          child: pw.Align(
                            alignment: pw.Alignment.topRight,
                            child: pw.Text(
                              '${tableData003[index][3]}',
                              maxLines: 2,
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2.0),
                          child: pw.Align(
                            alignment: pw.Alignment.topRight,
                            child: pw.Text(
                              '${tableData003[index][4]}',
                              maxLines: 2,
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2.0),
                          child: pw.Align(
                            alignment: pw.Alignment.topRight,
                            child: pw.Text(
                              '${tableData003[index][5]}',
                              maxLines: 2,
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                        )),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2.0),
                          child: pw.Align(
                            alignment: pw.Alignment.topRight,
                            child: pw.Text(
                              '${tableData003[index][6]}',
                              maxLines: 2,
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  font: ttf,
                                  color: PdfColors.grey800),
                            ),
                          ),
                        )),
                  ]),
              ])),
          pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColors.white,
              border: const pw.Border(
                top: pw.BorderSide(color: PdfColors.grey600),
                // left: pw.BorderSide(color: PdfColors.grey600),
              ),
            ),
            // padding: const pw.EdgeInsets.fromLTRB(0, 4, 0, 0),
            alignment: pw.Alignment.centerRight,
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // pw.Container(
                //   padding: const pw.EdgeInsets.all(4.0),
                //   child: pw.Text(
                //     'กำหนดชำระเงิน ภายในวันที่ 5 ของเดือน',
                //     style: pw.TextStyle(
                //         fontSize: font_Size,
                //         fontWeight: pw.FontWeight.bold,
                //         font: ttf,
                //         color: PdfColors.grey800),
                //   ),
                // ),
                pw.Spacer(flex: 6),
                pw.Expanded(
                  flex: 4,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                'มูลค่าตามใบกำกับเดิม /Original Total Amount',
                                maxLines: 1,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                '${nFormat.format(sum_total)}',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                'มูลค่าที่ถูกต้อง /Total Amount Correct',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                '${nFormat.format(amt_inv - vat_inv - wht_inv)}',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                'ผลต่าง /Total Amount Difference',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                '${nFormat.format(sum_total - (amt_inv - vat_inv - wht_inv))}',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //////////----------->
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: pw.Border(
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                'ภาษีมูลค่าเพิ่ม / Vat ( $nvat_inv % )',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                '${nFormat.format(vat_inv)}',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                'หัก ณ ที่จ่าย / Wht ( $nwht_inv % )',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                '${nFormat.format(wht_inv)}',
                                // '${nFormat.format(double.parse(sum_wht.toString()))}',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                'ยอดสุทธิ / Total Amount ',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  top: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Text(
                                '${nFormat.format(amt_inv)}',
                                //'${nFormat.format((double.parse(Total.toString()) + double.parse(sum_fee.toString())) - (double.parse(dis_sum_Matjum.toString()) + double.parse(dis_sum_Pakan.toString())))}',

                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), // pw.SizedBox(height: 2 * PdfPageFormat.mm),
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
                        '(~${convertToThaiBaht(amt_inv)}~)',
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
                                '${nFormat.format(amt_inv)}',
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
                padding: pw.EdgeInsets.fromLTRB(2, 4, 2, 4),
                child: pw.Row(
                  children: [
                    for (int index = 0; index < 4; index++)
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  (index == 0)
                                      ? 'ลงชื่อ : ผู้จัดการ'
                                      : (index == 1)
                                          ? 'ลงชื่อ : รองผู้จัดการ'
                                          : (index == 2)
                                              ? 'ลงชื่อ : พนักงาน'
                                              : 'ลงชื่อ : อื่นๆ',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '........................................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '(......................................................)',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  'วันที่/Date...........................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                              ])),
                  ],
                )),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: pw.Align(
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      'พิมพ์เมื่อ : $date',
                      // textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 7.00,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: pw.Align(
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Text(
                      'หน้าที่ ${context.pageNumber} / ${context.pagesCount} ',
                      // textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 7.00,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    ));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewPdfgen_Billsplay(doc: pdf, title: 'ใบลดหนี้/ใบกำกับภาษี'),
        ));
  }
}
