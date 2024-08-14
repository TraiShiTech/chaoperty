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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import '../../CRC_16_Prompay/generate_qrcode.dart';
import '../../Constant/Myconstant.dart';
import '../../PeopleChao/Pays_.dart';
import '../../Style/ThaiBaht.dart';
import '../../Style/loadAndCacheImage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Pdfgen_his_statusbill_TP9 {
//////////---------------------------------------------------->(ใบเสร็จรับเงิน/ใบกำกับภาษี)   ใช้  //

  static void exportPDF_statusbill_TP9(
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
      ref_invoice,
      finnancetransModels,
      date_Transaction,
      dayfinpay,
      type_bills,
      dis_sum_Matjum,
      TitleType_Default_Receipt_Name,
      dis_sum_Pakan,
      sum_fee,
      com_ment,
      fonts_pdf,
      electricityModels) async {
    ////
    //// ------------>(ใบเสร็จรับเงิน)
    ///////
    final pdf = pw.Document();
    final font = await rootBundle.load("${fonts_pdf}");
    var Colors_pd = PdfColors.black;
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

    int pageCount = 1; // Initialize the page count
    final ttf = pw.Font.ttf(font);

    double font_Size = 10.0;
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
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    List netImage_QR = [];
    Uint8List? resizedLogo = await getResizedLogo();

    ///
    ///
////////////////------------------------------->
    double Total_CASH = double.parse(
      '${finnancetransModels.where((model) => model.ptser == '1' && model.dtype == 'KP').fold<double>(
            0.0,
            (double previousValue, element) =>
                previousValue +
                (element.total != null ? double.parse(element.total!) : 0),
          )}',
    );

    // '${finnancetransModels.where((model) => model.ptser == '1' && model.dtype == 'KP').map((model) => model.total).join(', ')}';
    String total_QR =
        '${nFormat.format(double.parse('${Total}') - Total_CASH)}';
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

//////////---------------------------->
    bool hasNonCashTransaction = finnancetransModels.any((transaction) {
      return transaction.type.toString() != 'CASH' &&
          transaction.type != null &&
          transaction.dtype.toString() != 'FTA';
    }); ///// เงินโอน , Online Standard QR , Online Payment
////////////////------------------------------->
    bool hasNonCashTransaction1 = finnancetransModels.any((transaction) {
      return transaction.type.toString() == 'CASH' &&
          transaction.dtype.toString() != 'FTA';
    }); ///// เงินสด
////////////////------------------------------->
    bool hasNonCashTransaction2 = finnancetransModels.any((transaction) {
      return transaction.ptser.toString() == '6' &&
          transaction.dtype.toString() != 'FTA';
    }); //Online Standard QR
////////////////------------------------------->
    bool hasNonCashTransaction3 = finnancetransModels.any((transaction) {
      return transaction.ptser.toString() == '2' &&
          transaction.dtype.toString() != 'FTA';
    }); ///// เงินโอน
////////////////------------------------------->
    bool hasNonCashTransaction4 = finnancetransModels.any((transaction) {
      return transaction.ptser.toString() == '5' &&
          transaction.dtype.toString() != 'FTA';
    }); ///// Online Payment
////////////////------------------------------->
    bool hasNonCashTransaction5 = finnancetransModels.any((transaction) {
      return transaction.dtype.toString() == 'MM';
    }); ///// Online Payment
//////////---------------------------------->
    bool hasNonCashTransaction6 = finnancetransModels.any((transaction) {
      return transaction.dtype.toString() == 'FTA';
    }); ///// Online Payment
