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

class Pdfgen_his_statusbill_TP10 {
//////////---------------------------------------------------->(ใบเสร็จรับเงิน/ใบกำกับภาษี)   ใช้  //

  static void exportPDF_statusbill_TP10(
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
    final thaiDate2 = DateTime.parse(dayfinpay);
    final formatter2 = DateFormat('d MMMM', 'th_TH');
    final formattedDate2 = formatter.format(thaiDate2);
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

    pw.Widget Header(int serpang) {
      return pw.Column(children: [
        pw.Row(
          // mainAxisSize: pw.MainAxisSize.min,
          // crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              height: 30,
              width: 40,
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: resizedLogo != null
                  ? pw.Image(
                      pw.MemoryImage(resizedLogo),
                      height: 30,
                      width: 40,
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
            //         height: 30,
            //         width: 40,
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
            //     : pw.Container(
            //         height: 30,
            //         width: 40,
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
            //           height: 30,
            //           width: 40,
            //         ),
            //       ),
            pw.Spacer(),
            (hasNonCashTransaction1)
                ? pw.Text(
                    (numdoctax.toString() == '')
                        ? 'บิลเงินสด(Cash Sell)'
                        : 'บิลเงินสด/ใบกำกับภาษี(Cash Sell/Tax invoice)',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size + 1,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  )
                : pw.Text(
                    (numdoctax.toString() == '')
                        ? 'ใบเสร็จรับเงิน(Receipt)'
                        : 'ใบเสร็จรับเงิน/ใบกำกับภาษี(Receipt/Tax invoice)',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size + 1,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
          ],
        ),
        pw.Row(
          children: [
            pw.Container(
              width: 200,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // (netImage.isEmpty)
                  //     ? pw.Container(
                  //         height: 30,
                  //         width: 40,
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
                  //     : pw.Container(
                  //         height: 30,
                  //         width: 40,
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
                  //           height: 30,
                  //           width: 40,
                  //         ),
                  //       ),
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
                  // pw.Text(
                  //   'ลูกค้า(Customer)',
                  //   textAlign: pw.TextAlign.right,
                  //   maxLines: 1,
                  //   style: pw.TextStyle(
                  //     fontSize: font_Size,
                  //     fontWeight: pw.FontWeight.bold,
                  //     font: ttf,
                  //     color: Colors_pd,
                  //   ),
                  // ),
                  pw.Text(
                    'ลูกค้า(Customer) : ${(sname.toString() == '' || sname == null || sname.toString() == 'null') ? '-' : sname} (${(cname.toString() == '' || cname == null || cname.toString() == 'null') ? '-' : cname})',
                    // (sname.toString() == null ||
                    //         sname.toString() == '' ||
                    //         sname.toString() == 'null')
                    //     ? ' -'
                    //     : '$sname',
                    textAlign: pw.TextAlign.right, maxLines: 1,
                    // textAlign: pw.TextAlign.justify,
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
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
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
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'รูปแบบชำระ : ',
                        textAlign: pw.TextAlign.justify,
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Expanded(
                          flex: 4,
                          child: pw.Row(
                            children: [
                              for (var i = 0;
                                  i < finnancetransModels.length;
                                  i++)
                                if (finnancetransModels[i].dtype.toString() !=
                                    'FTA')
                                  (finnancetransModels[i].dtype.toString() ==
                                          'KP')
                                      ? pw.Padding(
                                          padding: pw.EdgeInsets.fromLTRB(
                                              2, 0, 2, 0),
                                          child: pw.Text(
                                            (finnancetransModels[i]
                                                        .type
                                                        .toString() ==
                                                    'CASH')
                                                ? '${i + 1}.เงินสด : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท'
                                                : '${i + 1}.เงินโอน : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท',
                                            textAlign: pw.TextAlign.justify,
                                            style: pw.TextStyle(
                                              fontSize: font_Size,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ))
                                      : pw.Padding(
                                          padding: pw.EdgeInsets.fromLTRB(
                                              2, 0, 2, 0),
                                          child: pw.Text(
                                            '${i + 1}.${finnancetransModels[i].remark} : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท',
                                            textAlign: pw.TextAlign.justify,
                                            style: pw.TextStyle(
                                              fontSize: font_Size,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                        ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
            pw.Spacer(),
            pw.Container(
              width: 180,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  // pw.Text(
                  //   (numdoctax.toString() == '')
                  //       ? 'ใบเสร็จรับเงิน(Receipt)'
                  //       : 'ใบเสร็จรับเงิน/ใบกำกับภาษี(Receipt/Tax invoice)',
                  //   textAlign: pw.TextAlign.right,
                  //   maxLines: 1,
                  //   style: pw.TextStyle(
                  //     fontSize: font_Size,
                  //     fontWeight: pw.FontWeight.bold,
                  //     font: ttf,
                  //     color: Colors_pd,
                  //   ),
                  // ),
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
                    (numdoctax.toString() == '')
                        ? 'เลขที่(ID) : $numinvoice '
                        : 'เลขที่(ID) : $numdoctax ',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'วันที่ทำรายการ : $formattedDate ${newYear}',
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
                    'โซน(Zone) : $Zone_s / ห้อง( Room) : $Ln_s',
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
                    (dayfinpay.toString() == '' ||
                            dayfinpay.toString() == 'null' ||
                            dayfinpay == null)
                        ? 'วันที่ชำระ : -'
                        : 'วันที่ชำระ : $formattedDate2 ${DateTime.parse('${dayfinpay}').year + 543}',
                    // (dayfinpay.toString() == '' ||
                    //         dayfinpay.toString() == 'null' ||
                    //         dayfinpay == null)
                    //     ? 'วันที่ชำระ : '
                    //     : 'วันที่ชำระ : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${dayfinpay}'))} ',
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'พนักงาน(Staff) : $fname',
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
                    (ref_invoice.length == 0)
                        ? ''
                        : 'อ้างอิงเลขที่ :  ${ref_invoice.toSet().map((model) => model).join(', ')}',
                    textAlign: pw.TextAlign.right,
                    maxLines: 3,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),

                  (type_bills.toString().trim() == '' || type_bills == null)
                      ? pw.Text('')
                      : pw.Container(
                          padding: pw.EdgeInsets.fromLTRB(1, 0.3, 1, 0.3),
                          decoration: const pw.BoxDecoration(
                            // color: PdfColors.green100,
                            border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.grey300),
                              left: pw.BorderSide(color: PdfColors.grey300),
                              top: pw.BorderSide(color: PdfColors.grey300),
                              bottom: pw.BorderSide(color: PdfColors.grey300),
                            ),
                          ),
                          child: pw.Text(
                            'ประเภท : ล็อคเสียบ',
                            textAlign: pw.TextAlign.justify,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ),
                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
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
      return (!hasNonCashTransaction)
          ? pw.Expanded(
              child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(0),
                  child: pw.Text(
                    '1. โปรดชำระเงินภายในวันที่ 25 ถึง วันที่ 5 ของเดือนถัดไป หากเกิดการชำระเงินล่าช้า ทางโครงการจะขอเก็บค่าปรับเป็นดอกเบี้ย ร้อยละ 15 ต่อปี ของยอดนั้นๆ',
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
                    '2. ขอความกรุณาโอนชำระค่าเช่าให้ตรงกับยอดในใบแจ้งหนี้ เพื่อความถูกต้องในทางบัญชี',
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
                    '1. โปรดชำระเงินภายในวันที่ 25 ถึง วันที่ 5 ของเดือนถัดไป หากเกิดการชำระเงินล่าช้า ทางโครงการจะขอเก็บค่าปรับเป็นดอกเบี้ย ร้อยละ 15 ต่อปี ของยอดนั้นๆ',
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
                    (hasNonCashTransaction)
                        ? '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => model.bank).join(', ')} เลขที่บัญชี ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => model.bno).join(', ')} [ ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => (model.ptname.toString() == 'Online Payment' ? 'PromptPay QR' : model.ptname == 'เงินโอน' ? 'เลขบัญชี' : model.ptname == 'Beam Checkout' ? 'Beam Checkout' : 'Online Standard QR')).join(', ')} ]'
                        : '',
                    // (numdoctax.toString() == '')
                    //     ? '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${finnancetransModels.where((model) => model.ptser == '6' && model.dtype != 'MM').map((model) => model.bank).join(', ')} เลขที่บัญชี ${finnancetransModels.where((model) => model.ptser == '6' && model.dtype != 'MM').map((model) => model.bno).join(', ')} [ Ref1 : $numinvoice , Ref2 : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${dayfinpay}'))} ] (Standard QR)'
                    //     : '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${finnancetransModels.where((model) => model.ptser == '6' && model.dtype != 'MM').map((model) => model.bank).join(', ')} เลขที่บัญชี ${finnancetransModels.where((model) => model.ptser == '6' && model.dtype != 'MM').map((model) => model.bno).join(', ')} [ Ref1 : $numdoctax , Ref2 : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${dayfinpay}'))} ] (Standard QR)',
                    //  '2. การชำระเงิน ท่านสามารถโอนเข้าเลขที่บัญชี ${finnancetransModels.where((model) => model.ptser == '6' && model.dtype != 'MM').map((model) => model.bno).join(', ')}',
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
                    '3. ขอความกรุณาโอนชำระค่าเช่าให้ตรงกับยอดในใบแจ้งหนี้ เพื่อความถูกต้องในทางบัญชี',
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
                      'หมายเหตุ(Note) : $com_ment',
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
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'ลงชื่อ..................................................................(ผู้จัดการ)',
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
                        pw.Text(
                          'วันที่/Date........................................................',
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
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'ลงชื่อ..................................................................(ผู้รับเงิน)',
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
                        pw.Text(
                          'วันที่/Date........................................................',
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
                // pw.Expanded(child: footer_data_sub(0)),
                // if (hasNonCashTransaction2)
                //   pw.Container(
                //       child: pw.Column(
                //     children: [
                //       pw.BarcodeWidget(
                //         data:
                //             '|${finnancetransModels.where((model) => model.ptser == '6' && model.dtype == 'KP').map((model) => model.bno).join(',')}\r${numinvoice.replaceAll('-', '')}\r${DateFormat('ddMM').format(DateTime.parse(dayfinpay))}${DateTime.parse('${dayfinpay}').year + 543}\r${newTotal_QR}',
                //         barcode: pw.Barcode.qrCode(),
                //         height: 35,
                //         width: 40,
                //       ),
                //       pw.Padding(
                //         padding: pw.EdgeInsets.all(0),
                //         child: pw.Text(
                //           'สแกน (Scan me)',
                //           textAlign: pw.TextAlign.left,
                //           maxLines: 1,
                //           style: pw.TextStyle(
                //               font: ttf,
                //               fontSize: font_Size,
                //               color: PdfColors.grey800),
                //         ),
                //       ),
                //     ],
                //   )),
                // if (hasNonCashTransaction4)
                //   pw.Container(
                //       child: pw.Column(
                //     children: [
                //       pw.BarcodeWidget(
                //         data: generateQRCode(
                //             promptPayID:
                //                 "${finnancetransModels.where((model) => model.ptser == '5' && model.dtype == 'KP').map((model) => model.bno).join(',')}",
                //             amount: double.parse((Total == null || Total == '')
                //                 ? '0'
                //                 : '${finnancetransModels.where((model) => model.ptser == '5' && model.dtype == 'KP').map((model) => model.total).join(',')}')),
                //         barcode: pw.Barcode.qrCode(),
                //         height: 35,
                //         width: 40,
                //       ),
                //       pw.Padding(
                //         padding: pw.EdgeInsets.all(0),
                //         child: pw.Text(
                //           'สแกน (Scan me)',
                //           textAlign: pw.TextAlign.left,
                //           maxLines: 1,
                //           style: pw.TextStyle(
                //               font: ttf,
                //               fontSize: font_Size,
                //               color: PdfColors.grey800),
                //         ),
                //       ),
                //     ],
                //   )),
                // if (hasNonCashTransaction3)
                //   for (var i = 0; i < finnancetransModels.length; i++)
                //     if (finnancetransModels[i].ptser.toString() == '2' &&
                //         finnancetransModels[i].dtype.toString() == 'KP')
                //       pw.Container(
                //           child: pw.Column(
                //         children: [
                //           pw.Image(
                //             (netImage_QR[i]),
                //             height: 35,
                //             width: 40,
                //           ),
                //           pw.Padding(
                //             padding: pw.EdgeInsets.all(0),
                //             child: pw.Text(
                //               'สแกน (Scan me)',
                //               textAlign: pw.TextAlign.left,
                //               maxLines: 1,
                //               style: pw.TextStyle(
                //                   font: ttf,
                //                   fontSize: font_Size,
                //                   color: PdfColors.grey800),
                //             ),
                //           ),
                //         ],
                //       )),
              ]),
              // pw.Row(
              //   children:
              // (!hasNonCashTransaction)
              //       ? [pw.Expanded(child: footer_data_sub(0))]
              //       : (hasNonCashTransaction2)
              //           ? [
              //               footer_data_sub(0),
              //               pw.Column(children: [
              //                 pw.Container(
              //                   child: pw.BarcodeWidget(
              //                     data:
              //                         '|${finnancetransModels.where((model) => model.ptser == '6' && model.dtype != 'MM').map((model) => model.bno).join(', ')}\r$numinvoice\r${DateFormat('dd-MM-yyyy').format(DateTime.parse('${dayfinpay}'))}\r${newTotal_QR}\r',
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
              //               for (var i = 0; i < finnancetransModels.length; i++)
              //                 if (finnancetransModels[i].ptser.toString() !=
              //                         '1' &&
              //                     finnancetransModels[i].dtype.toString() !=
              //                         'MM')
              //                   pw.Column(children: [
              //                     pw.Container(
              //                       child: (!hasNonCashTransaction3)
              //                           ? pw.BarcodeWidget(
              //                               data: generateQRCode(
              //                                   promptPayID:
              //                                       "${finnancetransModels[i].bno}",
              //                                   amount: double.parse(
              //                                       (finnancetransModels[i]
              //                                                       .total ==
              //                                                   null ||
              //                                               finnancetransModels[
              //                                                           i]
              //                                                       .total
              //                                                       .toString() ==
              //                                                   '')
              //                                           ? '0'
              //                                           : '${finnancetransModels[i].total}')),
              //                               barcode: pw.Barcode.qrCode(),
              //                               height: 35,
              //                               width: 40,
              //                             )
              //                           : pw.Image(
              //                               (netImage_QR[i]),
              //                               height: 35,
              //                               width: 40,
              //                             ),
              //                     ),
              //                     pw.Padding(
              //                       padding: pw.EdgeInsets.all(0),
              //                       child: pw.Text(
              //                         'สแกน (Scan me)',
              //                         textAlign: pw.TextAlign.left,
              //                         maxLines: 1,
              //                         style: pw.TextStyle(
              //                             font: ttf,
              //                             fontSize: font_Size,
              //                             color: PdfColors.grey800),
              //                       ),
              //                     ),
              //                   ]),
              //             ],
              // ),

              if (serpang == 1 && tableData00.length < 7)
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
              if (tableData00.length > 6)
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
                          width: 30,
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
                        // pw.Expanded(
                        //   flex: 2,
                        //   child: pw.Container(
                        //     decoration: const pw.BoxDecoration(
                        //       // color: PdfColors.green100,
                        //       border: pw.Border(
                        //           // left: pw.BorderSide(color: PdfColors.grey800),
                        //           // top: pw.BorderSide(color: PdfColors.grey800),
                        //           // bottom: pw.BorderSide(color: PdfColors.grey800),
                        //           ),
                        //     ),
                        //     // height: 25,
                        //     child: pw.Text(
                        //       'กำหนดชำระ(Due date)',
                        //       maxLines: 1,
                        //       textAlign: pw.TextAlign.left,
                        //       style: pw.TextStyle(
                        //           fontSize: font_Size,
                        //           fontWeight: pw.FontWeight.bold,
                        //           font: ttf,
                        //           color: PdfColors.black),
                        //     ),
                        //   ),
                        // ),
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
                              'จำนวน (Quantity)',
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
                          flex: 1,
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
                              'หน่วยละ (Unit)',
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
                          flex: 1,
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
                          flex: 1,
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
                          pw.Container(
                            width: 30,
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
                          // pw.Expanded(
                          //   flex: 2,
                          //   child: pw.Container(
                          //     // height: 25,
                          //     decoration: const pw.BoxDecoration(
                          //       color: PdfColors.white,
                          //       border: const pw.Border(
                          //           // left: pw.BorderSide(color: PdfColors.grey600),
                          //           // bottom: pw.BorderSide(color: PdfColors.grey600),
                          //           ),
                          //     ),
                          //     // padding: const pw.EdgeInsets.all(1.0),
                          //     child: pw.Align(
                          //       alignment: pw.Alignment.centerLeft,
                          //       child: pw.Text(
                          //         (tableData00[index][1] == null)
                          //             ? '${tableData00[index][1]}'
                          //             : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${tableData00[index][1]}'))}',
                          //         // '${tableData003[index][1]}',
                          //         maxLines: 1,
                          //         textAlign: pw.TextAlign.left,
                          //         style: pw.TextStyle(
                          //             fontSize: font_Size,
                          //             font: ttf,
                          //             color: PdfColors.grey800),
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
                                  (tableData00[index][0].toString() == '6')
                                      ? '${tableData00[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData00[index][1]))}/${DateTime.parse('${tableData00[index][1]}').year + 543} [ หน่วยที่ใช้ไป ${tableData00[index][8]}-${tableData00[index][9]} ]'
                                      : '${tableData00[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData00[index][1]))}/${DateTime.parse('${tableData00[index][1]}').year + 543}',
                                  // '${tableData00[index][2]}',
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
                                  (tableData00[index][10].toString() == '0.00')
                                      ? '1.00'
                                      : '${tableData00[index][10]}',
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
                            flex: 1,
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
                                  (tableData00[index][14].toString() != '0' &&
                                          tableData00[index][14] != null)
                                      ? 'อัตราพิเศษ'
                                      : (tableData00[index][7].toString() ==
                                              '0.00')
                                          ? '${tableData00[index][5]}'
                                          : '${tableData00[index][7]}',
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
                            flex: 1,
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
                                  '${tableData00[index][12]}',
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
                            flex: 1,
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
                                  '${tableData00[index][13]}',
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
                          pw.Container(
                            width: 30,
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
                                '${tableData00.length + 1}',
                                maxLines: 1,
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          // pw.Expanded(
                          //   flex: 2,
                          //   child: pw.Container(
                          //     // height: 25,
                          //     decoration: const pw.BoxDecoration(
                          //       color: PdfColors.white,
                          //       border: const pw.Border(
                          //           // left: pw.BorderSide(color: PdfColors.grey600),
                          //           // bottom: pw.BorderSide(color: PdfColors.grey600),
                          //           ),
                          //     ),
                          //     // padding: const pw.EdgeInsets.all(1.0),
                          //     child: pw.Align(
                          //       alignment: pw.Alignment.centerLeft,
                          //       child: pw.Text(
                          //         (tableData01[index][1] == null)
                          //             ? '${tableData01[index][1]}'
                          //             : '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${tableData01[index][1]}'))}',
                          //         // '${tableData01[index][1]}',
                          //         maxLines: 1,
                          //         textAlign: pw.TextAlign.left,
                          //         style: pw.TextStyle(
                          //             fontSize: font_Size,
                          //             font: ttf,
                          //             color: PdfColors.grey800),
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
                                  '${tableData01[index][2]}',
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
                                  (tableData01[index][10].toString() == '0.00')
                                      ? '1.00'
                                      : '${tableData01[index][10]}',
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
                            flex: 1,
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
                                  (tableData01[index][7].toString() == '0.00')
                                      ? '${tableData01[index][5]}'
                                      : '${tableData01[index][7]}',
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
                            flex: 1,
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
                            flex: 1,
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
                                  '${tableData01[index][6]}',
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
                    padding: const pw.EdgeInsets.fromLTRB(0, 1.5, 0, 0),
                    alignment: pw.Alignment.centerRight,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            // '${nFormat.format((double.parse(Total.toString()) + double.parse(sum_fee.toString())) - (double.parse(dis_sum_Matjum.toString()) + double.parse(dis_sum_Pakan.toString())))}',
                            '(~${convertToThaiBaht((double.parse(Total.toString()) + double.parse(sum_fee.toString())) - (double.parse(dis_sum_Matjum.toString()) + double.parse(dis_sum_Pakan.toString())))}~)',
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
                                        .format(double.parse(
                                            dis_sum_Matjum.toString()))
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
                                        .format(double.parse(
                                            dis_sum_Pakan.toString()))
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
                                pw.Container(
                                  decoration: const pw.BoxDecoration(
                                    // color: PdfColors.green100,
                                    border: pw.Border(
                                      top: pw.BorderSide(
                                          color: PdfColors.grey600),
                                    ),
                                  ),
                                  child: pw.Row(
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
            if (tableData00.length < 6) footer_data(serpang)
          ],
        ),
      );
    }

    if (tableData00.length < 6)
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
        ),
      );
    if (tableData00.length > 5)
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
            footer: (tableData00.length < 5)
                ? null
                : (context) {
                    return footer_data(1);
                  }),
      );
    if (tableData00.length > 5)
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
            footer: (tableData00.length < 5)
                ? null
                : (context) {
                    return footer_data(2);
                  }),
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
