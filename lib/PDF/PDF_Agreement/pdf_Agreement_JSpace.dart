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
import '../../Style/ThaiBaht.dart';

class Pdfgen_Agreement_JSpace {
//////////---------------------------------------------------->( **** เอกสารสัญญาเช่า ปกติ  J Space Sansai)

  static void exportPDF_Agreement_JSpace(
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
      Datex_text,
      Pri1_text,
      Pri2_text,
      Pri3_text) async {
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
    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
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
                                fontSize: 10,
                                font: ttf,
                                color: Colors_pd,
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
                  'สัญญาเช่าที่ดินและสิ่งปลูกสร้าง ',
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
                        'ทำที่ โครงการ เจ สเปซ  ตำบลหนองจ๊อม อำเภอสันทราย จังหวัดเชียงใหม่',
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
            pw.Text(
              'สัญญาฉบับนี้ทำขึ้นนระหว่าง บริษัท อริสตา พลัส จำกัด โดย นางสาวนวพร  ศิริสานต์ สำนักงานตั้งอยู่เลขที่  316/8 หมู่ที่ 8 ตำบลหนองจ๊อม อำเภอสันทราย จังหวัดเชียงใหม่ ',
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
                  'ซึ่งต่อไปในสัญญานี้เรียกว่า “ผู้ให้เช่า” ฝ่ายหนึ่งกับ ',
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
                        width: 0.5, // Underline thickness
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
            // pw.Text(
            //   'อยู่บ้านเลขที่........$bill_addr........ถือบัตรประชาชนเลขที่..............$Form_tax..................ซึ่งต่อไปในสัญญานี้เรียกว่า “ผู้เช่า” อีกฝ่ายหนึ่ง',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.Row(
              children: [
                pw.Text(
                  'อยู่บ้านเลขที่ ',
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
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ซึ่งต่อไปในสัญญานี้เรียกว่า “ผู้เช่า” อีกฝ่ายหนึ่ง ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'คู่สัญญาทั้งสองฝ่ายตกลงทำสัญญากันโดยมีข้อความดังต่อไปนี้ ',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.Text(
            //   'ข้อ 1.“ทรัพย์ที ่เช่า”คูู่สัญญาตกลงให้เช่าและตกลงเช่าพื้นที่และสิ่งปลูกสร้างจำนวน....$Form_qty....ห้องโดยมีขนาดพื้นที่....$Form_area.... ตารางเมตร อาคาร/ห้องเลขที่....$Form_ln....ตามแผนผังพื้นที่เช่า ที่ระบุในภาคผนวก 1 ซึ่งเป็นส่วนหนึ่งของที่ดินโฉนดเลขที่ 9950 เลขที่ดิน1261 หน้าสำรวจ 773 ตำบลหนองจ๊อม อำเภอสันทราย จังหวัดเชียงใหม่ ซึ่งต่อไปในสัญญาเรียกว่า “ทรัพย์ที ่เช่า” เพื่อประโยชน์ใน การดำเนินกิจการธุรกิจ',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //     fontWeight: pw.FontWeight.bold,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ข้อ 1.“ทรัพย์ที ่เช่า”คูู่สัญญาตกลงให้เช่าและตกลงเช่าพื้นที่และสิ่งปลูกสร้างจำนวน ',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text: ' ${Form_qty} ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: 'ห้องโดยมีขนาดพื้นที่',
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: ' ${Form_area} ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: 'ตารางเมตร',
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.Row(
              children: [
                pw.Text(
                  'อาคาร/ห้องเลขที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
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
                    )),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'ตามแผนผังพื้นที่เช่า ที่ระบุในภาคผนวก 1  ',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                )
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ซึ่งเป็นส่วนหนึ่งของที่ดินโฉนดเลขที่ 9950 เลขที่ดิน 1261 หน้าสำรวจ 773 ตำบลหนองจ๊อม อำเภอสันทราย จังหวัดเชียงใหม่ ซึ่งต่อไปในสัญญาเรียกว่า “ทรัพย์ที ่เช่า” เพื่อประโยชน์ใน การดำเนินกิจการธุรกิจ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ 2.ระยะเวลาเช่าและอัตราค่าเช่า',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '2.1.ผู้เช่าตกลงเช่าทรัพย์ตามข้อ1.',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.RichText(
              text: pw.TextSpan(
                text: 'มีกำหนดระยะเวลา ',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text: ' $Form_period$Howday ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: 'เริ่มเช่าตั้งแต่วันที่',
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: ' $Form_sdate ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: 'สิ้นสุดสัญญาเช่าวันที่',
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: ' $Form_ldate ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: 'ในอัตราค่าเช่าเดือนละ',
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        ' ${nFormat.format(double.parse(Pri1_text.text.toString()))}บาท(~${convertToThaiBaht(double.parse(Pri1_text.text.toString()))}~) ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        'โดยผู้เช่าตกลงจะชำระค่าเช่าให้แก่ผู้ให้เช่าล่วงหน้า ภายในวันที่ 5 ของทุกเดือน โดยนำเงินฝากค่าเช่าผ่านบัญชีเงินฝาก ธนาคารกรุงไทย จำกัด (มหาชน)  สาขา บ่อสร้าง ประเภท สะสมทรัพย์ เลขที่บัญชี 553-0-43304-9 ชื่อ บริษัท อริสตา พลัส จำกัด ในกรณีที่ผู้เช่าชำระค่าเช่าล่าช้าเกินวันที่ 5  ทางผู้เช่ายินยอมชำระค่าปรับวันละ 50 บาท (ห้าสิบบาทถ้วน) จนกว่าทางผู้ให้เช่าจะได้รับชำระค่าเช่าดังกล่าว',
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // pw.Text(
            //   'มีกำหนดระยะเวลา....$Form_period....$Howday เริ่มเช่าตั้งแต่วันที่....$Form_sdate....สิ้นสุดสัญญาเช่าวันที่....$Form_ldate....ในอัตราค่าเช่าเดือนละ....${quotxSelectModels.where((model) => model.exptser == '1').map((model) => nFormat.format(double.parse(model.total!))).join(', ')}....โดยผู้เช่าตกลงจะชำระค่าเช่าให้แก่ผู้ให้เช่าล่วงหน้า ภายในวันที่ 5 ของทุกเดือน โดยนำเงินฝากค่าเช่าผ่านบัญชีเงินฝาก ธนาคารกรุงไทย จำกัด (มหาชน)  สาขา บ่อสร้าง ประเภท สะสมทรัพย์ เลขที่บัญชี 553-0-43304-9 ชื่อ บริษัท อริสตา พลัส จำกัด ในกรณีที่ผู้เช่าชำระค่าเช่าล่าช้าเกินวันที่ 5  ทางผู้เช่ายินยอมชำระค่าปรับวันละ 50 บาท (ห้าสิบบาทถ้วน) จนกว่าทางผู้ให้เช่าจะได้รับชำระค่าเช่าดังกล่าว',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //     fontWeight: pw.FontWeight.bold,
            //   ),
            // ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '2.2.ในการเช่าทรัพย์สินที่เช่าดังกล่าวในข้อ1.',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            // pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.Text(
            //   'ผู้เช่าได้วางเงินประกันไว้ให้แก่ผู้ให้เช่าตลอดอายุสัญญาเช่าในวันทำสัญญาเป็นจํานวนเงินทั้งสิ้น____________________________________โดยจำนวนเงินดังกล่าวผู้ให้เช่าตกลงจะคืนให้แก่ผู้เช่าเท่ากับจำนวนเดิมเมื่อครบกำหนดอายุสัญญาเช่าเท่านั้นทั้งนี้ภายหลังที่ผู้ให้เช่าได้หักหนี้สินใดๆที่ผู้เช่าค้างชำระจ่ายหรือหักค่าใช้จ่ายที่เกิดจากความเสีย หายต่อทรัพย์ที่เช่าระหว่างหรือเมื่อสิ้นสุดสัญญาหากเงินประกันไม่เพียงพอผู้ให้เช่ามีสิทธิที่จะเรียกร้องค่าเสียหายจากผู้เช่าจนครบจำนวนและเงินประกันนี้ไม่สามารถ นำมาชำระเป็นค่าเช่าล่วงหน้าหรือไม่ถือเป็นค่าเช่ารายเดือนได้',
            //   textAlign: pw.TextAlign.justify,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ผู้เช่าได้วางเงินประกันไว้ให้แก่ผู้ให้เช่าตลอดอายุสัญญาเช่าในวันทำสัญญาเป็นจํานวนเงินทั้งสิ้น',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text:
                        ' ${nFormat.format(double.parse(Pri2_text.text.toString()))}บาท(~${convertToThaiBaht(double.parse(Pri2_text.text.toString()))}~) ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        'โดยจำนวนเงินดังกล่าวผู้ให้เช่า ตกลงจะคืนให้แก่ผู้เช่าเท่ากับจำนวนเดิมเมื่อครบกำหนดอายุสัญญาเช่าเท่านั้นทั้งนี้ภายหลังที่ผู้ให้เช่าได้หักหนี้สินใดๆที่ผู้เช่าค้างชำระจ่ายหรือหักค่าใช้จ่ายที่เกิดจากความเสีย หายต่อทรัพย์ที่เช่าระหว่างหรือเมื่อสิ้นสุดสัญญาหากเงินประกันไม่เพียงพอผู้ให้เช่ามีสิทธิที่จะเรียกร้องค่าเสียหายจากผู้เช่าจนครบจำนวนและเงินประกันนี้ไม่สามารถ นำมาชำระเป็นค่าเช่าล่วงหน้าหรือไม่ถือเป็นค่าเช่ารายเดือนได้',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // pw.Text(
            //   'ผู้ให้เช่ามีสิทธิที่จะเรียกร้องค่าเสียหายจากผู้เช่าจนครบจำนวน และเงินประกันนี้ไม่สามารถนำมาชำระเป็นค่าเช่าล่วงหน้าหรือไม่ถือเป็นค่าเช่ารายเดือนได้',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '2.3.ผู้เช่าตกลงเป็นผู้รับผิดชอบชำระค่าประกันมิเตอร์น้ำประปา จำนวน 2,000 บาท (สองพันบาทถ้วน) และ ค่าประกัน มิเตอร์ไฟฟ้า จำนวน 2,000 บาท (สองพันบาทถ้วน) โดยรวมอยู่ในประกันข้อ 2.2 แล้ว ',
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
              '2.4.ผู้เช่าตกลงเป็นผู้รับผิดชอบชำระค่าน้ำประปาหน่วยละ 15 บาท โดยชำระกับทางผู้ให้เช่า และมิเตอร์ไฟฟ้า หน่วยละ7 บาท ถ้ามีการปรับราคา จะมีการแจ้งผู้ให้เช่าทราบเป็นลายลักษณ์อักษร โดยชำระภายในวันที่ 5 ของเดือนถัดไป ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            // pw.Text(
            //   '2.5.ผู้เช่าต้องชำระค่าส่วนกลาง เช่น ค่าไฟฟ้าถนน ค่าห้องน้ำ ค่าเก็บขยะ ค่าทำความสะอาดส่วนกลางเป็นจำนวนเงิน_________________________________ต่อเดือน โดยชำระเป็นเงินสดหรือตามตกลง  ต่อพื้นที่เช่า ถ้ามีการปรับราคา จะมีการแจ้งผู้ให้ เช่าทราบเป็นลายลักษณ์อักษร หากผู้เช่าไม่ชำระค่าส่วนกลางแก่ผู้ให้เช่า ทางผู้เช่ายินยอมที่จะให้ตัดน้ำ ไฟ และยกเลิกสัญญาตามลำดับ',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //     fontWeight: pw.FontWeight.bold,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    '2.5.ผู้เช่าต้องชำระค่าส่วนกลาง เช่น ค่าไฟฟ้าถนน ค่าห้องน้ำ ค่าเก็บขยะ ค่าทำความสะอาดส่วนกลางเป็นจำนวนเงิน',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text:
                        ' ${nFormat.format(double.parse(Pri3_text.text.toString()))}บาท(~${convertToThaiBaht(double.parse(Pri3_text.text.toString()))}~) ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        'ต่อเดือนโดยชำระเป็นเงินสดหรือตามตกลงต่อพื้นที่เช่า ถ้ามีการปรับราคา จะมีการแจ้งผู้ให้ เช่าทราบเป็นลายลักษณ์อักษร หากผู้เช่าไม่ชำระค่าส่วนกลางแก่ผู้ให้เช่า ทางผู้เช่ายินยอมที่จะให้ตัดน้ำ ไฟ และยกเลิกสัญญาตามลำดับ',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '2.6.หากผู้เช่าไม่ชำระเงินงวดใดงวดหนึ่ง ทางผู้เช่ายินยอมให้มีการปิดกั้นการเข้าพื้นที่ ตัดน้ำไฟ หรือ สามารถยกเลิกสัญญาได้ในทันที ',
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
              'ข้อ 3. รายละเอียดและเงื่อนไข',
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
              '3.1.ในการเช่าพื้นที่เช่าผู้เช่าจะต้องใช้ชื่อในการประกอบการและประเภทของการประกอบกิจการ ตามที่ระบุไว้ในภาคผนวกที่ 2 เท่านั้นผู้ให้เช่าถือว่าเป็นสาระสำคัญในสัญญา',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'เช่านี้การที่ผู้เช่าได้ประกอบกิจการค้าประเภทอื่นและ/หรือใช้ชื่อในการประกอบการเป็นอย่างอื่นโดยที่ผู้ให้เช่าไม่ทราบหรือไม่ได้ทักท้วงจะถือว่าผู้ให้เช่าให้ความยินยอมหรือสละสิทธิการเป็นสาระสำคัญของข้อสัญญาเช่านี้ไม่ได้ซึ่งหากผู้เช่าประสงค์จะเปลี่ยนแปลงหรือประกอบกิจการประเภทอื่นนอกเหนือจากที่ระบุไว้จะกระทำได้ต่อเมื่อได้รับความเห็นชอบเป็นลายลักษณ์อักษรจากผู้ให้เช่าเท่านั้นและผู้เช่าจะไม่ประกอบกิจการที่เสียหายต่อสังคมกฎหมายส่วนรวม หรือรบกวนผู้เช่ารายอื่น   ',
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
              '3.2.ผู้เช่าตกลงไม่หยุดประกอบกิจการ เกิน 4 วันต่อเดือนยกเว้นวันหยุดตามที่โครงการประกาศหรือมีเหตุจำเป็นโดยผู้เช่าต้องแจ้งให้ผู้ให้เช่าทราบล่วงหน้าอย่างน้อย 7 วัน หากผู้เช่าปิดร้านเกินกำหนด ผู้ให้เช่ามีสิทธิ์ตักเตือน หรือบอกเลิกสัญญาเช่าได้',
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
              '3.3.หากผู้เช่าทอดทิ้งทรัพย์ที่เช่าปราศจากการประกอบกิจการติดต่อกันเป็นระยะเวลาเกิน 7 วัน โดยไม่ได้รับความยินยอมจากผู้ให้เช่าผู้ให้เช่ามีสิทธิ์บอกเลิกสัญญา',
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
              '3.4.ผู้เช่าต้องจัดวางอุปกรณ์หรือวัตถุของทางร้านค้าให้เป็นระเบียบ ไม่วางวัตถุลงบนทางเท้า หรือล้ำเข้ามาภายในเขตทางเท้าหน้าอาคาร หรือพื้นที่ส่วนรวมของของโครงการ เว้นแต่ได้รับการยินยอมเป็นลายลักษณ์อักษรจากผู้ให้เช่า',
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
              '3.5.ผู้เช่าจะต้องจัดหาบ่อดักไขมันก่อนที่จะปล่อยน้ำเสียที่เกิดจากการประกอบธุรกิจเข้าสู่ท่อระบายน้ำของทางโครงการของผู้ให้เช่า หากผู้เช่าไม่ปฏิบัติติ ผู้เช่ายินยอมชำระค่าเสียหายตามที่ผู้ให้เช่าแจ้งเป็นลายลักษณ์อักษร',
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
              'ข้อ 4.การใช้ทรัพย์ที่เช่า',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            // pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ในกรณีที่ผู้เช่าประสงค์จะทำการก่อสร้าง,ตกแต่ง,ดัดแปลง,แก้ไขหรือกระทำการใดๆในทรัพย์ที่เช่าผู้เช่าจะต้องได้รับความยินยอมเป็นหนังสือจากผู้ให้เช่าก่อนโดยผู้เช่าเป็นฝ่าย รับผิดชอบในค่าใช้จ่ายต่างๆในการดำเนินการทั้งนี้ทรัพย์สินหรือวัสดุอุปกรณ์ที่นำมาตกแต่ง ดัดแปลง แก้ไขปรับปรุงหรือต่อเติมทรัพย์ที่เช่า ห้ถือเป็นกรรมสิทธิ์ของผู้เช่า โดยเมื่อครบกำหนดระยะเวลาการเช่าตามสัญญานี้ผู้ให้เช่ายินยอมให้ผู้เช่ารื้อถอนบรรดาทรัพย์สินต่างๆ ที่ผู้เช่านำมาตกแต่ง ดัดแปลงแก้ไขปรับปรุง หรือต่อเติม ออกไปจากทรัพย์ที่เช่าโดยต้องปรับสภาพทรัพย์ที่เช่าให้อยู่ในสภาพที่ดี หรือตกลงกับผู้ให้เช่า ',
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
              'ข้อ 5.ค่าภาษีป้าย หรือภาษีอื่นๆใดที่เกิดจากการทำกิจการของผู้เช่า ผู้เช่าต้องเป็นผู้ชำระเองทั้งหมด ',
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
              '5.1.ผู้เช่าตกลงเป็นผู้รับผิดชอบชำระภาษีที่ดินและสิ่งปลูกสร้าง 5% ของค่าเช่ารวมทั้งปี โดยชำระกับทางผู้ให้เช่ารายปี',
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
              'ข้อ 6.ห้ามมิให้ผู้เช่าโอนกรรมสิทธิ์การเช่าโดยการเช่าช่วงหรือนำทรัพย์ที่เช่าไปให้บุคคลอื่นเช่าช่วงไม่ว่าจะทั้งหมดหรือแต่บางส่วนหรือนำสิทธิ์ตามสัญญานี้ไปเป็นหลัก ประกันใดๆกับธนาคารหรือบุคคลอื่น ไม่ว่าจะโดยทางตรงหรือทางอ้อม โดยเด็ดขาด เว้นแต่จะได้รับความยินยอมเป็นลายลักษณ์อักษรจากผู้ให้เช่าเท่านั้น',
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
              'การโอนกรรมสิทธิ์การเช่า โดยการเซ้งต่อหรือการเปลี่ยนชื่อสัญญาผู้เช่า สามารถทำได้หากได้รับความยินยอมจากผู้ให้เช่า เท่านั้น โดยมีค่าเปลี่ยนสัญญาเป็นจำนวนเงิน 2 เท่า ของค่าเช่า ตามค่าเช่าจริง ณ วันที่ทำการเปลี่ยนสัญญา โดยเงื่อนไขอื่นๆยังคงให้เป็นไปตามสัญญาเดิมทุกประการ',
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
              'ข้อ 7.การตรวจทรัพย์สินที่เช่าผู้เช่าจะต้องอำนวยความสะดวกให้แก่ผู้ให้เช่าหรือตัวแทนผู้ให้เช่าตรวจตราทรัพย์ที่เช่าได้ตลอดเวลา โดยไม่ต้องบอกกล่าวล่วงหน้าและในการ ตรวจทรัพย์ที่เช่า หากผู้ให้เช่า ตรวจพบว่าผู้เช่ากระทำการใดๆอันเป็นการทำให้ทรัพย์ที่เช่าเสียหายผู้ให้เช่ามีสิทธิ์แจ้งให้ผู้เช่าหยุดกระทำการหรือทำการแก้ไขปรับปรุงได้ ทันทีและเมื่อผู้เช่าได้รับแจ้งจากผู้ให้เช่าแล้ว ผู้เช่าจะต้องทำการตามที่ได้รับแจ้งทันที โดยผู้เช่าเป็นผู้ออกค่าใช้จ่ายเองทั้งหมด',
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
              'ข้อ 8.ในกรณีที่ผู้เช่าประสงค์จะนำทรัพย์สินออกจากพื้นที่เช่า ผู้เช่าตกลงให้เจ้าหน้าที่รักษาความปลอดภัยหรือตัวแทนของผู้ให้เช่าดำเนินการตรวจค้นและ/หรือหน่วงเหนี่ยวทรัพย์สินซึ่งสงสัยว่าอาจไม่ใช่ของผู้เช่าเพื่อรอพิสูจน์สิทธิได้',
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
              'ข้อ 9.ผู้เช่าเข้าใจเป็นอย่างดีแล้วว่า เงินประกันการเช่าไม่ใช่การชำระค่าเช่าล่วงหน้าแต่อย่างใด ผู้เช่าจะอ้างเหตุของการวางเงินประกันการเช่าดังกล่าว เพื่อไม่ชำระค่าเช่าตามสัญญาเช่านี้ไม่ได้',
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
              'ข้อ 10.กรณีเหตุที่เกิดขึ้นในทางกฎหมายกรณีมีเหตุเกิดขึ้นในสถานที่เช่าทางผู้เช่าจะต้องรับผิดชอบเองทั้งหมดทั้งทางกฎหมายและทางอื่นๆโดยผู้ให้เช่าจะไม่มีการ รับผิดชอบใดๆทั้งสิ้น ',
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
              'ข้อ 11.กรณีผู้เช่าบอกเลิกสัญญาก่อนครบกำหนดระยะเวลา ผู้เช่าต้องแจ้งให้ผู้ให้เช่าทราบเป็นลายลักษณ์อักษรอย่างน้อย 60วันก่อนการเลิกสัญญาโดยผู้เช่ายังคงต้อง รับผิดชอบค่าเช่าตามสัญญาต่อผู้ให้เช่าจนครบกำหนดที่ขอบอกเลิกการเช่า หรือ จนถึงวันส่งมอบทรัพย์ที่เช่าคืน',
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
              'ข้อ 12.กรณีผู้เช่าประสงค์ที่จะต่อสัญญาเมื่อครบกำหนดสัญญา ให้แจ้งผู้ให้เช่าทราบอย่างน้อย 60 วันก่อนวันครบสัญญา เช่า ผู้ให้เช่าจะพิจารณาสัญญาใหม่ และกำหนดอัตราค่าเช่าใหม่ โดยรายละเอียดจะแจ้งให้ทราบก่อนหมดสัญญา ',
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
              'หากผู้เช่าไม่ประสงค์ที่จะเช่าต่อผู้เช่าต้องขนย้ายทรัพย์สินและบริวารออกจากทรัพย์ที่เช่า ดำเนินการให้แล้วเสร็จภายใน14 วัน นับแต่วันที่สัญญานี้เลิกกัน พร้อมคืนกุญแจให้แก่ผู้ให้เช่า (ถ้ามี) โดยเมื่อครบกำหนดสัญญาเช่าแล้ว ผู้เช่ายังไม่ออกจากทรัพย์ ที่เช่า ผู้เช่ายินยอมให้ผู้ให้เช่าปรับวันละ 2,000 บาท (สองพันบาทถ้วน) ',
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
              'ข้อ 13.การทำประกันอัคคีภัย ภัยทางธรรมชาติทุกชนิด (ประกันพื้นที่เช่า) โดยผู้เช่าจะต้องเป็นผู้จัดหาบริษัทอัคคีภัยภัยทางธรรมชาติทุกชนิดโดยผู้เช่าเป็นฝ่าย ชำระเบี้ยประกันดังกล่าวโดยในกรมธรรม์ต้องกำหนดให้ผู้ให้เช่าเป็นผู้รับผลประโยชน์ตาม กรมธรรม์ดังกล่าว ทั้งนี้ต้องส่งมอบหลักฐานการทำประกันภัยภายใน 30 วันนับแต่วันทำสัญญา',
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
              'ในกรณีที่ผู้เช่าไม่ทำประกันภัย ในกรณีวินาศภัย หากมีขึ้น ผู้เช่าจะต้องชดใช้ค่าสินไหมทดแทนแก่ผู้ให้เช่าและผู้เช่าราย อื่นที่ได้รับความเสียหายที่เกิดขึ้นจากภัยของผู้เช่า โดยผู้เช่าจะต้องชดใช้ค่าสินไหมทั้งหมดแต่เพียงผู้เดียว ทั้งนี้ ในกรณีเกิดอัคคีภัยหรือ ภัยพิบัติอื่นใด จนไม่เหมาะสมที่จะทำกิจการ ให้ถือว่าสัญญาเป็นการสิ้นสุดลง ',
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
              'ข้อ 14.ในกรณีที่ผู้เช่าผิดสัญญาในข้อหนึ่งข้อใดหรือหลายข้อรวมกันในสัญญาฉบับนี้ให้ถือว่าสัญญาเช่าฉบับนี้เป็นอันเลิกกัน โดยมิต้องบอกกล่าวล่วงหน้าทั้งนี้ผู้เช่า ยินยอมให้ผู้ให้เช่าทรงไว้ซึ่งสิทธิกลับเข้ายึดถือครอบครองทรัพย์ที่เช่าตลอดจนย้าย บุคคล และสิ่งของออกไปจากทรัพย์ที่เช่า ตามสัญญานี้ได้ทันทีโดยไม่มีเงื่อนไข นอกจากนั้นผู้เช่าตกลงให้ผู้ให้เช่าริบเงินประกันการ เช่า และเงินอื่นๆ ที่ผู้เช่าได้วางไว้กับผู้ให้เช่าได้ทั้งสินตลอดจนระงับการจ่ายกระแสไฟฟ้า และน้ำประปา โดยผู้เช่าตกลงจะไม่เรียกร้องค่าเสียหายใดๆทั้งสิ้น',
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
              'ข้อ 15.ผู้เช่าตกลงว่าอาคารโครงการ และพื้นที่เช่าตามสัญญาเช่านี้เป็นภูมิลำเนาอีกแห่งหนึ่งของผู้เช่าบรรดาคำบอกกล่าวใดๆ ที่ผู้ให้เช่ามีถึงผู้เช่าเมื่อได้ส่งหรือปิดไว้ โดยเปิดเผย ณ อาคารโครงการและ/หรือพื้นที่เช่า หรือเมื่อผู้ให้เช่าส่งคำบอกกล่าว โดยจดหมายลงทะเบียนตอบรับไปยังพื้นที่เช่าให้ถือว่าเป็นการส่งโดยชอบและถือว่าผู้เช่าได้ทราบข้อความนั้นแล้ว ',
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
              'ข้อ 16.ข้อสัญญาใดๆในสัญญาเช่านี้ ที่ห้ามผู้เช่ากระทำสิ่งหนึ่งสิ่งใดเว้นแต่จะได้รับความยินยอมจากผู้ให้เช่าก่อนนั้นความยินยอมดังกล่าวจะต้องทำเป็นลายลักษณ์อักษร เสมอในกรณีที่ผู้เช่าได้กระทำสิ่งหนึ่งสิ่งใดซึ่งเป็นข้อห้ามตามที่ระบุในข้างต้น โดยผู้ให้เช่าไม่ได้ทักท้วงจะถือว่าผู้ให้เช่าให้ความยินยอม หรือสละสิทธิตามข้อสัญญาเช่านั้นไม่ได้',
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
              'ข้อ 17.หากข้อสัญญาเช่าหรือเงื่อนไขข้อหนึ่งข้อใดในสัญญาเช่านี้ไม่สมบูรณ์ หรือตกเป็นโมฆะคู่สัญญาก็เจตตาให้ข้อสัญญา หรือเงื่อนไขข้ออื่นในสัญญาเช่าใช้บังคับได้อยู่ โดยให้แยกส่วนที่ไม่สมบูรณ์ออกจากส่วนที่สมบูรณ์ ',
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
              'สัญญาเช่าฉบับนี้ทำขึ้น 2 ฉบับ ฉบับละ 5 หน้ามีข้อความถูกต้องตรงกันคู่สัญญาทั้งสองฝ่ายได้อ่านข้อความในสัญญานี้แล้วรับว่าถูกต้องตามเจตนาจึงลงลายมือชื่อ และประทับตรา(ถ้ามี)ต่อหน้าพยาน ไว้เป็นสำคัญคู่สัญญาเก็บรักษาไว้ฝ่ายละฉบับ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
                fontWeight: pw.FontWeight.bold,
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
                      '___________________________ผู้เช่า/The Lessee   ',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      '___________________________ผู้ให้เช่า/The Lessor ',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
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
                              fontSize: 10,
                              font: ttf,
                              color: Colors_pd,
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
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'ภาคผนวก 1',
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
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'ตำแหน่งพื้นที่เช่า',
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
                pw.Text(
                  '(สัญญาเช่า ข้อ 1.)',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    color: Colors_pd,
                    fontSize: font_Size,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                  ),
                ),
                pw.SizedBox(height: 30 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: (netImage.isEmpty)
                      ? pw.Container(
                          height: 500,
                          width: 500,
                          color: PdfColors.grey200,
                          child: pw.Center(
                            child: pw.Text(
                              'Image 500 x 500',
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ))

                      // pw.Image(
                      //     pw.MemoryImage(iconImage),
                      //     height: 72,
                      //     width: 70,
                      //   )
                      : pw.Image(
                          (netImage[1]),
                          height: 500,
                          width: 500,
                        ),
                )
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
                    '___________________________ผู้เช่า/The Lessee   ',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 10,
                      font: ttf,
                      color: Colors_pd,
                      // fontWeight: pw.FontWeight.bold
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    '___________________________ผู้ให้เช่า/The Lessor ',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 10,
                      font: ttf,
                      color: Colors_pd,
                      // fontWeight: pw.FontWeight.bold
                    ),
                  ),
                ),
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
                              fontSize: 10,
                              font: ttf,
                              color: Colors_pd,
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
            // pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(height: 2),
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
                'ภาคผนวก 2',
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
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'ชื่อในการประกอบการและประเภทของกิจการ ',
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
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                '(สัญญาเช่า ข้อ 3.1)',
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
          // pw.Text(
          //   'ชื่อในการประกอบการ: ........$Form_bussshop........',
          //   textAlign: pw.TextAlign.left,
          //   style: pw.TextStyle(
          //     color: Colors_pd,
          //     fontSize: font_Size,
          //     fontWeight: pw.FontWeight.bold,
          //     font: ttf,
          //   ),
          // ),
          pw.Row(
            children: [
              pw.Text(
                'ชื่อในการประกอบการ ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  color: Colors_pd,
                  fontSize: font_Size,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: Colors_pd,
                      width: 0.3, // Underline thickness
                    ))),
                    child: pw.Text(
                      ": $Form_bussshop",
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                  )),
              pw.Expanded(flex: 1, child: pw.Text(''))
            ],
          ),

          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(
            children: [
              pw.Text(
                'รูปแบบ หรือ ประเภทของกิจการ ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  color: Colors_pd,
                  fontSize: font_Size,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: Colors_pd,
                      width: 0.3, // Underline thickness
                    ))),
                    child: pw.Text(
                      ": $Form_typeshop",
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                  )),
              pw.Expanded(flex: 1, child: pw.Text(''))
            ],
          ),

          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(
            children: [
              pw.Text(
                'สินค้าหรือบริการ  ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  color: Colors_pd,
                  fontSize: font_Size,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                      color: Colors_pd,
                      width: 0.3, // Underline thickness
                    ))),
                    child: pw.Text(
                      ":",
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                  )),
              pw.Expanded(flex: 1, child: pw.Text(''))
            ],
          ),
          // pw.RichText(
          //   text: pw.TextSpan(
          //     text: 'สินค้าหรือบริการ : ',
          //     style: pw.TextStyle(
          //       fontSize: font_Size,
          //       font: ttf,
          //       color: Colors_pd,
          //       fontWeight: pw.FontWeight.bold,
          //     ),
          //     children: <pw.TextSpan>[
          //       pw.TextSpan(
          //         text: '___________________________',
          //         style: pw.TextStyle(
          //           // decoration: pw.TextDecoration.underline,
          //           fontSize: font_Size,
          //           font: ttf,
          //           color: Colors_pd,
          //           fontWeight: pw.FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
                    '___________________________ผู้เช่า/The Lessee   ',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 10,
                      font: ttf,
                      color: Colors_pd,
                      // fontWeight: pw.FontWeight.bold
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    '___________________________ผู้ให้เช่า/The Lessor ',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 10,
                      font: ttf,
                      color: Colors_pd,
                      // fontWeight: pw.FontWeight.bold
                    ),
                  ),
                ),
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
