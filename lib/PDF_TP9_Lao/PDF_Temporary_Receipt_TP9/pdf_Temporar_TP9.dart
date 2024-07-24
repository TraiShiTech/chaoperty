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
import '../../Constant/Myconstant.dart';
import '../../PeopleChao/Pays_.dart';
import '../../Style/ThaiBaht.dart';
import '../../Style/loadAndCacheImage.dart';

class Pdfgen_Temporary_receipt_TP9_Lao {
//////////---------------------------------------------------->(ใบเสร็จรับเงิน/ใบกำกับภาษี)   ใช้  //

  static void exportPDF_Temporary_receipt_TP9_Lao(
      Cust_no,
      cid_s,
      Zone_s,
      Ln_s,
      fname,
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
      TitleType_Default_Receipt_Name,
      dis_sum_Pakan,
      fonts_pdf) async {
    ////
    //// ------------>(ใบเสร็จรับเงินชั่วคราว paySrsscreen_)
    ///////
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

    int pageCount = 1; // Initialize the page count
    final ttf = pw.Font.ttf(font);

    double font_Size = 7.0;
    //////--------------------------------------------->
    DateTime date = DateTime.now();
    // // var formatter = new DateFormat.MMMMd('th_TH');
    // // String thaiDate = formatter.format(date);
    // final thaiDate = DateTime.parse(date_Transaction);
    // final formatter = DateFormat('d MMMM', 'th_TH');
    // final formattedDate = formatter.format(thaiDate);
    // //////--------------->พ.ศ.
    // DateTime dateTime = DateTime.parse(date_Transaction);
    // int newYear = dateTime.year + 543;
    //////--------------------------------------------->
    var nFormat = NumberFormat("#,##0", "en_US");
    var nFormat2 = NumberFormat("###0", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    List netImage_QR = [];
    Uint8List? resizedLogo = await getResizedLogo();
    // String total_QR = '${nFormat.format(double.parse('${Total}'))}';
    String total_QR =
        '${nFormat.format(finnancetransModels.where((model) => model.type.toString() == 'OP' && model.dtype.toString() != 'MM').fold<double>(0.0, (double sum, model) => sum + (double.parse(model.total ?? '0.00'))))}';

    String newTotal_QR = total_QR.replaceAll(RegExp(r'[^0-9]'), '');

    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   netImage.add(await networkImage('${newValuePDFimg[i]}'));
    // }
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
    bool hasNonCashTransaction3 = finnancetransModels.any((transaction) {
      return transaction.type.toString() != 'CASH' ||
          transaction.ptser.toString() != '6' ||
          transaction.ptser.toString() != '5' ||
          transaction.ptser.toString() != '2' ||
          transaction.ptser.toString() != '1' ||
          transaction.dtype != 'MM';
    });
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
            //               fontSize: 7,
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
                        ? 'ທີ່ຢູ່ : -'
                        : 'ທີ່ຢູ່ : $bill_addr',
                    maxLines: 3,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      color: Colors_pd,
                      font: ttf,
                    ),
                  ),
                  pw.Text(
                    (bill_tax.toString() == '' || bill_tax == null)
                        ? 'ໝາຍເລກປະຈຳຕົວຜູ້ເສຍພາສີ : 0'
                        : 'ໝາຍເລກປະຈຳຕົວຜູ້ເສຍພາສີ : $bill_tax',
                    // textAlign: pw.TextAlign.justify,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'ໂທລະສັບ : $bill_tel',
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

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 8.00,
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
                                            ? 'ຊື່ລູກຄ້າ /Name : -'
                                            : 'ຊື່ລູກຄ້າ /Name : $sname',
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
                                            ? 'ທີ່ຢູ່ /Address : -'
                                            : 'ທີ່ຢູ່ /Address  : $addr',
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
                                            ? 'ໝາຍເລກຜູ້ເສຍພາສີ /Tax : 0'
                                            : 'ໝາຍເລກຜູ້ເສຍພາສີ /Tax : $tax',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      pw.Text(
                                        'ໝາຍເລກສັນຍາ /No. : $cid_s ',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      pw.Text(
                                        'ເຂດ /Zone : $Zone_s',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      pw.Text(
                                        'ຫມາຍ​ເຫດ​ /Note : ',
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
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                child: pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
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
                                              (TitleType_Default_Receipt_Name !=
                                                      null)
                                                  ? (TitleType_Default_Receipt_Name
                                                              .toString() ==
                                                          'ต้นฉบับ')
                                                      ? 'ໃບຮັບເງິນຊົ່ວຄາວ [ ຕົ້ນສະບັບ ]'
                                                      : 'ໃບຮັບເງິນຊົ່ວຄາວ [ ສຳເນົາ ]'
                                                  : 'ໃບຮັບເງິນຊົ່ວຄາວ',
                                              textAlign: pw.TextAlign.center,
                                              style: pw.TextStyle(
                                                fontSize: 8,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                                color: Colors_pd,
                                              ),
                                            ),
                                            pw.Text(
                                              (TitleType_Default_Receipt_Name !=
                                                      null)
                                                  ? (TitleType_Default_Receipt_Name
                                                              .toString() ==
                                                          'ต้นฉบับ')
                                                      ? 'Temporary Receipt Original'
                                                      : 'Temporary Receipt Copy'
                                                  : 'Temporary Receipt',
                                              textAlign: pw.TextAlign.center,
                                              style: pw.TextStyle(
                                                fontSize: 8,
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
                                                  'ວັນທີເຮັດທຸລະກໍາ',
                                                  textAlign:
                                                      pw.TextAlign.center,
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
                                                  textAlign:
                                                      pw.TextAlign.center,
                                                  style: pw.TextStyle(
                                                    fontSize: font_Size,
                                                    font: ttf,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                    color: Colors_pd,
                                                  ),
                                                ),
                                                pw.Text(
                                                  (date_Transaction == null ||
                                                          date_Transaction
                                                                  .toString() ==
                                                              '')
                                                      ? '$date_Transaction'
                                                      : '${DateFormat('dd/MM').format(DateTime.parse(date_Transaction!))}/${DateTime.parse('${date_Transaction}').year + 0}',
                                                  // '$date_Transaction',
                                                  textAlign:
                                                      pw.TextAlign.center,
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
                                                  'ໝາຍເລກໃບເກັບເງິນ',
                                                  textAlign:
                                                      pw.TextAlign.center,
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
                                                  textAlign:
                                                      pw.TextAlign.center,
                                                  style: pw.TextStyle(
                                                    fontSize: font_Size,
                                                    font: ttf,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                    color: Colors_pd,
                                                  ),
                                                ),
                                                pw.Text(
                                                  (numdoctax.toString() == '')
                                                      ? '$numinvoice '
                                                      : '$numdoctax ',
                                                  textAlign:
                                                      pw.TextAlign.center,
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
                            pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                  height: 35,
                                  decoration: const pw.BoxDecoration(
                                    // color: PdfColors.green100,
                                    border: pw.Border(
                                      right: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey800),
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
                                        'ພະນັກງານຂາຍ /Sales man No.',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      pw.Text(
                                        '$fname',
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
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey800),
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
                                        'ປະເພດ /Type.',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      pw.Text(
                                        (type_bills.toString().trim() == '' ||
                                                type_bills == null)
                                            ? 'ສັນຍາ'
                                            : 'ປລັກສຽບ',
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
                                      right: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      left: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey600),
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
                                        'ID ລູກຄ້າ /Code',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      pw.Text(
                                        '$Cust_no',
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
                  // pw.Expanded(
                  //     flex: 1,
                  //     child: pw.Container(
                  //       height: 35,
                  //       decoration: const pw.BoxDecoration(
                  //         // color: PdfColors.green100,
                  //         border: pw.Border(
                  //           right: pw.BorderSide(color: PdfColors.grey600),
                  //           // left: pw.BorderSide(color: PdfColors.grey800),
                  //           bottom: pw.BorderSide(color: PdfColors.grey600),
                  //         ),
                  //       ),
                  //       child: pw.Row(
                  //         crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //         children: [
                  //           pw.Expanded(
                  //             flex: 1,
                  //             child: pw.Container(
                  //                 height: 35,
                  //                 padding: const pw.EdgeInsets.all(2.0),
                  //                 child: pw.Column(
                  //                   mainAxisAlignment:
                  //                       pw.MainAxisAlignment.center,
                  //                   crossAxisAlignment:
                  //                       pw.CrossAxisAlignment.center,
                  //                   children: [
                  //                     pw.Text(
                  //                       'วันที่รับชำระ /Payment Date',
                  //                       textAlign: pw.TextAlign.center,
                  //                       style: pw.TextStyle(
                  //                         fontSize: font_Size,
                  //                         font: ttf,
                  //                         fontWeight: pw.FontWeight.bold,
                  //                         color: Colors_pd,
                  //                       ),
                  //                     ),
                  //                     pw.Text(
                  //                       (dayfinpay.toString() == '' ||
                  //                               dayfinpay.toString() ==
                  //                                   'null' ||
                  //                               dayfinpay == null)
                  //                           ? '-'
                  //                           : '${DateFormat('dd/MM').format(DateTime.parse(dayfinpay!))}/${DateTime.parse('${dayfinpay}').year + 543}',
                  //                       textAlign: pw.TextAlign.center,
                  //                       style: pw.TextStyle(
                  //                         fontSize: font_Size,
                  //                         font: ttf,
                  //                         fontWeight: pw.FontWeight.bold,
                  //                         color: Colors_pd,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ],
                  //       ),
                  //     )),
                  // pw.Expanded(
                  //     flex: 1,
                  //     child: pw.Container(
                  //       height: 35,
                  //       decoration: const pw.BoxDecoration(
                  //         // color: PdfColors.green100,
                  //         border: pw.Border(
                  //           right: pw.BorderSide(color: PdfColors.grey600),
                  //           // left: pw.BorderSide(color: PdfColors.grey800),
                  //           bottom: pw.BorderSide(color: PdfColors.grey600),
                  //         ),
                  //       ),
                  //       child: pw.Row(
                  //         crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //         children: [
                  //           pw.Expanded(
                  //             flex: 1,
                  //             child: pw.Container(
                  //                 height: 35,
                  //                 padding: const pw.EdgeInsets.all(2.0),
                  //                 child: pw.Column(
                  //                   mainAxisAlignment:
                  //                       pw.MainAxisAlignment.center,
                  //                   crossAxisAlignment:
                  //                       pw.CrossAxisAlignment.center,
                  //                   children: [
                  //                     pw.Text(
                  //                       'กำหนดชำระเงิน /Term',
                  //                       textAlign: pw.TextAlign.center,
                  //                       style: pw.TextStyle(
                  //                         fontSize: font_Size,
                  //                         font: ttf,
                  //                         fontWeight: pw.FontWeight.bold,
                  //                         color: Colors_pd,
                  //                       ),
                  //                     ),
                  //                     pw.Text(
                  //                       '-',
                  //                       textAlign: pw.TextAlign.center,
                  //                       style: pw.TextStyle(
                  //                         fontSize: font_Size,
                  //                         font: ttf,
                  //                         fontWeight: pw.FontWeight.bold,
                  //                         color: Colors_pd,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ],
                  //       ),
                  //     )),
                  // pw.Expanded(
                  //     flex: 1,
                  //     child: pw.Container(
                  //       height: 35,
                  //       decoration: const pw.BoxDecoration(
                  //         // color: PdfColors.green100,
                  //         border: pw.Border(
                  //           right: pw.BorderSide(color: PdfColors.grey600),
                  //           // left: pw.BorderSide(color: PdfColors.grey800),
                  //           bottom: pw.BorderSide(color: PdfColors.grey600),
                  //         ),
                  //       ),
                  //       child: pw.Row(
                  //         crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //         children: [
                  //           pw.Expanded(
                  //             flex: 1,
                  //             child: pw.Container(
                  //                 height: 35,
                  //                 padding: const pw.EdgeInsets.all(2.0),
                  //                 child: pw.Column(
                  //                   mainAxisAlignment:
                  //                       pw.MainAxisAlignment.center,
                  //                   crossAxisAlignment:
                  //                       pw.CrossAxisAlignment.center,
                  //                   children: [
                  //                     pw.Text(
                  //                       'ครบกำหนด /Due Date',
                  //                       textAlign: pw.TextAlign.center,
                  //                       style: pw.TextStyle(
                  //                         fontSize: font_Size,
                  //                         font: ttf,
                  //                         fontWeight: pw.FontWeight.bold,
                  //                         color: Colors_pd,
                  //                       ),
                  //                     ),
                  //                     pw.Text(
                  //                       '-',
                  //                       textAlign: pw.TextAlign.center,
                  //                       style: pw.TextStyle(
                  //                         fontSize: font_Size,
                  //                         font: ttf,
                  //                         fontWeight: pw.FontWeight.bold,
                  //                         color: Colors_pd,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ],
                  //       ),
                  //     )),
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
                          'ເລກ',
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
                            'ລະ​ຫັດ​ຜະ​ລິດ​ຕະ​ພັນ',
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
                            'ລາຍລະອຽດ',
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
                            'ປະລິມານ',
                            maxLines: 1,
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                color: PdfColors.black),
                          ),
                          pw.Text(
                            'Quantity',
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
                            'ໜ່ວຍ',
                            maxLines: 1,
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                color: PdfColors.black),
                          ),
                          pw.Text(
                            'Unit',
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
                            'ສ່ວນຫຼຸດ',
                            maxLines: 1,
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                color: PdfColors.black),
                          ),
                          pw.Text(
                            'Dis',
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
                            'ຈໍາ​ນວນ',
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
                ],
              ),
            ),

            pw.Container(
              // height: 800,
              // color: PdfColors.green100,
              child: pw.Table(
                border: pw.TableBorder(
                    left: pw.BorderSide(color: PdfColors.grey600, width: 1),
                    right: pw.BorderSide(color: PdfColors.grey600, width: 1),
                    verticalInside: pw.BorderSide(
                        width: 1,
                        color: PdfColors.grey600,
                        style: pw.BorderStyle.solid)),
                children: [
                  for (int index = 0; index < tableData00.length; index++)
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
                        flex: 1,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2.0),
                          child: pw.Align(
                            alignment: pw.Alignment.topLeft,
                            child: pw.Text(
                              '${tableData00[index][11]}',
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
                                (tableData00[index][0].toString() == '6')
                                    ? '${tableData00[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData00[index][1]))}/${DateTime.parse('${tableData00[index][1]}').year + 0} [ ຫນ່ວຍງານທີ່ໃຊ້ ${tableData00[index][8]}-${tableData00[index][9]} ]'
                                    : '${tableData00[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData00[index][1]))}/${DateTime.parse('${tableData00[index][1]}').year + 0}',
                                maxLines: 2,
                                textAlign: pw.TextAlign.left,
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
                                (tableData00[index][10].toString() == '0.00')
                                    ? '1'
                                    : '${tableData00[index][10]}',
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
                                (tableData00[index][7].toString() == '0.00')
                                    ? '${tableData00[index][5]}'
                                    : '${tableData00[index][7]}',
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
                                '${tableData00[index][12]}',
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
                                '${tableData00[index][13]}',
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
                  for (int index = 0; index < tableData01.length; index++)
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
                        flex: 1,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2.0),
                          child: pw.Align(
                            alignment: pw.Alignment.topLeft,
                            child: pw.Text(
                              '${tableData01[index][11]}',
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
                                (tableData01[index][0].toString() == '6')
                                    ? '${tableData01[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData01[index][1]))}/${DateTime.parse('${tableData01[index][1]}').year + 0} [ ຫນ່ວຍງານທີ່ໃຊ້ ${tableData01[index][8]}-${tableData01[index][9]} ]'
                                    : '${tableData01[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData01[index][1]))}/${DateTime.parse('${tableData01[index][1]}').year + 0}',
                                maxLines: 2,
                                textAlign: pw.TextAlign.left,
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
                                (tableData01[index][10].toString() == '0.00')
                                    ? '1'
                                    : '${tableData01[index][10]}',
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
                                (tableData01[index][7].toString() == '0.00')
                                    ? '${tableData01[index][5]}'
                                    : '${tableData01[index][7]}',
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
                                '0',
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
                                '${tableData01[index][6]}',
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
                ],
              ),
            ),

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
                  //     '',
                  //     // 'กำหนดชำระเงิน ภายในวันที่ 5 ของเดือน',
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
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  'ລາຄາສິນຄ້າທັງໝົດ / Sub Total',
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
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  '${nFormat.format(double.parse(sum_pvat.toString()))}',
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
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  'ອາກອນມູນຄ່າເພີ່ມ / Vat',
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
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  '${nFormat.format(double.parse(sum_vat.toString()))}',
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
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  'ຫັກຢູ່ບ່ອນຈ່າຍ / Withholding ',
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
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  '${nFormat.format(double.parse(sum_wht.toString()))}',
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
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  'ທັງໝົດ / Total',
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
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  '${nFormat.format(double.parse(Sum_SubTotal.toString()))}',
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
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  'ສ່ວນຫຼຸດ / Discount',
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
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  '${nFormat.format(double.parse(sum_disamt.toString()))}',
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
                        if (nFormat
                                .format(double.parse(dis_sum_Matjum.toString()))
                                .toString() !=
                            '0.00')
                          pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  decoration: const pw.BoxDecoration(
                                    color: PdfColors.white,
                                    border: const pw.Border(
                                      top: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      left: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      right: pw.BorderSide(
                                          color: PdfColors.grey600),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Text(
                                    'ຝາກ(ຕັດເງິນຝາກ) / deposit',
                                    //  'เงินมัดจำ(${nFormat.format(sum_matjum)})',
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
                                      left: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      top: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      right: pw.BorderSide(
                                          color: PdfColors.grey600),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Text(
                                    dis_sum_Matjum == 0.00
                                        ? '${nFormat.format(double.parse(dis_sum_Matjum.toString()))}'
                                        : '${nFormat.format(double.parse(dis_sum_Matjum.toString()))}',
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
                        if (nFormat
                                .format(double.parse(dis_sum_Pakan.toString()))
                                .toString() !=
                            '0.00')
                          pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  decoration: const pw.BoxDecoration(
                                    color: PdfColors.white,
                                    border: const pw.Border(
                                      top: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      left: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      right: pw.BorderSide(
                                          color: PdfColors.grey600),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Text(
                                    'ຝາກ(ການຫັກປະກັນໄພ) / insurance',
                                    //  'เงินมัดจำ(${nFormat.format(sum_matjum)})',
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
                                      left: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      top: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey600),
                                      right: pw.BorderSide(
                                          color: PdfColors.grey600),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Text(
                                    dis_sum_Pakan == 0.00
                                        ? '${nFormat.format(double.parse(dis_sum_Pakan.toString()))}'
                                        : '${nFormat.format(double.parse(dis_sum_Pakan.toString()))}',
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
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  'ຈໍານວນການຈ່າຍເງິນ / Payment Amount',
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
                                    left:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    top:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    bottom:
                                        pw.BorderSide(color: PdfColors.grey600),
                                    right:
                                        pw.BorderSide(color: PdfColors.grey600),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.all(2.0),
                                child: pw.Text(
                                  '${nFormat.format(double.parse(Total.toString()) - double.parse(dis_sum_Matjum.toString()) - double.parse(dis_sum_Pakan.toString()))}',
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
            ),
            // pw.SizedBox(height: 2 * PdfPageFormat.mm),
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
                        'ລັກສະນະ ',
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
                                    'ທັງໝົດສຸດທິ',
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
                    children: [
                      pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'ຫມາຍ​ເຫດ​ :',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '............................................................................................................................................',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '............................................................................................................................................',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '............................................................................................................................................',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                              ])),
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'ເຊັນ: ຜູ້​ຈັດ​ການ',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '.......................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '(.......................................)',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  'ວັນທີ/Date.......................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                              ])),
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'ເຊັນ: ຜູ້ຮັບເງິນ',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '.......................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '(.......................................)',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  'ວັນທີ/Date.......................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                              ])),
                      // pw.Expanded(
                      //     flex: 1,
                      //     child: pw.Column(
                      //         mainAxisAlignment: pw.MainAxisAlignment.end,
                      //         crossAxisAlignment: pw.CrossAxisAlignment.end,
                      //         children: [
                      //           for (var i = 0;
                      //               i < finnancetransModels.length;
                      //               i++)
                      //             if (finnancetransModels[i].ptser.toString() !=
                      //                     '1' &&
                      //                 finnancetransModels[i].dtype.toString() !=
                      //                     'MM')
                      //               pw.Container(
                      //                 child: (finnancetransModels[i]
                      //                                 .ptser
                      //                                 .toString() ==
                      //                             '' ||
                      //                         finnancetransModels[i].ptser ==
                      //                             null ||
                      //                         finnancetransModels[i].img ==
                      //                             null ||
                      //                         finnancetransModels[i]
                      //                                 .img
                      //                                 .toString() ==
                      //                             '')
                      //                     ? pw.BarcodeWidget(
                      //                         data: generateQRCode(
                      //                             promptPayID:
                      //                                 "${finnancetransModels[i].bno}",
                      //                             amount: double.parse(
                      //                                 (finnancetransModels[i]
                      //                                                 .total ==
                      //                                             null ||
                      //                                         finnancetransModels[i]
                      //                                                 .total
                      //                                                 .toString() ==
                      //                                             '')
                      //                                     ? '0'
                      //                                     : '${finnancetransModels[i].total}')),
                      //                         barcode: pw.Barcode.qrCode(),
                      //                         width: 60,
                      //                         height: 60)
                      //                     : pw.Image(
                      //                         (netImage_QR[i]),
                      //                         height: 60,
                      //                         width: 60,
                      //                       ),
                      //               ),
                      //         ])),
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
                        'ພິມເມື່ອ : $date',
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
                        'ຫນ້າ No. ${context.pageNumber} / ${context.pagesCount} ',
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
          builder: (context) => PreviewPdfgen_Billsplay(
              doc: pdf, title: 'ใบรับเงินชั่วคราว-ໃບຮັບເງິນຊົ່ວຄາວ'),
        ));
  }
}
