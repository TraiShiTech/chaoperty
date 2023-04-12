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
import '../PeopleChao/Rental_Information.dart';

class Pdfgen_RentalInforma {
  static void exportPDF_RentalInforma(
      context,
      Get_Value_NameShop_index,
      Get_Value_cid,
      _verticalGroupValue,
      Form_nameshop,
      Form_typeshop,
      Form_bussshop,
      Form_bussscontact,
      Form_address,
      Form_tel,
      Form_email,
      Form_tax,
      Form_ln,
      Form_zn,
      Form_area,
      Form_qty,
      Form_sdate,
      Form_ldate,
      Form_period,
      Form_rtname,
      quotxSelectModels,
      _TransModels,
      renTal_name,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg) async {
    ////
    //// ------------>(ใบเสนอราคา),
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    ///////////////////////------------------------------------------------->
    final tableHeaders = [
      'งวด',
      'รายการ',
      'วันที่',
      'ยอด/งวด',
      'ยอด',
    ];
    double total_ = 0.0;
    // final tableData = [
    for (int index = 0; index < quotxSelectModels.length; index++)
      total_ = total_ +
          (int.parse(quotxSelectModels[index].term!) *
              double.parse(quotxSelectModels[index].total!));
    //     [
    //       '${quotxSelectModels[index].unit} / ${quotxSelectModels[index].term} (งวด)',
    //       '${quotxSelectModels[index].expname}',
    //       '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].ldate!} 00:00:00'))}',
    //       '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
    //       '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
    //     ],
    // ];
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
                            '$renTal_name ',
                            maxLines: 1,
                            style: pw.TextStyle(
                              fontSize: 8,
                              font: ttf,
                              color: PdfColors.grey300,
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
                        '$renTal_name',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 14.0,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        '$bill_addr',
                        maxLines: 3,
                        style: pw.TextStyle(
                          fontSize: 10.0,
                          color: PdfColors.grey800,
                          font: ttf,
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
                      // pw.Text(
                      //   'ใบเสนอราคา',
                      //   style: pw.TextStyle(
                      //     fontSize: 12.00,
                      //     fontWeight: pw.FontWeight.bold,
                      //     font: ttf,
                      //   ),
                      // ),
                      // pw.Text(
                      //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                      //   textAlign: pw.TextAlign.right,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      pw.Text(
                        'โทรศัพท์: $bill_tel',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        'อีเมล: $bill_email',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                        maxLines: 2,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        'ณ วันที่:  $thaiDate ${DateTime.now().year + 543}',
                        maxLines: 2,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // pw.Row(
            //   children: [
            //     pw.Image(
            //       pw.MemoryImage(iconImage),
            //       height: 72,
            //       width: 72,
            //     ),
            //     pw.SizedBox(width: 1 * PdfPageFormat.mm),
            //     pw.Column(
            //       mainAxisSize: pw.MainAxisSize.min,
            //       crossAxisAlignment: pw.CrossAxisAlignment.start,
            //       children: [
            //         pw.Text(
            //           'บริษัทดีเซนทริค จำกัด(Dzentric co., ltd.)',
            //           style: pw.TextStyle(
            //             fontSize: 14.0,
            //             fontWeight: pw.FontWeight.bold,
            //             font: ttf,
            //           ),
            //         ),
            //         pw.Text(
            //           '1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
            //           style: pw.TextStyle(
            //             fontSize: 10.0,
            //             color: PdfColors.grey700,
            //             font: ttf,
            //           ),
            //         ),
            //       ],
            //     ),
            //     pw.Spacer(),
            //     pw.Container(
            //       width: 180,
            //       child: pw.Column(
            //         mainAxisSize: pw.MainAxisSize.min,
            //         crossAxisAlignment: pw.CrossAxisAlignment.end,
            //         children: [
            //           pw.Text(
            //             'ข้อมูลพื้นที่',
            //             textAlign: pw.TextAlign.center,
            //             style: pw.TextStyle(
            //                 fontSize: 11.0,
            //                 fontWeight: pw.FontWeight.bold,
            //                 font: ttf,
            //                 color: PdfColors.black),
            //           ),
            //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
            //           pw.Text(
            //             'รหัสพื้นที่ {NumberArea_}',
            //             textAlign: pw.TextAlign.right,
            //             style: pw.TextStyle(
            //                 fontSize: 10.0, font: ttf, color: PdfColors.black),
            //           ),
            //           pw.Text(
            //             'ณ วันที่: ${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
            //             textAlign: pw.TextAlign.right,
            //             style: pw.TextStyle(
            //                 fontSize: 10.0, font: ttf, color: PdfColors.black),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 4 * PdfPageFormat.mm),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ใบเสนอราคา/สัญญาเช่าพื้นที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 10.0,
                      font: ttf,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black),
                ),
              ],
            ),
            pw.SizedBox(height: 4 * PdfPageFormat.mm),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  'ข้อมูลผู้เช่า',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 10.0,
                      font: ttf,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black),
                ),
              ],
            ),
            pw.Row(children: [
              pw.Expanded(
                flex: 1,
                child: pw.Container(
                  decoration: pw.BoxDecoration(
                      color: PdfColors.green100,
                      border: pw.Border(
                          bottom: pw.BorderSide(
                        color: PdfColors.green900,
                        width: 1.0, // Underline thickness
                      ))),
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'ข้อมูลผู้เช่า',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.green900),
                  ),
                ),
              )
            ]),
            pw.SizedBox(height: 4 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'ประเภท : ',
                    style: pw.TextStyle(
                        fontSize: 9.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$_verticalGroupValue',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    Get_Value_NameShop_index.toString() == '1'
                        ? 'เลขที่ใบสัญญา : '
                        : 'เลขที่ใบเสนอราคา : ',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 9.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Get_Value_cid',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'ชื่อร้าน : ',
                    style: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_nameshop',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'ประเภทร้านค้า :',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_typeshop',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'ชื่อผู้เช่า/บริษัท : ',
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_bussshop',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 8.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'ชื่อผู้ติดต่อ :',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_bussscontact',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'ที่อยู่ : ',
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 6,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_address',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'เบอร์โทร : ',
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_tel',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'อีเมล :',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_email',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'ID/TAX ID : ',
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 6,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_tax',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            // pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.Divider(
            //   height: 1.0,
            //   color: PdfColors.green900,
            // ),
            // pw.SizedBox(height: 4 * PdfPageFormat.mm),
            // pw.Row(children: [
            //   pw.Expanded(
            //     flex: 1,
            //     child: pw.Container(
            //       decoration: pw.BoxDecoration(
            //           color: PdfColors.green100,
            //           border: pw.Border(
            //               bottom: pw.BorderSide(
            //             color: PdfColors.green900,
            //             width: 1.0, // Underline thickness
            //           ))),
            //       padding: const pw.EdgeInsets.all(8.0),
            //       child: pw.Text(
            //         'พื้นที่เช่า ',
            //         textAlign: pw.TextAlign.center,
            //         style: pw.TextStyle(
            //             fontSize: 10.0,
            //             fontWeight: pw.FontWeight.bold,
            //             font: ttf,
            //             color: PdfColors.green900),
            //       ),
            //     ),
            //   )
            // ]),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'รหัสพื้นที่เช่า : ',
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_ln',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'โซนพื้นที่เช่า :',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_zn',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
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
                  child: pw.Text(
                    'รวมพื้นที่เช่า: ',
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_area (ตร.ม.)',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'จำนวนพื้นที่ :',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_qty ',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            // pw.SizedBox(height: 4 * PdfPageFormat.mm),
            // pw.Row(children: [
            //   pw.Expanded(
            //     flex: 1,
            //     child: pw.Container(
            //       decoration: pw.BoxDecoration(
            //           color: PdfColors.green100,
            //           border: pw.Border(
            //               bottom: pw.BorderSide(
            //             color: PdfColors.green900,
            //             width: 1.0, // Underline thickness
            //           ))),
            //       padding: const pw.EdgeInsets.all(8.0),
            //       child: pw.Text(
            //         'ข้อมูลสัญญา/เสนอราคา',
            //         textAlign: pw.TextAlign.center,
            //         style: pw.TextStyle(
            //             fontSize: 10.0,
            //             fontWeight: pw.FontWeight.bold,
            //             font: ttf,
            //             color: PdfColors.green900),
            //       ),
            //     ),
            //   )
            // ]),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'วันที่เริ่มสัญญา/เสนอราคา : ',
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_sdate',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'วันที่สิ้นสุดสัญญา/เสนอราคา :',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_ldate',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'ประเภทการเช่า :',
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_rtname',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'ระยะเวลาการเช่า :',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10.0,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: PdfColors.black),
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: PdfColors.grey200,
                      width: 1.0, // Underline thickness
                    ))),
                    child: pw.Text(
                      '$Form_period',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 9.0,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: PdfColors.grey800),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  'รายละเอียดค่าบริการ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 10.0,
                      font: ttf,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black),
                ),
              ],
            ),
            // pw.SizedBox(height: 5 * PdfPageFormat.mm),
            // pw.Table.fromTextArray(
            //   headers: tableHeaders,
            //   data: tableData,
            //   border: null,
            //   headerStyle: pw.TextStyle(
            //       fontSize: 10.0,
            //       fontWeight: pw.FontWeight.bold,
            //       font: ttf,
            //       color: PdfColors.green900),
            //   headerDecoration: const pw.BoxDecoration(
            //     color: PdfColors.green100,
            //     border: pw.Border(
            //       bottom: pw.BorderSide(color: PdfColors.green900),
            //     ),
            //   ),
            //   cellDecoration: (int rowIndex, dynamic record, int columnIndex) {
            //     return pw.BoxDecoration(
            //       color:
            //           (rowIndex % 2 == 0) ? PdfColors.grey100 : PdfColors.white,
            //       border: const pw.Border(
            //         bottom: pw.BorderSide(color: PdfColors.grey300),
            //       ),
            //     );
            //   },
            //   cellStyle: pw.TextStyle(
            //       fontSize: 8.0, font: ttf, color: PdfColors.black),
            //   cellHeight: 25.0,
            //   cellAlignments: {
            //     0: pw.Alignment.centerLeft,
            //     1: pw.Alignment.center,
            //     2: pw.Alignment.center,
            //     3: pw.Alignment.centerRight,
            //     4: pw.Alignment.centerRight,
            //     5: pw.Alignment.centerRight,
            //     6: pw.Alignment.centerRight,
            //     7: pw.Alignment.centerRight,
            //   },
            // ),
            pw.Container(
              height: 25,
              decoration: const pw.BoxDecoration(
                color: PdfColors.green100,
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.green900),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      // decoration: const pw.BoxDecoration(
                      //   color: PdfColors.grey100,
                      //   border: const pw.Border(
                      //     bottom: pw.BorderSide(color: PdfColors.grey300),
                      //   ),
                      // ),
                      child: pw.Center(
                        child: pw.Text(
                          'งวด',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      // decoration: const pw.BoxDecoration(
                      //   color: PdfColors.white,
                      //   border: const pw.Border(
                      //     bottom: pw.BorderSide(color: PdfColors.grey300),
                      //   ),
                      // ),
                      child: pw.Center(
                        child: pw.Text(
                          'รายการ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      // decoration: const pw.BoxDecoration(
                      //   color: PdfColors.grey100,
                      //   border: const pw.Border(
                      //     bottom: pw.BorderSide(color: PdfColors.grey300),
                      //   ),
                      // ),
                      child: pw.Center(
                        child: pw.Text(
                          'วันที่',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      // decoration: const pw.BoxDecoration(
                      //   color: PdfColors.white,
                      //   border: const pw.Border(
                      //     bottom: pw.BorderSide(color: PdfColors.grey300),
                      //   ),
                      // ),
                      child: pw.Center(
                        child: pw.Text(
                          'ยอด/งวด',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      // decoration: const pw.BoxDecoration(
                      //   color: PdfColors.grey100,
                      //   border: const pw.Border(
                      //     bottom: pw.BorderSide(color: PdfColors.grey300),
                      //   ),
                      // ),
                      child: pw.Center(
                        child: pw.Text(
                          'ยอด',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int index = 0; index < quotxSelectModels.length; index++)
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey100,
                        border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.grey300),
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          '${quotxSelectModels[index].unit} / ${quotxSelectModels[index].term} (งวด)',
                          textAlign: pw.TextAlign.left,
                          maxLines: 2,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              // fontWeight: pw.FontWeight.bold,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        border: const pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.grey300),
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          '${quotxSelectModels[index].expname}',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              // fontWeight: pw.FontWeight.bold,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey100,
                        border: const pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.grey300),
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].ldate!} 00:00:00'))}',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              // fontWeight: pw.FontWeight.bold,
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
                        border: const pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.grey300),
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              // fontWeight: pw.FontWeight.bold,
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
                        color: PdfColors.grey100,
                        border: const pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.grey300),
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              // fontWeight: pw.FontWeight.bold,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    height: 25,
                    // decoration: const pw.BoxDecoration(
                    //   color: PdfColors.grey100,
                    //   border: pw.Border(
                    //     bottom: pw.BorderSide(color: PdfColors.grey300),
                    //   ),
                    // ),
                    child: pw.Center(
                      child: pw.Text(
                        '',
                        textAlign: pw.TextAlign.left,
                        maxLines: 2,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            // fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey800),
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    height: 25,
                    // decoration: const pw.BoxDecoration(
                    //   color: PdfColors.white,
                    //   border: const pw.Border(
                    //     bottom: pw.BorderSide(color: PdfColors.grey300),
                    //   ),
                    // ),
                    child: pw.Center(
                      child: pw.Text(
                        '',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            // fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey800),
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    height: 25,
                    // decoration: const pw.BoxDecoration(
                    //   color: PdfColors.grey100,
                    //   border: const pw.Border(
                    //     bottom: pw.BorderSide(color: PdfColors.grey300),
                    //   ),
                    // ),
                    child: pw.Center(
                      child: pw.Text(
                        '',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            // fontWeight: pw.FontWeight.bold,
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
                      color: PdfColors.grey100,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    ),
                    child: pw.Center(
                      child: pw.Text(
                        'รวม',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black),
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    height: 25,
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey100,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    ),
                    child: pw.Center(
                      child: pw.Text(
                        '${nFormat.format(total_)}',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            // pw.Row(
            //   mainAxisAlignment: pw.MainAxisAlignment.start,
            //   children: [
            //     pw.Text(
            //       'ตารางสรุปรายละเอียดค่าบริการ',
            //       textAlign: pw.TextAlign.left,
            //       style: pw.TextStyle(
            //           fontSize: 10.0,
            //           font: ttf,
            //           fontWeight: pw.FontWeight.bold,
            //           color: PdfColors.black),
            //     ),
            //   ],
            // ),
            // // pw.SizedBox(height: 5 * PdfPageFormat.mm),
            // pw.Container(
            //   decoration: pw.BoxDecoration(
            //       color: PdfColors.green100,
            //       border: pw.Border(
            //           bottom: pw.BorderSide(
            //         color: PdfColors.green900,
            //         width: 1.0, // Underline thickness
            //       ))),
            //   padding: const pw.EdgeInsets.all(8.0),
            //   child: pw.Column(
            //     children: [
            //       pw.Row(
            //         children: [
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'ประเภทค่าบริการ',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //       pw.Row(
            //         children: [
            //           // ('widget.Get_Value_NameShop_index' == '1')
            //           //     ? pw.SizedBox()
            //           //     : pw.Expanded(
            //           //         flex: 1,
            //           //         child: pw.Text(
            //           //           'งวด',
            //           //           textAlign: pw.TextAlign.center,
            //           //           style: pw.TextStyle(
            //           //               fontSize: 8.0,
            //           //               font: ttf,
            //           //               fontWeight: pw.FontWeight.bold,
            //           //               color: PdfColors.black),
            //           //         ),
            //           //       ),
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'วันที่ชำระ',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 8.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //           pw.Expanded(
            //             flex: 2,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'ประเภทค่าบริการ',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'VAT',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'VAT(%)',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'VAT(฿)',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 '',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'WHT (%)',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'WHT (฿)',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //           pw.Expanded(
            //             flex: 1,
            //             child: pw.Center(
            //               child: pw.Text(
            //                 'ยอดสุทธิ',
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //                     fontSize: 10.0,
            //                     font: ttf,
            //                     fontWeight: pw.FontWeight.bold,
            //                     color: PdfColors.green900),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // for (int index = 0; index < _TransModels.length; index++)
            //   pw.Row(
            //     children: [

            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.white,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransModels[index].duedate!} 00:00:00'))}',
            //               textAlign: pw.TextAlign.center,
            //               maxLines: 2,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 2,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.grey100,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${_TransModels[index].name!}',
            //               maxLines: 2,
            //               textAlign: pw.TextAlign.center,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.white,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${_TransModels[index].vtype!}',
            //               maxLines: 2,
            //               textAlign: pw.TextAlign.center,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.grey100,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${_TransModels[index].nvat!} %',
            //               textAlign: pw.TextAlign.center,
            //               maxLines: 2,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.white,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${_TransModels[index].vat!}',
            //               maxLines: 2,
            //               textAlign: pw.TextAlign.center,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.grey100,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${_TransModels[index].pvat!}',
            //               maxLines: 2,
            //               textAlign: pw.TextAlign.center,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.white,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${_TransModels[index].nwht!}',
            //               maxLines: 2,
            //               textAlign: pw.TextAlign.center,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.grey100,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${_TransModels[index].wht!}',
            //               maxLines: 2,
            //               textAlign: pw.TextAlign.center,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Container(
            //           height: 25,
            //           decoration: pw.BoxDecoration(
            //             color: PdfColors.white,
            //             border: const pw.Border(
            //               bottom: pw.BorderSide(color: PdfColors.grey300),
            //             ),
            //           ),
            //           child: pw.Center(
            //             child: pw.Text(
            //               '${nFormat.format(double.parse(_TransModels[index].total!))}',
            //               textAlign: pw.TextAlign.center,
            //               maxLines: 2,
            //               style: pw.TextStyle(
            //                   fontSize: 8.0,
            //                   font: ttf,
            //                   fontWeight: pw.FontWeight.bold,
            //                   color: PdfColors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // pw.SizedBox(height: 5 * PdfPageFormat.mm),
          ];
        },
        footer: (context) {
          return (context.pageNumber != context.pagesCount)
              ? pw.Align(
                  alignment: pw.Alignment.bottomRight,
                  child: pw.Text(
                    'หน้า ${context.pageNumber} / ${context.pagesCount} ',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: 10,
                      font: ttf,
                      color: PdfColors.grey800,
                      // fontWeight: pw.FontWeight.bold
                    ),
                  ),
                )
              : pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    if (context.pageNumber == context.pagesCount)
                      pw.Container(
                          decoration: pw.BoxDecoration(
                            border:
                                pw.Border.all(color: PdfColors.grey, width: 1),
                          ),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 2 * PdfPageFormat.mm),
                              pw.Row(
                                children: [
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Text(
                                      'ลงชื่อ',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          color: PdfColors.black),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Text(
                                      'ลงชื่อ',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          color: PdfColors.black),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 4 * PdfPageFormat.mm),
                              pw.Row(
                                children: [
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Text(
                                      '..........................................',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 10,
                                          font: ttf,
                                          color: PdfColors.grey800),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Text(
                                      '..........................................',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 10,
                                          font: ttf,
                                          color: PdfColors.grey800),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 2 * PdfPageFormat.mm),
                              pw.Row(
                                children: [
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Text(
                                      '(................................)',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          font: ttf,
                                          color: PdfColors.grey800),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Text(
                                      '(................................)',
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          font: ttf,
                                          color: PdfColors.grey800),
                                    ),
                                  ),
                                ],
                              ),

                              pw.SizedBox(height: 2 * PdfPageFormat.mm),
                              pw.Row(
                                children: [
                                  pw.SizedBox(width: 2 * PdfPageFormat.mm),
                                  pw.Text(
                                    'หมายเหตุ',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: PdfColors.black,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 1 * PdfPageFormat.mm),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    '  ............................................................................................................................................................................',
                                    textAlign: pw.TextAlign.left,
                                    maxLines: 1,
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: PdfColors.grey800),
                                  ),
                                ],
                              ),

                              pw.SizedBox(height: 1 * PdfPageFormat.mm),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    '  ............................................................................................................................................................................',
                                    textAlign: pw.TextAlign.left,
                                    maxLines: 1,
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        font: ttf,
                                        color: PdfColors.grey800),
                                  ),
                                ],
                              ),
                              // pw.Bullet(
                              //   text:
                              //       '.................................................................................................................................................................................',
                              //   textAlign: pw.TextAlign.left,
                              //   style: pw.TextStyle(
                              //       fontSize: 10, font: ttf, color: PdfColors.grey800),
                              // ),
                              // pw.Bullet(
                              //   text:
                              //       '..................................................................................................',
                              //   textAlign: pw.TextAlign.left,
                              //   style: pw.TextStyle(
                              //       fontSize: 10, font: ttf, color: PdfColors.grey800),
                              // ),
                              pw.SizedBox(height: 3 * PdfPageFormat.mm),
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
                          color: PdfColors.grey800,
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
    //----------------------------------------->
    // final List<int> bytes = await pdf.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    // final dir = await FileSaver.instance.saveFile(
    //     "ใบเสนอราคา(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreenRentalInforma(doc: pdf),
        ));
  }
}