//////////---------------------------------->
    bool hasNonCashTransaction7 = finnancetransModels.any((transaction) {
      return transaction.ref1.toString().trim() == '';
    });
    bool hasNonCashTransaction8 = finnancetransModels.any((transaction) {
      return transaction.ptser.toString().trim() == '6';
    });
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? renTalLogoUrl = preferences.getString('renTal_logo');
    // Uint8List? cachedImage = await Man_logo();

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
            // cachedImage != null
            //     ? pw.Image(
            //         pw.MemoryImage(cachedImage),
            //         height: 60,
            //         width: 60,
            //       )
            //     : pw.Text('No image available'),
            // (cachedImage!.isEmpty)
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
            //         child:
            // pw.Center(
            //           child: pw.Text(
            //             '$bill_name ',
            //             maxLines: 1,
            //             style: pw.TextStyle(
            //               fontSize: 10,
            //               font: ttf,
            //               color: Colors_pd,
            //             ),
            //           ),
            //         )
            // ),

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
            //           pw.MemoryImage(cachedImage),
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
            pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Text(
                'หน้าที่ ${context.pageNumber} / ${context.pagesCount} ',
                // textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 10,
                  font: ttf,
                  color: Colors_pd,
                  // fontWeight: pw.FontWeight.bold
                ),
              ),
            )
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
              height: (ref_invoice.length > 5)
                  ? 112
                  : (ref_invoice.length > 1)
                      ? 100
                      : 85,
              child: pw.Row(
                children: [
                  pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        height: (ref_invoice.length > 5)
                            ? 112
                            : (ref_invoice.length > 1)
                                ? 115
                                : 85,
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
                                        'นามลูกค้า /Name : ${(sname.toString() == '' || sname == null || sname.toString() == 'null') ? '-' : sname}',
                                        // (cname.toString() == '' ||
                                        //         cname == null ||
                                        //         cname.toString() == 'null')
                                        //     ? 'นามลูกค้า /Name : ${(sname.toString() == '' || sname == null || sname.toString() == 'null') ? '-' : sname}'
                                        //     : 'นามลูกค้า /Name : ${(cname.toString() == '' || sname == null || sname.toString() == 'null') ? '-' : sname} ',
                                        // (sname.toString() == null ||
                                        //         sname.toString() == '' ||
                                        //         sname.toString() == 'null')
                                        //     ? 'นามลูกค้า /Name : -'
                                        //     : 'นามลูกค้า /Name : $sname',
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
                                        'โซน /Zone : $Zone_s (รหัสพื้นที่ /Area  : $Ln_s)',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      pw.Text(
                                        'หมายเหตุ /Note : $com_ment ',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      (ref_invoice.length > 1)
                                          ? pw.Text(
                                              'อ้างอิงเลขที่/Refer no. : ${ref_invoice.toSet().map((model) => model).join(', ')}',
                                              textAlign: pw.TextAlign.left,
                                              style: pw.TextStyle(
                                                fontSize: font_Size,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                                color: Colors_pd,
                                              ),
                                            )
                                          : pw.SizedBox(),
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
                                height: (ref_invoice.length > 5)
                                    ? 40
                                    : (ref_invoice.length > 1)
                                        ? 20
                                        : 10,
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
                                            (hasNonCashTransaction1)
                                                ? pw.Text(
                                                    (TitleType_Default_Receipt_Name !=
                                                            null)
                                                        ? (numdoctax.toString() ==
                                                                '')
                                                            ? 'บิลเงินสด [ $TitleType_Default_Receipt_Name ]'
                                                            : 'บิลเงินสด/ใบกำกับภาษี [ $TitleType_Default_Receipt_Name ]'
                                                        : (numdoctax.toString() ==
                                                                '')
                                                            ? 'บิลเงินสด'
                                                            : 'บิลเงินสด/ใบกำกับภาษี',
                                                    textAlign:
                                                        pw.TextAlign.center,
                                                    style: pw.TextStyle(
                                                      fontSize: 14,
                                                      font: ttf,
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      color: Colors_pd,
                                                    ),
                                                  )
                                                : pw.Text(
                                                    (TitleType_Default_Receipt_Name !=
                                                            null)
                                                        ? (numdoctax.toString() ==
                                                                '')
                                                            ? 'ใบเสร็จรับเงิน [ $TitleType_Default_Receipt_Name ]'
                                                            : 'ใบเสร็จรับเงิน/ใบกำกับภาษี [ $TitleType_Default_Receipt_Name ]'
                                                        : (numdoctax.toString() ==
                                                                '')
                                                            ? 'ใบเสร็จรับเงิน'
                                                            : 'ใบเสร็จรับเงิน/ใบกำกับภาษี',
                                                    textAlign:
                                                        pw.TextAlign.center,
                                                    style: pw.TextStyle(
                                                      fontSize: 14,
                                                      font: ttf,
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      color: Colors_pd,
                                                    ),
                                                  ),
                                            (hasNonCashTransaction1)
                                                ? pw.Text(
                                                    (TitleType_Default_Receipt_Name !=
                                                            null)
                                                        ? (numdoctax.toString() ==
                                                                '')
                                                            ? (TitleType_Default_Receipt_Name
                                                                        .toString() ==
                                                                    'ต้นฉบับ')
                                                                ? 'Cash Sell Original'
                                                                : 'Cash Sell Copy'
                                                            : (TitleType_Default_Receipt_Name
                                                                        .toString() ==
                                                                    'ต้นฉบับ')
                                                                ? 'Cash Sell/Tax Invoice Original'
                                                                : 'Cash Sell/Tax Invoice Copy'
                                                        : (numdoctax.toString() ==
                                                                '')
                                                            ? 'Cash Sell'
                                                            : 'Cash Sell/Tax Invoice',
                                                    textAlign:
                                                        pw.TextAlign.center,
                                                    style: pw.TextStyle(
                                                      fontSize: 14,
                                                      font: ttf,
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      color: Colors_pd,
                                                    ),
                                                  )
                                                : pw.Text(
                                                    (TitleType_Default_Receipt_Name !=
                                                            null)
                                                        ? (numdoctax.toString() ==
                                                                '')
                                                            ? (TitleType_Default_Receipt_Name
                                                                        .toString() ==
                                                                    'ต้นฉบับ')
                                                                ? 'Receipt Original'
                                                                : 'Receipt Copy'
                                                            : (TitleType_Default_Receipt_Name
                                                                        .toString() ==
                                                                    'ต้นฉบับ')
                                                                ? 'Receipt/Tax Receipt Original'
                                                                : 'Receipt/Tax Invoice Copy'
                                                        : (numdoctax.toString() ==
                                                                '')
                                                            ? 'Receipt'
                                                            : 'Receipt/Tax Invoice',
                                                    textAlign:
                                                        pw.TextAlign.center,
                                                    style: pw.TextStyle(
                                                      fontSize: 14,
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
                          pw.Row(
                            children: [
                              pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    height: (ref_invoice.length > 5)
                                        ? 70
                                        : (ref_invoice.length > 1)
                                            ? 50
                                            : 40,
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
                                                  '${DateFormat('dd/MM').format(DateTime.parse(date_Transaction!))}/${DateTime.parse('${date_Transaction}').year + 543}',
                                                  //'$date_Transaction',
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
                                    height: (ref_invoice.length > 5)
                                        ? 70
                                        : (ref_invoice.length > 1)
                                            ? 50
                                            : 40,
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
                              (ref_invoice.length == 0 ||
                                      ref_invoice.length > 1)
                                  ? pw.SizedBox()
                                  : pw.Expanded(
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
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.center,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    pw.Text(
                                                      'อ้างอิงเลขที่',
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
                                                      'Refer no.',
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
                                                      ' ${ref_invoice[0]}',
                                                      // (ref_invoice == null ||
                                                      //         ref_invoice
                                                      //                 .toString() ==
                                                      //             '')
                                                      //     ? ''
                                                      //     : '${ref_invoice}',
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
                                        'พนักงานขาย /Sales man No.',
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
                                        'ประเภท /Type.',
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
                                            ? 'สัญญา'
                                            : 'ล็อคเสียบ',
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
                                        'วันที่รับชำระ /Payment Date',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                      pw.Text(
                                        (dayfinpay.toString() == '' ||
                                                dayfinpay.toString() ==
                                                    'null' ||
                                                dayfinpay == null)
                                            ? '-'
                                            : '${DateFormat('dd/MM').format(DateTime.parse(dayfinpay!))}/${DateTime.parse('${dayfinpay}').year + 543}',
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
                  //                       (type_bills.toString().trim() == '' ||
                  //                               type_bills == null)
                  //                           ? 'วันที่ 5 ของเดือน'
                  //                           : '-',
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
                            'จำนวน',
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
                            'หน่วยละ',
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
                            'ส่วนลด',
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
                            'จำนวนเงิน',
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
                            '${tableData00[index][14].toString()}',
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
                            alignment: (tableData00[index][11].toString() == '')
                                ? pw.Alignment.topCenter
                                : pw.Alignment.topLeft,
                            child: pw.Text(
                              (tableData00[index][11].toString() == '' ||
                                      tableData00[index][11] == null)
                                  ? '-'
                                  : '${tableData00[index][11]}',
                              maxLines: 2,
                              textAlign:
                                  (tableData00[index][11].toString() == '')
                                      ? pw.TextAlign.center
                                      : pw.TextAlign.left,
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
                                    ? '${tableData00[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData00[index][1]))}/${DateTime.parse('${tableData00[index][1]}').year + 543} [ หน่วยที่ใช้ไป ${tableData00[index][8]}-${tableData00[index][9]} ]'
                                    : '${tableData00[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData00[index][1]))}/${DateTime.parse('${tableData00[index][1]}').year + 543}',
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
                                    ? '1.00'
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
                                (tableData00[index][14].toString() != '0' &&
                                        tableData00[index][14] != null)
                                    ? 'อัตราพิเศษ'
                                    : (tableData00[index][7].toString() ==
                                            '0.00')
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
                            alignment: (tableData01[index][11].toString() == '')
                                ? pw.Alignment.topCenter
                                : pw.Alignment.topLeft,
                            child: pw.Text(
                              (tableData01[index][11].toString() == '' ||
                                      tableData01[index][11] == null)
                                  ? '-'
                                  : '${tableData01[index][11]}',
                              maxLines: 2,
                              textAlign:
                                  (tableData01[index][11].toString() == '')
                                      ? pw.TextAlign.center
                                      : pw.TextAlign.left,
                              // '${tableData01[index][11]}',

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
                                    ? '${tableData01[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData01[index][1]))}/${DateTime.parse('${tableData01[index][1]}').year + 543} [ หน่วยที่ใช้ไป ${tableData01[index][8]}-${tableData01[index][9]} ]'
                                    : '${tableData01[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData01[index][1]))}/${DateTime.parse('${tableData01[index][1]}').year + 543}',
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
                                    ? '1.00'
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
                                '0.00',
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
                  //     padding: const pw.EdgeInsets.all(4.0),
                  //     child: pw.Column(
                  //       children: [
                  //         pw.Text(
                  //           '# หมายเหตุ : ',
                  //           style: pw.TextStyle(
                  //               fontSize: font_Size,
                  //               fontWeight: pw.FontWeight.bold,
                  //               font: ttf,
                  //               color: PdfColors.grey800),
                  //         ),
                  //         pw.Text(
                  //           'ค่าไฟฟ้าอัตตราพิเศษ หน่วยละ ( ) , ค่าไฟฟ้าอัตตราพิเศษ หน่วยละ ( )',
                  //           style: pw.TextStyle(
                  //               fontSize: font_Size,
                  //               fontWeight: pw.FontWeight.bold,
                  //               font: ttf,
                  //               color: PdfColors.grey800),
                  //         ),
                  //         pw.Text(
                  //           'ค่าน้ำอัตตราพิเศษ หน่วยละ ( ) , ค่าไฟฟ้าอัตตราพิเศษ หน่วยละ ( )',
                  //           style: pw.TextStyle(
                  //               fontSize: font_Size,
                  //               fontWeight: pw.FontWeight.bold,
                  //               font: ttf,
                  //               color: PdfColors.grey800),
                  //         ),
                  //       ],
                  //     )),
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
                                  'รวมราคาสินค้า / Sub Total',
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
                                  'ภาษีมูลค่าเพิ่ม / Vat',
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
                                  'หัก ณ ที่จ่าย / Withholding ',
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
                                  'ค่าธรรมเนียม / Fees',
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
                                  '${nFormat.format(double.parse(sum_fee.toString()))}',
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
                                  'ยอดรวม / Total',
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
                                  'ส่วนลด / Discount',
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
                                    'เงินมัดจำ(ตัดมัดจำ) / deposit',
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
                                    'เงินประกัน(ตัดเงินประกัน) / insurance',
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
                                  'ยอดชำระ / Payment Amount',
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
                                  '${nFormat.format((double.parse(Total.toString()) + double.parse(sum_fee.toString())) - (double.parse(dis_sum_Matjum.toString()) + double.parse(dis_sum_Pakan.toString())))}',
                                  // '${nFormat.format(double.parse(Total.toString()) - double.parse(dis_sum_Matjum.toString()) - double.parse(dis_sum_Pakan.toString()))}',
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
                          '(~${convertToThaiBaht(double.parse(Total.toString()) + double.parse(sum_fee.toString()))}~)',
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
                                  '${nFormat.format(double.parse(Total.toString()) + double.parse(sum_fee.toString()))}',
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
                  padding: pw.EdgeInsets.fromLTRB(2, 4, 2, 4),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'หมายเหตุ : ',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  (hasNonCashTransaction)
                                      ? '( / ) 1. เงินโอน, QR Code, Mobile Banking '
                                      : '(   ) 1. เงินโอน, QR Code, Mobile Banking ',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  (hasNonCashTransaction)
                                      ? '      บัญชี ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => model.bank).join(', ')} เลขที่ ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => model.bno).join(', ')} [ ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => (model.ptname.toString() == 'Online Payment' ? 'PromptPay QR' : model.ptname == 'เงินโอน' ? 'เลขบัญชี' : model.ptname == 'Beam Checkout' ? 'Beam Checkout' : 'Online Standard QR')).join(', ')} ]'
                                      : '      บัญชี...................................เลขที่...................................',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                if (hasNonCashTransaction8)
                                  pw.Text(
                                    hasNonCashTransaction7
                                        ? '      ( Ref1. ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => model.inv.replaceAll('-', '')).join(', ')} Ref2. ${DateFormat('ddMM').format(DateTime.parse(dayfinpay!))}${DateTime.parse('${dayfinpay}').year + 543} )'
                                        : '      ( Ref1. ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => model.ref1).join(', ')} Ref2. ${DateFormat('ddMM').format(DateTime.parse(dayfinpay!))}${DateTime.parse('${dayfinpay}').year + 543} )',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      fontWeight: pw.FontWeight.bold,
                                      color: Colors_pd,
                                    ),
                                  ),
                                pw.Row(
                                  // mainAxisAlignment:
                                  //     pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Expanded(
                                      flex: 1,
                                      child: pw.Text(
                                        (hasNonCashTransaction1)
                                            ? '( / ) 2. เงินสด'
                                            : '(   ) 2. เงินสด',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 3,
                                      child: pw.Text(
                                        (hasNonCashTransaction ||
                                                hasNonCashTransaction1)
                                            ? '(   ) 3. อื่นๆ.............................'
                                            : '( / ) 3. อื่นๆ ${finnancetransModels.where((model) => model.ptser != '6' || model.ptser != '5' || model.ptser != '2' || model.ptser != '1' && model.dtype == 'KP').map((model) => model.bank).join(', ')}',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ])),
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'ลงชื่อ : ผู้จัดการ',
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
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'ลงชื่อ : ผู้รับเงิน',
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
                      // pw.Expanded(
                      //     flex: 1,
                      //     child: pw.Column(
                      //         mainAxisAlignment: pw.MainAxisAlignment.start,
                      //         // crossAxisAlignment: pw.CrossAxisAlignment.center,
                      //         children: [
                      //           if (hasNonCashTransaction2)
                      //             pw.Container(
                      //               child: pw.BarcodeWidget(
                      //                   data:
                      //                       '|${finnancetransModels.where((model) => model.ptser == '6' && model.dtype == 'KP').map((model) => model.bno).join(',')}\r${numinvoice.replaceAll('-', '')}\r${DateFormat('ddMM').format(DateTime.parse(dayfinpay))}${DateTime.parse('${dayfinpay}').year + 543}\r${newTotal_QR}',
                      //                   barcode: pw.Barcode.qrCode(),
                      //                   width: 55,
                      //                   height: 55),
                      //             ),
                      //           if (hasNonCashTransaction4)
                      //             pw.BarcodeWidget(
                      //                 data: generateQRCode(
                      //                     promptPayID:
                      //                         "${finnancetransModels.where((model) => model.ptser == '5' && model.dtype == 'KP').map((model) => model.bno).join(',')}",
                      //                     amount: double.parse((Total == null ||
                      //                             Total == '')
                      //                         ? '0'
                      //                         : '${finnancetransModels.where((model) => model.ptser == '5' && model.dtype == 'KP').map((model) => model.total).join(',')}')),
                      //                 barcode: pw.Barcode.qrCode(),
                      //                 width: 55,
                      //                 height: 55),
                      //           if (hasNonCashTransaction3)
                      //             for (var i = 0;
                      //                 i < finnancetransModels.length;
                      //                 i++)
                      //               if (finnancetransModels[i]
                      //                           .ptser
                      //                           .toString() ==
                      //                       '2' &&
                      //                   finnancetransModels[i]
                      //                           .dtype
                      //                           .toString() ==
                      //                       'KP')
                      //                 pw.Image(
                      //                   (netImage_QR[i]),
                      //                   height: 55,
                      //                   width: 55,
                      //                 ),
                      //         ])),
                    ],
                  )),
              if (electricityModels.length != 0)
                if (int.parse('${context.pageNumber}') ==
                    int.parse('${context.pagesCount}'))
                  pw.Row(
                    children: [
                      pw.Text(
                        // ignore: unnecessary_string_interpolations
                        '# หมายเหตุ อัตราการคำนวณปัจจุบัน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            fontSize: font_Size,
                            color: PdfColors.grey800),
                      ),
                    ],
                  ),
              if (electricityModels.length != 0)
                if (int.parse('${context.pageNumber}') ==
                    int.parse('${context.pagesCount}'))
                  pw.Align(
                    alignment: pw.Alignment.bottomCenter,
                    child: pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.grey100,
                          borderRadius: pw.BorderRadius.only(
                              topLeft: pw.Radius.circular(8),
                              topRight: pw.Radius.circular(8),
                              bottomLeft: pw.Radius.circular(8),
                              bottomRight: pw.Radius.circular(8)),
                          border:
                              pw.Border.all(color: PdfColors.grey400, width: 1),
                        ),
                        padding: const pw.EdgeInsets.all(3.0),
                        child: pw.Container(
                          child: pw.Column(
                            children: [
                              for (int index = 0;
                                  index < electricityModels.length;
                                  index++)
                                pw.Container(
                                  decoration: const pw.BoxDecoration(
                                    // color: PdfColors.green100,
                                    border: pw.Border(
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey300, width: 0.5),
                                    ),
                                  ),
                                  child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 100,
                                        child: pw.Text(
                                          '${electricityModels[index].nameEle}',
                                          style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              font: ttf,
                                              fontSize: font_Size,
                                              color: PdfColors.grey800),
                                        ),
                                      ),
                                      // for (int index2 = 0; index2 < 7; index2++)
                                      (double.parse(electricityModels[index]
                                                      .eleMitOne!) +
                                                  double.parse(
                                                      electricityModels[index]
                                                          .eleGobOne!)) ==
                                              0.00
                                          ? pw.SizedBox()
                                          : pw.Expanded(
                                              flex: 1,
                                              child: pw.Container(
                                                decoration:
                                                    const pw.BoxDecoration(
                                                  // color: PdfColors.green100,
                                                  border: pw.Border(
                                                    // top: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    // right: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    left: pw.BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            PdfColors.grey300),
                                                    // bottom: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                  ),
                                                ),
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        4.0),
                                                child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'หน่วยที่ 0 - ${electricityModels[index].eleOne}',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                          font: ttf,
                                                          fontSize:
                                                              font_Size - 1,
                                                          color: PdfColors
                                                              .grey800),
                                                    ),
                                                    pw.SizedBox(
                                                      child: pw.Row(children: [
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitOne!) ==
                                                                  0.00
                                                              ? 'เหมาจ่าย '
                                                              : 'หน่วยละ ',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size - 1,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitOne!) ==
                                                                  0.00
                                                              ? '${electricityModels[index].eleGobOne}บาท'
                                                              : '${electricityModels[index].eleMitOne}บาท',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size - 1,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                      ]),
                                                    )
                                                  ],
                                                ),
                                              )),
                                      (double.parse(electricityModels[index]
                                                      .eleMitTwo!) +
                                                  double.parse(
                                                      electricityModels[index]
                                                          .eleGobTwo!)) ==
                                              0.00
                                          ? pw.SizedBox()
                                          : pw.Expanded(
                                              flex: 1,
                                              child: pw.Container(
                                                decoration:
                                                    const pw.BoxDecoration(
                                                  // color: PdfColors.green100,
                                                  border: pw.Border(
                                                    // top: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    // right: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    left: pw.BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            PdfColors.grey300),
                                                    // bottom: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                  ),
                                                ),
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        4.0),
                                                child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'หน่วยที่ ${int.parse(electricityModels[index].eleOne!) + 1} - ${electricityModels[index].eleTwo}}',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                          font: ttf,
                                                          fontSize:
                                                              font_Size - 1,
                                                          color: PdfColors
                                                              .grey800),
                                                    ),
                                                    pw.SizedBox(
                                                      child: pw.Row(children: [
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitTwo!) ==
                                                                  0.00
                                                              ? 'เหมาจ่าย '
                                                              : 'หน่วยละ ',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size - 1,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitTwo!) ==
                                                                  0.00
                                                              ? '${electricityModels[index].eleGobTwo}บาท'
                                                              : '${electricityModels[index].eleMitTwo}บาท',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size - 1,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                      ]),
                                                    )
                                                  ],
                                                ),
                                              )),
                                      (double.parse(electricityModels[index]
                                                      .eleMitThree!) +
                                                  double.parse(
                                                      electricityModels[index]
                                                          .eleGobThree!)) ==
                                              0.00
                                          ? pw.SizedBox()
                                          : pw.Expanded(
                                              flex: 1,
                                              child: pw.Container(
                                                decoration:
                                                    const pw.BoxDecoration(
                                                  // color: PdfColors.green100,
                                                  border: pw.Border(
                                                    // top: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    // right: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    left: pw.BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            PdfColors.grey300),
                                                    // bottom: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                  ),
                                                ),
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        4.0),
                                                child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'หน่วยที่ ${int.parse(electricityModels[index].eleTwo!) + 1} - ${electricityModels[index].eleThree}',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                          font: ttf,
                                                          fontSize: font_Size,
                                                          color: PdfColors
                                                              .grey800),
                                                    ),
                                                    pw.SizedBox(
                                                      child: pw.Row(children: [
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitThree!) ==
                                                                  0.00
                                                              ? 'เหมาจ่าย '
                                                              : 'หน่วยละ ',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitThree!) ==
                                                                  0.00
                                                              ? '${electricityModels[index].eleGobThree}บาท'
                                                              : '${electricityModels[index].eleMitThree}บาท',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                      ]),
                                                    )
                                                  ],
                                                ),
                                              )),
                                      (double.parse(electricityModels[index]
                                                      .eleMitTour!) +
                                                  double.parse(
                                                      electricityModels[index]
                                                          .eleGobTour!)) ==
                                              0.00
                                          ? pw.SizedBox()
                                          : pw.Expanded(
                                              flex: 1,
                                              child: pw.Container(
                                                decoration:
                                                    const pw.BoxDecoration(
                                                  // color: PdfColors.green100,
                                                  border: pw.Border(
                                                    // top: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    // right: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    left: pw.BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            PdfColors.grey300),
                                                    // bottom: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                  ),
                                                ),
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        4.0),
                                                child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'หน่วยที่ ${int.parse(electricityModels[index].eleThree!) + 1} - ${electricityModels[index].eleTour}',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                          font: ttf,
                                                          fontSize: font_Size,
                                                          color: PdfColors
                                                              .grey800),
                                                    ),
                                                    pw.SizedBox(
                                                      child: pw.Row(children: [
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitTour!) ==
                                                                  0.00
                                                              ? 'เหมาจ่าย '
                                                              : 'หน่วยละ ',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitTour!) ==
                                                                  0.00
                                                              ? '${electricityModels[index].eleGobTour}บาท'
                                                              : '${electricityModels[index].eleMitTour}บาท',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                      (double.parse(electricityModels[index]
                                                      .eleMitFive!) +
                                                  double.parse(
                                                      electricityModels[index]
                                                          .eleGobFive!)) ==
                                              0.00
                                          ? pw.SizedBox()
                                          : pw.Expanded(
                                              flex: 1,
                                              child: pw.Container(
                                                decoration:
                                                    const pw.BoxDecoration(
                                                  // color: PdfColors.green100,
                                                  border: pw.Border(
                                                    // top: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    // right: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    left: pw.BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            PdfColors.grey300),
                                                    // bottom: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                  ),
                                                ),
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        4.0),
                                                child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'หน่วยที่ ${int.parse(electricityModels[index].eleTour!) + 1} - ${electricityModels[index].eleFive}',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                          font: ttf,
                                                          fontSize: font_Size,
                                                          color: PdfColors
                                                              .grey800),
                                                    ),
                                                    pw.SizedBox(
                                                      child: pw.Row(children: [
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitFive!) ==
                                                                  0.00
                                                              ? 'เหมาจ่าย '
                                                              : 'หน่วยละ ',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitFive!) ==
                                                                  0.00
                                                              ? '${electricityModels[index].eleGobFive}บาท'
                                                              : '${electricityModels[index].eleMitFive}บาท',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                      (double.parse(electricityModels[index]
                                                      .eleMitSix!) +
                                                  double.parse(
                                                      electricityModels[index]
                                                          .eleGobSix!)) ==
                                              0.00
                                          ? pw.SizedBox()
                                          : pw.Expanded(
                                              flex: 1,
                                              child: pw.Container(
                                                decoration:
                                                    const pw.BoxDecoration(
                                                  // color: PdfColors.green100,
                                                  border: pw.Border(
                                                    // top: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    // right: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                    left: pw.BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            PdfColors.grey300),
                                                    // bottom: pw.BorderSide(
                                                    //     color:
                                                    //         PdfColors.grey600),
                                                  ),
                                                ),
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        4.0),
                                                child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'หน่วยที่ ${electricityModels[index].eleSix} ขึ้นไป',
                                                      style: pw.TextStyle(
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                          font: ttf,
                                                          fontSize: font_Size,
                                                          color: PdfColors
                                                              .grey800),
                                                    ),
                                                    pw.SizedBox(
                                                      child: pw.Row(children: [
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitSix!) ==
                                                                  0.00
                                                              ? 'เหมาจ่าย '
                                                              : 'หน่วยละ ',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                        pw.Text(
                                                          double.parse(electricityModels[
                                                                          index]
                                                                      .eleMitSix!) ==
                                                                  0.00
                                                              ? '${electricityModels[index].eleGobSix}บาท'
                                                              : '${electricityModels[index].eleMitSix}บาท',
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              font: ttf,
                                                              fontSize:
                                                                  font_Size,
                                                              color: PdfColors
                                                                  .grey800),
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )),
                  ),
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

        // footer: (context) {
        //   return pw.Column(
        //     mainAxisSize: pw.MainAxisSize.min,
        //     children: [
        //       pw.Container(
        //           decoration: pw.BoxDecoration(
        //             border: pw.Border.all(color: PdfColors.grey, width: 1),
        //           ),
        //           padding: pw.EdgeInsets.fromLTRB(2, 2, 2, 2),
        //           child: pw.Row(
        //             children: [
        //               pw.Expanded(
        //                   flex: 2,
        //                   child: pw.Column(
        //                       mainAxisAlignment: pw.MainAxisAlignment.start,
        //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
        //                       children: [
        //                         pw.Text(
        //                           'หมายเหตุ :',
        //                           textAlign: pw.TextAlign.left,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Text(
        //                           (!hasNonCashTransaction)
        //                               ? '(   ) 1. เงินโอน, QR Code, Mobile Banking '
        //                               : '( / ) 1. เงินโอน, QR Code, Mobile Banking ',
        //                           textAlign: pw.TextAlign.left,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Text(
        //                           (!hasNonCashTransaction)
        //                               ? '      บัญชี...................................เลขที่...................................'
        //                               : '      บัญชี ${finnancetransModels.where((model) => model.type.toString() != 'CASH' || model.ptser == '6' || model.ptser == '5' || model.ptser == '2' && model.dtype != 'MM').map((model) => model.bank).join(', ')} เลขที่ ${finnancetransModels.where((model) => model.ptser == '6' || model.ptser == '5' || model.ptser == '2' && model.dtype != 'MM').map((model) => model.bno).join(', ')}',
        //                           textAlign: pw.TextAlign.left,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Row(
        //                           // mainAxisAlignment:
        //                           //     pw.MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             pw.Expanded(
        //                               flex: 1,
        //                               child: pw.Text(
        //                                 (hasNonCashTransaction)
        //                                     ? '(   ) 2. เงินสด'
        //                                     : '( / ) 2. เงินสด',
        //                                 textAlign: pw.TextAlign.left,
        //                                 style: pw.TextStyle(
        //                                   fontSize: font_Size,
        //                                   font: ttf,
        //                                   fontWeight: pw.FontWeight.bold,
        //                                   color: Colors_pd,
        //                                 ),
        //                               ),
        //                             ),
        //                             pw.Expanded(
        //                               flex: 3,
        //                               child: pw.Text(
        //                                 (hasNonCashTransaction3)
        //                                     ? '(   ) 3. อื่นๆ.............................'
        //                                     : '( / ) 3. อื่นๆ ${finnancetransModels.where((model) => model.ptser == '6' || model.ptser == '5' || model.ptser == '2' || model.ptser == '1' && model.dtype != 'MM').map((model) => model.bank).join(', ')}',
        //                                 textAlign: pw.TextAlign.left,
        //                                 style: pw.TextStyle(
        //                                   fontSize: font_Size,
        //                                   font: ttf,
        //                                   fontWeight: pw.FontWeight.bold,
        //                                   color: Colors_pd,
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         )
        //                       ])),
        //               pw.Expanded(
        //                   flex: 1,
        //                   child: pw.Column(
        //                       mainAxisAlignment: pw.MainAxisAlignment.start,
        //                       // crossAxisAlignment: pw.CrossAxisAlignment.center,
        //                       children: [
        //                         pw.Text(
        //                           'ผู้รับเงิน /Collector :',
        //                           textAlign: pw.TextAlign.left,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Text(
        //                           '........................................................',
        //                           textAlign: pw.TextAlign.center,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Text(
        //                           '(......................................................)',
        //                           textAlign: pw.TextAlign.center,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Text(
        //                           'วันที่/Date...........................................',
        //                           textAlign: pw.TextAlign.center,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                       ])),
        //               pw.Expanded(
        //                   flex: 1,
        //                   child: pw.Column(
        //                       mainAxisAlignment: pw.MainAxisAlignment.start,
        //                       // crossAxisAlignment: pw.CrossAxisAlignment.center,
        //                       children: [
        //                         pw.Text(
        //                           'ผู้จัดการ /Manager :',
        //                           textAlign: pw.TextAlign.left,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Text(
        //                           '........................................................',
        //                           textAlign: pw.TextAlign.center,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Text(
        //                           '(......................................................)',
        //                           textAlign: pw.TextAlign.center,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         pw.Text(
        //                           'วันที่/Date...........................................',
        //                           textAlign: pw.TextAlign.center,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                       ])),

        //             ],
        //           )),
        //       pw.Row(
        //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //         children: [
        //           pw.Padding(
        //             padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
        //             child: pw.Align(
        //               alignment: pw.Alignment.bottomLeft,
        //               child: pw.Text(
        //                 'พิมพ์เมื่อ : $date',
        //                 // textAlign: pw.TextAlign.left,
        //                 style: pw.TextStyle(
        //                   fontSize: 7.00,
        //                   font: ttf,
        //                   color: Colors_pd,
        //                   // fontWeight: pw.FontWeight.bold
        //                 ),
        //               ),
        //             ),
        //           ),
        //           pw.Padding(
        //             padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
        //             child: pw.Align(
        //               alignment: pw.Alignment.bottomRight,
        //               child: pw.Text(
        //                 'หน้าที่ ${context.pageNumber} / ${context.pagesCount} ',
        //                 // textAlign: pw.TextAlign.left,
        //                 style: pw.TextStyle(
        //                   fontSize: 7.00,
        //                   font: ttf,
        //                   color: Colors_pd,
        //                   // fontWeight: pw.FontWeight.bold
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       )
        //     ],
        //   );
        // },
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
              doc: pdf,
              title: (TitleType_Default_Receipt_Name == null)
                  ? (numdoctax.toString() == '')
                      ? 'ใบเสร็จรับเงิน $numinvoice'
                      : 'ใบเสร็จรับเงิน/ใบกำกับภาษี $numdoctax'
                  : (numdoctax.toString() == '')
                      ? 'ใบเสร็จรับเงิน [ $TitleType_Default_Receipt_Name ]$numinvoice'
                      : 'ใบเสร็จรับเงิน/ใบกำกับภาษี [ $TitleType_Default_Receipt_Name ]$numdoctax'),
        ));
  }
}
