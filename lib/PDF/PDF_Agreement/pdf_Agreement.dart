import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../PeopleChao/Rental_Information.dart';
import '../../Style/loadAndCacheImage.dart';

class Pdfgen_Agreement {
//////////---------------------------------------------------->( **** เอกสารสัญญาเช่า ปกติ  )

  static void exportPDF_Agreement(
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
      newValuePDFimg,
      tableData00,
      TitleType_Default_Receipt_Name,
      Datex_text) async {
    ////
    //// ------------>(ใบเสนอราคา)
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;

    final ttf = pw.Font.ttf(font);
    double font_Size = 12.5;
    DateTime date = DateTime.now();
    // var formatter = DateFormat('MMMMd', 'th');
    String thaiDate = DateFormat('d เดือน MMM', 'th').format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    Uint8List? resizedLogo = await getResizedLogo();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int pageCount = 1; // Initialize the page count
    String? base64Image_1 = preferences.getString('base64Image1');
    // String? base64Image_2 = preferences.getString('base64Image2');
    // String? base64Image_3 = preferences.getString('base64Image3');
    // String? base64Image_4 = preferences.getString('base64Image4');
    String base64Image_new1 = (base64Image_1 == null) ? '' : base64Image_1;
    // String base64Image_new2 = (base64Image_2 == null) ? '' : base64Image_2;
    // String base64Image_new3 = (base64Image_3 == null) ? '' : base64Image_3;
    // String base64Image_new4 = (base64Image_4 == null) ? '' : base64Image_4;
    // Uint8List data1 = base64Decode(base64Image_new1);
    // Uint8List data2 = base64Decode(base64Image_new2);
    // Uint8List data3 = base64Decode(base64Image_new3);
    // Uint8List data4 = base64Decode(base64Image_new4);

    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   netImage.add(await networkImage('${newValuePDFimg[i]}'));
    // }
    // final tableData = [
    //   for (int index = 0; index < quotxSelectModels.length; index++)
    //     [
    //       '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
    //     ],
    // ];
    // double Sumtotal = 0;
    // for (int index = 0; index < quotxSelectModels.length; index++)
    //   Sumtotal = Sumtotal +
    //       (int.parse(quotxSelectModels[index].term!) *
    //           double.parse(quotxSelectModels[index].total!));

///////////////////////------------------------------------------------->
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 18.00,
          marginLeft: 18.00,
          marginRight: 18.00,
          marginTop: 18.00,
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
                //         color: PdfColors.grey200,
                //         child: pw.Center(
                //           child: pw.Text(
                //             '$renTal_name ',
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
                //     : pw.Image(
                //         (netImage[0]),
                //         height: 72,
                //         width: 70,
                //       ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Container(
                  width: 280,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '${bill_name.toString().trim()}',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        '${bill_addr.toString().trim()}',
                        maxLines: 3,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          color: Colors_pd,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                        maxLines: 2,
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
                      if (TitleType_Default_Receipt_Name != null &&
                          TitleType_Default_Receipt_Name.toString().trim() !=
                              '')
                        pw.Text(
                          '[ $TitleType_Default_Receipt_Name ]',
                          maxLines: 1,
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey400,
                          ),
                        ),
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
                        'วันที่ทำสัญญา :${Datex_text.text}',
                        // 'วันที่ทำสัญญา :____/________/____',
                        // '${DateFormat('วันที่ทำสัญญา : d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
                        maxLines: 2,
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
            pw.Divider(height: 2),
            // pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
          ]);
        },
        build: (context) {
          return [
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'สัญญาเช่าพื้นที่',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    color: Colors_pd,
                    fontSize: font_Size,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                  ),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Spacer(),
                pw.Container(
                  width: 180,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'เลขที่สัญญา.........$Get_Value_cid................ ',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'ทำที่ $bill_name ',
                        // 'ทำที่ $renTal_name ',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'วันที่ทำสัญญา ............. ',
                      //   style: pw.TextStyle(
                      //     fontSize: font_Size,
                      //     font: ttf,
                      //     color: Colors_pd,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'สัญญาฉบับนี้ทำขึ้นระหว่าง',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 4,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$bill_name",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ที่อยู่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$bill_addr",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            // pw.Text(
            //   'สัญญาฉบับนี้ ทำขึ้นระหว่าง........$bill_name........',
            //   textAlign: pw.TextAlign.justify,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            // pw.Text(
            //   'ที่อยู่........$bill_addr........',
            //   textAlign: pw.TextAlign.justify,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ซึ่งต่อไปในสัญญานี้เรียกว่า “ผู้ให้เช่า” ฝ่ายหนึ่งกับ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_bussshop",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ที่อยู่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_address",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'เลขประจำตัวผู้เสียภาษี ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_tax",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'เบอร์โทรศัพท์ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_tel",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'Email ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_email",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            // pw.Text(
            //   'เบอร์โทรศัพท์.....$Form_tel...........Email........$Form_email................................... ',
            //   textAlign: pw.TextAlign.justify,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Text(
              '        ซึ่งต่อไปในสัญญานี้เรียกว่า “ผู้เช่า” อีกฝ่ายหนึ่ง  ทั้งสองฝ่ายตกลงทำสัญญาดังมีข้อความต่อไปนี้',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            // pw.Text(
            //   '        ทั้งสองฝ่ายตกลงทำสัญญาดังมีข้อความต่อไปนี้',
            //   textAlign: pw.TextAlign.justify,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ข้อ 1. ผู้ให้เช่า ตกลงให้เช่า และ ผู้เช่าตกลงเช่า พื้นที่บางส่วน บริเวณพื้นที่โซน ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_zn",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'รหัสพื้นที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'รหัสพื้นที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 4,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_email",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ล็อค/ห้อง ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Text(
                  'มีเนื้อที่ประมาณ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_area",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ตารางเมตร จำนวนพื้นที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_qty",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ล็อค/ห้อง',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ตั้งอยู่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$bill_addr",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            // pw.Text(
            //   'ตั้งอยู่........$bill_addr........',
            //   textAlign: pw.TextAlign.justify,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //     fontWeight: pw.FontWeight.bold,
            //   ),
            // ),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Text(
              '        ซึ่งต่อไปนี้ในสัญญานี้เรียกว่า “พื้นที่เช่า”',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ข้อ 2. ผู้ให้เช่าตกลงให้ผู้เช่า เช่าพื้นที่เช่า มีกำหนดอายุ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_period",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  (Form_rtname.toString() == 'รายวัน')
                      ? 'วัน '
                      : (Form_rtname.toString() == 'รายเดือน')
                          ? 'เดือน '
                          : (Form_rtname.toString() == 'รายปี')
                              ? 'ปี '
                              : '$Form_rtname ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Text(
                  'เริ่มอายุการเช่าตั้งแต่วันที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_sdate",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'และสิ้นสุดในวันที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_ldate",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'โดยมีวัตถุประสงค์ของการเช่าเพื่อทำธุรกิจ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_typeshop",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'โดยใช้ชื่อธุรกิจว่า ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.1, // Underline thickness
                      ))),
                      child: pw.Text(
                        (Form_nameshop == null ||
                                Form_nameshop.toString() == 'null')
                            ? "$Form_bussshop"
                            : "$Form_nameshop",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 3.  ผู้เช่าจะชำระค่าบริการแก่ผู้ให้เช่า ดังนี้ ',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.Text(
            //   '(ดึงข้อมูลในตาราง “รายละเอียดค่าบริการ” จากหน้า ข้อมูลการเช่ามา ทุกอันยกเว้นเงินประกัน)',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //       fontSize: 10.0, font: ttf, color: PdfColors.black),
            // ),

            pw.Container(
              decoration: const pw.BoxDecoration(
                color: PdfColors.green100,
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.green900),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'งวด',
                          maxLines: 1,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'วันที่',
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
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
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'ยอด/งวด',
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'ยอด',
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int index = 0; index < tableData00.length; index++)
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          '${tableData00[index][0]}',
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
                      height: 25,
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
                    flex: 1,
                    child: pw.Container(
                      height: 25,
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
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
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
                      height: 25,
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
                ],
              ),
            pw.Container(
              height: 5,
              decoration: const pw.BoxDecoration(
                // color: PdfColors.green100,
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.green900),
                ),
              ),
            ),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Text(
              '        โดยผู้ให้เช่าต้องให้การบริการในส่วนที่เก็บค่าบริการอย่างสุจริตและโปร่งใสตามหน้าที่ของผู้ให้เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 4.  ผู้เช่าตกลงวางเงินประกันการเช่า ดังนี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              ' ( หากมีระบุไว้ในข้อ 3 )',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '        ให้แก่ผู้ให้เช่าเพื่อเป็นการประกันการปฏิบัติตามสัญญาเช่าและเป็นประกันความเสียหายใดๆที่อาจเกิดขึ้นแก่พื้นที่เช่าและ/หรือแก่ผู้ให้เช่าเงินประกันการเช่านี้ผู้ให้เช่าจะ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'คืนให้แก่ผู้เช่าในทันทีที่สัญญาเช่าสิ้นสุดลงโดยผู้ให้เช่ามีสิทธิที่จะหักค่าเช่าที่ค้างชำระอยู่และหากเงินประกันการเช่านี้มีจำนวนไม่เพียงพอผู้เช่าสัญญาว่าจะชำระเงินส่วนที่ขาด ให้แก่ผู้ให้เช่าในทันทีที่ได้รับการทวงถาม',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 5.  เมื่อสัญญาเช่าฉบับนี้สิ้นสุดลงตามระยะเวลาดังกล่าวใน ข้อ 2. โดย ผู้เช่ามิได้เคยมีการผิดนัดผิดสัญญาในข้อหนึ่งข้อใดมาก่อนหากผู้เช่าประสงค์จะขอเช่าพื้นที่เช่า นี้ต่อไปอีกต้องดำเนินการแจ้งความประสงค์ดังกล่าวล่วงหน้าเป็นหนังสือก่อนสิ้นสุดระยะเวลาที่ได้ระบุไว้ในสัญญานี้ไม่น้อยกว่า 3 เดือนเมื่อผู้ให้เช่าได้รับหนังสือตามที่ได้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.Text(
              'กล่าวไว้ในวรรคแรกแล้วจะทำการตกลงรายละเอียดอีกครั้งเพื่อจัดทำสัญญาเช่าฉบับใหม่โดยผู้ให้เช่าจะต้องเสนอราคาของการเช่าครั้งใหม่ให้ผู้เช่าก่อนทุกครั้ง',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 6.  ค่าภาษีโรงเรือนและที่ดิน ผู้ให้เช่าจะเป็นผู้ชำระเองทั้งสิ้น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 7.  ผู้ให้เช่ามีหน้าที่ในการจัดหรือแนะนำสถานที่จอดรถและแนวทางการอำนวยการจราจรซึ่งสามารถรวมไปยัง ระบบรักษาความปลอดภัยภายในและภายนอกอาคาร ตลอด 24 ชั่วโมง ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 8.  ผู้เช่ามีหน้าที่ในการดูแลรักษาและซ่อมแซมพื้นที่เช่าเสมอวิญญูชนจะพึงสงวนรักษาทรัพย์สินของตนเองโดยทุนทรัพย์ของผู้เช่าเองเว้นแต่การชำรุดทรุดโทรมที่เกิด ขึ้นตามสภาพของพื้นที่เช่าจนถึงขนาดต้องซ่อมแซมใหญ่ผู้ให้เช่าจึงจะเป็นผู้รับผิดชอบในค่าใช้จ่ายสำหรับการซ่อมแซมนั้นหากผู้เช่าไม่ปฏิบัติหน้าที่ในการดูแลรักษา',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.Text(
              'และซ่อมแซมพื้นที่เช่าตามวรรคแรกและผู้ให้เช่าได้บอกกล่าวแล้วผู้ให้เช่า มีสิทธิจัดการซ่อมแซมเองโดย ผู้เช่า ต้องเป็นผู้ออกค่าใช้จ่ายในการนั้นทั้งสิ้น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 9.  ผู้เช่า จะไม่ทำการดัดแปลง ต่อเติม รื้อถอน หรือเปลี่ยนแปลง พื้นที่เช่า ไม่ว่าจะทั้งหมดหรือเพียงบางส่วนเว้นแต่ จะได้รับความยินยอมเป็นหนังสือจาก ผู้ให้เช่าก่อน หากผู้เช่า ได้กระทำการไปโดยไม่ได้รับความยินยอม ผู้ให้เช่าจะเรียก ให้ผู้เช่าทำพื้นที่เช่าให้กลับสู่สภาพเดิมรวมถึงเรียกให้ชดใช้ในค่าเสียหายอันเกิดจากการดัดแปลง ต่อเติม รื้อถอน หรือเปลี่ยนแปลงนั้นก็ได้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.Text(
              '        บรรดาทรัพย์สิน อุปกรณ์ หรือเครื่องตกแต่งที่มีลักษณะติดตรึงตรากับพื้นที่เช่า ที่ผู้เช่า หรือบริวารนำมาติดตั้ง ไม่ว่าจะโดยได้รับความยินยอมจาก ผู้ให้เช่า หรือไม่ก็ตาม ให้ตกเป็นกรรมสิทธิ์ของผู้ให้เช่าในทันที โดยผู้ให้เช่า ไม่ต้องชดใช้ราคาหรือค่าตอบแทนใด ๆ ทั้งสิ้น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 10.  ผู้เช่า ยินยอมให้ ผู้ให้เช่าหรือตัวแทนของผู้ให้เช่า เข้าตรวจตรา พื้นที่เช่า ได้เป็นครั้งคราวและในระยะเวลาที่เหมาะสมตามสมควร',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 11.  ผู้เช่า จะไม่นำพื้นที่เช่า ไปให้ผู้อื่นเช่าช่วง หรือยินยอมไม่ว่าจะโดยชัดแจ้ง หรือโดยปริยายให้ผู้อื่นใช้ พื้นที่เช่า เว้นแต่จะได้รับความยินยอมเป็นหนังสือจากผู้ให้เช่าก่อน',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 12.  ผู้เช่า สัญญาว่าจะไม่กระทำการใด ๆ ที่เป็นการขัดต่อกฎหมาย หรือศีลธรรมอันดีของประชาชน หรือเป็นการก่อให้เกิดความเดือนร้อนรำคาญแก่บุคคลอื่น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 13.  ถ้าผู้เช่า เลิกสัญญาเช่าก่อนครบกำหนดระยะเวลาตามสัญญานี้ หรือผู้เช่า ผิดนัดผิดสัญญาข้อใดข้อหนึ่งก็ตาม ผู้ให้เช่า มีสิทธิบอกเลิกสัญญาเช่า และทำการริบเงินประกันการเช่าไว้ทั้งหมดได้ทันที',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 14.  เมื่อสัญญาเช่าได้สิ้นสุดลงไม่ว่าจะโดยเหตุใดก็ตาม ผู้เช่า ต้องขนย้ายทรัพย์สินและบริวารออกไปจากพื้นที่เช่า และส่งมอบพื้นที่เช่าคืนให้แก่ผู้ให้เช่าในสภาพที่เรียบร้อย ภายในกำหนดเวลา 15 วันนับแต่วันที่สัญญาสิ้นสุดลง โดย ผู้เช่าจะเรียกร้องค่าขนย้ายหรือค่าใช้จ่ายประการใด ๆ จากผู้ให้เช่า อีกไม่ได้ หากผู้เช่า ไม่ดำเนินการภายในกำหนด ผู้เช่ายินยอมให้ผู้ให้เช่าปรับตามเรตอัตราค่าเช่ารายวันคูณ 2 เท่า ไปจนกว่าจะดำเนินการได้ถูกต้องตามสัญญา',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 15.  ในกรณีที่พื้นที่เช่าถูกเวนคืนตามกฎหมายของทางราชการก่อนครบกำหนดตามสัญญาเช่าหรือเกิดอัคคีภัยหรือวินาศภัยใดๆขึ้นกับพื้นที่เช่าจนเป็นเหตุให้ไม่สามารถ ใช้งานพื้นที่เช่าได้โดยมิใช่สาเหตุที่เกิดจากผู้เช่าแล้วคู่สัญญาทั้งสองฝ่ายตกลงกันให้ถือว่าสัญญาเช่าฉบับนี้เป็นอันระงับสิ้นสุดลงและต่างฝ่ายต่างไม่ติดใจเรียกร้องค่าเสียหาย ประการใดๆต่อกันอีก',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 16.  หากคู่สัญญาฝ่ายใดฝ่ายหนึ่ง ผิดนัดผิดสัญญาข้อใดข้อหนึ่งคู่สัญญาอีกฝ่ายหนึ่งมีสิทธิบอกเลิกสัญญาได้ทันทีและคู่สัญญาฝ่ายที่ผิดยินยอมชดใช้ค่าเสียหายตามที่เกิด ขึ้นจริงนับแต่วันบอกเลิกสัญญาเป็นต้นไป',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
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
    ); // final bytes = await pdf.save();
///////////////////////------------------------------------------------->

    pageCount++;
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 18.00,
        marginLeft: 18.00,
        marginRight: 18.00,
        marginTop: 18.00,
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
              //         color: PdfColors.grey200,
              //         child: pw.Center(
              //           child: pw.Text(
              //             '$renTal_name ',
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
              //     : pw.Image(
              //         (netImage[0]),
              //         height: 72,
              //         width: 70,
              //       ),
              pw.SizedBox(width: 1 * PdfPageFormat.mm),
              pw.Container(
                width: 280,
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${bill_name.toString().trim()}',
                      maxLines: 2,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        color: PdfColors.black,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                    pw.Text(
                      '${bill_addr.toString().trim()}',
                      maxLines: 3,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        color: Colors_pd,
                        font: ttf,
                      ),
                    ),
                    pw.Text(
                      'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                      maxLines: 2,
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
                    if (TitleType_Default_Receipt_Name != null &&
                        TitleType_Default_Receipt_Name.toString().trim() != '')
                      pw.Text(
                        '[ $TitleType_Default_Receipt_Name ]',
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.grey400,
                        ),
                      ),
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
                      'วันที่ทำสัญญา :${Datex_text.text}',
                      // 'วันที่ทำสัญญา :____/________/____',
                      // '${DateFormat('วันที่ทำสัญญา : d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
                      maxLines: 2,
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
          pw.Divider(height: 2),
          // pw.SizedBox(height: 1 * PdfPageFormat.mm),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
        ]);
      },
      build: (context) {
        return [
          pw.SizedBox(height: 30 * PdfPageFormat.mm),
          pw.Text(
            '        สัญญานี้ทำขึ้น 2 ฉบับ มีข้อความตรงกัน คู่สัญญาทั้งสองฝ่ายได้อ่าน และเข้าข้อความในสัญญาฉบับนี้โดยตลอดแล้ว เห็นว่าถูกต้องและตรงตามความประสงค์แล้ว จึงได้ลงลายมือชื่อไว้เป็นหลักฐานต่อหน้าพยาน และเก็บสัญญาไว้ฝ่ายละฉบับ',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: font_Size,
              font: ttf,
              color: Colors_pd,
            ),
          ),
          pw.SizedBox(height: 30 * PdfPageFormat.mm),
          pw.Row(children: [
            pw.Expanded(
                flex: 1,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'ลงชื่อ___________________________ผู้ให้เช่า    ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Text(
                      '(___________________________) ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Text(
                      'วันที่____/________/____',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            pw.SizedBox(width: 5 * PdfPageFormat.mm),
            pw.Expanded(
                flex: 1,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'ลงชื่อ___________________________ผู้เช่า    ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Text(
                      '(___________________________) ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Text(
                      'วันที่____/________/____',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ]),
          pw.SizedBox(height: 20 * PdfPageFormat.mm),
          pw.Row(children: [
            pw.Expanded(
                flex: 1,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'ลงชื่อ___________________________พยาน    ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Text(
                      '(___________________________) ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Text(
                      'วันที่____/________/____',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            pw.SizedBox(width: 5 * PdfPageFormat.mm),
            pw.Expanded(
                flex: 1,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'ลงชื่อ___________________________พยาน    ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Text(
                      '(___________________________) ',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    pw.Text(
                      'วันที่____/________/____',
                      textAlign: pw.TextAlign.justify,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          // pw.SizedBox(height: 50 * PdfPageFormat.mm),
          // pw.Row(children: [
          //   pw.Expanded(
          //       flex: 1,
          //       child: pw.Column(
          //         children: [
          //           pw.Text(
          //             'ลงชื่อ.............................................ผู้ให้เช่า    ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
          //           pw.Text(
          //             '(.......................................................) ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
          //           pw.Text(
          //             'วันที่............/.................../............. ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       )),
          //   pw.SizedBox(width: 5 * PdfPageFormat.mm),
          //   pw.Expanded(
          //       flex: 1,
          //       child: pw.Column(
          //         children: [
          //           pw.Text(
          //             'ลงชื่อ.............................................ผู้เช่า    ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
          //           pw.Text(
          //             '(.......................................................) ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
          //           pw.Text(
          //             'วันที่............/.................../............. ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       )),
          // ]),
          // pw.SizedBox(height: 20 * PdfPageFormat.mm),
          // pw.Row(children: [
          //   pw.Expanded(
          //       flex: 1,
          //       child: pw.Column(
          //         children: [
          //           pw.Text(
          //             'ลงชื่อ.............................................พยาน    ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
          //           pw.Text(
          //             '(.......................................................) ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
          //           pw.Text(
          //             'วันที่............/.................../............. ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       )),
          //   pw.SizedBox(width: 5 * PdfPageFormat.mm),
          //   pw.Expanded(
          //       flex: 1,
          //       child: pw.Column(
          //         children: [
          //           pw.Text(
          //             'ลงชื่อ.............................................พยาน    ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
          //           pw.Text(
          //             '(.......................................................) ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
          //           pw.Text(
          //             'วันที่............/.................../............. ',
          //             textAlign: pw.TextAlign.justify,
          //             style: pw.TextStyle(
          //               color: Colors_pd,
          //               fontSize: font_Size,
          //               font: ttf,
          //               fontWeight: pw.FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       )),
          // ]),
          // pw.SizedBox(height: 2 * PdfPageFormat.mm),
        ];
      },
      footer: (context) {
        return pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
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
    ));
    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/name');
    // await file.writeAsBytes(bytes);
    // return file;
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
          builder: (context) => RentalInforman_Agreement(
            doc: pdf,
            context: context,
            ////////////------------------->
            ///
            Get_Value_NameShop_index: Get_Value_NameShop_index,
            Get_Value_cid: Get_Value_cid,
            verticalGroupValue: _verticalGroupValue,
            Form_nameshop: Form_nameshop,
            Form_typeshop: Form_typeshop,
            Form_bussshop: Form_bussshop,
            Form_bussscontact: Form_bussscontact,
            Form_address: Form_address,
            Form_tel: Form_tel,
            Form_email: Form_email,
            Form_tax: Form_tax,
            Form_ln: Form_ln,
            Form_zn: Form_zn,
            Form_area: Form_area,
            Form_qty: Form_qty,
            Form_sdate: Form_sdate,
            Form_ldate: Form_ldate,
            Form_period: Form_period,
            Form_rtname: Form_rtname,
            quotxSelectModels: quotxSelectModels,
            TransModels: _TransModels,
            renTal_name: renTal_name,
            bill_addr: bill_addr,
            bill_email: bill_email,
            bill_tel: bill_tel,
            bill_tax: bill_tax,
            bill_name: bill_name,
            newValuePDFimg: newValuePDFimg,
          ),
        ));
  }
}



// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../PeopleChao/Rental_Information.dart';

// class Pdfgen_Agreement {
// //////////---------------------------------------------------->( **** เอกสารสัญญาเช่า ปกติ  )

//   static void exportPDF_Agreement(
//       context,
//       Get_Value_NameShop_index,
//       Get_Value_cid,
//       _verticalGroupValue,
//       Form_nameshop,
//       Form_typeshop,
//       Form_bussshop,
//       Form_bussscontact,
//       Form_address,
//       Form_tel,
//       Form_email,
//       Form_tax,
//       Form_ln,
//       Form_zn,
//       Form_area,
//       Form_qty,
//       Form_sdate,
//       Form_ldate,
//       Form_period,
//       Form_rtname,
//       quotxSelectModels,
//       _TransModels,
//       renTal_name,
//       bill_addr,
//       bill_email,
//       bill_tel,
//       bill_tax,
//       bill_name,
//       newValuePDFimg,
//       tableData00,
//       TitleType_Default_Receipt_Name) async {
//     ////
//     //// ------------>(ใบเสนอราคา)
//     ///////
//     final pdf = pw.Document();
//     // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
//     // var dataint = fontData.buffer
//     //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
//     // final PdfFont font = PdfFont.of(pdf, data: dataint);
//     final font = await rootBundle.load("fonts/THSarabunNew.ttf");
//     var Colors_pd = PdfColors.black;

//     final ttf = pw.Font.ttf(font);
//     double font_Size = 12.5;
//     DateTime date = DateTime.now();
//     // var formatter = DateFormat('MMMMd', 'th');
//     String thaiDate = DateFormat('d เดือน MMM', 'th').format(date);
//     var nFormat = NumberFormat("#,##0.00", "en_US");
//     var nFormat2 = NumberFormat("###0.00", "en_US");
//     final iconImage =
//         (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
//     List netImage = [];
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     int pageCount = 1; // Initialize the page count
//     String? base64Image_1 = preferences.getString('base64Image1');
//     // String? base64Image_2 = preferences.getString('base64Image2');
//     // String? base64Image_3 = preferences.getString('base64Image3');
//     // String? base64Image_4 = preferences.getString('base64Image4');
//     String base64Image_new1 = (base64Image_1 == null) ? '' : base64Image_1;
//     // String base64Image_new2 = (base64Image_2 == null) ? '' : base64Image_2;
//     // String base64Image_new3 = (base64Image_3 == null) ? '' : base64Image_3;
//     // String base64Image_new4 = (base64Image_4 == null) ? '' : base64Image_4;
//     // Uint8List data1 = base64Decode(base64Image_new1);
//     // Uint8List data2 = base64Decode(base64Image_new2);
//     // Uint8List data3 = base64Decode(base64Image_new3);
//     // Uint8List data4 = base64Decode(base64Image_new4);

//     for (int i = 0; i < newValuePDFimg.length; i++) {
//       netImage.add(await networkImage('${newValuePDFimg[i]}'));
//     }
//     // final tableData = [
//     //   for (int index = 0; index < quotxSelectModels.length; index++)
//     //     [
//     //       '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
//     //     ],
//     // ];
//     // double Sumtotal = 0;
//     // for (int index = 0; index < quotxSelectModels.length; index++)
//     //   Sumtotal = Sumtotal +
//     //       (int.parse(quotxSelectModels[index].term!) *
//     //           double.parse(quotxSelectModels[index].total!));

// ///////////////////////------------------------------------------------->
//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4.copyWith(
//           marginBottom: 18.00,
//           marginLeft: 18.00,
//           marginRight: 18.00,
//           marginTop: 18.00,
//         ),
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
//                             '$renTal_name ',
//                             maxLines: 1,
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
//                   width: 280,
//                   child: pw.Column(
//                     mainAxisSize: pw.MainAxisSize.min,
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         '${bill_name.toString().trim()}',
//                         maxLines: 2,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           color: PdfColors.black,
//                           fontWeight: pw.FontWeight.bold,
//                           font: ttf,
//                         ),
//                       ),
//                       pw.Text(
//                         '${bill_addr.toString().trim()}',
//                         maxLines: 3,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           color: Colors_pd,
//                           font: ttf,
//                         ),
//                       ),
//                       pw.Text(
//                         'เลขประจำตัวผู้เสียภาษี : $bill_tax',
//                         maxLines: 2,
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
//                       if (TitleType_Default_Receipt_Name != null &&
//                           TitleType_Default_Receipt_Name.toString().trim() !=
//                               '')
//                         pw.Text(
//                           '[ $TitleType_Default_Receipt_Name ]',
//                           maxLines: 1,
//                           style: pw.TextStyle(
//                             fontSize: font_Size,
//                             font: ttf,
//                             color: PdfColors.grey400,
//                           ),
//                         ),
//                       // pw.Text(
//                       //   'ใบเสนอราคา',
//                       //   style: pw.TextStyle(
//                       //     fontSize: 12.00,
//                       //     fontWeight: pw.FontWeight.bold,
//                       //     font: ttf,
//                       //   ),
//                       // ),
//                       // pw.Text(
//                       //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
//                       //   textAlign: pw.TextAlign.right,
//                       //   style: pw.TextStyle(
//                       //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
//                       // ),
//                       pw.Text(
//                         'โทรศัพท์ : $bill_tel',
//                         textAlign: pw.TextAlign.right,
//                         maxLines: 1,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       pw.Text(
//                         'อีเมล : $bill_email',
//                         maxLines: 1,
//                         textAlign: pw.TextAlign.right,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),

//                       pw.Text(
//                         '${DateFormat('วันที่ทำสัญญา : d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
//                         maxLines: 2,
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
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Divider(),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//           ]);
//         },
//         build: (context) {
//           return [
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.center,
//               children: [
//                 pw.Text(
//                   'สัญญาเช่าพื้นที่',
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                     color: Colors_pd,
//                     fontSize: font_Size,
//                     fontWeight: pw.FontWeight.bold,
//                     font: ttf,
//                   ),
//                 ),
//               ],
//             ),
//             pw.Row(
//               children: [
//                 pw.Spacer(),
//                 pw.Container(
//                   width: 180,
//                   child: pw.Column(
//                     mainAxisSize: pw.MainAxisSize.min,
//                     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                     children: [
//                       pw.Text(
//                         'เลขที่สัญญา.........$Get_Value_cid................ ',
//                         textAlign: pw.TextAlign.right,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       pw.Text(
//                         'ทำที่ $renTal_name ',
//                         textAlign: pw.TextAlign.right,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           color: Colors_pd,
//                         ),
//                       ),
//                       // pw.Text(
//                       //   'วันที่ทำสัญญา ............. ',
//                       //   style: pw.TextStyle(
//                       //     fontSize: font_Size,
//                       //     font: ttf,
//                       //     color: Colors_pd,
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 5 * PdfPageFormat.mm),
//             pw.Text(
//               'สัญญาฉบับนี้ ทำขึ้นระหว่าง........$bill_name........',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.Text(
//               'ที่อยู่........$bill_addr........',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ซึ่งต่อไปในสัญญานี้เรียกว่า “ผู้ให้เช่า” ฝ่ายหนึ่งกับ........$Form_bussshop........',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.Text(
//               'ที่อยู่..............$Form_address.................. ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.Text(
//               'เลขประจำตัวผู้เสียภาษี..............$Form_tax.................. ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: font_Size, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'เบอร์โทรศัพท์.....$Form_tel...........Email........$Form_email................................... ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '        ซึ่งต่อไปในสัญญานี้เรียกว่า “ผู้เช่า” อีกฝ่ายหนึ่ง',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.Text(
//               '        ทั้งสองฝ่ายตกลงทำสัญญาดังมีข้อความต่อไปนี้',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 1. ผู้ให้เช่า ตกลงให้เช่า และ ผู้เช่าตกลงเช่า พื้นที่บางส่วน บริเวณพื้นที่โซน....$Form_zn....รหัสพื้นที่....$Form_ln....',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),

