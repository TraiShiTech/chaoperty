// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:file_saver/file_saver.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:math' as math;
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';

// import '../../../ChaoArea/ChaoAreaRenew_Screen.dart';
// import '../../../Constant/Myconstant.dart';
// import '../../../PeopleChao/Bills_.dart';
// import '../../../PeopleChao/Pays_.dart';
// import '../../../Style/ThaiBaht.dart';
// import '../../CRC_16_Prompay/generate_qrcode.dart';

// class Pdf_genReceipt_Template10 {
//   static void exportPDF_Receipt_Template10(
//       bills_name_dtype,
//       numinvoice,
//       tableData00,
//       context,
//       Slip_status,
//       _InvoiceHistoryModels,
//       Num_cid,
//       Namenew,
//       sum_pvat,
//       sum_vat,
//       sum_wht,
//       Sum_SubTotal,
//       sum_disp,
//       sum_disamt,
//       Total,
//       renTal_name,
//       Form_bussshop,
//       Form_address,
//       Form_tel,
//       Form_email,
//       Form_tax,
//       Form_nameshop,
//       bill_addr,
//       bill_email,
//       bill_tel,
//       bill_tax,
//       bill_name,
//       newValuePDFimg,
//       pamentpage,
//       paymentName1,
//       paymentName2,
//       Form_payment1,
//       Form_payment2,
//       Value_newDateD,
//       selectedValue_bank_bno,
//       newValuePDFimg_QR,
//       TitleType_Default_Receipt_Name,
//       sum_matjum,
//       dis_sum_Matjum) async {
//     ////
//     //// ------------>(ใบเสร็จรับเงินชั่วคราว paySrsscreen_)
//     ///////
//     final pdf = pw.Document();
//     //final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
//     final font = await rootBundle.load("fonts/THSarabunNew.ttf");
//     // final font = await rootBundle.load("fonts/MaliBold.ttf");
//     var Colors_pd = PdfColors.black;
//     final ttf = pw.Font.ttf(font);
//     double font_Size = 12.0;
//     DateTime date = DateTime.now();
//     var formatter = new DateFormat.MMMMd('th_TH');
//     String thaiDate = formatter.format(date);
//     var nFormat = NumberFormat("#,##0.00", "en_US");
//     var nFormat2 = NumberFormat("###0.00", "en_US");
//     final iconImage =
//         (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
//     List netImage = [];
//     List netImage_QR = [];
//     for (int i = 0; i < newValuePDFimg.length; i++) {
//       netImage.add(await networkImage('${newValuePDFimg[i]}'));
//     }
//     netImage_QR.add(await networkImage('${newValuePDFimg_QR}'));

//     String total_QR = '${nFormat.format(double.parse('${Total}'))}';
//     String newTotal_QR = total_QR.replaceAll(RegExp(r'[^0-9]'), '');
//     final tableHeaders = [
//       'ลำดับ',
//       'กำหนดชำระ',
//       'รายการ',
//       'จำนวน',
//       'หน่วย',
//       'vat',
//       'ราคารวม',
//       'ราคารวมvat',
//     ];

//     // final tableData = [
//     //   for (int index = 0; index < _InvoiceHistoryModels.length; index++)
//     //     [
//     //       '${index + 1}',
//     //       '${_InvoiceHistoryModels[index].date}',
//     //       '${_InvoiceHistoryModels[index].descr}',
//     //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].qty!))}',
//     //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].nvat!))}',
//     //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].vat!))}',
//     //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].pvat!))}',
//     //       '${nFormat.format(double.parse(_InvoiceHistoryModels[index].amt!))}',
//     //     ],
//     // ];
// ///////////////////////------------------------------------------------->

// ///////////////////////------------------------------------------------->
//     pdf.addPage(
//       pw.MultiPage(
//         header: (context) {
//           return pw.Column(children: [
//             pw.Row(
//               children: [
//                 (netImage.isEmpty)
//                     ? pw.Container(
//                         height: 72,
//                         width: 70,
//                         color: PdfColors.grey200,
//                         child: pw.Center(
//                           child: pw.Text(
//                             '$bill_name ',
//                             maxLines: 2,
//                             style: pw.TextStyle(
//                               fontSize: 10,
//                               font: ttf,
//                               color: Colors_pd,
//                             ),
//                           ),
//                         ))

