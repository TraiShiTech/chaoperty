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
import '../../Style/loadAndCacheImage.dart';

class Pdfgen_BillingNoteInvlice_TP8_Choice {
  //////////---------------------------------------------------->(ใบวางบิล แจ้งหนี้)  ใช้  ++
  static void exportPDF_BillingNoteInvlice_TP8_Choice(
      foder,
      Cust_no,
      cid_,
      Zone_s,
      Ln_s,
      fname,

      ///(ser_BillingNote 1 = วางบิล  /// 2 = ประวัติวางบิล )

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
      TitleType_Default_Receipt_Name,
      payment_Ptser1,
      bank1,
      ptser1,
      ptname1,
      img1,
      Preview_ser,
      End_Bill_Paydate,
      fonts_pdf) async {
    int YearQRthai = await int.parse(DateFormat('yyyy')
            .format(DateTime.parse(End_Bill_Paydate))
            .toString()) +
        543;
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("${fonts_pdf}");
    var Colors_pd = PdfColors.black;
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    var nFormat3 = NumberFormat("###-##-##0", "en_US");
    // double percen =
    //     (double.parse('$DisC') / double.parse(' $Sum_SubTotal')) * 100.00;
    final ttf = pw.Font.ttf(font);
    double font_Size = 10.0;
    double widths = await MediaQuery.of(context).size.width;
    //////---------------------------------------------> (วางบิล)
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    //////--------------------------------------------->(ประวัติวางบิล)

    // var formatter = new DateFormat.MMMMd('th_TH');
    // String thaiDate = formatter.format(date);
    final thaiDate2 = DateTime.parse(date_Transaction);
    final formatter2 = DateFormat('d MMMM', 'th_TH');
    final formattedDate2 = formatter.format(thaiDate2);
    //////--------------->พ.ศ.
    DateTime dateTime2 = DateTime.parse(date_Transaction);
    int newYear2 = dateTime2.year + 543;
    //////--------------------------------------------->
    String total_QR = '${nFormat.format(double.parse('${Total}'))}';
    String newTotal_QR = total_QR.replaceAll(RegExp(r'[^0-9]'), '');
    List netImage = [];
    List netImage_QR = [];
    Uint8List? resizedLogo = await getResizedLogo();
    ////////////////------------------------------->
    final ByteData image = await rootBundle.load('images/image7-11.png');
    final ByteData BG_PDF = await rootBundle.load('images/Choice_BG_PDF.png');
    final ByteData LG_PDF = await rootBundle.load('images/choice_logo2.png');
    Uint8List imageData = (image).buffer.asUint8List();
    Uint8List imageBG = (BG_PDF).buffer.asUint8List();
    Uint8List imageLG = (LG_PDF).buffer.asUint8List();
    var docid = '$cFinn ';
    var licence_name1 = 'สิริกร พรหมปัญญา';
    var licence_name2 = 'สิริกร พรหมปัญญา';
    var refid = 'LLJZX20241';

    // final imageBytes_manager = await loadAndCacheImage(
    //     '${MyConstant().domain}/gen_licence_img.php?isAdd=true&ren=50&ref_id=$refid&name_id=$licence_name1&doc_id=$docid&extension=.png');
    // final imageBytes_Payee = await loadAndCacheImage(
    //     '${MyConstant().domain}/gen_licence_img.php?isAdd=true&ren=50&ref_id=$refid&name_id=$licence_name2&doc_id=$docid&extension=.png');
////////////////------------------------------->
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
    pw.Widget Header(context) {
      return pw.Column(children: [
        pw.Container(
          width: PdfPageFormat.a4.width + 100,
          color: PdfColors.green900,
          height: 10,
        ),
        pw.SizedBox(height: 1 * PdfPageFormat.mm),

        pw.Container(
            padding: pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: pw.Column(children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  imageLG != null
                      ? pw.SizedBox(
                          child: pw.Center(
                          child: pw.Image(pw.MemoryImage(imageLG),
                              height: 70, width: 75, fit: pw.BoxFit.fill),
                        ))
                      : pw.Container(
                          height: 70,
                          width: 75,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white,
                            border: pw.Border.all(color: PdfColors.grey300),
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
                          ),
                        ),
                  // pw.Container(
                  //   height: 60,
                  //   width: 60,
                  //   decoration: pw.BoxDecoration(
                  //     color: PdfColors.grey200,
                  //     border: pw.Border.all(color: PdfColors.grey300),
                  //   ),
                  //   child: resizedLogo != null
                  //       ? pw.Image(
                  //           pw.MemoryImage(resizedLogo),
                  //           height: 60,
                  //           width: 60,
                  //         )
                  //       : pw.Center(
                  //           child: pw.Text(
                  //             '$bill_name ',
                  //             maxLines: 1,
                  //             style: pw.TextStyle(
                  //               fontSize: 10,
                  //               font: ttf,
                  //               color: Colors_pd,
                  //             ),
                  //           ),
                  //         ),
                  // ),
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
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
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
                      ),
                      if (TitleType_Default_Receipt_Name != null &&
                          TitleType_Default_Receipt_Name.toString().trim() !=
                              '')
                        pw.Container(
                          width: 80,
                          decoration: pw.BoxDecoration(
                            // color: PdfColors.grey400,
                            borderRadius: pw.BorderRadius.only(
                                topLeft: pw.Radius.circular(10),
                                topRight: pw.Radius.circular(10),
                                bottomLeft: pw.Radius.circular(10),
                                bottomRight: pw.Radius.circular(10)),
                            border: pw.Border.all(
                                color: PdfColors.grey400, width: 1),
                          ),
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Center(
                            child: pw.Text(
                              '$TitleType_Default_Receipt_Name',
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.grey400,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                  // pw.Align(
                  //   alignment: pw.Alignment.topRight,
                  //   child: pw.Text(
                  //     'หน้าที่ ${context.pageNumber} / ${context.pagesCount} ',
                  //     // textAlign: pw.TextAlign.left,
                  //     style: pw.TextStyle(
                  //       fontSize: 10,
                  //       font: ttf,
                  //       color: Colors_pd,
                  //       // fontWeight: pw.FontWeight.bold
                  //     ),
                  //   ),
                  // )
                  // pw.Column(
                  //   crossAxisAlignment: pw.CrossAxisAlignment.end,
                  //   mainAxisAlignment: pw.MainAxisAlignment.end,
                  //   children: [
                  //     pw.SizedBox(height: 10),
                  //     if (cFinn != null)
                  //       pw.Container(
                  //         child: pw.BarcodeWidget(
                  //             data: (cFinn.toString() == '' ||
                  //                     cFinn == null ||
                  //                     cFinn.toString() == 'null')
                  //                 ? '-'
                  //                 : '$cFinn ',
                  //             barcode: pw.Barcode.code128(),
                  //             width: 100,
                  //             height: 35),
                  //       ),
                  //   ],
                  // )
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm + 3),
            ])),

        // pw.SizedBox(height: 1 * PdfPageFormat.mm),
        // pw.Divider(),
        // pw.SizedBox(height: 1 * PdfPageFormat.mm),
      ]);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 5.00,
          marginLeft: 0.00,
          marginRight: 0.00,
          marginTop: 0.00,
        ),
        // pageFormat: PdfPageFormat.a4.copyWith(
        //   marginBottom: 8.00,
        //   marginLeft: 8.00,
        //   marginRight: 8.00,
        //   marginTop: 8.00,
        // ),
        header: (context) {
          return Header(context);
        },
        build: (context) {
          return [
            pw.Container(
                decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                    image: pw.MemoryImage(
                      imageBG,
                    ),
                    fit: pw.BoxFit.fill,
                  ),
                ),
                padding: pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: pw.Column(children: [
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
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  left: pw.BorderSide(color: PdfColors.grey600),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Container(
                                        padding:
                                            pw.EdgeInsets.fromLTRB(2, 4, 2, 2),
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              'นามลูกค้า /Name : ${(sname_.toString() == '' || sname_ == null || sname_.toString() == 'null') ? '-' : sname_} (${(cname_.toString() == '' || cname_ == null || cname_.toString() == 'null') ? '-' : cname_})',
                                              // (sname_.toString() == null ||
                                              //         sname_.toString() == '' ||
                                              //         sname_.toString() == 'null')
                                              //     ? 'นามลูกค้า /Name : -'
                                              //     : 'นามลูกค้า /Name : $sname_',
                                              textAlign: pw.TextAlign.left,
                                              style: pw.TextStyle(
                                                fontSize: font_Size,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                                color: Colors_pd,
                                              ),
                                            ),
                                            pw.Text(
                                              (addr_.toString() == null ||
                                                      addr_.toString() == '' ||
                                                      addr_.toString() ==
                                                          'null')
                                                  ? 'ที่อยู่ /Address : -'
                                                  : 'ที่อยู่ /Address  : $addr_',
                                              textAlign: pw.TextAlign.left,
                                              style: pw.TextStyle(
                                                fontSize: font_Size,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                                color: Colors_pd,
                                              ),
                                            ),
                                            pw.Text(
                                              (tax_ == null ||
                                                      tax_.toString() == '' ||
                                                      tax_.toString() == 'null')
                                                  ? 'เลขที่ผู้เสียภาษี /Tax : 0'
                                                  : 'เลขที่ผู้เสียภาษี /Tax : $tax_',
                                              textAlign: pw.TextAlign.left,
                                              style: pw.TextStyle(
                                                fontSize: font_Size,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                                color: Colors_pd,
                                              ),
                                            ),
                                            pw.Text(
                                              'เลขสัญญา /No. : $cid_ ',
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
                                            pw.CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                          pw.Expanded(
                                            flex: 1,
                                            child: pw.Column(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.center,
                                                crossAxisAlignment: pw
                                                    .CrossAxisAlignment.center,
                                                children: [
                                                  pw.Text(
                                                    (TitleType_Default_Receipt_Name !=
                                                            null)
                                                        ? 'ใบแจ้งหนี้ '
                                                        : 'ใบแจ้งหนี้',
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
                                                  pw.Text(
                                                    (TitleType_Default_Receipt_Name !=
                                                            null)
                                                        ? (TitleType_Default_Receipt_Name
                                                                    .toString() ==
                                                                'ต้นฉบับ')
                                                            ? 'Invoice Original'
                                                            : 'Invoice Copy'
                                                        : 'Invoice',
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
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Text(
                                                        'วันที่ทำรายการ',
                                                        textAlign:
                                                            pw.TextAlign.center,
                                                        style: pw.TextStyle(
                                                          fontSize: font_Size,
                                                          font: ttf,
                                                          fontWeight: pw
                                                              .FontWeight.bold,
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
                                                          fontWeight: pw
                                                              .FontWeight.bold,
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
                                                          fontWeight: pw
                                                              .FontWeight.bold,
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
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Text(
                                                        'เลขที่ใบกำกับ',
                                                        textAlign:
                                                            pw.TextAlign.center,
                                                        style: pw.TextStyle(
                                                          fontSize: font_Size,
                                                          font: ttf,
                                                          fontWeight: pw
                                                              .FontWeight.bold,
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
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                          color: Colors_pd,
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        (cFinn.toString() ==
                                                                    '' ||
                                                                cFinn == null ||
                                                                cFinn.toString() ==
                                                                    'null')
                                                            ? '-'
                                                            : '$cFinn ',
                                                        textAlign:
                                                            pw.TextAlign.center,
                                                        style: pw.TextStyle(
                                                          fontSize: font_Size,
                                                          font: ttf,
                                                          fontWeight: pw
                                                              .FontWeight.bold,
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
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
                                ),
                              ),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
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
                                              'พนักงานขาย /Sales man No',
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
                        //                       '5 วัน',
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
                        pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              height: 35,
                              decoration: const pw.BoxDecoration(
                                // color: PdfColors.green100,
                                border: pw.Border(
                                  right:
                                      pw.BorderSide(color: PdfColors.grey600),
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey600),
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
                                              'ครบกำหนด /Due Date',
                                              textAlign: pw.TextAlign.center,
                                              style: pw.TextStyle(
                                                fontSize: font_Size,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                                color: Colors_pd,
                                              ),
                                            ),
                                            pw.Text(
                                              (End_Bill_Paydate == null ||
                                                      End_Bill_Paydate
                                                              .toString() ==
                                                          '')
                                                  ? '${End_Bill_Paydate}'
                                                  : '${DateFormat('dd/MM').format(DateTime.parse(End_Bill_Paydate!))}/${DateTime.parse('${End_Bill_Paydate}').year + 543}',
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
                                  // pw.Expanded(
                                  //   flex: 1,
                                  //   child: pw.Container(
                                  //       height: 35,
                                  //       padding: const pw.EdgeInsets.all(2.0),
                                  //       child: pw.Column(
                                  //         mainAxisAlignment:
                                  //             pw.MainAxisAlignment.center,
                                  //         crossAxisAlignment:
                                  //             pw.CrossAxisAlignment.center,
                                  //         children: [
                                  //           pw.Text(
                                  //             'รูปแบบชำระ/Payment Type',
                                  //             textAlign: pw.TextAlign.center,
                                  //             style: pw.TextStyle(
                                  //               fontSize: font_Size,
                                  //               font: ttf,
                                  //               fontWeight: pw.FontWeight.bold,
                                  //               color: Colors_pd,
                                  //             ),
                                  //           ),
                                  //           pw.Text(
                                  //             (payment_Ptser1 == null)
                                  //                 ? '-'
                                  //                 : (payment_Ptser1 == '1')
                                  //                     ? 'เงินสด'
                                  //                     : (payment_Ptser1 == '2' ||
                                  //                             payment_Ptser1 == '5' ||
                                  //                             payment_Ptser1 == '6')
                                  //                         ? 'เงินโอน'
                                  //                         : 'อื่นๆ',
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
                          flex: 1,
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
                          border: const pw.TableBorder(
                              left: pw.BorderSide(
                                  color: PdfColors.grey800, width: 1),
                              right: pw.BorderSide(
                                  color: PdfColors.grey800, width: 1),
                              verticalInside: pw.BorderSide(
                                  width: 1,
                                  color: PdfColors.grey800,
                                  style: pw.BorderStyle.solid)),
                          children: [
                        for (int index = 0;
                            index < tableData003.length;
                            index++)
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
                                    '${tableData003[index][11]}',
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
                                      (tableData003[index][0].toString() == '6')
                                          ? '${tableData003[index][2]}'
                                          : '${tableData003[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData003[index][1]))}/${DateTime.parse('${tableData003[index][1]}').year + 543}',
                                      // (tableData003[index][0].toString() == '6')
                                      //     ? '${tableData003[index][2]}[ หน่วยที่ใช้ไป ${tableData003[index][8]}-${tableData003[index][9]} ]'
                                      //     : '${tableData003[index][2]} ${DateFormat('dd/MM').format(DateTime.parse(tableData003[index][1]))}/${DateTime.parse('${tableData003[index][1]}').year + 543}',
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
                                flex: 2,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(2.0),
                                  child: pw.Align(
                                    alignment: pw.Alignment.topRight,
                                    child: pw.Text(
                                      '${tableData003[index][12]}',
                                      // (tableData003[index][0].toString() == '6')
                                      //     ? '${tableData003[index][10]}'
                                      //     : (tableData003[index][10].toString() ==
                                      //             '0.00')
                                      //         ? '1.00'
                                      //         : '${tableData003[index][10]}',
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
                                      (tableData003[index][14].toString() !=
                                                  '0' &&
                                              tableData003[index][14] != null)
                                          ? 'อัตราพิเศษ'
                                          : '${tableData003[index][13]}',
                                      // (tableData003[index][7].toString() == '0.00')
                                      //     ? '${tableData003[index][5]}'
                                      //     : '${tableData003[index][7]}',
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
                                flex: 1,
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
                      border: pw.Border(
                        top: pw.BorderSide(color: PdfColors.grey600),
                        // bottom: pw.BorderSide(color: PdfColors.grey600),
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
                                          left: pw.BorderSide(
                                              color: PdfColors.grey600),
                                          top: pw.BorderSide(
                                              color: PdfColors.grey600),
                                          right: pw.BorderSide(
                                              color: PdfColors.grey600),
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey600),
                                        ),
                                      ),
                                      padding: const pw.EdgeInsets.all(2.0),
                                      child: pw.Text(
                                        '${nFormat.format(double.parse(SubTotal.toString()))}',
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
                                          left: pw.BorderSide(
                                              color: PdfColors.grey600),
                                          top: pw.BorderSide(
                                              color: PdfColors.grey600),
                                          right: pw.BorderSide(
                                              color: PdfColors.grey600),
                                          bottom: pw.BorderSide(
                                              color: PdfColors.grey600),
                                        ),
                                      ),
                                      padding: const pw.EdgeInsets.all(2.0),
                                      child: pw.Text(
                                        '${nFormat.format(double.parse(Vat.toString()))}',
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
                                        '${nFormat.format(double.parse(Deduct.toString()))}',
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
                                        '${nFormat.format(double.parse(DisC.toString()))}',
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
                                        '${nFormat.format(double.parse(Total.toString()))}',
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
                ])),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: pw.Stack(children: [
                  pw.Positioned(
                      top: 4,
                      left: 0,
                      child: pw.Container(
                        width: 300,
                        height: 300,
                        decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                            image: pw.MemoryImage(
                              imageBG,
                            ),
                            fit: pw.BoxFit.cover,
                          ),
                          // border:
                          //     pw.Border.all(color: PdfColors.grey, width: 1),
                        ),
                      )),
                  pw.Positioned(
                      bottom: 4,
                      right: 0,
                      child: pw.Container(
                        width: 200,
                        height: 30,
                        decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                            image: pw.MemoryImage(
                              imageBG,
                            ),
                            fit: pw.BoxFit.cover,
                          ),
                          // border:
                          //     pw.Border.all(color: PdfColors.grey, width: 1),
                        ),
                      )),
                  pw.Container(
                      decoration: pw.BoxDecoration(
                        // image: pw.DecorationImage(
                        //   image: pw.MemoryImage(
                        //     imageBG,
                        //   ),
                        //   fit: pw.BoxFit.cover,
                        // ),
                        border: pw.Border.all(color: PdfColors.grey, width: 1),
                      ),
                      padding: pw.EdgeInsets.fromLTRB(2, 4, 2, 4),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 2,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
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
                                      (ptser1.toString() == '2' ||
                                              ptser1.toString() == '5' ||
                                              ptser1.toString() == '6' ||
                                              ptser1.toString() == '7')
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
                                      (ptser1.toString() == '2' ||
                                              ptser1.toString() == '5' ||
                                              ptser1.toString() == '6' ||
                                              ptser1.toString() == '7')
                                          ? '      บัญชี ${bank1} เลขที่ ${selectedValue_bank_bno} [ ${(ptname1 == 'Online Payment') ? 'PromptPay QR' : (ptname1 == 'เงินโอน') ? 'เลขบัญชี' : (ptname1 == 'Beam Checkout') ? 'Beam Checkout' : 'Online Standard QR'} ]'
                                          : '      บัญชี...................................เลขที่...................................',
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
                                            (ptser1.toString() == '1')
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
                                            (ptser1.toString() == '2' ||
                                                    ptser1.toString() == '5' ||
                                                    ptser1.toString() == '6' ||
                                                    ptser1.toString() == '1' ||
                                                    ptser1.toString() == '7')
                                                ? '(   ) 3. อื่นๆ.............................'
                                                : '( / ) 3. อื่นๆ ${ptname1.toString().trim()}',
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
                                    pw.Container(
                                      width: 150,
                                      // decoration: const pw.BoxDecoration(
                                      //   // color: PdfColors.green100,
                                      //   border: pw.Border(
                                      //     bottom: pw.BorderSide(
                                      //         width: 0.5, color: PdfColors.grey600),
                                      //   ),
                                      // ),
                                      padding: const pw.EdgeInsets.fromLTRB(
                                          4, 0, 4, 0),
                                      child: pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.end,
                                        // mainAxisAlignment:
                                        //     pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'ลงชื่อ : ',
                                            textAlign: pw.TextAlign.left,
                                            style: pw.TextStyle(
                                              fontSize: font_Size,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                          pw.Expanded(
                                              flex: 1,
                                              child: pw.Container(
                                                // width: 120,
                                                decoration:
                                                    const pw.BoxDecoration(
                                                  // color: PdfColors.green100,
                                                  border: pw.Border(
                                                    bottom: pw.BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            PdfColors.grey600),
                                                  ),
                                                ),
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        8.0),
                                                height: 30,
                                              )
                                              // (imageBytes_manager.isEmpty)
                                              //     ? pw.Container(
                                              //         // width: 120,
                                              //         decoration:
                                              //             const pw.BoxDecoration(
                                              //           // color: PdfColors.green100,
                                              //           border: pw.Border(
                                              //             bottom: pw.BorderSide(
                                              //                 width: 0.5,
                                              //                 color: PdfColors
                                              //                     .grey600),
                                              //           ),
                                              //         ),
                                              //         padding:
                                              //             const pw.EdgeInsets.all(
                                              //                 8.0),
                                              //         height: 30,
                                              //       )
                                              //     : pw.Container(
                                              //         // width: 120,
                                              //         decoration:
                                              //             const pw.BoxDecoration(
                                              //           // color: PdfColors.green100,
                                              //           border: pw.Border(
                                              //             bottom: pw.BorderSide(
                                              //                 width: 0.5,
                                              //                 color: PdfColors
                                              //                     .grey600),
                                              //           ),
                                              //         ),
                                              //         padding:
                                              //             const pw.EdgeInsets.all(
                                              //                 8.0),
                                              //         child: pw.Center(
                                              //           child: pw.Image(
                                              //             pw.MemoryImage(
                                              //                 imageBytes_manager),
                                              //             height: 30,
                                              //             width: 100,
                                              //           ),
                                              //         ),
                                              //       ),
                                              ),
                                          pw.Text(
                                            ' ผู้จัดการ',
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
                                    ),
                                    pw.SizedBox(
                                      height: 3,
                                    ),
                                    pw.Container(
                                      width: 150,
                                      // decoration: const pw.BoxDecoration(
                                      //   // color: PdfColors.green100,
                                      //   border: pw.Border(
                                      //     bottom: pw.BorderSide(
                                      //         width: 0.5, color: PdfColors.grey600),
                                      //   ),
                                      // ),
                                      padding: const pw.EdgeInsets.fromLTRB(
                                          4, 0, 4, 0),
                                      child: pw.Row(
                                        // mainAxisAlignment:
                                        //     pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'คุณ : ',
                                            textAlign: pw.TextAlign.left,
                                            style: pw.TextStyle(
                                              fontSize: font_Size,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 1,
                                            child: pw.Align(
                                              alignment: pw.Alignment.center,
                                              child: pw.Text(
                                                '(${licence_name1})',
                                                textAlign: pw.TextAlign.left,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    pw.Container(
                                      width: 150,
                                      padding: const pw.EdgeInsets.fromLTRB(
                                          4, 0, 4, 0),
                                      child: pw.Row(
                                        // mainAxisAlignment:
                                        //     pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'วันที่/Date : ',
                                            textAlign: pw.TextAlign.left,
                                            style: pw.TextStyle(
                                              fontSize: font_Size,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 1,
                                            child: pw.Align(
                                              alignment: pw.Alignment.center,
                                              child: pw.Text(
                                                '${DateFormat('dd/MM').format(date)}/${DateTime.parse('${date}').year + 543}',
                                                // '${DateFormat('dd/MM').format(DateTime.parse(date_Transaction!))}/${DateTime.parse('${date_Transaction}').year + 543}',
                                                textAlign: pw.TextAlign.left,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ])),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  // crossAxisAlignment: pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Container(
                                      width: 150,
                                      // decoration: const pw.BoxDecoration(
                                      //   // color: PdfColors.green100,
                                      //   border: pw.Border(
                                      //     bottom: pw.BorderSide(
                                      //         width: 0.5, color: PdfColors.grey600),
                                      //   ),
                                      // ),
                                      padding: const pw.EdgeInsets.fromLTRB(
                                          4, 0, 4, 0),
                                      child: pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.end,
                                        // mainAxisAlignment:
                                        //     pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'ลงชื่อ : ',
                                            textAlign: pw.TextAlign.left,
                                            style: pw.TextStyle(
                                              fontSize: font_Size,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                          pw.Expanded(
                                              flex: 1,
                                              child: pw.Container(
                                                // width: 120,
                                                decoration:
                                                    const pw.BoxDecoration(
                                                  // color: PdfColors.green100,
                                                  border: pw.Border(
                                                    bottom: pw.BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            PdfColors.grey600),
                                                  ),
                                                ),
                                                padding:
                                                    const pw.EdgeInsets.all(
                                                        8.0),
                                                height: 45,
                                              )
                                              // (imageBytes_Payee.isEmpty)
                                              //     ? pw.Container(
                                              //         // width: 120,
                                              //         decoration:
                                              //             const pw.BoxDecoration(
                                              //           // color: PdfColors.green100,
                                              //           border: pw.Border(
                                              //             bottom: pw.BorderSide(
                                              //                 width: 0.5,
                                              //                 color: PdfColors
                                              //                     .grey600),
                                              //           ),
                                              //         ),
                                              //         padding:
                                              //             const pw.EdgeInsets.all(
                                              //                 8.0),
                                              //         height: 30,
                                              //       )
                                              //     : pw.Container(
                                              //         // width: 120,
                                              //         decoration:
                                              //             const pw.BoxDecoration(
                                              //           // color: PdfColors.green100,
                                              //           border: pw.Border(
                                              //             bottom: pw.BorderSide(
                                              //                 width: 0.5,
                                              //                 color: PdfColors
                                              //                     .grey600),
                                              //           ),
                                              //         ),
                                              //         padding:
                                              //             const pw.EdgeInsets.all(
                                              //                 8.0),
                                              //         child: pw.Center(
                                              //           child: pw.Image(
                                              //             pw.MemoryImage(
                                              //                 imageBytes_Payee),
                                              //             height: 30,
                                              //             width: 100,
                                              //           ),
                                              //         ),
                                              //       ),
                                              ),
                                          pw.Text(
                                            ' พนักงาน',
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
                                    ),
                                    pw.SizedBox(
                                      height: 3,
                                    ),
                                    pw.Container(
                                      width: 150,
                                      // decoration: const pw.BoxDecoration(
                                      //   // color: PdfColors.green100,
                                      //   border: pw.Border(
                                      //     bottom: pw.BorderSide(
                                      //         width: 0.5, color: PdfColors.grey600),
                                      //   ),
                                      // ),
                                      padding: const pw.EdgeInsets.fromLTRB(
                                          4, 0, 4, 0),
                                      child: pw.Row(
                                        // mainAxisAlignment:
                                        //     pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'คุณ : ',
                                            textAlign: pw.TextAlign.left,
                                            style: pw.TextStyle(
                                              fontSize: font_Size,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 1,
                                            child: pw.Align(
                                              alignment: pw.Alignment.center,
                                              child: pw.Text(
                                                '( $fname )',
                                                // '(${licence_name2})',
                                                textAlign: pw.TextAlign.left,
                                                style: pw.TextStyle(
                                                  fontSize: font_Size,
                                                  font: ttf,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: Colors_pd,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    pw.Container(
                                      width: 150,
                                      padding: const pw.EdgeInsets.fromLTRB(
                                          4, 0, 4, 0),
                                      child: pw.Row(
                                        // mainAxisAlignment:
                                        //     pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'วันที่/Date : ',
                                            textAlign: pw.TextAlign.left,
                                            style: pw.TextStyle(
                                              fontSize: font_Size,
                                              font: ttf,
                                              fontWeight: pw.FontWeight.bold,
                                              color: Colors_pd,
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 1,
                                            child: pw.Align(
                                                alignment: pw.Alignment.center,
                                                child: pw.Container(
                                                  // width: 120,
                                                  decoration:
                                                      const pw.BoxDecoration(
                                                    // color: PdfColors.green100,
                                                    border: pw.Border(
                                                      bottom: pw.BorderSide(
                                                          width: 0.5,
                                                          color: PdfColors
                                                              .grey600),
                                                    ),
                                                  ),
                                                  padding:
                                                      const pw.EdgeInsets.all(
                                                          8.0),
                                                  height: 12,
                                                )
                                                //  pw.Text(
                                                //   '${DateFormat('dd/MM').format(DateTime.parse(date_Transaction!))}/${DateTime.parse('${date_Transaction}').year + 543}',
                                                //   textAlign: pw.TextAlign.left,
                                                //   style: pw.TextStyle(
                                                //     fontSize: font_Size,
                                                //     font: ttf,
                                                //     fontWeight:
                                                //         pw.FontWeight.bold,
                                                //     color: Colors_pd,
                                                //   ),
                                                // ),
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ])),
                          // pw.Expanded(
                          //     flex: 1,
                          //     child: pw.Column(
                          //         mainAxisAlignment: pw.MainAxisAlignment.start,
                          //         // crossAxisAlignment: pw.CrossAxisAlignment.center,
                          //         children: [
                          //           pw.Text(
                          //             'ลงชื่อ :',
                          //             textAlign: pw.TextAlign.left,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //           pw.Text(
                          //             '........................................................',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //           pw.Text(
                          //             '(......................................................)',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //           pw.Text(
                          //             'วันที่/Date...........................................',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //         ])),
                          // pw.Expanded(
                          //     flex: 1,
                          //     child: pw.Column(
                          //         mainAxisAlignment: pw.MainAxisAlignment.start,
                          //         // crossAxisAlignment: pw.CrossAxisAlignment.center,
                          //         children: [
                          //           pw.Text(
                          //             'ลงชื่อ : ',
                          //             textAlign: pw.TextAlign.left,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //           pw.Text(
                          //             '........................................................',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //           pw.Text(
                          //             '(......................................................)',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //           pw.Text(
                          //             'วันที่/Date...........................................',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size,
                          //               font: ttf,
                          //               fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //         ])),
                          // pw.Expanded(
                          //     flex: 1,
                          //     child: pw.Column(
                          //         mainAxisAlignment: pw.MainAxisAlignment.start,
                          //         // crossAxisAlignment: pw.CrossAxisAlignment.center,
                          //         children: [
                          //           // pw.Container(
                          //           //   child: pw.BarcodeWidget(
                          //           //       data:
                          //           //           '|099400016565010\r$cFinn\r15022567\r0100\r',
                          //           //       barcode: pw.Barcode.qrCode(),
                          //           //       width: 55,
                          //           //       height: 55),
                          //           // ),
                          //           if (ptser1.toString() == '6')
                          //             pw.Container(
                          //               child: pw.BarcodeWidget(
                          //                   data:
                          //                       '|$selectedValue_bank_bno\r${cFinn.replaceAll('-', '')}\r${DateFormat('ddMM').format(DateTime.parse(End_Bill_Paydate))}$YearQRthai\r${newTotal_QR}',
                          //                   barcode: pw.Barcode.qrCode(),
                          //                   width: 55,
                          //                   height: 55),
                          //             ),
                          //           if (ptser1.toString() == '5')
                          //             pw.BarcodeWidget(
                          //                 data: generateQRCode(
                          //                     promptPayID:
                          //                         "$selectedValue_bank_bno",
                          //                     amount: double.parse(
                          //                         (Total == null || Total == '')
                          //                             ? '0'
                          //                             : '$Total')),
                          //                 barcode: pw.Barcode.qrCode(),
                          //                 width: 55,
                          //                 height: 55),
                          //           if (img1.toString() != '')
                          //             if (ptser1.toString() == '2')
                          //               pw.Image(
                          //                 (netImage_QR[0]),
                          //                 height: 55,
                          //                 width: 55,
                          //               ),
                          //           pw.SizedBox(height: 2),
                          //           pw.Text(
                          //             (End_Bill_Paydate == null ||
                          //                     End_Bill_Paydate.toString() == '')
                          //                 ? 'ชำระไม่เกินวันที่ ${End_Bill_Paydate} '
                          //                 : 'ชำระไม่เกินวันที่ ${DateFormat('dd/MM').format(DateTime.parse(End_Bill_Paydate!))}/${DateTime.parse('${End_Bill_Paydate}').year + 543}',
                          //             textAlign: pw.TextAlign.center,
                          //             style: pw.TextStyle(
                          //               fontSize: font_Size - 1.5,
                          //               font: ttf,
                          //               // fontWeight: pw.FontWeight.bold,
                          //               color: Colors_pd,
                          //             ),
                          //           ),
                          //         ])),
                        ],
                      )),
                ]),
              ),
              pw.Stack(
                children: [
                  pw.Container(
                      width: PdfPageFormat.a4.width,
                      height: 55,
                      child: pw.Center(
                        child: pw.Container(
                            width: widths,
                            height: 25,
                            child: pw.Column(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                mainAxisSize: pw.MainAxisSize.min,
                                children: [
                                  pw.Row(children: [
                                    pw.Expanded(
                                        child: pw.Container(
                                      color: PdfColors.red,
                                      height: 5,
                                    ))
                                  ]),
                                  pw.Row(children: [
                                    pw.Expanded(
                                        child: pw.Container(
                                      color: PdfColors.green900,
                                      height: 8,
                                    ))
                                  ]),
                                  pw.Row(children: [
                                    pw.Expanded(
                                        child: pw.Container(
                                      color: PdfColors.red,
                                      height: 5,
                                    ))
                                  ]),
                                ])),
                      )),
                  pw.Positioned(
                      top: 4,
                      right: 50,
                      child: pw.Container(
                          width: 50.0,
                          height: 50.0,
                          child: pw.Image(pw.MemoryImage(imageData)))),
                  pw.Positioned(
                    top: 4,
                    left: 40,
                    child: pw.Text(
                      "CHOICE MINI STORE CO., LTD. 7/11 VILLAGE NO.5, THA SALA SUB-DISTRICT, MUEANG CHIANG MAI DISTRICT, CHIANG MAI PROVINANCE 50000",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size - 4,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    bottom: 4,
                    right: 120,
                    child: pw.Text(
                      "Sub Area Licencee: Chiang Mai, Lamphun, Mae-Hong-Son",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: Colors_pd,
                        fontSize: font_Size - 4,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    bottom: 4,
                    left: 40,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: pw.Align(
                            alignment: pw.Alignment.bottomLeft,
                            child: pw.Text(
                              'พิมพ์เมื่อ : $date ',
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
                              ' ( หน้าที่ ${context.pageNumber} / ${context.pagesCount} ) ',
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
                    ),
                  ),
                ],
              ),
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //   children: [
              //     pw.Padding(
              //       padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
              //       child: pw.Align(
              //         alignment: pw.Alignment.bottomLeft,
              //         child: pw.Text(
              //           'พิมพ์เมื่อ : $date',
              //           // textAlign: pw.TextAlign.left,
              //           style: pw.TextStyle(
              //             fontSize: 7.00,
              //             font: ttf,
              //             color: Colors_pd,
              //             // fontWeight: pw.FontWeight.bold
              //           ),
              //         ),
              //       ),
              //     ),
              //     pw.Padding(
              //       padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
              //       child: pw.Align(
              //         alignment: pw.Alignment.bottomRight,
              //         child: pw.Text(
              //           'หน้าที่ ${context.pageNumber} / ${context.pagesCount} ',
              //           // textAlign: pw.TextAlign.left,
              //           style: pw.TextStyle(
              //             fontSize: 7.00,
              //             font: ttf,
              //             color: Colors_pd,
              //             // fontWeight: pw.FontWeight.bold
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
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
        //                   flex: 3,
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
        //                           '1. ขอความกรุณาชำระค่าบริการ/ค่าเช่าให้ตรงตามยอด เพื่อความถูกต้อง',
        //                           textAlign: pw.TextAlign.left,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                         (payment_Ptser1 == '6' &&
        //                                 payment_Ptser1 != '1' &&
        //                                 paymentName1 != null)
        //                             ? pw.Padding(
        //                                 padding: pw.EdgeInsets.all(0),
        //                                 child: pw.Text(
        //                                   '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${bank1} เลขที่บัญชี ${selectedValue_bank_bno} [ Ref1 : $cFinn , Ref2 : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${date_Transaction}'))} ] (Standard QR)',
        //                                   //  '2. การชำระเงิน ท่านสามารถโอนเข้าเลขที่บัญชี ${finnancetransModels.where((model) => model.ptser == '6' && model.dtype != 'MM').map((model) => model.bno).join(', ')}',
        //                                   textAlign: pw.TextAlign.left,
        //                                   maxLines: 2,
        //                                   style: pw.TextStyle(
        //                                       font: ttf,
        //                                       fontSize: font_Size,
        //                                       color: PdfColors.grey800),
        //                                 ),
        //                               )
        //                             : (payment_Ptser1 != '1' &&
        //                                     paymentName1 != null)
        //                                 ? pw.Padding(
        //                                     padding: pw.EdgeInsets.all(0),
        //                                     child: pw.Text(
        //                                       (payment_Ptser1 == '2')
        //                                           ? '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${bank1} เลขที่บัญชี ${selectedValue_bank_bno} '
        //                                           : '2. การชำระเงิน ท่านสามารถโอนเข้าบัญชี ${bank1} เลขที่บัญชี ${selectedValue_bank_bno} ($paymentName1)',
        //                                       textAlign: pw.TextAlign.left,
        //                                       maxLines: 2,
        //                                       style: pw.TextStyle(
        //                                           font: ttf,
        //                                           fontSize: font_Size,
        //                                           color: PdfColors.grey800),
        //                                     ),
        //                                   )
        //                                 : pw.SizedBox(),
        //                         pw.Text(
        //                           (payment_Ptser1 == '1' ||
        //                                   paymentName1 == null)
        //                               ? '2. หากเกิดข้อผิดพลาดโปรดเก็บหลักฐานการชำระไว้ เพื่อติดต่อเจ้าหน้าที่'
        //                               : '3. หากเกิดข้อผิดพลาดโปรดเก็บหลักฐานการชำระไว้ เพื่อติดต่อเจ้าหน้าที่',
        //                           textAlign: pw.TextAlign.left,
        //                           style: pw.TextStyle(
        //                             fontSize: font_Size,
        //                             font: ttf,
        //                             fontWeight: pw.FontWeight.bold,
        //                             color: Colors_pd,
        //                           ),
        //                         ),
        //                       ])),
        //               pw.Expanded(
        //                   flex: 2,
        //                   child: pw.Column(
        //                     mainAxisAlignment: pw.MainAxisAlignment.end,
        //                     crossAxisAlignment: pw.CrossAxisAlignment.end,
        //                     children: [
        //                       pw.Row(
        //                         mainAxisAlignment: pw.MainAxisAlignment.end,
        //                         crossAxisAlignment: pw.CrossAxisAlignment.end,
        //                         children: [
        //                           pw.Expanded(
        //                             flex: 1,
        //                             child: pw.Text(
        //                               'ลงชื่อ',
        //                               textAlign: pw.TextAlign.center,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 fontWeight: pw.FontWeight.bold,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                           ),
        //                           pw.Expanded(
        //                             flex: 1,
        //                             child: pw.Text(
        //                               'ลงชื่อ',
        //                               textAlign: pw.TextAlign.center,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 fontWeight: pw.FontWeight.bold,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       pw.Row(
        //                         mainAxisAlignment: pw.MainAxisAlignment.end,
        //                         crossAxisAlignment: pw.CrossAxisAlignment.end,
        //                         children: [
        //                           pw.Expanded(
        //                             flex: 1,
        //                             child: pw.Text(
        //                               '......................................',
        //                               maxLines: 1,
        //                               textAlign: pw.TextAlign.center,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 fontWeight: pw.FontWeight.bold,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                           ),
        //                           pw.Expanded(
        //                             flex: 1,
        //                             child: pw.Text(
        //                               '......................................',
        //                               textAlign: pw.TextAlign.center,
        //                               maxLines: 1,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 fontWeight: pw.FontWeight.bold,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       pw.SizedBox(height: 5),
        //                       pw.Row(
        //                         mainAxisAlignment: pw.MainAxisAlignment.end,
        //                         crossAxisAlignment: pw.CrossAxisAlignment.end,
        //                         children: [
        //                           pw.Expanded(
        //                             flex: 1,
        //                             child: pw.Text(
        //                               '(.....................................)',
        //                               maxLines: 1,
        //                               textAlign: pw.TextAlign.center,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 fontWeight: pw.FontWeight.bold,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                           ),
        //                           pw.Expanded(
        //                             flex: 1,
        //                             child: pw.Text(
        //                               '(.....................................)',
        //                               textAlign: pw.TextAlign.center,
        //                               maxLines: 1,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 fontWeight: pw.FontWeight.bold,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       pw.SizedBox(height: 5),
        //                       pw.Row(
        //                         mainAxisAlignment: pw.MainAxisAlignment.end,
        //                         crossAxisAlignment: pw.CrossAxisAlignment.end,
        //                         children: [
        //                           pw.Expanded(
        //                             flex: 1,
        //                             child: pw.Text(
        //                               'วันที่.........................',
        //                               maxLines: 1,
        //                               textAlign: pw.TextAlign.center,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 fontWeight: pw.FontWeight.bold,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                           ),
        //                           pw.Expanded(
        //                             flex: 1,
        //                             child: pw.Text(
        //                               'วันที่.........................',
        //                               textAlign: pw.TextAlign.center,
        //                               maxLines: 1,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 fontWeight: pw.FontWeight.bold,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   )),
        //               if (paymentName1.toString().trim() != 'เงินสด' ||
        //                   paymentName1 != null)
        //                 pw.Expanded(
        //                     flex: 1,
        //                     child:
        //                         (paymentName1.toString().trim() == 'เงินโอน' ||
        //                                 paymentName1.toString().trim() ==
        //                                     'เงินโอน' ||
        //                                 paymentName1.toString().trim() ==
        //                                     'Online Payment' ||
        //                                 paymentName1.toString().trim() ==
        //                                     'Online Payment' ||
        //                                 paymentName1.toString().trim() ==
        //                                     'Online Standard QR' ||
        //                                 paymentName2.toString().trim() ==
        //                                     'เงินโอน' ||
        //                                 paymentName2.toString().trim() ==
        //                                     'เงินโอน' ||
        //                                 paymentName2.toString().trim() ==
        //                                     'Online Payment' ||
        //                                 paymentName2.toString().trim() ==
        //                                     'Online Payment' ||
        //                                 paymentName2.toString().trim() ==
        //                                     'Online Standard QR')
        //                             ? pw.Container(
        //                                 padding: const pw.EdgeInsets.all(4.0),
        //                                 child: pw.Column(
        //                                   mainAxisAlignment:
        //                                       pw.MainAxisAlignment.end,
        //                                   crossAxisAlignment:
        //                                       pw.CrossAxisAlignment.end,
        //                                   children: [
        //                                     pw.Container(
        //                                       child: pw.BarcodeWidget(
        //                                           data: (paymentName1
        //                                                           .toString()
        //                                                           .trim() ==
        //                                                       'Online Standard QR' ||
        //                                                   paymentName2
        //                                                           .toString()
        //                                                           .trim() ==
        //                                                       'Online Standard QR')
        //                                               ? '|$selectedValue_bank_bno\r$cFinn\r${DateFormat('dd-MM-yyyy').format(DateTime.parse(date_Transaction))}\r${newTotal_QR}\r'
        //                                               : generateQRCode(
        //                                                   promptPayID:
        //                                                       "$selectedValue_bank_bno",
        //                                                   amount: double.parse(
        //                                                       (Total == null ||
        //                                                               Total ==
        //                                                                   '')
        //                                                           ? '0'
        //                                                           : '$Total')),
        //                                           barcode: pw.Barcode.qrCode(),
        //                                           width: 60,
        //                                           height: 60),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               )
        //                             : pw.SizedBox(width: 60, height: 60)),
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
    // final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/name');
    // await file.writeAsBytes(bytes);
    // return file;
    ///////----------------------------------------->
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

    // Future<Uint8List> _generatePdf(pw.Document doc, String title) async {
    //   return pdf.save();
    // }

    // await Printing.directPrintPdf(
    //     printer: Printer(url: 'name of your device(printer name)'),
    //     onLayout: (format) => _generatePdf(pdf, 'title'));
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => PreviewPdfgen_Bills(
    //           doc: pdf, nameBills: 'ใบวางบิล/ใบแจ้งหนี้${cFinn}'),
    //     ));
  }
}
