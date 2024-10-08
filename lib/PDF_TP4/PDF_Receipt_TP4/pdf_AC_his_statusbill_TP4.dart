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

class Pdfgen_his_statusbill_TP4 {
//////////---------------------------------------------------->(ใบเสร็จรับเงิน/ใบกำกับภาษี)   ใช้  //

  static void exportPDF_statusbill_TP4(
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
      fonts_pdf) async {
    ////
    //// ------------>(ใบเสร็จรับเงินชั่วคราว paySrsscreen_)
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
    // var formatter = new DateFormat.MMMMd('th_TH');
    // String thaiDate = formatter.format(date);
    final thaiDate = DateTime.parse(date_Transaction);
    final formatter = DateFormat('d MMMM', 'th_TH');
    final formattedDate = formatter.format(thaiDate);
    //////--------------->พ.ศ.
    DateTime dateTime = DateTime.parse(date_Transaction);
    int newYear = dateTime.year + 543;
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
///// Online Standard QR
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
                //         height: 72,
                //         width: 70,
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
                //         height: 72,
                //         width: 70,
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
                //           height: 72,
                //           width: 70,
                //         ),
                //       ),
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
                      (hasNonCashTransaction1)
                          ? pw.Text(
                              (TitleType_Default_Receipt_Name != null)
                                  ? (numdoctax.toString() == '')
                                      ? 'บิลเงินสด [ $TitleType_Default_Receipt_Name ]'
                                      : 'บิลเงินสด/ใบกำกับภาษี [ $TitleType_Default_Receipt_Name ]'
                                  : (numdoctax.toString() == '')
                                      ? 'บิลเงินสด'
                                      : 'บิลเงินสด/ใบกำกับภาษี',
                              maxLines: 1,
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            )
                          : pw.Text(
                              (TitleType_Default_Receipt_Name != null)
                                  ? (numdoctax.toString() == '')
                                      ? 'ใบเสร็จรับเงิน [ $TitleType_Default_Receipt_Name ]'
                                      : 'ใบเสร็จรับเงิน/ใบกำกับภาษี [ $TitleType_Default_Receipt_Name ]'
                                  : (numdoctax.toString() == '')
                                      ? 'ใบเสร็จรับเงิน'
                                      : 'ใบเสร็จรับเงิน/ใบกำกับภาษี',
                              maxLines: 1,
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                      pw.Text(
                        (numdoctax.toString() == '')
                            ? 'เลขที่ชำระ : $numinvoice'
                            : 'เลขที่ชำระ : $numdoctax',
                        maxLines: 2,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'วันที่ทำรายการ : $formattedDate ${newYear}',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (ref_invoice.length == 0)
                            ? ''
                            : 'อ้างอิงเลขที่ :  ${ref_invoice.toSet().map((model) => model).join(', ')}',
                        // (ref_invoice == null || ref_invoice.toString() == '')
                        //     ? ''
                        //     : 'อ้างอิงเลขที่ : ${ref_invoice}',
                        maxLines: 3,
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
                        '${(sname.toString() == '' || sname == null || sname.toString() == 'null') ? '-' : sname} (${(cname.toString() == '' || cname == null || cname.toString() == 'null') ? '-' : cname})',
                        // (sname.toString() == null ||
                        //         sname.toString() == '' ||
                        //         sname.toString() == 'null')
                        //     ? ' -'
                        //     : '$sname',
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
                      pw.Text(
                        'โซน(Zone) : $Zone_s / ห้อง( Room) : $Ln_s',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'หมายเหตุ : $com_ment',
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
            // pw.Text(
            //   'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
            //   textAlign: pw.TextAlign.justify,
            // ),

            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    'รูปแบบชำระ',
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontSize: font_Size,
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
                      pw.Text(
                        (dayfinpay.toString() == '' ||
                                dayfinpay.toString() == 'null' ||
                                dayfinpay == null)
                            ? 'วันที่ชำระ : - '
                            : 'วันที่ชำระ : ${DateFormat('dd-MM').format(DateTime.parse('${dayfinpay}'))}-${DateTime.parse(dayfinpay).year + 543}',
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

            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < finnancetransModels.length; i++)
                        if (finnancetransModels[i].dtype.toString() != 'FTA')
                          pw.Row(
                            children: [
                              (finnancetransModels[i].dtype.toString() == 'KP')
                                  ? pw.Expanded(
                                      flex: 1,
                                      child: pw.Container(
                                        // decoration: pw.BoxDecoration(
                                        //   color: PdfColors.green100,
                                        //   // border: pw.Border(
                                        //   //   bottom: pw.BorderSide(
                                        //   //       color: PdfColors.green900),
                                        //   // ),
                                        // ),
                                        child: pw.Text(
                                          (finnancetransModels[i]
                                                      .type
                                                      .toString() ==
                                                  'CASH')
                                              ? '${i + 1}.เงินสด : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)'
                                              : '${i + 1}.เงินโอน : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท  (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)',
                                          textAlign: pw.TextAlign.justify,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            font: ttf,
                                            fontWeight: pw.FontWeight.bold,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ))
                                  : pw.Expanded(
                                      flex: 1,
                                      child: pw.Container(
                                        // decoration: pw.BoxDecoration(
                                        //   color: PdfColors.green100,
                                        //   // border: pw.Border(
                                        //   //   bottom: pw.BorderSide(
                                        //   //       color: PdfColors.green900),
                                        //   // ),
                                        // ),
                                        child: pw.Text(
                                          '${i + 1}.${finnancetransModels[i].remark} : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท  (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)',
                                          textAlign: pw.TextAlign.justify,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            font: ttf,
                                            fontWeight: pw.FontWeight.bold,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      )),
                            ],
                          )
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),

            pw.Container(
              decoration: const pw.BoxDecoration(
                // color: PdfColors.green100,
                border: pw.Border(
                  top: pw.BorderSide(color: PdfColors.grey600),
                  bottom: pw.BorderSide(color: PdfColors.grey600),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Container(
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        left: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    width: 30,
                    height: 20,
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
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
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      height: 20,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'รหัสสินค้า',
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
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      height: 20,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'รายการ',
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
                  ),
                  // pw.Expanded(
                  //   flex: 2,
                  //   child: pw.Container(
                  //     decoration: const pw.BoxDecoration(
                  //       // color: PdfColors.green100,
                  //       border: pw.Border(
                  //         left: pw.BorderSide(color: PdfColors.grey600),
                  //       ),
                  //     ),
                  //     height: 20,
                  //     padding: const pw.EdgeInsets.all(2.0),
                  //     child: pw.Align(
                  //       alignment: pw.Alignment.centerRight,
                  //       child: pw.Text(
                  //         'จำนวน',
                  //         textAlign: pw.TextAlign.left,
                  //         maxLines: 1,
                  //         style: pw.TextStyle(
                  //             fontSize: font_Size,
                  //             fontWeight: pw.FontWeight.bold,
                  //             font: ttf,
                  //             color: PdfColors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // pw.Expanded(
                  //   flex: 2,
                  //   child: pw.Container(
                  //     decoration: const pw.BoxDecoration(
                  //       // color: PdfColors.green100,
                  //       border: pw.Border(
                  //         left: pw.BorderSide(color: PdfColors.grey600),
                  //       ),
                  //     ),
                  //     height: 20,
                  //     padding: const pw.EdgeInsets.all(2.0),
                  //     child: pw.Align(
                  //       alignment: pw.Alignment.centerRight,
                  //       child: pw.Text(
                  //         'หน่วย',
                  //         textAlign: pw.TextAlign.left,
                  //         maxLines: 1,
                  //         style: pw.TextStyle(
                  //             fontSize: font_Size,
                  //             fontWeight: pw.FontWeight.bold,
                  //             font: ttf,
                  //             color: PdfColors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      height: 20,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'VAT',
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
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      height: 20,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'WHT',
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
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      height: 20,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'ก่อนVAT',
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
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      height: 20,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'ส่วนลด',
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
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                        // color: PdfColors.green100,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                          right: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      height: 20,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'ยอดสุทธิ',
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
                  ),
                ],
              ),
            ),
            for (int index = 0; index < tableData00.length; index++)
              pw.Container(
                decoration: const pw.BoxDecoration(
                  // color: PdfColors.green100,
                  border: pw.Border(
                    // top: pw.BorderSide(color: PdfColors.grey600),
                    bottom: pw.BorderSide(color: PdfColors.grey600),
                  ),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      width: 30,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
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
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            // (tableData00[index][1] == null ||
                            //         tableData00[index][1].toString() == '')
                            //     ? '${tableData00[index][1]}'
                            //     : '${DateFormat('dd-MM').format(DateTime.parse(tableData00[index][1].toString()))}-${DateTime.parse(tableData00[index][1].toString()).year + 543}',
                            '${tableData00[index][11]}',
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
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '${tableData00[index][2]}',
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
                    // pw.Expanded(
                    //   flex: 2,
                    //   child: pw.Container(
                    //     decoration: const pw.BoxDecoration(
                    //       color: PdfColors.white,
                    //       border: const pw.Border(
                    //         left: pw.BorderSide(color: PdfColors.grey600),
                    //       ),
                    //     ),
                    //     padding: const pw.EdgeInsets.all(2.0),
                    //     child: pw.Align(
                    //       alignment: pw.Alignment.centerRight,
                    //       child: pw.Text(
                    //         '-',
                    //         maxLines: 2,
                    //         textAlign: pw.TextAlign.right,
                    //         style: pw.TextStyle(
                    //             fontSize: font_Size,
                    //             font: ttf,
                    //             color: PdfColors.grey800),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // pw.Expanded(
                    //   flex: 2,
                    //   child: pw.Container(
                    //     decoration: const pw.BoxDecoration(
                    //       color: PdfColors.white,
                    //       border: const pw.Border(
                    //         left: pw.BorderSide(color: PdfColors.grey600),
                    //       ),
                    //     ),
                    //     padding: const pw.EdgeInsets.all(2.0),
                    //     child: pw.Align(
                    //       alignment: pw.Alignment.centerRight,
                    //       child: pw.Text(
                    //         '-',
                    //         maxLines: 2,
                    //         textAlign: pw.TextAlign.right,
                    //         style: pw.TextStyle(
                    //             fontSize: font_Size,
                    //             font: ttf,
                    //             color: PdfColors.grey800),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${tableData00[index][3]}',
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
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${tableData00[index][4]}',
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
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${tableData00[index][5]}',
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
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
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
                      ),
                    ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            right: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
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
                      ),
                    ),
                  ],
                ),
              ),