//                     // pw.Image(
//                     //     pw.MemoryImage(iconImage),
//                     //     height: 72,
//                     //     width: 70,
//                     //   )
//                     : pw.Image(
//                         (netImage[0]),
//                         height: 72,
//                         width: 70,
//                       ),
//                 pw.SizedBox(width: 1 * PdfPageFormat.mm),
//                 pw.Container(
//                   width: 200,
//                   child: pw.Column(
//                     mainAxisSize: pw.MainAxisSize.min,
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         '$bill_name',
//                         maxLines: 2,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           fontWeight: pw.FontWeight.bold,
//                           font: ttf,
//                         ),
//                       ),
//                       pw.Text(
//                         'ที่อยู่: $bill_addr',
//                         maxLines: 3,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           color: Colors_pd,
//                           font: ttf,
//                         ),
//                       ),
//                       pw.Text(
//                         'โทรศัพท์: $bill_tel',
//                         textAlign: pw.TextAlign.right,
//                         maxLines: 1,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       pw.Text(
//                         'อีเมล: $bill_email',
//                         maxLines: 1,
//                         textAlign: pw.TextAlign.right,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       pw.Text(
//                         (bill_tax.toString() == '' ||
//                                 bill_tax == null ||
//                                 bill_tax.toString() == 'null')
//                             ? 'เลขประจำตัวผู้เสียภาษี: 0'
//                             : 'เลขประจำตัวผู้เสียภาษี: $bill_tax',
//                         textAlign: pw.TextAlign.right,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.Spacer(),
//                 pw.Container(
//                   width: 180,
//                   child: pw.Column(
//                     mainAxisSize: pw.MainAxisSize.min,
//                     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                     children: [
//                       if (TitleType_Default_Receipt_Name != null)
//                         pw.Text(
//                           '[ $TitleType_Default_Receipt_Name ]',
//                           maxLines: 1,
//                           style: pw.TextStyle(
//                             fontSize: font_Size,
//                             font: ttf,
//                             color: PdfColors.grey400,
//                           ),
//                         ),
//                       pw.SizedBox(
//                         height: 6,
//                       ),
//                       pw.Text(
//                         (bills_name_dtype.toString() == 'P' ||
//                                 bills_name_dtype == null ||
//                                 bills_name_dtype.toString() == 'บิลธรรมดา')
//                             ? 'ใบเสร็จรับเงิน'
//                             : (bills_name_dtype.toString() == 'F')
//                                 ? 'ใบเสร็จรับเงิน/ใบกำกับภาษี'
//                                 : '-$bills_name_dtype',
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           fontWeight: pw.FontWeight.bold,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       // pw.Text(
//                       //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
//                       //   textAlign: pw.TextAlign.right,
//                       //   style: pw.TextStyle(
//                       //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
//                       // ),
//                       // pw.Text(
//                       //   'โทรศัพท์: $bill_tel',
//                       //   textAlign: pw.TextAlign.right,
//                       //   maxLines: 1,
//                       //   style: pw.TextStyle(
//                       //       fontSize: 10.0,
//                       //       font: ttf,
//                       //       color: PdfColors.grey800),
//                       // ),
//                       // pw.Text(
//                       //   'อีเมล: $bill_email',
//                       //   maxLines: 1,
//                       //   textAlign: pw.TextAlign.right,
//                       //   style: pw.TextStyle(
//                       //       fontSize: 10.0,
//                       //       font: ttf,
//                       //       color: PdfColors.grey800),
//                       // ),
//                       pw.Text(
//                         'เลขที่: $numinvoice ',
//                         maxLines: 2,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       pw.Text(
//                         'วันที่ทำรายการ: $thaiDate ${DateTime.now().year + 543}',
//                         maxLines: 2,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       // pw.Container(
//                       //   child: pw.BarcodeWidget(
//                       //       data: "$numinvoice",
//                       //       barcode: pw.Barcode.code128(),
//                       //       width: 140,
//                       //       height: 40),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ]);
//         },
//         build: (context) {
//           return [
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Divider(),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Row(
//               children: [
//                 // pw.Expanded(
//                 //   flex: 4,
//                 //   child: pw.Column(
//                 //     mainAxisSize: pw.MainAxisSize.min,
//                 //     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 //     children: [
//                 //       pw.Text(
//                 //         'ผู้ขาย',
//                 //         style: pw.TextStyle(
//                 //           fontSize: 10.0,
//                 //           fontWeight: pw.FontWeight.bold,
//                 //           font: ttf,
//                 //         ),
//                 //       ),
//                 //       pw.Text(
//                 //         '$renTal_name',
//                 //         textAlign: pw.TextAlign.justify,
//                 //         style: pw.TextStyle(
//                 //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
//                 //       ),
//                 //       pw.Text(
//                 //         (bill_addr.toString() == '' || bill_tax == null)
//                 //             ? 'ที่อยู่:-'
//                 //             : 'ที่อยู่:$bill_addr',
//                 //         textAlign: pw.TextAlign.left,
//                 //         style: pw.TextStyle(
//                 //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
//                 //       ),
//                 //       pw.Text(
//                 //         (bill_tax.toString() == '' || bill_tax == null)
//                 //             ? 'เลขประจำตัวผู้เสียภาษี:0'
//                 //             : 'เลขประจำตัวผู้เสียภาษี:$bill_tax',
//                 //         textAlign: pw.TextAlign.justify,
//                 //         style: pw.TextStyle(
//                 //             fontSize: 10.0, font: ttf, color: PdfColors.grey),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // pw.SizedBox(width: 10 * PdfPageFormat.mm),
//                 pw.Expanded(
//                   flex: 4,
//                   child: pw.Column(
//                     mainAxisSize: pw.MainAxisSize.min,
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         'ลูกค้า',
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           fontWeight: pw.FontWeight.bold,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       pw.Text(
//                         (Form_bussshop.toString() == '' ||
//                                 Form_bussshop == null ||
//                                 Form_bussshop.toString() == 'null')
//                             ? '-'
//                             : '$Form_bussshop',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       // pw.Text(
//                       //   'ที่อยู่:$Form_address',
//                       //   textAlign: pw.TextAlign.left,
//                       //   style: pw.TextStyle(
//                       //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
//                       // ),
//                       // pw.Text(
//                       //   'เลขประจำตัวผู้เสียภาษี:$Form_tax',
//                       //   textAlign: pw.TextAlign.justify,
//                       //   style: pw.TextStyle(
//                       //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
//                       // ),
//                       pw.Text(
//                         (Form_address.toString() == '' ||
//                                 Form_address == null ||
//                                 Form_address.toString() == 'null')
//                             ? 'ที่อยู่: -'
//                             : 'ที่อยู่: $Form_address',
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       pw.Text(
//                         (Form_tax.toString() == '' ||
//                                 Form_tax == null ||
//                                 Form_tax.toString() == 'null')
//                             ? 'เลขประจำตัวผู้เสียภาษี: 0'
//                             : 'เลขประจำตัวผู้เสียภาษี: $Form_tax',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             if (Slip_status.toString() != '1')
//               pw.SizedBox(height: 3 * PdfPageFormat.mm),
//             if (Slip_status.toString() != '1')
//               pw.Row(
//                 children: [
//                   pw.Expanded(
//                     flex: 4,
//                     child: pw.Text(
//                       'รูปแบบชำระ',
//                       textAlign: pw.TextAlign.justify,
//                       style: pw.TextStyle(
//                         fontSize: font_Size,
//                         font: ttf,
//                         fontWeight: pw.FontWeight.bold,
//                         color: Colors_pd,
//                       ),
//                     ),
//                   ),
//                   pw.SizedBox(width: 10 * PdfPageFormat.mm),
//                   pw.Expanded(
//                     flex: 4,
//                     child: pw.Column(
//                       mainAxisSize: pw.MainAxisSize.min,
//                       crossAxisAlignment: pw.CrossAxisAlignment.end,
//                       children: [
//                         if (Value_newDateD.toString() == '' ||
//                             Value_newDateD.toString() == 'null')
//                           pw.Text(
//                             'วันที่ชำระ : - ',
//                             style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: Colors_pd,
//                             ),
//                           ),
//                         if (Value_newDateD.toString() != '' ||
//                             Value_newDateD.toString() != 'null')
//                           pw.Text(
//                             'วันที่ชำระ : $Value_newDateD',
//                             textAlign: pw.TextAlign.justify,
//                             style: pw.TextStyle(
//                               fontSize: font_Size,
//                               font: ttf,
//                               color: Colors_pd,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             if (Slip_status.toString() != '1')
//               pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             // //////////////---------------------------------->
//             if (Slip_status.toString() != '1')
//               pw.Row(children: [
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       // decoration: pw.BoxDecoration(
//                       //   color: PdfColors.green100,
//                       //   // border: pw.Border(
//                       //   //   bottom: pw.BorderSide(
//                       //   //       color: PdfColors.green900),
//                       //   // ),
//                       // ),
//                       child: (paymentName1.toString().trim() != 'เงินสด')
//                           ? pw.Text(
//                               (Form_payment1 == null ||
//                                       Form_payment1.toString() == 'null' ||
//                                       Form_payment1.toString() == '')
//                                   ? '1.เงินโอน : -'
//                                   : '1.เงินโอน : ${nFormat.format(double.parse(Form_payment1.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment1.toString()))}~)',
//                               textAlign: pw.TextAlign.justify,
//                               style: pw.TextStyle(
//                                 fontSize: font_Size,
//                                 font: ttf,
//                                 fontWeight: pw.FontWeight.bold,
//                                 color: Colors_pd,
//                               ),
//                             )
//                           : pw.Text(
//                               (Form_payment1 == null ||
//                                       Form_payment1.toString() == 'null' ||
//                                       Form_payment1.toString() == '')
//                                   ? '1.$paymentName1 : -'
//                                   : '1.$paymentName1 : ${nFormat.format(double.parse(Form_payment1.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment1.toString()))}~)',
//                               textAlign: pw.TextAlign.justify,
//                               style: pw.TextStyle(
//                                 fontSize: font_Size,
//                                 font: ttf,
//                                 fontWeight: pw.FontWeight.bold,
//                                 color: Colors_pd,
//                               ),
//                             ),
//                     )),
//               ]),

// // //////////////---------------------------------->
//             if (Slip_status.toString() != '1')
//               if (pamentpage != 0)
//                 pw.Row(children: [
//                   pw.Expanded(
//                       flex: 1,
//                       child: pw.Container(
//                         // decoration: pw.BoxDecoration(
//                         //   color: PdfColors.green100,
//                         //   // border: pw.Border(
//                         //   //   bottom: pw.BorderSide(
//                         //   //       color: PdfColors.green900),
//                         //   // ),
//                         // ),
//                         child: (paymentName2.toString().trim() != 'เงินสด' ||
//                                 paymentName2.toString().trim() != 'เงินสด')
//                             ? pw.Text(
//                                 (Form_payment2 == null ||
//                                         Form_payment2.toString() == 'null' ||
//                                         Form_payment2.toString() == '')
//                                     ? '2.เงินโอน : -'
//                                     : '2.เงินโอน : ${nFormat.format(double.parse(Form_payment2.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment2.toString()))}~)',
//                                 textAlign: pw.TextAlign.justify,
//                                 style: pw.TextStyle(
//                                   fontSize: font_Size,
//                                   font: ttf,
//                                   fontWeight: pw.FontWeight.bold,
//                                   color: Colors_pd,
//                                 ),
//                               )
//                             : pw.Text(
//                                 (Form_payment2 == null ||
//                                         Form_payment2.toString() == 'null' ||
//                                         Form_payment2.toString() == '')
//                                     ? '2.$paymentName2 : -'
//                                     : '2.$paymentName2 : ${nFormat.format(double.parse(Form_payment2.toString()))} บาท (~${convertToThaiBaht(double.parse(Form_payment2.toString()))}~)',
//                                 textAlign: pw.TextAlign.justify,
//                                 style: pw.TextStyle(
//                                   fontSize: font_Size,
//                                   font: ttf,
//                                   fontWeight: pw.FontWeight.bold,
//                                   color: Colors_pd,
//                                 ),
//                               ),
//                       )),
//                 ]),
//             pw.SizedBox(height: 3 * PdfPageFormat.mm),
// //////////////---------------------------------->
//             pw.Container(
//               // decoration: const pw.BoxDecoration(
//               //   // color: PdfColors.green100,
//               //   border: pw.Border(
//               //     top: pw.BorderSide(color: PdfColors.grey800),
//               //     bottom: pw.BorderSide(color: PdfColors.grey800),
//               //   ),
//               // ),
//               child: pw.Row(
//                 children: [
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       decoration: const pw.BoxDecoration(
//                         // color: PdfColors.green100,
//                         border: pw.Border(
//                           left: pw.BorderSide(color: PdfColors.grey800),
//                           top: pw.BorderSide(color: PdfColors.grey800),
//                           bottom: pw.BorderSide(color: PdfColors.grey800),
//                         ),
//                       ),
//                       height: 25,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'ลำดับ',
//                           maxLines: 1,
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: PdfColors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       decoration: const pw.BoxDecoration(
//                         // color: PdfColors.green100,
//                         border: pw.Border(
//                           left: pw.BorderSide(color: PdfColors.grey800),
//                           top: pw.BorderSide(color: PdfColors.grey800),
//                           bottom: pw.BorderSide(color: PdfColors.grey800),
//                         ),
//                       ),
//                       height: 25,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'กำหนดชำระ',
//                           textAlign: pw.TextAlign.center,
//                           maxLines: 1,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: PdfColors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 4,
//                     child: pw.Container(
//                       decoration: const pw.BoxDecoration(
//                         // color: PdfColors.green100,
//                         border: pw.Border(
//                           left: pw.BorderSide(color: PdfColors.grey800),
//                           top: pw.BorderSide(color: PdfColors.grey800),
//                           bottom: pw.BorderSide(color: PdfColors.grey800),
//                         ),
//                       ),
//                       height: 25,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'รายการ',
//                           textAlign: pw.TextAlign.center,
//                           maxLines: 1,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: PdfColors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       decoration: const pw.BoxDecoration(
//                         // color: PdfColors.green100,
//                         border: pw.Border(
//                           left: pw.BorderSide(color: PdfColors.grey800),
//                           right: pw.BorderSide(color: PdfColors.grey800),
//                           top: pw.BorderSide(color: PdfColors.grey800),
//                           bottom: pw.BorderSide(color: PdfColors.grey800),
//                         ),
//                       ),
//                       height: 25,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'ยอดสุทธิ',
//                           textAlign: pw.TextAlign.center,
//                           maxLines: 1,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: PdfColors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             for (int index = 0; index < tableData00.length; index++)
//               pw.Container(
//                 // decoration: const pw.BoxDecoration(
//                 //   // color: PdfColors.green100,
//                 //   border: pw.Border(
//                 //     bottom: pw.BorderSide(color: PdfColors.grey800),
//                 //   ),
//                 // ),
//                 child: pw.Row(
//                   children: [
//                     pw.Expanded(
//                       flex: 1,
//                       child: pw.Container(
//                         // height: 25,
//                         decoration: const pw.BoxDecoration(
//                           color: PdfColors.white,
//                           border: const pw.Border(
//                             left: pw.BorderSide(color: PdfColors.grey600),
//                             bottom: pw.BorderSide(color: PdfColors.grey600),
//                           ),
//                         ),
//                         padding: const pw.EdgeInsets.all(2.0),
//                         child: pw.Center(
//                           child: pw.Text(
//                             '${tableData00[index][0]}',
//                             maxLines: 2,
//                             textAlign: pw.TextAlign.left,
//                             style: pw.TextStyle(
//                                 fontSize: font_Size,
//                                 font: ttf,
//                                 color: PdfColors.grey800),
//                           ),
//                         ),
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2.0),
//                         // height: 25,
//                         decoration: const pw.BoxDecoration(
//                           color: PdfColors.white,
//                           border: const pw.Border(
//                             left: pw.BorderSide(color: PdfColors.grey600),
//                             bottom: pw.BorderSide(color: PdfColors.grey600),
//                           ),
//                         ),
//                         child: pw.Align(
//                           alignment: pw.Alignment.center,
//                           child: pw.Text(
//                             '${tableData00[index][1]}',
//                             maxLines: 2,
//                             textAlign: pw.TextAlign.center,
//                             style: pw.TextStyle(
//                                 fontSize: font_Size,
//                                 font: ttf,
//                                 color: PdfColors.grey800),
//                           ),
//                         ),
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 4,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2.0),
//                         // height: 25,
//                         decoration: const pw.BoxDecoration(
//                           color: PdfColors.white,
//                           border: const pw.Border(
//                             left: pw.BorderSide(color: PdfColors.grey600),
//                             bottom: pw.BorderSide(color: PdfColors.grey600),
//                           ),
//                         ),
//                         child: pw.Align(
//                           alignment: pw.Alignment.centerLeft,
//                           child: pw.Text(
//                             '${tableData00[index][2]}',
//                             maxLines: 2,
//                             textAlign: pw.TextAlign.right,
//                             style: pw.TextStyle(
//                                 fontSize: font_Size,
//                                 font: ttf,
//                                 color: PdfColors.grey800),
//                           ),
//                         ),
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Container(
//                         padding: const pw.EdgeInsets.all(2.0),
//                         // height: 25,
//                         decoration: pw.BoxDecoration(
//                           color: PdfColors.white,
//                           border: const pw.Border(
//                             left: pw.BorderSide(color: PdfColors.grey600),
//                             right: pw.BorderSide(color: PdfColors.grey600),
//                             bottom: pw.BorderSide(color: PdfColors.grey600),
//                           ),
//                         ),
//                         child: pw.Align(
//                           alignment: pw.Alignment.centerRight,
//                           child: pw.Text(
//                             '${tableData00[index][6]}',
//                             maxLines: 2,
//                             textAlign: pw.TextAlign.right,
//                             style: pw.TextStyle(
//                                 fontSize: font_Size,
//                                 font: ttf,
//                                 color: PdfColors.grey800),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             // pw.Divider(color: PdfColors.grey),
//             pw.Container(
//               alignment: pw.Alignment.centerRight,
//               child: pw.Row(
//                 children: [
//                   pw.Spacer(flex: 6),
//                   pw.Expanded(
//                     flex: 4,
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         // SubTotal, Vat, Deduct, Sum_SubTotal, DisC, Total

//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'รวมราคาสินค้า/Sub Total',
//                                 style: pw.TextStyle(
//                                     fontSize: font_Size,
//                                     fontWeight: pw.FontWeight.bold,
//                                     font: ttf,
//                                     color: PdfColors.grey800),
//                               ),
//                             ),
//                             pw.Text(
//                               '${nFormat.format(double.parse(sum_pvat.toString()))}',
//                               // '${sum_pvat}',
//                               // '$SubTotal',
//                               style: pw.TextStyle(
//                                   fontSize: font_Size,
//                                   fontWeight: pw.FontWeight.bold,
//                                   font: ttf,
//                                   color: PdfColors.grey800),
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'ภาษีมูลค่าเพิ่ม/Vat',
//                                 style: pw.TextStyle(
//                                     fontSize: font_Size,
//                                     fontWeight: pw.FontWeight.bold,
//                                     font: ttf,
//                                     color: PdfColors.grey800),
//                               ),
//                             ),
//                             pw.Text(
//                               '${nFormat.format(double.parse(sum_vat.toString()))}',
//                               // '${sum_vat}',
//                               // '$Vat',
//                               style: pw.TextStyle(
//                                   fontSize: font_Size,
//                                   fontWeight: pw.FontWeight.bold,
//                                   font: ttf,
//                                   color: PdfColors.grey800),
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'หัก ณ ที่จ่าย',
//                                 style: pw.TextStyle(
//                                     fontSize: font_Size,
//                                     fontWeight: pw.FontWeight.bold,
//                                     font: ttf,
//                                     color: PdfColors.grey800),
//                               ),
//                             ),
//                             pw.Text(
//                               '${nFormat.format(double.parse(sum_wht.toString()))}',
//                               // '${sum_wht}',
//                               // '$Deduct',
//                               style: pw.TextStyle(
//                                   fontSize: font_Size,
//                                   fontWeight: pw.FontWeight.bold,
//                                   font: ttf,
//                                   color: PdfColors.grey800),
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'ยอดรวม',
//                                 style: pw.TextStyle(
//                                     fontSize: font_Size,
//                                     fontWeight: pw.FontWeight.bold,
//                                     font: ttf,
//                                     color: PdfColors.grey800),
//                               ),
//                             ),
//                             pw.Text(
//                               '${nFormat.format(double.parse(Sum_SubTotal.toString()))}',
//                               // '$Sum_SubTotal',
//                               style: pw.TextStyle(
//                                   fontSize: font_Size,
//                                   fontWeight: pw.FontWeight.bold,
//                                   font: ttf,
//                                   color: PdfColors.grey800),
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'ส่วนลด/Discount',
//                                 style: pw.TextStyle(
//                                     fontSize: font_Size,
//                                     fontWeight: pw.FontWeight.bold,
//                                     font: ttf,
//                                     color: PdfColors.grey800),
//                               ),
//                             ),
//                             pw.Text(
//                               '${nFormat.format(double.parse(sum_disamt.toString()))}',
//                               // '${sum_disamt}',
//                               // '$DisC',
//                               style: pw.TextStyle(
//                                   fontSize: font_Size,
//                                   fontWeight: pw.FontWeight.bold,
//                                   font: ttf,
//                                   color: PdfColors.grey800),
//                             ),
//                           ],
//                         ),
//                         if (nFormat.format(dis_sum_Matjum).toString() != '0.00')
//                           pw.Row(
//                             children: [
//                               pw.Expanded(
//                                 child: pw.Text(
//                                   'เงินมัดจำ(ตัดมัดจำ)',
//                                   //  'เงินมัดจำ(${nFormat.format(sum_matjum)})',
//                                   style: pw.TextStyle(
//                                       fontSize: font_Size,
//                                       fontWeight: pw.FontWeight.bold,
//                                       font: ttf,
//                                       color: PdfColors.grey800),
//                                 ),
//                               ),
//                               pw.Text(
//                                 dis_sum_Matjum == 0.00
//                                     ? '${nFormat.format(dis_sum_Matjum)}'
//                                     : '${nFormat.format(dis_sum_Matjum)}',
//                                 style: pw.TextStyle(
//                                     fontSize: font_Size,
//                                     fontWeight: pw.FontWeight.bold,
//                                     font: ttf,
//                                     color: PdfColors.grey800),
//                               ),
//                             ],
//                           ),
//                         pw.Divider(color: PdfColors.grey600),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'ยอดชำระ',
//                                 style: pw.TextStyle(
//                                     fontSize: font_Size,
//                                     fontWeight: pw.FontWeight.bold,
//                                     font: ttf,
//                                     color: PdfColors.grey800),
//                               ),
//                             ),
//                             pw.Text(
//                               '${nFormat.format(double.parse(Total.toString()))}',
//                               style: pw.TextStyle(
//                                   fontSize: font_Size,
//                                   fontWeight: pw.FontWeight.bold,
//                                   font: ttf,
//                                   color: PdfColors.grey800),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Container(
//                 height: 25,
//                 decoration: const pw.BoxDecoration(
//                   // color: PdfColors.green100,
//                   border: pw.Border(
//                     top: pw.BorderSide(color: PdfColors.grey600),
//                     bottom: pw.BorderSide(color: PdfColors.grey600),
//                   ),
//                 ),
//                 alignment: pw.Alignment.centerRight,
//                 child: pw.Center(
//                   child: pw.Row(
//                     children: [
//                       pw.SizedBox(width: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         'ตัวอักษร ',
//                         style: pw.TextStyle(
//                             fontSize: font_Size,
//                             fontWeight: pw.FontWeight.bold,
//                             font: ttf,
//                             fontStyle: pw.FontStyle.italic,
//                             color: PdfColors.grey800),
//                       ),
//                       pw.Expanded(
//                         flex: 4,
//                         child: pw.Text(
//                           //"${nFormat2.format(double.parse(Total.toString()))}";
//                           '(~${convertToThaiBaht(double.parse(Total.toString()))}~)',
//                           style: pw.TextStyle(
//                             fontSize: font_Size,
//                             fontWeight: pw.FontWeight.bold,
//                             font: ttf,
//                             fontStyle: pw.FontStyle.italic,
//                             // decoration:
//                             //     pw.TextDecoration.lineThrough,
//                             color: PdfColors.grey800,
//                           ),
//                         ),
//                       ),
//                       // pw.Spacer(flex: 6),
//                       pw.Expanded(
//                         flex: 2,
//                         child: pw.Column(
//                           mainAxisAlignment: pw.MainAxisAlignment.center,
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           children: [
//                             pw.Row(
//                               children: [
//                                 pw.Expanded(
//                                   flex: 2,
//                                   child: pw.Text(
//                                     'ยอดรวมสุทธิ',
//                                     textAlign: pw.TextAlign.left,
//                                     style: pw.TextStyle(
//                                         fontWeight: pw.FontWeight.bold,
//                                         font: ttf,
//                                         fontSize: font_Size,
//                                         color: PdfColors.grey800),
//                                   ),
//                                 ),
//                                 pw.Text(
//                                   '${nFormat.format(double.parse(Total.toString()))}',
//                                   // '${Total}',
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold,
//                                       font: ttf,
//                                       fontSize: font_Size,
//                                       color: PdfColors.grey800),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             pw.SizedBox(height: 5 * PdfPageFormat.mm),
//           ];
//         },
//         footer: (context) {
//           return pw.Column(
//             mainAxisSize: pw.MainAxisSize.min,
//             children: [
//               (paymentName1.toString().trim() == 'เงินโอน' ||
//                       paymentName1.toString().trim() == 'เงินโอน' ||
//                       paymentName1.toString().trim() == 'Online Payment' ||
//                       paymentName1.toString().trim() == 'Online Payment' ||
//                       paymentName1.toString().trim() == 'Online Standard QR' ||
//                       paymentName2.toString().trim() == 'เงินโอน' ||
//                       paymentName2.toString().trim() == 'เงินโอน' ||
//                       paymentName2.toString().trim() == 'Online Payment' ||
//                       paymentName2.toString().trim() == 'Online Payment' ||
//                       paymentName2.toString().trim() == 'Online Standard QR')
//                   ? pw.Container(
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border.all(color: PdfColors.grey, width: 1),
//                       ),
//                       child: pw.Column(
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Row(
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               children: [
//                                 pw.Expanded(
//                                   flex: 1,
//                                   child: pw.Container(
//                                     padding: const pw.EdgeInsets.all(4.0),
//                                     child: pw.Column(
//                                       children: [
//                                         // pw.Container(
//                                         //     // height: 60,
//                                         //     // width: 200,
//                                         //     child: pw.Image(
//                                         //   pw.MemoryImage(uint8Listthaiqr),
//                                         //   height: 72,
//                                         //   width: 65,
//                                         // )),
//                                         pw.Container(
//                                           child: (paymentName1.toString().trim() ==
//                                                       'เงินโอน' ||
//                                                   paymentName2
//                                                           .toString()
//                                                           .trim() ==
//                                                       'เงินโอน')
//                                               ? pw.Image(
//                                                   (netImage_QR[0]),
//                                                   height: 55,
//                                                   width: 55,
//                                                 )
//                                               : pw.BarcodeWidget(
//                                                   data: (paymentName1
//                                                                   .toString()
//                                                                   .trim() ==
//                                                               'Online Standard QR' ||
//                                                           paymentName2
//                                                                   .toString()
//                                                                   .trim() ==
//                                                               'Online Standard QR')
//                                                       ? '|$selectedValue_bank_bno\r$numinvoice\r$Value_newDateD\r${newTotal_QR}\r'
//                                                       : generateQRCode(
//                                                           promptPayID:
//                                                               "$selectedValue_bank_bno",
//                                                           amount: double.parse(
//                                                               (Total == null ||
//                                                                       Total == '')
//                                                                   ? '0'
//                                                                   : '$Total')),
//                                                   barcode: pw.Barcode.qrCode(),
//                                                   width: 55,
//                                                   height: 55),

//                                           //  pw.PrettyQr(
//                                           //   // typeNumber: 3,
//                                           //   image: const AssetImage(
//                                           //     "images/Icon-chao.png",
//                                           //   ),
//                                           //   size: 110,
//                                           //   data: '${teNantModels[index].cid}',
//                                           //   errorCorrectLevel: QrErrorCorrectLevel.M,
//                                           //   roundEdges: true,
//                                           // ),
//                                         ),
//                                         pw.Text(
//                                           'บัญชี : $selectedValue_bank_bno',
//                                           style: pw.TextStyle(
//                                             font: ttf,
//                                             fontSize: font_Size,
//                                             fontWeight: pw.FontWeight.bold,
//                                           ),
//                                         ),
//                                         if (paymentName1.toString().trim() ==
//                                                 'Online Standard QR' ||
//                                             paymentName2.toString().trim() ==
//                                                 'Online Standard QR')
//                                           pw.Text(
//                                             '(Ref1 : $numinvoice , Ref2 : $Value_newDateD)',
//                                             style: pw.TextStyle(
//                                               font: ttf,
//                                               fontSize: font_Size,
//                                               fontWeight: pw.FontWeight.bold,
//                                             ),
//                                           ),
//                                         pw.Text(
//                                           'สำหรับชำระด้วย Mobile Banking',
//                                           style: pw.TextStyle(
//                                             font: ttf,
//                                             fontSize: font_Size,
//                                             fontWeight: pw.FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 pw.Expanded(
//                                   flex: 1,
//                                   child: pw.Container(
//                                     padding: const pw.EdgeInsets.all(4.0),
//                                     child: pw.Column(
//                                       children: [
//                                         pw.Text(
//                                           'คำเตือน',
//                                           textAlign: pw.TextAlign.left,
//                                           style: pw.TextStyle(
//                                               fontSize: font_Size,
//                                               font: ttf,
//                                               color: PdfColors.red,
//                                               fontWeight: pw.FontWeight.bold),
//                                         ),
//                                         pw.SizedBox(
//                                             height: 2 * PdfPageFormat.mm),
//                                         pw.Text(
//                                           'โปรดตรวจสอบความถูกต้องทุกครั้งก่อนทำการชำระเงิน',
//                                           textAlign: pw.TextAlign.left,
//                                           maxLines: 1,
//                                           style: pw.TextStyle(
//                                             fontSize: font_Size,
//                                             font: ttf,
//                                             color: PdfColors.red,
//                                           ),
//                                         ),
//                                         pw.SizedBox(
//                                             height: 2 * PdfPageFormat.mm),
//                                         pw.Text(
//                                           '( หากเกิดข้อผิดพลาดโปรดเก็บหลักฐานการชำระไว้ เพื่อติดต่อเจ้าหน้าที่ )',
//                                           textAlign: pw.TextAlign.center,
//                                           style: pw.TextStyle(
//                                             fontSize: font_Size,
//                                             font: ttf,
//                                             color: PdfColors.red,
//                                           ),
//                                         ),
//                                         pw.SizedBox(
//                                             height: 2 * PdfPageFormat.mm),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                         ],
//                       ))
//                   : pw.Container(
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border.all(color: PdfColors.grey, width: 1),
//                       ),
//                       child: pw.Column(
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Row(
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               children: [
//                                 pw.Expanded(
//                                   flex: 1,
//                                   child: pw.Container(
//                                     padding: const pw.EdgeInsets.all(4.0),
//                                     child: pw.Column(
//                                       children: [
//                                         pw.Text(
//                                           'หมายเหตุ',
//                                           textAlign: pw.TextAlign.center,
//                                           style: pw.TextStyle(
//                                               fontSize: font_Size,
//                                               font: ttf,
//                                               color: Colors_pd,
//                                               fontWeight: pw.FontWeight.bold),
//                                         ),
//                                         pw.SizedBox(
//                                             height: 2 * PdfPageFormat.mm),
//                                         pw.Text(
//                                           '................................................................................................................................................................................',
//                                           textAlign: pw.TextAlign.center,
//                                           // maxLines: 1,
//                                           style: pw.TextStyle(
//                                             fontSize: font_Size,
//                                             font: ttf,
//                                             color: Colors_pd,
//                                           ),
//                                         ),
//                                         pw.SizedBox(
//                                             height: 2 * PdfPageFormat.mm),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 pw.Expanded(
//                                   flex: 1,
//                                   child: pw.Container(
//                                     padding: const pw.EdgeInsets.all(4.0),
//                                     child: pw.Column(
//                                       children: [
//                                         pw.Text(
//                                           'ผู้รับเงิน',
//                                           textAlign: pw.TextAlign.left,
//                                           style: pw.TextStyle(
//                                               fontSize: font_Size,
//                                               font: ttf,
//                                               color: Colors_pd,
//                                               fontWeight: pw.FontWeight.bold),
//                                         ),
//                                         pw.SizedBox(
//                                             height: 2 * PdfPageFormat.mm),
//                                         pw.Text(
//                                           ' (..............................................)',
//                                           textAlign: pw.TextAlign.left,
//                                           maxLines: 1,
//                                           style: pw.TextStyle(
//                                             fontSize: font_Size,
//                                             font: ttf,
//                                             color: Colors_pd,
//                                           ),
//                                         ),
//                                         pw.SizedBox(
//                                             height: 2 * PdfPageFormat.mm),
//                                         pw.Text(
//                                           'วันที่........../........../..........',
//                                           textAlign: pw.TextAlign.center,
//                                           style: pw.TextStyle(
//                                             fontSize: font_Size,
//                                             font: ttf,
//                                             color: Colors_pd,
//                                           ),
//                                         ),
//                                         pw.SizedBox(
//                                             height: 2 * PdfPageFormat.mm),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                         ],
//                       )),
//               pw.SizedBox(height: 3 * PdfPageFormat.mm),
//               pw.Align(
//                 alignment: pw.Alignment.bottomRight,
//                 child: pw.Text(
//                   'หน้า ${context.pageNumber} / ${context.pagesCount} ',
//                   textAlign: pw.TextAlign.left,
//                   style: pw.TextStyle(
//                     fontSize: 10.0,
//                     font: ttf,
//                     color: Colors_pd,
//                     // fontWeight: pw.FontWeight.bold
//                   ),
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//     // final bytes = await pdf.save();

//     // final dir = await getApplicationDocumentsDirectory();
//     // final file = File('${dir.path}/name');
//     // await file.writeAsBytes(bytes);
//     // return file;
//     ///-------------------------------------------------->
//     // final List<int> bytes = await pdf.save();
//     // final Uint8List data = Uint8List.fromList(bytes);
//     // MimeType type = MimeType.PDF;
//     // final dir = await FileSaver.instance.saveFile(
//     //     "ใบเสร็จรับเงิน(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
//     //     data,
//     //     "pdf",
//     //     mimeType: type);
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PreviewPdfgen_Billsplay(
//               doc: pdf, title: 'ใบเสร็จรับเงิน/ใบกำกับภาษี'),
//         ));
//   }
// }