//             pw.Text(
//               'มีเนื้อที่ประมาณ....$Form_area....ตารางเมตร จำนวนพื้นที่....$Form_qty....ล็อค/ห้อง',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.Text(
//               'ตั้งอยู่........$bill_addr........',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '        ซึ่งต่อไปนี้ในสัญญานี้เรียกว่า “พื้นที่เช่า”',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),

//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               (Form_rtname.toString() == 'รายวัน')
//                   ? 'ข้อ 2. ผู้ให้เช่าตกลงให้ผู้เช่า เช่าพื้นที่เช่า มีกำหนดอายุ........$Form_period........วัน'
//                   : (Form_rtname.toString() == 'รายเดือน')
//                       ? 'ข้อ 2. ผู้ให้เช่าตกลงให้ผู้เช่า เช่าพื้นที่เช่า มีกำหนดอายุ........$Form_period........เดือน'
//                       : (Form_rtname.toString() == 'รายปี')
//                           ? 'ข้อ 2. ผู้ให้เช่าตกลงให้ผู้เช่า เช่าพื้นที่เช่า มีกำหนดอายุ........$Form_period........ปี'
//                           : 'ข้อ 2. ผู้ให้เช่าตกลงให้ผู้เช่า เช่าพื้นที่เช่า มีกำหนดอายุ........$Form_period........$Form_rtname',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),