            for (int index = 0; index < tableData01.length; index++)
              pw.Container(
                decoration: const pw.BoxDecoration(
                  // color: PdfColors.green100,
                  border: pw.Border(
                    // top: pw.BorderSide(color: PdfColors.grey600),
                    bottom: pw.BorderSide(color: PdfColors.grey600),
                  ),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.grey600),
                        ),
                      ),
                      width: 30,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
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
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '-',
                            // '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${tableData01[index][1]}'))} ',
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
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '${tableData01[index][2]}',
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
                    // pw.Expanded(
                    //   flex: 2,
                    //   child: pw.Container(
                    //     decoration: const pw.BoxDecoration(
                    //       color: PdfColors.white,
                    //       border: const pw.Border(
                    //         left: pw.BorderSide(color: PdfColors.grey600),
                    //       ),
                    //     ),
                    //     padding: const pw.EdgeInsets.all(2.0),
                    //     child: pw.Align(
                    //       alignment: pw.Alignment.centerRight,
                    //       child: pw.Text(
                    //         '-',
                    //         maxLines: 2,
                    //         textAlign: pw.TextAlign.right,
                    //         style: pw.TextStyle(
                    //             fontSize: font_Size,
                    //             font: ttf,
                    //             color: PdfColors.grey800),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // pw.Expanded(
                    //   flex: 2,
                    //   child: pw.Container(
                    //     decoration: const pw.BoxDecoration(
                    //       color: PdfColors.white,
                    //       border: const pw.Border(
                    //         left: pw.BorderSide(color: PdfColors.grey600),
                    //       ),
                    //     ),
                    //     padding: const pw.EdgeInsets.all(2.0),
                    //     child: pw.Align(
                    //       alignment: pw.Alignment.centerRight,
                    //       child: pw.Text(
                    //         '-',
                    //         maxLines: 2,
                    //         textAlign: pw.TextAlign.right,
                    //         style: pw.TextStyle(
                    //             fontSize: font_Size,
                    //             font: ttf,
                    //             color: PdfColors.grey800),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${tableData01[index][3]}',
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
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${tableData01[index][4]}',
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
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '${tableData01[index][5]}',
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
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
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
                      ),
                    ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          border: const pw.Border(
                            left: pw.BorderSide(color: PdfColors.grey600),
                            right: pw.BorderSide(color: PdfColors.grey600),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(2.0),
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
                                'ค่าธรรมเนียม',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_fee.toString()))}',
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
                                'ยอดรวม',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(Sum_SubTotal.toString()) + double.parse(sum_fee.toString()))}',
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
                        if (nFormat
                                .format(double.parse(dis_sum_Pakan.toString()))
                                .toString() !=
                            '0.00')
                          pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'เงินประกัน(ตัดเงินประกัน)',
                                  //  'เงินมัดจำ(${nFormat.format(sum_matjum)})',
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                              pw.Text(
                                dis_sum_Pakan == 0.00
                                    ? '${nFormat.format(double.parse(dis_sum_Pakan.toString()))}'
                                    : '${nFormat.format(double.parse(dis_sum_Pakan.toString()))}',
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
                              '${nFormat.format((double.parse(Total.toString()) + double.parse(sum_fee.toString())) - (double.parse(dis_sum_Matjum.toString()) + double.parse(dis_sum_Pakan.toString())))}',
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
                          //"${nFormat2.format(double.parse(Total.toString()))}";
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
        //       (hasNonCashTransaction)
        //           ? pw.Container(
        //               decoration: pw.BoxDecoration(
        //                 border: pw.Border.all(color: PdfColors.grey, width: 1),
        //               ),
        //               child: pw.Column(
        //                 mainAxisAlignment: pw.MainAxisAlignment.center,
        //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
        //                 children: [
        //                   (hasNonCashTransaction2)
        //                       ? pw.Row(
        //                           mainAxisAlignment:
        //                               pw.MainAxisAlignment.center,
        //                           children: [
        //                               pw.Expanded(
        //                                 flex: 1,
        //                                 child: pw.Container(
        //                                   padding: const pw.EdgeInsets.all(4.0),
        //                                   child: pw.Column(
        //                                     children: [
        //                                       // pw.Container(
        //                                       //     // height: 60,
        //                                       //     // width: 200,
        //                                       //     child: pw.Image(
        //                                       //   pw.MemoryImage(uint8Listthaiqr),
        //                                       //   height: 72,
        //                                       //   width: 65,
        //                                       // )),
        //                                       pw.Container(
        //                                         child: pw.BarcodeWidget(
        //                                             data:
        //                                                 '|${finnancetransModels.where((model) => model.ptser == '6').map((model) => model.bno).join(', ')}\r$numinvoice\r${DateFormat('dd-MM-yyyy').format(DateTime.parse('${dayfinpay}'))}\r${newTotal_QR}\r',
        //                                             barcode:
        //                                                 pw.Barcode.qrCode(),
        //                                             width: 55,
        //                                             height: 55),

        //                                         //  pw.PrettyQr(
        //                                         //   // typeNumber: 3,
        //                                         //   image: const AssetImage(
        //                                         //     "images/Icon-chao.png",
        //                                         //   ),
        //                                         //   size: 110,
        //                                         //   data: '${teNantModels[index].cid}',
        //                                         //   errorCorrectLevel: QrErrorCorrectLevel.M,
        //                                         //   roundEdges: true,
        //                                         // ),
        //                                       ),
        //                                       pw.Text(
        //                                         'บัญชี : ${finnancetransModels.where((model) => model.ptser == '6').map((model) => model.bno).join(', ')}',
        //                                         style: pw.TextStyle(
        //                                           font: ttf,
        //                                           fontSize: font_Size,
        //                                           fontWeight:
        //                                               pw.FontWeight.bold,
        //                                         ),
        //                                       ),

        //                                       pw.Text(
        //                                         '(Ref1 : $numinvoice , Ref2 : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${dayfinpay}'))})',
        //                                         style: pw.TextStyle(
        //                                           font: ttf,
        //                                           fontSize: font_Size,
        //                                           fontWeight:
        //                                               pw.FontWeight.bold,
        //                                         ),
        //                                       ),
        //                                       pw.Text(
        //                                         'สำหรับชำระด้วย Mobile Banking',
        //                                         style: pw.TextStyle(
        //                                           font: ttf,
        //                                           fontSize: font_Size,
        //                                           fontWeight:
        //                                               pw.FontWeight.bold,
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                               pw.Expanded(
        //                                 flex: 1,
        //                                 child: pw.Container(
        //                                   padding: const pw.EdgeInsets.all(4.0),
        //                                   child: pw.Column(
        //                                     children: [
        //                                       pw.Text(
        //                                         'คำเตือน',
        //                                         textAlign: pw.TextAlign.left,
        //                                         style: pw.TextStyle(
        //                                             fontSize: font_Size,
        //                                             font: ttf,
        //                                             color: PdfColors.red,
        //                                             fontWeight:
        //                                                 pw.FontWeight.bold),
        //                                       ),
        //                                       pw.SizedBox(
        //                                           height: 2 * PdfPageFormat.mm),
        //                                       pw.Text(
        //                                         'โปรดตรวจสอบความถูกต้องทุกครั้งก่อนทำการชำระเงิน',
        //                                         textAlign: pw.TextAlign.left,
        //                                         maxLines: 1,
        //                                         style: pw.TextStyle(
        //                                           fontSize: font_Size,
        //                                           font: ttf,
        //                                           color: PdfColors.red,
        //                                         ),
        //                                       ),
        //                                       pw.SizedBox(
        //                                           height: 2 * PdfPageFormat.mm),
        //                                       pw.Text(
        //                                         '( หากเกิดข้อผิดพลาดโปรดเก็บหลักฐานการชำระไว้ เพื่อติดต่อเจ้าหน้าที่ )',
        //                                         textAlign: pw.TextAlign.center,
        //                                         style: pw.TextStyle(
        //                                           fontSize: font_Size,
        //                                           font: ttf,
        //                                           color: PdfColors.red,
        //                                         ),
        //                                       ),
        //                                       pw.SizedBox(
        //                                           height: 2 * PdfPageFormat.mm),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                             ])
        //                       : pw.Row(
        //                           mainAxisAlignment:
        //                               pw.MainAxisAlignment.center,
        //                           children: [
        // for (var i = 0;
        //     i < finnancetransModels.length;
        //     i++)
        //   if (finnancetransModels[i]
        //               .ptser
        //               .toString() !=
        //           '1' &&
        //       finnancetransModels[i]
        //               .dtype
        //               .toString() !=
        //           'FTA')
        //                                   pw.Expanded(
        //                                     flex: 1,
        //                                     child: pw.Container(
        //                                       padding:
        //                                           const pw.EdgeInsets.all(4.0),
        //                                       child: pw.Column(
        //                                         children: [
        //                                           // pw.Container(
        //                                           //     // height: 60,
        //                                           //     // width: 200,
        //                                           //     child: pw.Image(
        //                                           //   pw.MemoryImage(uint8Listthaiqr),
        //                                           //   height: 72,
        //                                           //   width: 65,
        //                                           // )),
        //                                           pw.Container(
        //                                             child: (finnancetransModels[i]
        //                                                             .ptser
        //                                                             .toString() ==
        //                                                         '' ||
        //                                                     finnancetransModels[i].ptser ==
        //                                                         null ||
        //                                                     finnancetransModels[i]
        //                                                             .img ==
        //                                                         null ||
        //                                                     finnancetransModels[i]
        //                                                             .img
        //                                                             .toString() ==
        //                                                         '')
        //                                                 ?
        // pw.BarcodeWidget(
        //                                                     data: generateQRCode(
        //                                                         promptPayID:
        //                                                             "${finnancetransModels[i].bno}",
        //                                                         amount: double.parse(
        //                                                                 (Total == null || Total == '')
        //                                                                     ? '0'
        //                                                                     : '${Total}') +
        //                                                             double.parse(
        //                                                                 (sum_fee == null || sum_fee == '') ? '0' : sum_fee.toString())),
        //                                                     barcode: pw.Barcode.qrCode(),
        //                                                     width: 55,
        //                                                     height: 55)
        //                                                 :
        // pw.Image(
        //                                                     (netImage_QR[i]),
        //                                                     height: 55,
        //                                                     width: 55,
        //                                                   ),
        //                                           ),
        //                                           pw.Text(
        //                                             'บัญชี : ${finnancetransModels[i].bno}',
        //                                             style: pw.TextStyle(
        //                                               font: ttf,
        //                                               fontSize: font_Size,
        //                                               fontWeight:
        //                                                   pw.FontWeight.bold,
        //                                             ),
        //                                           ),

        //                                           pw.Text(
        //                                             'สำหรับชำระด้วย Mobile Banking',
        //                                             style: pw.TextStyle(
        //                                               font: ttf,
        //                                               fontSize: font_Size,
        //                                               fontWeight:
        //                                                   pw.FontWeight.bold,
        //                                             ),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   ),
        //                               pw.Expanded(
        //                                 flex: 1,
        //                                 child: pw.Container(
        //                                   padding: const pw.EdgeInsets.all(4.0),
        //                                   child: pw.Column(
        //                                     children: [
        //                                       pw.Text(
        //                                         'คำเตือน',
        //                                         textAlign: pw.TextAlign.left,
        //                                         style: pw.TextStyle(
        //                                             fontSize: font_Size,
        //                                             font: ttf,
        //                                             color: PdfColors.red,
        //                                             fontWeight:
        //                                                 pw.FontWeight.bold),
        //                                       ),
        //                                       pw.SizedBox(
        //                                           height: 2 * PdfPageFormat.mm),
        //                                       pw.Text(
        //                                         'โปรดตรวจสอบความถูกต้องทุกครั้งก่อนทำการชำระเงิน',
        //                                         textAlign: pw.TextAlign.left,
        //                                         maxLines: 1,
        //                                         style: pw.TextStyle(
        //                                           fontSize: font_Size,
        //                                           font: ttf,
        //                                           color: PdfColors.red,
        //                                         ),
        //                                       ),
        //                                       pw.SizedBox(
        //                                           height: 2 * PdfPageFormat.mm),
        //                                       pw.Text(
        //                                         '( หากเกิดข้อผิดพลาดโปรดเก็บหลักฐานการชำระไว้ เพื่อติดต่อเจ้าหน้าที่ )',
        //                                         textAlign: pw.TextAlign.center,
        //                                         style: pw.TextStyle(
        //                                           fontSize: font_Size,
        //                                           font: ttf,
        //                                           color: PdfColors.red,
        //                                         ),
        //                                       ),
        //                                       pw.SizedBox(
        //                                           height: 2 * PdfPageFormat.mm),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                             ]),
        //                 ],
        //               ))
        //           : pw.Container(
        //               decoration: pw.BoxDecoration(
        //                 border: pw.Border.all(color: PdfColors.grey, width: 1),
        //               ),
        //               child: pw.Column(
        //                 mainAxisAlignment: pw.MainAxisAlignment.center,
        //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
        //                 children: [
        //                   pw.Row(
        //                       mainAxisAlignment: pw.MainAxisAlignment.center,
        //                       children: [
        //                         pw.Expanded(
        //                           flex: 1,
        //                           child: pw.Container(
        //                             padding: const pw.EdgeInsets.all(4.0),
        //                             child: pw.Column(
        //                               children: [
        //                                 pw.Text(
        //                                   'หมายเหตุ ',
        //                                   textAlign: pw.TextAlign.center,
        //                                   style: pw.TextStyle(
        //                                       fontSize: font_Size,
        //                                       font: ttf,
        //                                       color: Colors_pd,
        //                                       fontWeight: pw.FontWeight.bold),
        //                                 ),
        //                                 pw.SizedBox(
        //                                     height: 2 * PdfPageFormat.mm),
        //                                 pw.Text(
        //                                   ' .' * 160,
        //                                   textAlign: pw.TextAlign.center,
        //                                   maxLines: 2,
        //                                   style: pw.TextStyle(
        //                                     fontSize: font_Size,
        //                                     font: ttf,
        //                                     color: Colors_pd,
        //                                   ),
        //                                 ),
        //                                 pw.SizedBox(
        //                                     height: 2 * PdfPageFormat.mm),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         pw.Expanded(
        //                           flex: 1,
        //                           child: pw.Container(
        //                             padding: const pw.EdgeInsets.all(4.0),
        //                             child: pw.Column(
        //                               children: [
        //                                 pw.Text(
        //                                   'ผู้รับเงิน',
        //                                   textAlign: pw.TextAlign.left,
        //                                   style: pw.TextStyle(
        //                                       fontSize: font_Size,
        //                                       font: ttf,
        //                                       color: Colors_pd,
        //                                       fontWeight: pw.FontWeight.bold),
        //                                 ),
        //                                 pw.SizedBox(
        //                                     height: 2 * PdfPageFormat.mm),
        //                                 pw.Text(
        //                                   ' (..............................................)',
        //                                   textAlign: pw.TextAlign.left,
        //                                   maxLines: 1,
        //                                   style: pw.TextStyle(
        //                                     fontSize: font_Size,
        //                                     font: ttf,
        //                                     color: Colors_pd,
        //                                   ),
        //                                 ),
        //                                 pw.SizedBox(
        //                                     height: 2 * PdfPageFormat.mm),
        //                                 pw.Text(
        //                                   'วันที่........../........../..........',
        //                                   textAlign: pw.TextAlign.center,
        //                                   style: pw.TextStyle(
        //                                     fontSize: font_Size,
        //                                     font: ttf,
        //                                     color: Colors_pd,
        //                                   ),
        //                                 ),
        //                                 pw.SizedBox(
        //                                     height: 2 * PdfPageFormat.mm),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                       ]),
        //                 ],
        //               )),
        //       pw.SizedBox(height: 3 * PdfPageFormat.mm),
        //       pw.Align(
        //         alignment: pw.Alignment.bottomRight,
        //         child: pw.Text(
        //           'หน้า ${context.pageNumber} / ${context.pagesCount} ',
        //           textAlign: pw.TextAlign.left,
        //           style: pw.TextStyle(
        //             fontSize: 10,
        //             font: ttf,
        //             color: Colors_pd,
        //             // fontWeight: pw.FontWeight.bold
        //           ),
        //         ),
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
              doc: pdf, title: 'ใบเสร็จรับเงิน/ใบกำกับภาษี'),
        ));
  }
}
