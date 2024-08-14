import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import '../../../Constant/Myconstant.dart';
import '../../../PeopleChao/Rental_Information.dart';
import '../../../Style/ThaiBaht.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../Style/loadAndCacheImage.dart';

class Pdfgen_Agreement_Ama1000 {
//////////---------------------------------------------------->( **** เอกสารสัญญาเช่า ปกติ  Ama1000)

  static void exportPDF_Agreement_Ama1000(
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
      map,
      logo,
      newValuePDFimg,
      tableData00,
      TitleType_Default_Receipt_Name,
      Datex_text,
      FormNameFile_text) async {
    ////
    //// ------------>(J Space Sansai)
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;
    var Colors_pd2 = PdfColors.grey;
    final ttf = pw.Font.ttf(font);
    double font_Size = 12.5;
    int space_ = 12;
    double space_s = 30.00;
    int space_sub = 5;
    DateTime date = DateTime.now();
    // var formatter = DateFormat('MMMMd', 'th');
    String thaiDate = DateFormat('d เดือน MMM', 'th').format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
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
    // netImage = newValuePDFimg;
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   netImage.add(await networkImage('${newValuePDFimg[i]}'));
    // }
    final imageBytes_map = await getResizedMap(map);
    // final imageBytes_logo = await loadAndCacheImage2(
    //     'https://race.nstru.ac.th/home_ex/blog/pic/cover/s9662.jpg');
    Uint8List? resizedLogo = await getResizedLogo();
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
    String Howday = (Form_rtname.toString() == 'รายวัน')
        ? 'วัน'
        : (Form_rtname.toString() == 'รายเดือน')
            ? 'เดือน'
            : (Form_rtname.toString() == 'รายปี')
                ? 'ปี'
                : '$Form_rtname';
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
          return pw.Column(
            children: [
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
                  // (imageBytes_logo.isEmpty)
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
                  //         pw.MemoryImage(imageBytes_logo),
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
                        // pw.Text(
                        //   'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                        //   maxLines: 2,
                        //   style: pw.TextStyle(
                        //     fontSize: font_Size,
                        //     font: ttf,
                        //     color: Colors_pd,
                        //   ),
                        // ),
                        // pw.Text(
                        //   'เลขที่สัญญา :${Get_Value_cid}',
                        //   // '${DateFormat('ณ วันที่: d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
                        //   maxLines: 2,
                        //   style: pw.TextStyle(
                        //     fontSize: font_Size,
                        //     font: ttf,
                        //     color: Colors_pd,
                        //   ),
                        // ),
                        // pw.Text(
                        //   'วันที่ทำสัญญา :${Datex_text.text}',
                        //   // '${DateFormat('ณ วันที่: d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
                        //   maxLines: 2,
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
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Divider(height: 2),
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
            ],
          );
        },
        build: (context) {
          return [
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
                        'ทำที่ $bill_addr',
                        // 'ทำที่ $renTal_name ',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'เลขที่สัญญา :${Get_Value_cid}',
                        // '${DateFormat('ณ วันที่: d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'วันที่ทำสัญญา :${Datex_text.text}',
                        // '${DateFormat('ณ วันที่: d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
                        maxLines: 2,
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
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'สัญญาเช่าพื้นที่ฉบับนี้ทำขึ้นระหว่าง',
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
                  'สำนักงานตั้งอยู่ที่ ',
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
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ต่อไปในสัญญานี้เรียกว่า "ผู้ให้เช่า" ฝ่ายหนึ่ง กับ ',
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
                  'ถือบัตรประชาชนเลขที่ ',
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
                        width: 0.3, // Underline thickness
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
                    flex: 4,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
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
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ต่อไปในสัญญานี้เรียกว่า "ผู้เช่า" อีกฝ่ายหนึ่ง ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'โดยผู้เช่าประสงค์เช่าพื้นที่บางส่วนและรับบริการ ในโครงการ “ตลาดอาม่า1,000 สุข” ต่อไปในสัญญานี้จะเรียกว่า “ตลาด” ',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.Row(
              children: [
                pw.Text(
                  'เพื่อเป็นสถานที่ประกอบการค้าประเภท ',
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
                  'โดยใช้ชื่อร้านค้าว่า ',
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
                            ? " $Form_bussshop "
                            : " $Form_nameshop ",
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
              'คู่สัญญาทั้งสองฝ่ายตกลงทำสัญญาฉบับนี้ เพื่อกำหนดข้อตกลงเกี่ยวกับการเช่าและการรับบริการ มีรายละเอียดดังนี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '1.	การเช่าพื้นที่ หรือสถานที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              ' ' * space_ +
                  '1.1	ผู้ให้เช่าตกลงให้เช่าและผู้เช่าตกลงเช่าพื้นที่บางส่วนของ “ตลาด” รายละเอียดพื้นที่ หรือ สถานที่เช่าปรากฏตามตำแหน่งที่ทำเครื่องหมายไว้ในแผนผัง',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.Text(
              ' ' * space_ +
                  'สถานที่เช่าใน “เอกสารแนบท้ายสัญญา หมายเลข 1” และให้ถือเป็นส่วนหนึ่งของสัญญาฉบับนี้ ต่อไปนี้ในสัญญานี้เรียกว่า “สถานที่เช่า”',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              ' ' * space_ + '1.2	$bill_addr ',
              textAlign: pw.TextAlign.left,
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
                  ' ' * space_ + '1.3	ล๊อค/ห้องเลขที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Container(
                  width: 400,
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(
                    color: Colors_pd,
                    width: 0.3, // Underline thickness
                  ))),
                  child: pw.Text(
                    "$Form_ln",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      color: Colors_pd,
                      fontSize: font_Size,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                    ),
                  ),
                )
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  ' ' * space_ + '1.4	จำนวนรวม ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Container(
                  width: 150,
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(
                    color: Colors_pd,
                    width: 0.3, // Underline thickness
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
                ),
                pw.Text(
                  'ล๊อค/ห้อง ขนาดพื้นที่เช่ารวม',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Container(
                  width: 150,
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(
                    color: Colors_pd,
                    width: 0.3, // Underline thickness
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
                ),
                pw.Text(
                  ' ตร.ม.',
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
                  ' ' * space_ + '1.5	ระยะเวลาการเช่า',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Container(
                  width: 80,
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(
                    color: Colors_pd,
                    width: 0.3, // Underline thickness
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
                ),
                pw.Text(
                  (Form_rtname.toString() == 'รายวัน')
                      ? 'วัน ตั้งแต่วันที่ '
                      : (Form_rtname.toString() == 'รายเดือน')
                          ? 'เดือน ตั้งแต่วันที่ '
                          : (Form_rtname.toString() == 'รายปี')
                              ? 'ปี ตั้งแต่วันที่'
                              : '$Form_rtname ตั้งแต่วันที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Container(
                  width: 150,
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(
                    color: Colors_pd,
                    width: 0.3, // Underline thickness
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
                ),
                pw.Text(
                  ' ถึง',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Container(
                  width: 150,
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(
                    color: Colors_pd,
                    width: 0.3, // Underline thickness
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
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.Text(
            //   '1.5	ระยะเวลาการเช่า________ เดือน  ตั้งแต่วันที่______________ ถึง________________',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.Text(
              ' ' * space_ +
                  '1.6	หากผู้เช่าประสงค์จะเช่าสถานที่เช่าต่อไปหลังจากระยะเวลาการเช่าตามสัญญานี้สิ้นสุดลง ผู้เช่าจะต้องแจ้งผู้ให้เช่าทราบเป็นลายลักษณ์อักษร',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.Text(
              ' ' * space_ +
                  'ไม่น้อยกว่า 60 (หกสิบ) วัน ก่อนวันสิ้นสุดระยะเวลาการเช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '2.	อัตราค่าเช่า และค่าบริการ',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),

            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '2.1	อัตราค่าเช่าล่วงหน้า ตามตารางข้อ 2.6 (ยกเว้นภาษีมูลค่าเพิ่ม)',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '2.2	อัตราค่าบริการล่วงหน้า ตามตารางข้อ 2.6 (รวมภาษีมูลค่าเพิ่มแล้ว)',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '2.3	ค่าส่วนกลางรายปี ตามารางข้อ 2.6 (รวมภาษีมูลค่าเพิ่มแล้ว)',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '2.4	อัตราค่าน้ำปะปา ตามอัตราที่บริษัทกำหนด (ทางตลาดขอสงวนสิทธิ์ในการปรับราคาในระหว่างสัญญา)',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '2.5	อัตราค่าไฟ ตามอัตราที่บริษัทกำหนด (ทางตลาดขอสงวนสิทธิ์ในการปรับราคาในระหว่างสัญญา)',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ])),
            pw.SizedBox(height: 35 * PdfPageFormat.mm),
            pw.Text(
              '2.6 ตาราง อัตราค่าเช่า-ค่าบริการของผู้เช่า ตลอดอายุสัญญา',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Container(
              decoration: const pw.BoxDecoration(
                color: PdfColors.green100,
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.green900),
                ),
              ),
              padding: pw.EdgeInsets.all(2),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 20,
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
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      height: 20,
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
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 20,
                      child: pw.Text(
                        'รายการ',
                        textAlign: pw.TextAlign.left,
                        maxLines: 1,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.green900),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 20,
                      child: pw.Text(
                        'ยอด/งวด',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.green900),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 20,
                      child: pw.Text(
                        'ยอด',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.green900),
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
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '3.	การชำระค่าเช่า ค่าบริการ ค่าสาธารณูปโภค และภาษีต่างๆ',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              ' ' * space_ +
                  '3.1	ผู้ให้เช่าจะออกใบแจ้งหนี้ภายในวันที่ 5 ของทุกเดือน และผู้เช่าตกลงชำระค่าเช่า ค่าบริการ ค่าสาธารณูปโภค ให้แก่ผู้ให้เช่าเป็นรายเดือนไม่เกินวันที่ 10 ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              ' ' * space_ +
                  'ของทุกเดือน หรือภายในวันที่ผู้ให้เช่าระบุไว้ในใบแจ้งหนี้',
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
              ' ' * space_ +
                  '3.2	ผู้เช่าตกลงที่จะชำระค่าเช่า และค่าบริการในข้อ 2 ผ่านบัญชี ธนาคารกรุงเทพ เลขบัญชี 199-5-63966-1 สาขา ถนนเทพารักษ์ สมุทรปราการ ชื่อบัญชี',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              ' ' * space_ +
                  'บจ.อาม่า1000สุข เท่านั้นหากผู้เช่าไม่ได้ทำการชำระผ่านบัญชีที่กำหนดไว้ทางผู้ให้เช่าขอสงวนสิทธิ์ที่จะไม่รับผิดชอบในกรณีที่ตรวจสอบไม่พบยอดชำระนั้นๆ',
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
              ' ' * space_ +
                  '3.3	หากผู้เช่าไม่ชำระค่าเช่า,ค่าบริการ และ/หรือเงินใดๆ ที่มีหน้าที่ต้องชำระแก่ผู้ให้เช่าภายในกำหนดเวลาหรือชำระไม่ครบถ้วน ผู้ให้เช่ามีสิทธิ์',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              ' ' * space_ +
                  'เรียกเก็บค่าปรับเป็นจำนวน 200 บาท (สองร้อยบาทถ้วน) ต่อวันต่อล๊อค และ/หรือ ผู้ให้เช่าอาจริบเงินประกันตามสัญญานี้ เพื่อชำระค่าเช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              ' ' * space_ +
                  'และ/หรือค่าใช้จ่ายใดๆที่ชำระตามสัญญานี้ได้โดยไม่ต้องแจ้งให้ทราบก่อนและ/หรือผู้ให้เช่าอาจใช้สิทธิบอกเลิกสัญญานี้ได้หากผู้เช่าไม่ชำระเงิน',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              ' ' * space_ + 'ตามกำหนดกติกาที่ระบุไว้ในสัญญานี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                // ' ' * space_ +
                '3.4	ค่าโทรศัพท์และค่าอินเทอร์เน็ต การติดตั้งระบบโทรศัพท์และอินเทอร์เน็ตภายในสถานที่เช่า ผู้เช่าจะต้องติดตั้งและชำระค่าบริการ\nต่อหน่วยงานที่รับผิดชอบโดยตรงด้วยตนเอง และต้องได้รับอนุญาตจากตลาดก่อน',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                // ' ' * space_ +
                '3.5	ค่าภาษีป้าย ค่าภาษีป้ายเฉพาะในส่วนของอาคาร สถานที่ ที่ผู้เช่าได้ใช้ประกอบกิจการ ผู้เช่าตกลงเป็นผู้ยืนแบบแสดงรายการเสียภาษีและชำระค่าภาษี\nต่อหน่วยงานที่รับผิดชอบเอง และต้องได้รับอนุญาตจากตลาดก่อน',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),

            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                // ' ' * space_ +
                '3.6	ค่าภาษีที่ดินและสิ่งปลูกสร้าง ผู้ให้เช่าตกลงว่า จะส่งแบบประเมินภาษีของที่ดินที่เช่า ที่ได้รับจากหน่วยงานราชการที่รับผิดชอบ ให้แก่ผู้เช่า \nและผู้เช่าตกลงว่า จะเป็นผู้ชำระค่าภาษีที่ดินและสถานที่เช่า ภายในกำหนดระยะเวลาที่ปรากฏในแบบประเมินภาษี',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '3.7	ค่าอากรแสตมป์ คู่สัญญาทั้งสองฝ่ายตกลงให้ผู้เช่าเป็นผู้ยื่นแบบและชำระค่าอากรแสตมป์ต่อหน่วยงานราชการที่รับผิดชอบหรือปิดอากรแสตมป์\nตามหลักเกณฑ์ที่กฎหมายกำหนดด้วยตัวเอง',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '4.	เงินประกันการปฏิบัติตามสัญญาเช่า',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      // pw.Row(
                      //   children: [
                      //     pw.Text(
                      //       '4.1	ผู้เช่าตกลงวางเงินประกันการเช่า 1 เดือน ',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //     pw.Container(
                      //       width: 120,
                      //       height: 18,
                      //       decoration: pw.BoxDecoration(
                      //           border: pw.Border(
                      //               bottom: pw.BorderSide(
                      //         color: Colors_pd,
                      //         width: 0.3, // Underline thickness
                      //       ))),
                      //       child: pw.Text(
                      //         " ",
                      //         textAlign: pw.TextAlign.center,
                      //         style: pw.TextStyle(
                      //           color: Colors_pd,
                      //           fontSize: font_Size,
                      //           fontWeight: pw.FontWeight.bold,
                      //           font: ttf,
                      //         ),
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       'บาท (',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //     pw.Expanded(
                      //       flex: 1,
                      //       child: pw.Container(
                      //         height: 18,
                      //         decoration: pw.BoxDecoration(
                      //             border: pw.Border(
                      //                 bottom: pw.BorderSide(
                      //           color: Colors_pd,
                      //           width: 0.3, // Underline thickness
                      //         ))),
                      //         child: pw.Text(
                      //           " ",
                      //           textAlign: pw.TextAlign.center,
                      //           style: pw.TextStyle(
                      //             color: Colors_pd,
                      //             fontSize: font_Size,
                      //             fontWeight: pw.FontWeight.bold,
                      //             font: ttf,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       ')',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '4.1	ผู้เช่าตกลงวางเงินประกันการเช่า 1 เดือนให้แก่ผู้ให้เช่าภายใน 7 วันนับจากวันทำสัญญาฉบับนี้ โดยสัญญานี้จะมีผลผูกพันผู้ให้เช่าก็ต่อเมื่อ\nผู้ให้เช่าได้รับชำระเงินประกันข้างต้นครบถ้วน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      // pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      // pw.Row(
                      //   children: [
                      //     pw.Text(
                      //       '4.2	ผู้เช่าตกลงวางเงินประกันค่าบริการ เป็นเงิน ',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //     pw.Container(
                      //       width: 120,
                      //       height: 18,
                      //       decoration: pw.BoxDecoration(
                      //           border: pw.Border(
                      //               bottom: pw.BorderSide(
                      //         color: Colors_pd,
                      //         width: 0.3, // Underline thickness
                      //       ))),
                      //       child: pw.Text(
                      //         " ",
                      //         textAlign: pw.TextAlign.center,
                      //         style: pw.TextStyle(
                      //           color: Colors_pd,
                      //           fontSize: font_Size,
                      //           fontWeight: pw.FontWeight.bold,
                      //           font: ttf,
                      //         ),
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       'บาท (',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //     pw.Expanded(
                      //       flex: 1,
                      //       child: pw.Container(
                      //         height: 18,
                      //         decoration: pw.BoxDecoration(
                      //             border: pw.Border(
                      //                 bottom: pw.BorderSide(
                      //           color: Colors_pd,
                      //           width: 0.3, // Underline thickness
                      //         ))),
                      //         child: pw.Text(
                      //           " ",
                      //           textAlign: pw.TextAlign.center,
                      //           style: pw.TextStyle(
                      //             color: Colors_pd,
                      //             fontSize: font_Size,
                      //             fontWeight: pw.FontWeight.bold,
                      //             font: ttf,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       ')',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '4.2	ผู้เช่าตกลงวางเงินประกันค่าบริการ 1  เดือน (รวม ภาษีมูลค่าเพิ่มแล้ว) ให้แก่ผู้ให้เช่าภายใน7 วันนับจากวันทำสัญญาฉบับนี้โดยสัญญานี้จะมีผลผูกพันผู้ให้เช่าก็ต่อเมื่อ \nผู้ให้เช่าได้รับชำระเงินประกันข้างต้นครบถ้วน',
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
                        '4.3	ผู้เช่าตกลงวางเงินประกันมิเตอร์ไฟ เป็นจำนวนเงิน ตามตางรางข้อ 2.6 ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Row(
                      //   children: [
                      //     pw.Text(
                      //       '4.3	ผู้เช่าตกลงวางเงินประกันมิเตอร์ไฟ เป็นจำนวนเงิน ตามตางรางข้อ 2.6 ',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //     pw.Container(
                      //       width: 120,
                      //       height: 18,
                      //       decoration: pw.BoxDecoration(
                      //           border: pw.Border(
                      //               bottom: pw.BorderSide(
                      //         color: Colors_pd,
                      //         width: 0.3, // Underline thickness
                      //       ))),
                      //       child: pw.Text(
                      //         " 500.00 ",
                      //         textAlign: pw.TextAlign.center,
                      //         style: pw.TextStyle(
                      //           color: Colors_pd,
                      //           fontSize: font_Size,
                      //           fontWeight: pw.FontWeight.bold,
                      //           font: ttf,
                      //         ),
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       'บาท (',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //     pw.Container(
                      //       height: 18,
                      //       decoration: pw.BoxDecoration(
                      //           border: pw.Border(
                      //               bottom: pw.BorderSide(
                      //         color: Colors_pd,
                      //         width: 0.3, // Underline thickness
                      //       ))),
                      //       child: pw.Text(
                      //         " ห้าร้อยบาทถ้วน ",
                      //         textAlign: pw.TextAlign.center,
                      //         style: pw.TextStyle(
                      //           color: Colors_pd,
                      //           fontSize: font_Size,
                      //           fontWeight: pw.FontWeight.bold,
                      //           font: ttf,
                      //         ),
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       ')',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '4.4	ผู้เช่าตกลงวางเงินประกันมิเตอร์น้ำ เป็นจำนวนเงิน ตามตางรางข้อ 2.6 ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Row(
                      //   children: [
                      //     pw.Text(
                      //       '4.4	ผู้เช่าตกลงวางเงินประกันมิเตอร์ เป็นเงิน ',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //     pw.Container(
                      //       width: 120,
                      //       height: 18,
                      //       decoration: pw.BoxDecoration(
                      //           border: pw.Border(
                      //               bottom: pw.BorderSide(
                      //         color: Colors_pd,
                      //         width: 0.3, // Underline thickness
                      //       ))),
                      //       child: pw.Text(
                      //         " 500.00 ",
                      //         textAlign: pw.TextAlign.center,
                      //         style: pw.TextStyle(
                      //           color: Colors_pd,
                      //           fontSize: font_Size,
                      //           fontWeight: pw.FontWeight.bold,
                      //           font: ttf,
                      //         ),
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       'บาท (',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //     pw.Container(
                      //       height: 18,
                      //       decoration: pw.BoxDecoration(
                      //           border: pw.Border(
                      //               bottom: pw.BorderSide(
                      //         color: Colors_pd,
                      //         width: 0.3, // Underline thickness
                      //       ))),
                      //       child: pw.Text(
                      //         " ห้าร้อยบาทถ้วน ",
                      //         textAlign: pw.TextAlign.center,
                      //         style: pw.TextStyle(
                      //           color: Colors_pd,
                      //           fontSize: font_Size,
                      //           fontWeight: pw.FontWeight.bold,
                      //           font: ttf,
                      //         ),
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       ')',
                      //       textAlign: pw.TextAlign.left,
                      //       style: pw.TextStyle(
                      //         fontSize: font_Size,
                      //         font: ttf,
                      //         color: Colors_pd,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ])),

            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        '4.5	กรณีที่สัญญานี้สิ้นสุดลงอันเนื่องมาจากความผิดของผู้เช่า ผู้เช่าตกลงให้ผู้ให้เช่ายึดเงินประกันข้างต้นเป็นส่วนหนึ่งของค่าเสียหายที่ผู้ให้เช่าพึงได้รับ\nจากผู้เช่า นอกจากนี้ผู้ให้เช่าขอสงวนสิทธิ์ที่จะเรียกค่าเสียหายอื่นใดที่เกิดขึ้น (หากมี) จากกรณีผิดสัญญานี้ได้อีกด้วย',
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
                        '4.6	ผู้ให้เช่าจะคืนเงินประกันตามสัญญานี้ให้แก่ผู้เช่าโดยไม่มีดอกเบี้ยภายหลังเมื่อสัญญาเช่าสิ้นสุดลงภายใต้เงื่อนไขดังต่อไปนี้',
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
                        ' ' * space_sub +
                            '4.6.1	การสิ้นสุดหรือการระงับลงของสัญญานี้มิใช่เป็นผลมาจากความผิดของผู้เช่า',
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
                        ' ' * space_sub +
                            '4.6.2	ผู้เช่าได้ขนย้ายทรัพย์สินและบริวารออกจากสถานที่เช่าและส่งมอบสถานที่เช่าคืนแก่ผู้ให้เช่าในสภาพที่เรียบร้อยภายในวันสิ้นสุดระยะเวลาการเช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        ' ' * space_sub +
                            'หรือวันอื่นตามที่ผู้ให้เช่าจะให้ความเห็นชอบ',
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
                        ' ' * space_sub +
                            '4.6.3	ผู้เช่าปฏิบัติตามกติกาในสัญญาฉบับนี้อย่างถูกต้อง',
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
                        '4.7	ในกรณีผู้เช่ามิได้ติดค้างชำระค่าเช่า ค่าเสียหาย หนี้สิน หรือเงินอื่นใดตามสัญญาเช่าฉบับนี้แก่ผู้ให้เช่า ทั้งนี้ การคืนเงินประกันให้แก่ผู้เช่านั้น ผู้ให้เช่าตกลงคืนให้ภายในกำหนดระยะเวลา 30 (สามสิบ) วัน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ])),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '5.	การรับมอบสถานที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        '5.1	ผู้ให้เช่าจะส่งมอบสถานที่เช่าให้แก่ผู้เช่า และผู้เช่าจะมีสิทธิในการใช้และเข้าครอบครองสถานที่เช่าได้โดยสมบูรณ์ ก็ต่อเมื่อผู้เช่าได้ชำระเงินค่าเช่า\nล่วงหน้าของเดือนแรกตามข้อ 3 และเงินประกันตามข้อ 4 ให้แก่ผู้ให้เช่าครบถ้วนเรียบร้อยแล้วและผู้เช่าได้ตรวจรับมอบสถานที่เช่าและยอมรับว่า\nสถานที่เช่าอยู่ในสภาพเรียบร้อยดีทุกประการจากผู้ให้เช่า',
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
                        '5.2	หรือภายในวันที่________________________________________',
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
                        '5.3	ผู้เช่าจะต้องดูแลบำรุงรักษา ซ่อมแซมสถานที่เช่าให้อยู่ในสภาพที่ดีตามสภาพการใช้งานตามปกติตลอดอายุสัญญานี้ ด้วยค่าใช้จ่ายของผู้เช่าเอง หากสถานที่เช่าหรือวัสดุอุปกรณ์ภายในสถานที่เช่า หรือที่เกี่ยวข้องกับสถานที่เช่าเกิดชำรุด เสียหาย อันเนื่องมาจากการกระทำของผู้เช่า บริวาร ลูกค้า หรือผู้ที่มาใช้บริการของผู้เช่า และผู้เช่ามิได้จัดการแก้ไขซ่อมแซม หรือจัดหามาแทนในเวลาอันควร ผู้ให้เช่ามีสิทธิเข้าซ่อมแซมหรือจัดหามาแทนได้ โดยผู้เช่าจะต้องชดใช้ราคาทั้งหมดแก่ผู้ให้เช่า เมื่อทวงถาม หากผู้เช่าไม่ชำระ ผู้เช่าตกลงให้ผู้ให้เช่ามีสิทธิจะใช้วิธีการเรียกเก็บเพิ่มจากอัตราค่าเช่า\nที่กำหนดไว้ในสัญญานี้ อีกร้อยละ 10 (สิบ) ในเดือนถัดจากเดือนที่ทวงถาม เพื่อเป็นค่าใช้จ่ายของผู้ให้เช่าที่ได้ชำระไปในการซ่อมแซม หรือจัดหา\nมาแทน พร้อมทั้งดอกเบี้ย จนกว่าจะครบจำนวนเงินที่ผู้ให้เช่าได้จ่ายเพื่อซ่อมแซมเนื่องจากกรณีดังกล่าว นอกจากนี้ผู้ให้เช่ามีสิทธิเรียก\nเก็บค่าใช้จ่ายในการติดตาม ทวงถามหนี้ อีกในอัตราร้อยละ 4 (สี่) ต่อปีของจำนวนเงินที่ค้างชำระจนกว่าจะชำระครบถ้วน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ])),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '6.	ข้อตกลงและหน้าที่ของผู้เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.1	เมื่อผู้ให้เช่าเปิดดำเนินการ และ/หรือผู้เช่าได้ทำการตกแต่งอาคารและ/หรือสถานที่เช่าเสร็จสิ้นสมบูรณ์แล้ว ผู้เช่าจะต้องเปิดสถานที่เช่า\nเพื่อประกอบกิจการค้าทันทีตามวันที่ผู้ให้เช่ากำหนด มิฉะนั้นผู้ให้เช่ามีสิทธิ์ยกเลิกสัญญา และริบเงินประกันทั้งหมด',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.2	ผู้เช่าจะต้องเปิดและปิดการประกอบกิจการค้าตามเวลาที่ผู้ให้เช่าได้กำหนดไว้อย่างเคร่งครัด ผู้เช่ามีสิทธิหยุดขาย 4 ครั้งต่อเดือน และหากผู้เช่าประสงค์จะขอหยุดประกอบกิจการในวันใด ผู้เช่าจะต้องแจ้งให้ผู้ให้เช่าทราบล่วงหน้าอย่างน้อย 1 (หนึ่ง) วัน หากมีการหยุดเกินจากสัญญาที่ระบุไว้ในฉบับนี้ ผู้ให้เช่ามีสิทธิเรียกปรับเพิ่มเป็นจำนวนเงิน 300 บาทต่อวันต่อล็อค',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.3	เพื่อความเป็นระเบียบเรียบร้อย ความสวยงาม และการรักษาความปลอดภัยของอาคารและสถานที่เช่า ผู้เช่าและลูกจ้างหรือบริวารของผู้เช่า\nจะต้องเชื่อฟังและปฏิบัติตามเงื่อนไขของสัญญานี้ รวมทั้งกฎ ระเบียบ ข้อบังคับ และคำสั่งใดๆ เกี่ยวกับผู้ให้เช่าและสถานที่เช่าตามที่ผู้ให้เช่าหรือผู้รับมอบหมายจากผู้ให้เช่าได้กำหนดขึ้นไว้แล้วในขณะนี้หรือในอนาคต และให้ถือเป็นส่วนหนึ่งของสัญญานี้ด้วยโดยเคร่งครัด',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.4	ผู้เช่าจะต้องไม่กระทำ หรือยินยอมให้บุคคลใดกระทำการใดๆ ในสถานที่เช่า อาคาร หรือสถานที่ข้างเคียง อันเป็นการผิดกฎหมาย หรือกระทำ\nการใดๆ อันเป็นการละเมิดสิทธิของบุคคลใดๆ และ/หรือสิทธิในทรัพย์สินทางปัญญาใดๆ ของบุคคลอื่น ตลอดจนไม่กระทำการใดๆ อันเป็นการผิดศีลธรรม\nอันดีของประชาชน หรือโดยเป็นหรืออาจจะเป็นเหตุให้เป็นอันตรายต่อสุขภาพอนามัย หรือเป็นที่น่ารังเกียจ หรือเป็นการรบกวนก่อให้เกิดความเดือดร้อนรำคาญแก่ผู้ให้เช่าหรือบุคคลอื่นๆ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.5	ผู้เช่าจะต้องดูแลรักษาความสะอาดภายในสถานที่เช่าไม่ให้สกปรก หรือรกรุงรัง หรือเป็นที่น่ารังเกียจแก่ผู้พบเห็นรวมทั้งจะต้องดูแลรักษาความสะอาด\nบริเวณภายนอกในส่วนที่เกี่ยวเนื่องกับสถานที่เช่าด้วย และในการทิ้งขยะมูลฝอย ผู้เช่าจะต้องนำไปใส่ทั้งในภาชนะโดยผู้ให้เช่ากำหนดไว้',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.6	ผู้เช่าจะต้องรับผิดชอบดูแลรักษาทรัพย์สินของผู้เช่าที่นำเข้ามาไว้ในสถานที่เช่าด้วยตนเอง หากเกิดการสูญหาย หรือเสียหายขึ้นไม่ว่าด้วยเหตุประการ\nใดก็ตาม ผู้ให้เช่าไม่ต้องรับผิดชอบทั้งสิ้น',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.7	ผู้เช่าจะต้องรับผิดชอบต่ออุบัติเหตุใดๆ หรือความเสียหาย หรือการสูญหายใด ๆ อันเกิดจากความชำรุดของสถานที่เช่า วัสดุเครื่องมือเครื่องใช้ใดๆ หรือเหตุใดๆ ที่เกิดขึ้นต่อชีวิต ร่างกาย ทรัพย์สินของผู้ให้เช่า พร้อมบุคคลใดๆ ในสถานที่เช่า',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.8	กรณีผู้เช่าจัดให้มีการแสดงต่างๆ ในพื้นที่ตลาด เช่น ดนตรี, ละคร และการแสดงต่างๆ ตลอดจนเครื่องเล่น, สวนสนุก และอื่นๆ เพื่อเป็นการประชาสัมพันธ์และประโยชน์ของผู้เช่าแล้ว ผู้เช่าจะต้องใช้ความระมัดระวังในทรัพย์สินของผู้เช่ามิให้เกิดความเสียหายหรือสูญหาย หากปรากฏว่าทรัพย์สินของผู้เช่าเสียหายไม่ว่ากรณีใดก็ตาม อันเกิดจากบุคคลที่เข้ามาใช้บริการทั่วไปแล้ว ผู้เช่าไม่มีสิทธิ์ที่จะเรียกร้องค่าเสียหาย\nจากผู้ให้เช่าได้แต่อย่างใด',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.9	ผู้เช่าจะต้องบำบัดและดูแลน้ำเสียที่ทิ้งออกจากพื้นที่เช่า และมีการกรองผ่านบ่อดักไขมัน โดยบ่อตกไขมันนั้นจะต้องผ่านการอนุมัติจากทางตลาด\nแล้วเท่านั้น ในกรณีที่ผู้เช่าไม่ดำเนินการตามเงื่อนไข ผู้เช่าตกลงและยินยอมให้ผู้ให้เช่าหรือบุคคลที่ได้รับมอบหมายจากผู้ให้เช่าเข้าดำเนินการใดๆ\nในเรื่องดังกล่าวข้างต้นแทน โดยผู้เช่าจะต้องเป็นผู้รับผิดชอบในบรรดาค่าใช้จ่ายต่างๆที่เกิดขึ้นอันเนื่องมาจากการดำเนินการนั้นทั้งหมดทุกประการ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(
                space_s,
                0,
                space_s,
                0,
              ),
              child: pw.Text(
                '6.10	ผู้เช่าจะต้องจำหน่ายสินค้าที่ระบุอยู่ในสัญญาเท่านั้น หากมีการเพิ่มเติมหรือมีการเปลี่ยนแปลงจะต้องมีการรับอนุญาตจากทางตลาดแบบ\nเป็นลายลักษณ์อักษรเท่านั้น',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '7.	การโอนสิทธิการประกอบการ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      '7.1	ผู้เช่าจะไม่โอนสิทธิการเช่าตามสัญญานี้ หรือนำพื้นที่ของสถานที่เช่าไม่ว่าทั้งหมดหรือบางส่วนไปให้บุคคลอื่นเช่าช่วง หรือยินยอมให้บุคคลอื่น\nเข้าไปใช้ประโยชน์ ไม่ว่าจะเป็นการประจำหรือชั่วคราว และจะได้รับประโยชน์ค่าเช่าหรือค่าตอบแทนใดๆ หรือไม่ก็ตาม เว้นแต่จะได้รับความยินยอมเป็นหนังสือจากผู้ให้เช่าก่อน',
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
                      '7.2	ในกรณีที่ผู้ให้เช่าได้ให้ความยินยอมแก่ผู้เช่าในการโอนสิทธิการเช่าหรือเช่าช่วง หรือหากผู้เช่าเป็นผู้จัดหาผู้เช่ารายใหม่เข้ามาประกอบการค้าแทนผู้เช่า ผู้เช่าตกลงชำระค่าตอบแทนการเช่าให้แก่ผู้ให้เช่าในอัตราที่ผู้ให้เช่ากำหนด โดยตกลงชำระค่าตอบแทนให้แก่ผู้ให้เช่าทันที',
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
                      '7.3	ผู้เช่าจะต้องเป็นผู้ชำระค่าธรรมเนียม ค่าอากรแสตมป์ ตลอดจนค่าใช้จ่ายต่างๆ ในการจดทะเบียนการโอนสิทธิการใช้ประโยชน์ใน\nสถานที่เช่าแต่ฝ่ายเดียว',
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
                      '7.4	การโอนสิทธิการเช่าสถานที่เช่านี้ ผู้เช่าจะต้องโอนสิทธิตามสัญญาบริการไปด้วย และผู้รับโอนสิทธิการเช่าจะต้องผูกพันตามสัญญาบริการด้วย',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: Colors_pd,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                )),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '8.	การต่ออายุสัญญา',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        '8.1	ในกรณีผู้เช่ามีความประสงค์จะขอต่อสัญญาเช่านี้ ผู้เช่าจะต้องแจ้งความประสงค์จะขอต่ออายุสัญญาให้ผู้ให้เช่าทราบล่วงหน้าเป็นหนังสือไม่น้อยกว่า 30 (สามสิบวัน) ก่อนครบกำหนดอายุตามสัญญานี้ มิฉะนั้นให้ถือว่าผู้เช่าไม่ประสงค์ที่จะประกอบกิจการในสถานที่เช่าอีกต่อไป และให้สัญญาเช่าเป็นอันสิ้นสุด\nลงในวันที่ครบกำหนดอายุตามสัญญานี้ ทั้งนี้การต่ออายุสัญญาเป็นสิทธิของผู้ให้เช่าแต่เพียงฝ่ายเดียวที่จะพิจารณาว่าจะทำการต่ออายุ\nสัญญาให้แก่ผู้เช่าออกไปอีกหรือไม่ ในกรณีที่ผู้ให้เช่าพิจารณาต่ออายุสัญญาให้แก่ผู้เช่า ทั้งสองฝ่ายจะได้ทำความตกลงในเรื่องเงื่อนไขในสัญญา ค่าเช่า ค่าบริการ รายละเอียด และ/หรือข้อตกลงอื่นๆ ในสัญญากันใหม่ตามความเหมาะสม จะทำกันใหม่ตามความในวรรคก่อนนั้น ให้ถือเป็นสาระสำคัญของการต่ออายุสัญญาเช่า และคู่สัญญาจะต้องตกลงทำสัญญากันให้แล้วเสร็จก่อนสัญญาเช่านี้จะสิ้นสุดลงไม่น้อยกว่า 30 (สามสิบ) วัน',
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
                        '8.2	หากคู่สัญญาฝ่ายใดฝ่ายหนึ่งไม่ปฏิบัติตามสัญญานี้ไม่ว่าข้อหนึ่งข้อใด คู่สัญญาอีกฝ่ายหนึ่งมีสิทธิแจ้งให้ฝ่ายที่ปฏิบัติผิดสัญญาดำเนินการแก้ไขหรือ\nปฏิบัติให้ถูกต้องตามสัญญา หากคู่สัญญาฝ่ายนั้นไม่แก้ไขหรือปฏิบัติตามภายในเวลาที่กำหนด คู่สัญญาฝ่ายที่ไม่ได้ผิดสัญญามีสิทธิบอกเลิกสัญญา \nหรือฟ้องร้องต่อศาลให้บังคับคู่สัญญาอีกฝ่ายหนึ่งให้ปฏิบัติตามสัญญานี้ และ/หรือเรียกค่าเสียหายจากฝ่ายที่ผิดสัญญาได้',
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
                        '8.3	ในกรณีที่สถานที่เช่า ผู้เช่าได้ก่อสร้างขึ้นเองเพื่อให้เป็นสถานที่ตามวัตถุประสงค์ของผู้เช่าได้รับความเสียหายหรือสูญหายไม่ว่าทั้งหมดหรือบางส่วน\nในระหว่างระยะเวลาการเช่าตามข้อ 2. อันเนื่องมาจากเหตุสุดวิสัย อัคคีภัย ภัยธรรมชาติ ที่มิใช่เกิดจากความผิดพลาดของผู้เช่า อันส่งผลให้อาคาร\nหรือสถานที่เช่ามีสภาพไม่เหมาะสมที่จะใช้เพื่อประกอบกิจการร้านของผู้เช่า หรือไม่เหมาะสมต่อการใช้ประโยชน์ตามวัตถุประสงค์แห่งสัญญานี้อีกต่อไป ให้สัญญาฉบับนี้สิ้นสุดลงโดยไม่ถือว่าเป็นการผิดสัญญาและผู้ให้เช่าต้องคืนเงินประกันแก่ผู้เช่า และผู้เช่าไม่ต้องชำระค่าเช่าของระยะเวลาการเช่าที่เหลือ\nอยู่ให้แก่ผู้ให้เช่า ทั้งนี้ หากความเสียหายหรือสูญหายดังกล่าวข้างต้นนั้นอยู่ในวิสัยที่สามารถซ่อมแซมได้ คู่สัญญาทั้งสองฝ่ายตกลงให้สัญญาฉบับนี้\nยังคงมีผลต่อไป โดยผู้เช่าไม่ต้องชำระค่าเช่าให้แก่ผู้ให้เช่าระหว่างระยะเวลาที่ผู้ให้เช่าดำเนินการซ่อมแซมความเสียหายดังกล่าว',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ])),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '9.	การขนย้ายออกจากสถานที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        '9.1	เมื่อสัญญาฉบับนี้สิ้นสุดลงไม่ว่ากรณีใดๆ ผู้เช่าจะต้องขนย้ายทรัพย์สินและบริวารของผู้เช่าออกจากอาคาร สถานที่ และที่ดินที่เช่า ทำความสะอาด และส่งมอบคืนให้แก่ผู้ให้เช่าปรับสภาพให้กลับคืนสู่สภาพเดิมตามที่ได้รับมอบพื้นที่ในวันทำสัญญาเช่าจากผู้ให้เช่า ภายในเวลา 30 วัน นับตั้งแต่\nสัญญาสิ้นสุดลง โดยผู้เช่าจะต้องปรับสภาพพื้นที่เช่าให้กลับคืนสู่สภาพเดิมตามที่ได้รับมอบพื้นที่จากผู้ให้เช่า โดยผู้เช่าไม่ต้องชำระค่าเช่า\nหรือค่าตอบแทนในระหว่างระยะเวลานี้ให้แก่ผู้ให้เช่า',
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
                        '9.2	ในกรณีที่ผู้เช่าไม่ปฏิบัติตามข้อกำหนดในข้อ 9.1 ข้างต้น ผู้ให้เช่าหรือตัวแทนของผู้ให้เช่ามีสิทธิดำเนินการตามที่จำเป็นเพื่อกลับเข้าครอบครอง\nสถานที่เช่า และผู้เช่าต้องยินยอมให้ผู้ให้เช่าดำเนินการดังกล่าวได้โดยไม่ถือเป็นการบุกรุก ตลอดจนมีสิทธิเรียกค่าเสียหายจากผู้เช่า โดยคิดเป็นรายวัน คำนวณจากค่าเช่าหรือค่าตอบแทนที่กำหนดในสัญญานี้ (เพิ่มเป็น “พร้อมคิดค่าปรับอีกร้อยละ 15 ต่อปีของค่าเช่าที่กำหนด) จนกว่าผู้เช่าจะส่งมอบสถานที่เช่าคืนแก่ผู้ให้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ])),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '10.	การปฏิบัติตามกฎหมาย',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        'ผู้เช่าสัญญาว่าตลอดอายุการเช่าตามสัญญา ผู้เช่าจะไม่กระทำหรือละเว้นการกระทำอันใดที่เป็นการขัดต่อกฎหมายหรือศีลธรรมอันดี หรือเป็นที่น่ารังเกียจ หรือการก่อให้เกิดความเดือดร้อนรำคาญแก่ผู้ให้เช่าหรือแก่บุคคลอื่น หรือขัดกับแนวทางการค้าของผู้ให้เช่า ไม่ว่าด้วยวิธีการใด หรือกระทำการ\nใดอันอาจเป็นอันตรายต่อพื้นที่เช่า สถานีบริการ อาคาร หรือสถานที่ข้างเคียง หรือทรัพย์สินของผู้ให้เช่าหรือบุคคลอื่น',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ])),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '11.	สัมปทาน',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        'ผู้เช่าตกลงจะใช้บริการกับบริษัท/ผู้ให้บริการ ที่ได้ทำสัมปทานกับตลาด โดยค่าใช้จ่ายต่างๆผู้เช่ายินยอมจ่ายให้กับบริษัทผู้รับสัมปทาน (สัมปทาน เช่น ก๊าซหุงต้ม น้ำแข็ง เป็นต้น)',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ])),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '12.	การใช้ชื่อในทางการค้า การโฆษณา การส่งเสริมการขาย ป้ายต่างๆ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(children: [
                  pw.Text(
                    'ผู้เช่าจะต้องได้รับความเห็นชอบจากผู้ให้เช่าก่อนในการใช้ชื่อในทางการค้า การติดตั้งป้าย ขนาด ข้อความ รูปแบบ รูปภาพ ทั้งภาพนิ่งหรือภาพเคลื่อนไหว กรรมวิธี หรือกิจกรรมอันเกี่ยวกับการโฆษณา หรือส่งเสริมการขายของผู้เช่าในพื้นที่เช่า ซึ่งอยู่ภายในตลาด ทั้งที่เผยแพร่ต่อสาธารณชนหรือ\nกระทำภายในตลาด ในกรณีที่ได้รับความเห็นชอบจากผู้ให้เช่าแล้ว ผู้เช่าจะต้องขออนุญาตต่อหน่วยงานราชการที่เกี่ยวข้องเกี่ยวกับการติดสื่อ ป้าย หรือตามที่กฎหมายพึงให้ปฏิบัติด้วยตนเอง',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ])),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '13.	การดัดแปลง ต่อเติม หรือปลูกสร้างสิ่งอื่นใดในทรัพย์สินที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(
                  space_s,
                  0,
                  space_s,
                  0,
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        '13.1	ผู้เช่าจะทำการดัดแปลง ต่อเติม หรือปลูกสร้างสิ่งอื่นใดภายในพื้นที่เช่าไม่ได้ เว้นแต่จะได้รับความเห็นชอบเป็นลายลักษณ์อักษรจากผู้ให้เช่าก่อน และถ้ามีความเสียหายเกิดขึ้นจากการดำเนินการดังกล่าวข้างต้นไม่ว่าด้วยเหตุใดก็ตาม ผู้เช่าตกลงยินยอมชดใช้ค่าเสียหายแก่ผู้ให้เช่าทั้งหมดโดยไม่โต้แย้งใดๆ ทั้งสิ้น',
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
                        '13.2	ในกรณีที่ผู้ให้เช่าเห็นชอบอนุญาตให้ผู้เช่าทำการดัดแปลง ต่อเติม แก้ไข หรือปลูกสร้างสิ่งใดภายในพื้นที่เช่าดังกล่าว ผู้เช่าจะต้องขออนุญาต\nต่อหน่วยงานราชการที่เกี่ยวข้องสำหรับการดัดแปลง ต่อเติม แก้ไข หรือสิ่งปลูกสร้างสิ่งใดภายในพื้นที่เช่าดังกล่าว ด้วยค่าใช้จ่ายของผู้เช่าเอง',
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
                        '13.3	ผู้เช่าตกลงว่าบรรดาสิ่งที่ดัดแปลง ต่อเติม แก้ไข หรือสิ่งปลูกสร้างใดในพื้นที่เช่านั้น ตกเป็นกรรมสิทธิ์ของผู้ให้เช่า เว้นแต่ผู้ให้เช่า\nจะกำหนดไว้เป็นอย่างอื่น ซึ่งหากผู้ให้เช่าประสงค์ให้ผู้เช่าทำการรื้อถอน หรือทำกลับให้คืนสู่สภาพเดิมเมื่อสิ้นสุดอายุการเช่า ผู้เช่าจะต้องดำเนินการตามที่ผู้ให้เช่ากำหนดด้วยค่าใช้จ่ายของผู้เช่าเอง',
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
                        '13.4	หากผู้เช่าทำการดัดแปลง ต่อเติม แก้ไข หรือปลูกสร้างสิ่งใดภายในพื้นที่เช่าดังกล่าว โดยไม่ได้รับความยินยอมจากผู้ให้เช่าหรือได้รับความยินยอม\nจากผู้ให้เช่าแต่ไม่ได้รับอนุญาตจากหน่วยงานราชการที่เกี่ยวข้อง ผู้เช่าจะต้องทำการรื้อถอนบรรดาสิ่งที่ผู้เช่าทำการดัดแปลง ต่อเติม แก้ไข หรือปลูกสร้างสิ่งใดภายในพื้นที่ดังกล่าวในทันทีที่ได้รับการบอกกล่าวจากผู้ให้เช่าหรือหน่วยงานราชการดังกล่าว ด้วยค่าใช้จ่ายของผู้เช่าเอง',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ])),

            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '14.	คู่สัญญาตกลงให้เอกสารดังต่อไปนี้เป็นส่วนหนึ่งของสัญญานี้',
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
              ' ' * space_ +
                  '14.1	เอกสารแนบท้ายสัญญาเช่า หมายเลข 1 (แผนผังสถานที่เช่า)',
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
              ' ' * space_ +
                  '14.2	เอกสารแนบท้ายสัญญาเช่า หมายเลข 2 (ใบเสนอราคา)',
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
              '15.	ผู้เช่าจะต้องปฏิบัติตามข้อกำหนดและเงื่อนไขทั่วไปของสัญญาเช่า ซึ่งผู้ให้เช่าได้กำหนดขึ้นและผู้ให้เช่าอาจเปลี่ยนแปลงได้ตามความเหมาะสม',
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
              '16.	คู่สัญญาทั้งสองฝ่ายจะรักษาความลับและไม่เปิดเผยสัญญานี้และเอกสารใดๆที่เกี่ยวข้อง ตลอดจนข้อมูลในสัญญาให้แก่บุคคลใดๆ เว้นแต่ต้องเปิดเผยตาม\nที่กฎหมายกำหนด',
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
              '17.	ข้อเสนอและการมัดจำ',
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
              ' ' * space_ +
                  '17.1	 ใบเสนอราคาที่ยื่นจะมีอายุ  7 วัน นับจากวันที่ออกใบเสนอราคา',
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
              ' ' * space_ +
                  '17.2	 หากผู้เช่าต้องการจองพื้นที่เช่าตามใบเสนอราคา จะต้องวางมัดจำเป็นเงิน 1,000 บาทต่อล๊อค',
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
              ' ' * space_ +
                  '17.3	 หากมีการทำสัญญาเช่าจริง เงินมัดจำตามข้อ 17.2 จะถูกหักออกจากเงินมัดจำค่าเช่าตามข้อ 4.1',
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
              '18.	การบอกเลิกสัญญาก่อนกำหนด',
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
              ' ' * space_ +
                  '18.1	ผู้เช่ามีสิทธิ์บอกเลิกสัญญาก่อนกำหนดได้ โดยแจ้งเป็นลายลักษณ์อักษรไม่น้อยกว่า 60 วันล่วงหน้า',
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
              ' ' * space_ +
                  '18.2	ในกรณีที่ผู้เช่าบอกเลิกสัญญาก่อนกำหนดตามข้อ 18.1 ผู้ให้เช่ามีสิทธิ์ยึดเงินประกันตามข้อ 4.1 เพื่อเป็นค่าเสียหาย',
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
              '19.	ข้อกำหนดเพิ่มเติม',
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
              ' ' * space_ +
                  '19.1	ผู้เช่าจะต้องปฏิบัติตามข้อกำหนดด้านความปลอดภัยที่ผู้ให้เช่ากำหนดขึ้น และจะต้องแจ้งให้ผู้ให้เช่าทราบทันทีในกรณีที่เกิดเหตุการณ์',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              ' ' * space_ +
                  'ที่อาจก่อให้เกิดความเสียหายต่อสถานที่เช่าหรือทรัพย์สินภายในสถานที่เช่า',
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
              ' ' * space_ +
                  '19.2	ผู้เช่าจะต้องได้รับการอนุมัติเป็นลายลักษณ์อักษรจากผู้ให้เช่าก่อนทำการเปลี่ยนแปลงหรือเพิ่มเติมใดๆ ในการจัดวางสินค้าหรืออุปกรณ์ภายในสถานที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),

            // pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  '20.	อื่นๆ  ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    // width: 120,
                    height: 18,
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: Colors_pd,
                      width: 0.3, // Underline thickness
                    ))),
                    child: pw.Text(
                      " ${FormNameFile_text.text} ",
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (FormNameFile_text == null || FormNameFile_text.toString() == '')
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      // width: 120,
                      height: 18,
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        " ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            if (FormNameFile_text == null || FormNameFile_text.toString() == '')
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      // width: 120,
                      height: 18,
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        " ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            // pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.Text(
            //   ' ' * space_ + '20.2	ค่าบริการคิด vat ไม่ได้ฟรี',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //     fontWeight: pw.FontWeight.bold,
            //   ),
            // ),
            // pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.Text(
            //   ' ' * space_ +
            //       '20.3	-	ค่าส่วนกลางรายปี 10,000 บาท / ล๊อค โปรเปิดตลาด คิด 50 %',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //     fontWeight: pw.FontWeight.bold,
            //   ),
            // ),
            pw.SizedBox(height: 15 * PdfPageFormat.mm),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.SizedBox(height: 5 * PdfPageFormat.mm),
              pw.Row(
                // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      '',
                      // '___________________________ผู้เช่า/The Lessee   ',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                  // pw.Expanded(
                  //   flex: 1,
                  //   child: pw.Text(
                  //     '___________________________ผู้ให้เช่า/The Lessor ',
                  //     textAlign: pw.TextAlign.center,
                  //     style: pw.TextStyle(
                  //       fontSize: 10,
                  //       font: ttf,
                  //       color: Colors_pd,
                  //       // fontWeight: pw.FontWeight.bold
                  //     ),
                  //   ),
                  // ),
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
              ),
            ],
          );
        },
      ),
    );
    pageCount++;
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 18.00,
        marginLeft: 18.00,
        marginRight: 18.00,
        marginTop: 18.00,
      ),
      header: (context) {
        return pw.Column(
          children: [
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
                // (imageBytes_logo.isEmpty)
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
                //         pw.MemoryImage(imageBytes_logo),
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
                      // pw.Text(
                      //   'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                      //   maxLines: 2,
                      //   style: pw.TextStyle(
                      //     fontSize: font_Size,
                      //     font: ttf,
                      //     color: Colors_pd,
                      //   ),
                      // ),
                      pw.Text(
                        'วันที่ทำสัญญา :${Datex_text.text}',
                        // 'วันที่ทำสัญญา :____/________/____',
                        // '${DateFormat('ณ วันที่: d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
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
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(height: 2),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
          ],
        );
      },
      build: (context) {
        return [
          pw.SizedBox(height: 15 * PdfPageFormat.mm),
          pw.Text(
            ' ' * space_ +
                'สัญญาฉบับทำขึ้นเป็น 2 (สอง) ฉบับ มีข้อความถูกต้องตรงกัน คู่สัญญาแต่ละฝ่ายต่างได้อ่านและเข้าใจข้อความในสัญญาฉบับนี้โดยตลอดแล้ว จึงได้ลงลายมือชื่อพร้อมทั้งประทับตรา (ถ้ามี) ไว้เป็นหลักฐานต่อหน้าพยาน และต่างยึดถือฝ่ายละหนึ่งฉบับ',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: font_Size,
              font: ttf,
              color: Colors_pd,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 15 * PdfPageFormat.mm),
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
          pw.SizedBox(height: 15 * PdfPageFormat.mm),
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
        ];
      },
      footer: (context) {
        return pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    '',
                    // '___________________________ผู้เช่า/The Lessee   ',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 10,
                      font: ttf,
                      color: Colors_pd,
                      // fontWeight: pw.FontWeight.bold
                    ),
                  ),
                ),
                // pw.Expanded(
                //   flex: 1,
                //   child: pw.Text(
                //     '___________________________ผู้ให้เช่า/The Lessor ',
                //     textAlign: pw.TextAlign.center,
                //     style: pw.TextStyle(
                //       fontSize: 10,
                //       font: ttf,
                //       color: Colors_pd,
                //       // fontWeight: pw.FontWeight.bold
                //     ),
                //   ),
                // ),
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
            ),
          ],
        );
      },
    ));
    pageCount++;
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 18.00,
        marginLeft: 18.00,
        marginRight: 18.00,
        marginTop: 18.00,
      ),
      header: (context) {
        return pw.Column(
          children: [
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
                // (imageBytes_logo.isEmpty)
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
                //         pw.MemoryImage(imageBytes_logo),
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
                      // pw.Text(
                      //   'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                      //   maxLines: 2,
                      //   style: pw.TextStyle(
                      //     fontSize: font_Size,
                      //     font: ttf,
                      //     color: Colors_pd,
                      //   ),
                      // ),
                      pw.Text(
                        'วันที่ทำสัญญา :${Datex_text.text}',
                        // 'วันที่ทำสัญญา :____/________/____',
                        // '${DateFormat('ณ วันที่: d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
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
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(height: 2),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
          ],
        );
      },
      build: (context) {
        return [
          pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'เอกสารแนบท้ายสัญญาเช่า หมายเลข 1',
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
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      'แผนผังสถานที่เช่า',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Text(
                  'เอกสารแนบท้ายสัญญาเช่าหมายเลข 1 นี้เป็นส่วนหนึ่งของสัญญาเช่าพื้นที่ ตลาด อาม่า 1000 สุข สัญญาเช่าเลขที่ $Get_Value_cid',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    color: Colors_pd,
                    fontSize: font_Size,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                  ),
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Text(
                  'รายละเอียดเกี่ยวกับสถานที่เช่า',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    color: Colors_pd,
                    fontSize: font_Size,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                  ),
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Row(
                  children: [
                    pw.Text(
                      'พื้นที่บางส่วนภายในโครงการ ตลาด อาม่า 1000 สุข ล๊อคที่',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: Colors_pd,
                      ),
                    ),
                    pw.Container(
                      width: 150,
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "$Form_ln",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    ),
                    pw.Text(
                      'รวม',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: Colors_pd,
                      ),
                    ),
                    pw.Container(
                      width: 40,
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
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
                    ),
                    pw.Text(
                      'ล๊อค มีเนื้อที่ประมาณ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: Colors_pd,
                      ),
                    ),
                    pw.Container(
                      width: 40,
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
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
                    ),
                    pw.Text(
                      'ตารางเมตร',
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
                pw.Text(
                  'ตามตำแหน่งที่ทำเครื่องหมายไว้ในแผนผังแนบท้ายเอกสารสัญญาฉบับนี้ เมื่อผู้เช่าเข้าใช้สถานที่เช่า ผู้แทนของผู้ให้เช่าและผู้เช่าจะวัดและกำหนดพื้นที่ของสถานที่เช่า พร้อมทั้งรับรองความถูกต้องของสถานที่เช่าในวันทำสัญญาแล้ว',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    color: Colors_pd,
                    fontSize: font_Size,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                  ),
                ),
                pw.SizedBox(height: 10 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Container(
                    height: 400,
                    width: 400,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      border: pw.Border.all(color: PdfColors.grey300),
                    ),
                    child: imageBytes_map != null
                        ? pw.Image(
                            pw.MemoryImage(imageBytes_map),
                            height: 400,
                            width: 400,
                          )
                        : pw.Center(
                            child: pw.Text(
                              'Image max 400 x max 400',
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                  ),
                  // (imageBytes_map!.isEmpty)
                  //     ? pw.Container(
                  //         height: 400,
                  //         width: 400,
                  //         color: PdfColors.grey200,
                  //         child: pw.Center(
                  //           child: pw.Text(
                  //             'Image max 400 x max 400',
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
                  //         pw.MemoryImage(imageBytes_map),
                  //         height: 400,
                  //         width: 400,
                  //       ),
                ),
              ],
            ),
          ),
        ];
      },
      footer: (context) {
        return pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    '',
                    // '___________________________ผู้เช่า/The Lessee   ',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 10,
                      font: ttf,
                      color: Colors_pd,
                      // fontWeight: pw.FontWeight.bold
                    ),
                  ),
                ),
                // pw.Expanded(
                //   flex: 1,
                //   child: pw.Text(
                //     '___________________________ผู้ให้เช่า/The Lessor ',
                //     textAlign: pw.TextAlign.center,
                //     style: pw.TextStyle(
                //       fontSize: 10,
                //       font: ttf,
                //       color: Colors_pd,
                //       // fontWeight: pw.FontWeight.bold
                //     ),
                //   ),
                // ),
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
            ),
          ],
        );
      },
    ));

    // final bytes = await pdf.save();

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