//             pw.Text(
//               'เริ่มอายุการเช่าตั้งแต่วันที่........$Form_sdate........และสิ้นสุดในวันที่........$Form_ldate........',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),

//             pw.Text(
//               ' โดยมีวัตถุประสงค์ของการเช่าเพื่อทำธุรกิจ........$Form_typeshop........',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.Text(
//               (Form_nameshop == null || Form_nameshop.toString() == 'null')
//                   ? 'โดยใช้ชื่อธุรกิจว่า........$Form_bussshop........'
//                   : 'โดยใช้ชื่อธุรกิจว่า........$Form_nameshop........',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),

//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 3.  ผู้เช่าจะชำระค่าบริการแก่ผู้ให้เช่า ดังนี้ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             // pw.Text(
//             //   '(ดึงข้อมูลในตาราง “รายละเอียดค่าบริการ” จากหน้า ข้อมูลการเช่ามา ทุกอันยกเว้นเงินประกัน)',
//             //   textAlign: pw.TextAlign.left,
//             //   style: pw.TextStyle(
//             //       fontSize: 10.0, font: ttf, color: PdfColors.black),
//             // ),
//             pw.Container(
//               decoration: const pw.BoxDecoration(
//                 color: PdfColors.green100,
//                 border: pw.Border(
//                   bottom: pw.BorderSide(color: PdfColors.green900),
//                 ),
//               ),
//               child: pw.Row(
//                 children: [
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'งวด',
//                           maxLines: 1,
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: PdfColors.green900),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'วันที่',
//                           textAlign: pw.TextAlign.center,
//                           maxLines: 1,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: PdfColors.green900),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
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
//                               color: PdfColors.green900),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'ยอด/งวด',
//                           textAlign: pw.TextAlign.center,
//                           maxLines: 1,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: PdfColors.green900),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'ยอด',
//                           textAlign: pw.TextAlign.center,
//                           maxLines: 1,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               fontWeight: pw.FontWeight.bold,
//                               font: ttf,
//                               color: PdfColors.green900),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             for (int index = 0; index < tableData00.length; index++)
//               pw.Row(
//                 children: [
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Align(
//                         alignment: pw.Alignment.centerLeft,
//                         child: pw.Text(
//                           '${tableData00[index][0]}',
//                           maxLines: 2,
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               font: ttf,
//                               color: PdfColors.grey800),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Align(
//                         alignment: pw.Alignment.center,
//                         child: pw.Text(
//                           '${tableData00[index][1]}',
//                           maxLines: 2,
//                           textAlign: pw.TextAlign.center,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               font: ttf,
//                               color: PdfColors.grey800),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Align(
//                         alignment: pw.Alignment.centerLeft,
//                         child: pw.Text(
//                           '${tableData00[index][2]}',
//                           maxLines: 2,
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               font: ttf,
//                               color: PdfColors.grey800),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Align(
//                         alignment: pw.Alignment.centerRight,
//                         child: pw.Text(
//                           '${tableData00[index][3]}',
//                           maxLines: 2,
//                           textAlign: pw.TextAlign.right,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               font: ttf,
//                               color: PdfColors.grey800),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.Container(
//                       height: 25,
//                       child: pw.Align(
//                         alignment: pw.Alignment.centerRight,
//                         child: pw.Text(
//                           '${tableData00[index][4]}',
//                           maxLines: 2,
//                           textAlign: pw.TextAlign.right,
//                           style: pw.TextStyle(
//                               fontSize: font_Size,
//                               font: ttf,
//                               color: PdfColors.grey800),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             pw.Container(
//               height: 5,
//               decoration: const pw.BoxDecoration(
//                 // color: PdfColors.green100,
//                 border: pw.Border(
//                   bottom: pw.BorderSide(color: PdfColors.green900),
//                 ),
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '        โดยผู้ให้เช่าต้องให้การบริการในส่วนที่เก็บค่าบริการอย่างสุจริตและโปร่งใสตามหน้าที่ของผู้ให้เช่า',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 4.  ผู้เช่าตกลงวางเงินประกันการเช่า ดังนี้',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               ' ( หากมีระบุไว้ในข้อ 3 )',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '        ให้แก่ผู้ให้เช่าเพื่อเป็นการประกันการปฏิบัติตามสัญญาเช่าและเป็นประกันความเสียหายใดๆที่อาจเกิดขึ้นแก่ พื้นที่เช่าและ/หรือ แก่ผู้ให้เช่า',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.Text(
//               '        เงินประกันการเช่านี้ผู้ให้เช่าจะคืนให้แก่ผู้เช่าในทันทีที่สัญญาเช่าสิ้นสุดลงโดยผู้ให้เช่ามีสิทธิที่จะหักค่าเช่าที่ ค้างชำระอยู่และหากเงินประกันการเช่านี้มีจำนวนไม่เพียงพอ ผู้เช่า สัญญาว่าจะชำระเงินส่วนที่ขาดให้แก่ ผู้ให้เช่า ในทันทีที่ได้รับการทวงถาม',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 5.  เมื่อสัญญาเช่าฉบับนี้สิ้นสุดลงตามระยะเวลาดังกล่าวใน ข้อ 2. โดย ผู้เช่ามิได้เคยมีการผิดนัดผิดสัญญาในข้อหนึ่ง ข้อใดมาก่อนหากผู้เช่าประสงค์จะขอเช่าพื้นที่เช่านี้ต่อไปอีกต้องดำเนินการแจ้งความประสงค์ดังกล่าวล่วงหน้าเป็นหนังสือก่อนสิ้นสุดระยะเวลาที่ได้ระบุไว้ในสัญญานี้ไม่น้อยกว่า 3 เดือน',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.Text(
//               '        เมื่อผู้ให้เช่าได้รับหนังสือตามที่ได้กล่าวไว้ในวรรคแรกแล้วจะทำการตกลงรายละเอียดอีกครั้งเพื่อจัดทำสัญญาเช่า ฉบับใหม่โดยผู้ให้เช่าจะต้องเสนอราคาของการเช่าครั้งใหม่ให้ผู้เช่าก่อนทุกครั้ง',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),

//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 6.  ค่าภาษีโรงเรือนและที่ดิน ผู้ให้เช่าจะเป็นผู้ชำระเองทั้งสิ้น',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 7.  ผู้ให้เช่ามีหน้าที่ในการจัดหรือแนะนำสถานที่จอดรถและแนวทางการอำนวยการจราจรซึ่งสามารถรวมไปยัง ระบบรักษาความปลอดภัยภายในและภายนอกอาคาร ตลอด 24 ชั่วโมง ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 8.  ผู้เช่า มีหน้าที่ในการดูแลรักษาและซ่อมแซม พื้นที่เช่า เสมอวิญญูชนจะพึงสงวนรักษาทรัพย์สินของตนเองโดยทุน ทรัพย์ของผู้เช่าเองเว้นแต่การชำรุดทรุดโทรมที่เกิดขึ้นตามสภาพของพื้นที่เช่าจนถึงขนาดต้องซ่อมแซมใหญ่ ผู้ให้เช่า จึงจะเป็นผู้รับผิดชอบในค่าใช้จ่ายสำหรับการซ่อมแซมนั้น',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.Text(
//               '        หากผู้เช่า ไม่ปฏิบัติหน้าที่ในการดูแลรักษาและซ่อมแซม พื้นที่เช่า ตามวรรคแรก และผู้ให้เช่าได้บอกกล่าวแล้ว ผู้ให้เช่า มีสิทธิจัดการซ่อมแซมเองโดย ผู้เช่า ต้องเป็นผู้ออกค่าใช้จ่ายในการนั้นทั้งสิ้น',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 9.  ผู้เช่า จะไม่ทำการดัดแปลง ต่อเติม รื้อถอน หรือเปลี่ยนแปลง พื้นที่เช่า ไม่ว่าจะทั้งหมดหรือเพียงบางส่วนเว้นแต่ จะได้รับความยินยอมเป็นหนังสือจาก ผู้ให้เช่าก่อน หากผู้เช่า ได้กระทำการไปโดยไม่ได้รับความยินยอม ผู้ให้เช่าจะเรียก ให้ผู้เช่าทำพื้นที่เช่าให้กลับสู่สภาพเดิมรวมถึงเรียกให้ชดใช้ในค่าเสียหายอันเกิดจากการดัดแปลง ต่อเติม รื้อถอน หรือเปลี่ยนแปลงนั้นก็ได้',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.Text(
//               '        บรรดาทรัพย์สิน อุปกรณ์ หรือเครื่องตกแต่งที่มีลักษณะติดตรึงตรากับพื้นที่เช่า ที่ผู้เช่า หรือบริวารนำมาติดตั้ง ไม่ว่าจะโดยได้รับความยินยอมจาก ผู้ให้เช่า หรือไม่ก็ตาม ให้ตกเป็นกรรมสิทธิ์ของผู้ให้เช่าในทันที โดยผู้ให้เช่า ไม่ต้องชดใช้ราคาหรือค่าตอบแทนใด ๆ ทั้งสิ้น',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 10.  ผู้เช่า ยินยอมให้ ผู้ให้เช่าหรือตัวแทนของผู้ให้เช่า เข้าตรวจตรา พื้นที่เช่า ได้เป็นครั้งคราวและในระยะเวลาที่เหมาะสมตามสมควร',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 11.  ผู้เช่า จะไม่นำพื้นที่เช่า ไปให้ผู้อื่นเช่าช่วง หรือยินยอมไม่ว่าจะโดยชัดแจ้ง หรือโดยปริยายให้ผู้อื่นใช้ พื้นที่เช่า เว้นแต่จะได้รับความยินยอมเป็นหนังสือจาก ผู้ให้เช่าก่อน',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),

//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 12.  ผู้เช่า สัญญาว่าจะไม่กระทำการใด ๆ ที่เป็นการขัดต่อกฎหมาย หรือศีลธรรมอันดีของประชาชน หรือเป็นการก่อให้เกิดความเดือนร้อนรำคาญแก่บุคคลอื่น',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),

//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 13.  ถ้าผู้เช่า เลิกสัญญาเช่าก่อนครบกำหนดระยะเวลาตามสัญญานี้ หรือผู้เช่า ผิดนัดผิดสัญญาข้อใดข้อหนึ่งก็ตาม ผู้ให้เช่า มีสิทธิบอกเลิกสัญญาเช่า และทำการริบเงินประกันการเช่าไว้ทั้งหมดได้ทันที',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 14.  เมื่อสัญญาเช่าได้สิ้นสุดลงไม่ว่าจะโดยเหตุใดก็ตาม ผู้เช่า ต้องขนย้ายทรัพย์สินและบริวารออกไปจากพื้นที่เช่า และส่งมอบพื้นที่เช่าคืนให้แก่ ผู้ให้เช่า ในสภาพที่เรียบร้อย ภายในกำหนดเวลา 15 วันนับแต่วันที่สัญญาสิ้นสุดลง โดย ผู้เช่าจะเรียกร้องค่าขนย้ายหรือค่าใช้จ่ายประการใด ๆ จากผู้ให้เช่า อีกไม่ได้ หากผู้เช่า ไม่ดำเนินการภายในกำหนด ผู้เช่ายินยอมให้ผู้ให้เช่าปรับตามเรตอัตราค่าเช่ารายวันคูณ 2 เท่า ไปจนกว่าจะดำเนินการได้ถูกต้องตามสัญญา',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 15.  ในกรณีที่พื้นที่เช่าถูกเวนคืนตามกฎหมายของทางราชการก่อนครบกำหนดตามสัญญาเช่าหรือเกิดอัคคีภัยหรือ วินาศภัยใดๆขึ้นกับพื้นที่เช่าจนเป็นเหตุให้ไม่สามารถใช้งานพื้นที่เช่าได้โดยมิใช่สาเหตุที่เกิดจากผู้เช่าแล้วคู่สัญญาทั้งสอง ฝ่ายตกลงกันให้ถือว่าสัญญาเช่าฉบับนี้เป็นอันระงับสิ้นสุดลงและต่างฝ่ายต่าง ไม่ติดใจเรียกร้องค่าเสียหายประการใด ๆ ต่อกันอีก',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 16.  หากคู่สัญญาฝ่ายใดฝ่ายหนึ่ง ผิดนัดผิดสัญญาข้อใดข้อหนึ่ง คู่สัญญาอีกฝ่ายหนึ่ง มีสิทธิบอกเลิกสัญญาได้ทันที และคู่สัญญาฝ่ายที่ผิดยินยอมชดใช้ค่าเสียหายตามที่เกิดขึ้นจริง นับแต่วันบอกเลิกสัญญาเป็นต้นไป',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),

//             pw.SizedBox(height: 40 * PdfPageFormat.mm),
//             pw.SizedBox(height: 10 * PdfPageFormat.mm),
//             pw.Text(
//               '        สัญญานี้ทำขึ้น 2 ฉบับ มีข้อความตรงกัน คู่สัญญาทั้งสองฝ่ายได้อ่าน และเข้าข้อความในสัญญาฉบับนี้โดยตลอดแล้ว เห็นว่าถูกต้องและตรงตามความประสงค์แล้ว จึงได้ลงลายมือชื่อไว้เป็นหลักฐานต่อหน้าพยาน และเก็บสัญญาไว้ฝ่ายละฉบับ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: font_Size,
//                 font: ttf,
//                 color: Colors_pd,
//               ),
//             ),
//             pw.SizedBox(height: 65 * PdfPageFormat.mm),

//             pw.Row(children: [
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Column(
//                     children: [
//                       pw.Text(
//                         'ลงชื่อ.............................................ผู้ให้เช่า    ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         '(.......................................................) ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         'วันที่............/.................../............. ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )),
//               pw.SizedBox(width: 5 * PdfPageFormat.mm),
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Column(
//                     children: [
//                       pw.Text(
//                         'ลงชื่อ.............................................ผู้เช่า    ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         '(.......................................................) ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         'วันที่............/.................../............. ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )),
//             ]),

//             pw.SizedBox(height: 20 * PdfPageFormat.mm),
//             pw.Row(children: [
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Column(
//                     children: [
//                       pw.Text(
//                         'ลงชื่อ.............................................พยาน    ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         '(.......................................................) ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         'วันที่............/.................../............. ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )),
//               pw.SizedBox(width: 5 * PdfPageFormat.mm),
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Column(
//                     children: [
//                       pw.Text(
//                         'ลงชื่อ.............................................พยาน    ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         '(.......................................................) ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         'วันที่............/.................../............. ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           color: Colors_pd,
//                           fontSize: font_Size,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )),
//             ]),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//           ];
//         },
//         footer: (context) {
//           return pw.Column(
//             mainAxisSize: pw.MainAxisSize.min,
//             children: [
//               pw.Align(
//                 alignment: pw.Alignment.bottomRight,
//                 child: pw.Text(
//                   'หน้า ${context.pageNumber} / ${context.pagesCount} ',
//                   textAlign: pw.TextAlign.left,
//                   style: pw.TextStyle(
//                     fontSize: 10,
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
//     ); // final bytes = await pdf.save();

//     // final dir = await getApplicationDocumentsDirectory();
//     // final file = File('${dir.path}/name');
//     // await file.writeAsBytes(bytes);
//     // return file;
//     // final List<int> bytes = await pdf.save();
//     // final Uint8List data = Uint8List.fromList(bytes);
//     // MimeType type = MimeType.PDF;
//     // final dir = await FileSaver.instance.saveFile(
//     //     "ใบเสนอราคา(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
//     //     data,
//     //     "pdf",
//     //     mimeType: type);

//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RentalInforman_Agreement(
//             doc: pdf,
//             context: context,
//             ////////////------------------->
//             ///
//             Get_Value_NameShop_index: Get_Value_NameShop_index,
//             Get_Value_cid: Get_Value_cid,
//             verticalGroupValue: _verticalGroupValue,
//             Form_nameshop: Form_nameshop,
//             Form_typeshop: Form_typeshop,
//             Form_bussshop: Form_bussshop,
//             Form_bussscontact: Form_bussscontact,
//             Form_address: Form_address,
//             Form_tel: Form_tel,
//             Form_email: Form_email,
//             Form_tax: Form_tax,
//             Form_ln: Form_ln,
//             Form_zn: Form_zn,
//             Form_area: Form_area,
//             Form_qty: Form_qty,
//             Form_sdate: Form_sdate,
//             Form_ldate: Form_ldate,
//             Form_period: Form_period,
//             Form_rtname: Form_rtname,
//             quotxSelectModels: quotxSelectModels,
//             TransModels: _TransModels,
//             renTal_name: renTal_name,
//             bill_addr: bill_addr,
//             bill_email: bill_email,
//             bill_tel: bill_tel,
//             bill_tax: bill_tax,
//             bill_name: bill_name,
//             newValuePDFimg: newValuePDFimg,
//           ),
//         ));
//   }
// }
