import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

// import 'package:html_widget/html_widget.dart';
import 'package:html/parser.dart' as htmlParser;

import '../../PeopleChao/Rental_Information.dart';

class Pdfgen_Agreement_Ekkamai {
//////////---------------------------------------------------->( **** เอกสารสัญญาเช่า เอกมัยกรุงเทพ  )

  static void exportPDF_Agreement_Ekkamai(
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
      tableData00) async {
    ////
    //// ------------>(ใบเสนอราคา)
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");

    final ttf = pw.Font.ttf(font);
    double font_Size = 12.0;
    DateTime date = DateTime.now();
    String date_string = '${date.day}/${date.month}/${date.year}';
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];

    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // String? base64Image_1 = preferences.getString('base64Image1');
    // String? base64Image_2 = preferences.getString('base64Image2');
    // String? base64Image_3 = preferences.getString('base64Image3');
    // String? base64Image_4 = preferences.getString('base64Image4');
    // String base64Image_new1 = (base64Image_1 == null) ? '' : base64Image_1;
    // String base64Image_new2 = (base64Image_2 == null) ? '' : base64Image_2;
    // String base64Image_new3 = (base64Image_3 == null) ? '' : base64Image_3;
    // String base64Image_new4 = (base64Image_4 == null) ? '' : base64Image_4;
    // Uint8List data1 = base64Decode(base64Image_1);
    // Uint8List data2 = base64Decode(base64Image_2);
    // Uint8List data3 = base64Decode(base64Image_3);
    // Uint8List data4 = base64Decode(base64Image_4);

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    // final tableData = [
    //   for (int index = 0; index < quotxSelectModels.length; index++)
    //     [
    //       '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
    //     ],
    // ];
    double Sumtotal = 0;
    for (int index = 0; index < quotxSelectModels.length; index++)
      Sumtotal = Sumtotal +
          (int.parse(quotxSelectModels[index].term!) *
              double.parse(quotxSelectModels[index].total!));
    ///////////////////////------------------------------------------------->
    final List<String> _digitThai = [
      'ศูนย์',
      'หนึ่ง',
      'สอง',
      'สาม',
      'สี่',
      'ห้า',
      'หก',
      'เจ็ด',
      'แปด',
      'เก้า'
    ];

    final List<String> _positionThai = [
      '',
      'สิบ',
      'ร้อย',
      'พัน',
      'หมื่น',
      'แสน',
      'ล้าน'
    ];
/////////////////////////////------------------------>(จำนวนเต็ม)
    String convertNumberToText(int number) {
      String result = '';
      int numberIntPart = number.toInt();
      int numberDecimalPart = ((number - numberIntPart) * 100).toInt();
      final List<String> digits = numberIntPart.toString().split('');
      int position = digits.length - 1;
      for (int i = 0; i < digits.length; i++) {
        final int digit = int.parse(digits[i]);
        if (digit != 0) {
          if (position == 6) {
            result = '$result${_positionThai[6]}';
          }
          if (position != 6 && position != 8) {
            if (digit == 1 && position == 1) {
              // result = '$resultเอ็ด';
              result = '$resultสิบ';
            } else {
              result =
                  '$result${_digitThai[digit]}${_positionThai[position % 6]}';
            }
          } else if (position == 8) {
            result = '$result${_digitThai[digit]}${_positionThai[6]}';
          }
        }
        position--;
      }
      // final String decimalText =
      //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
      return result;
    }

/////////////////////////////------------------------>(จำนวนทศนิยม สตางค์)
    String convertNumberToText2(int number2) {
      String result = '';
      int numberIntPart = number2.toInt();
      int numberDecimalPart = ((number2 - numberIntPart) * 100).toInt();
      final List<String> digits = numberIntPart.toString().split('');
      int position = digits.length - 1;
      for (int i = 0; i < digits.length; i++) {
        final int digit = int.parse(digits[i]);
        if (digit != 0) {
          if (position == 6) {
            result = '$result${_positionThai[6]}';
          }
          if (position != 6 && position != 8) {
            if (digit == 1 && position == 1) {
              // result = '$resultเอ็ด';
              result = '$resultสิบ';
            } else {
              result =
                  '$result${_digitThai[digit]}${_positionThai[position % 6]}';
            }
          } else if (position == 8) {
            result = '$result${_digitThai[digit]}${_positionThai[6]}';
          }
        }
        position--;
      }
      // final String decimalText =
      //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
      return result;
    }

////////////////----------------------------->(ตัด หน้าจุดกับหลังจุดออกจากกัน)
    var number_ = "${nFormat2.format(Sumtotal)}";
    var parts = number_.split('.');
    var front = parts[0];
    var back = parts[1];

////////////////--------------------------------->(บาท)
    double number = double.parse(front);
    final int numberIntPart = number.toInt();
    final double numberDecimalPart = (number - numberIntPart) * 100;
    final String numberText = convertNumberToText(numberIntPart);
    final String decimalText = convertNumberToText(numberDecimalPart.toInt());
////////////////---------------------------------->(สตางค์)
    double number2 = double.parse(number_);
    final int numberIntPart2 = number.toInt();
    final int numberDecimalPart2 = ((number2 - numberIntPart2) * 100).round();
    final String numberText2 = convertNumberToText2(numberIntPart2);
    final String decimalText2 =
        convertNumberToText2(numberDecimalPart2.toInt());
////////////////------------------------------->(เช็คและเพิ่มตัวอักษร)
    final String formattedNumber = (decimalText2.replaceAll(
                _digitThai[0], "") ==
            '')
        ? '$numberTextบาทถ้วน'
        : (back[0].toString() == '0')
            ? '$numberTextบาทศูนย์${decimalText2.replaceAll(_digitThai[0], "")}สตางค์'
            : '$numberTextบาท${decimalText2.replaceAll(_digitThai[0], "")}สตางค์';

    String text_Number1 = formattedNumber;
    RegExp exp1 = RegExp(r"สองสิบ");
    if (exp1.hasMatch(text_Number1)) {
      text_Number1 = text_Number1.replaceAll(exp1, 'ยี่สิบ');
    }
    String text_Number2 = text_Number1;
    RegExp exp2 = RegExp(r"สิบหนึ่ง");
    if (exp2.hasMatch(text_Number2)) {
      text_Number2 = text_Number2.replaceAll(exp2, 'สิบเอ็ด');
    }
///////////////////////------------------------------------------------->
    // Your HTML content
    String htmlContent = """
<span style="font-size:20px;font-weight:bold;">FOR INTERNAL APPLICATION API VERSION 1.0.0</span><br><span style="margin-top:15px;font-size:13px;">Please read api manual guide for understanding methods availables list and how to
use.</span><br><br><span style="margin-top:15px;font-size:12px;">This page is generated by default and your remote IP is 183.88.217.148.</span>
 """;

    // Parse the HTML content into Flutter widget tree
    var document = htmlParser.parse(htmlContent);

    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          return pw.Column(children: [
            pw.Row(
              children: [
                (netImage.isEmpty)
                    ? pw.Container(
                        height: 72,
                        width: 70,
                        color: PdfColors.grey200,
                        child: pw.Center(
                          child: pw.Text(
                            '$bill_name ',
                            maxLines: 1,
                            style: pw.TextStyle(
                              fontSize: 10,
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
                        '$bill_name',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        '$bill_addr',
                        maxLines: 3,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          color: PdfColors.grey800,
                          font: ttf,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Spacer(),
                pw.Container(
                  width: 190,
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
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        'อีเมล: $bill_email',
                        maxLines: 2,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                        maxLines: 2,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                      pw.Text(
                        'ณ วันที่:  $thaiDate ${DateTime.now().year + 543}',
                        maxLines: 2,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey800),
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
                pw.Spacer(),
                pw.Container(
                  // width: 180,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'เลขที่สัญญา....$Get_Value_cid....',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.black),
                      ),
                      pw.Text(
                        'ทำที่ เอกมัยช้อปปิ้งมอลล์ (เวิ้งโบราณ)',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                            fontSize: 10.0, font: ttf, color: PdfColors.black),
                      ),
                      pw.Text(
                        'วันที่ทำสัญญา ............. ',
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'สัญญาเช่าพื้นที่อาคาร',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                  ),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'เอกมัยช้อปปิ้งมอลล์ (เวิ้งโบราณ)',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            pw.Text(
              'สัญญาเช่าพื้นที่อาคารฉบับนี้ ซึ่งต่อไปนี้จะเรียกว่า “สัญญา” ทำขึ้นที่....$bill_name....',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'แขวง คลองตันเหนือ เขต วัฒนา กรุงเทพมหานคร เมื่อวันที่.......ระหว่าง:',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.Text(
              '1). $bill_name โดย ผู้มีอำนาจลงนามท้ายสัญญา ทะเบียนนิติบุคคลเลขที่....$bill_tax....สำนักงานแห่งใหญ่ตั้งอยู่ที่....$bill_addr....ซึ่งต่อไปในสัญญาฉบับนี้จะเรียกว่า “ผู้ให้เช่า”',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '2). กับ....$Form_bussshop.....บัตรประจำตัวประชาชนเลขที่....${Form_tax}.....อยู่ที่....$Form_address....ต่อไปในสัญญานี้เรียกว่า “ผู้เช่า” อีกฝ่ายหนึ่ง',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'คู่สัญญาทั้งสองฝ่ายได้ตกลงทำสัญญากันโดยมีข้อความ ดังต่อไปนี้ : ',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '1. พื้นที่เช่า',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'โดยที่ผู้ให้เช่าเป็นเจ้าของสิทธิการเช่าที่ดินพร้อมอาคารในโครงการ เอกมัยช้อปปิ้งมอลล์   (เวิ้งโบราณ)รวมทั้งพื้นที่บริการ และสาธารณูปโภค ทั้งหมดภายในโครงการ ซึ่งตั้งอยู่  ณ เลขที่ 3 ซอยเจริญมิตร (เอกมัย10)แขวง คลองตันเหนือ เขต วัฒนา กรุงเทพมหานคร 10110 ตกลงให้ผู้เช่าเช่าพื้นที่  บริเวณพื้นที่โซน....$Form_zn....รหัสพื้นที่....$Form_ln....มีเนื้อที่ประมาณ....$Form_area....ตารางเมตร จำนวนพื้นที่....$Form_qty....ล็อค/ห้อง ซึ่งต่อไปนี้จะเรียกว่า “พื้นที่เช่า” และผู้เช่าตกลงเช่าพื้นที่เช่าดังกล่าวจากผู้ให้เช่า ',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '2. วัตถุประสงค์แห่งการเช่า',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '2.1.ผู้เช่าตกลงเช่าและผู้ให้เช่าตกลงให้เช่าซึ่งพื้นที่เช่าโดยมีวัตถุประสงค์เพื่อประกอบกิจการประเภทร้านขายอาหาร และเครื่องดื่มผู้เช่าตกลงจะไม่ใช้หรือยอมให้บุคคลอื่นใช้พื้นที่เช่านอกเหนือไปจากวัตถุประสงค์แห่งการเช่าตามที่กำหนด ไว้ในสัญญาฉบับนี้ ',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '2.2.ผู้เช่าจะต้องใช้พื้นที่เช่าเพื่อกิจการตามที่ระบุไว้ในข้อ2.1.เท่านั้นหากระหว่างอายุการเช่าผู้เช่าประสงค์เปลี่ยนแปลง ประเภทการใช้พื้นที่เช่าไปประกอบกิจการประเภทอื่นจะต้องได้รับอนุญาตจากผู้ให้เช่าเป็นลายลักษณ์อักษรก่อน มิฉะนั้น จะเป็นเหตุผลให้ผู้ให้เช่าบอกเลิกสัญญาได้',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '2.3.การประกอบกิจการตามสัญญานี้ผู้เช่าจะเปิดบริการตั้งแต่เวลาXX.XXน.ถึงเวลาXX.XXน.ทั้งนี้หากจะมีการเปลี่ยนแปลงกำหนดเวลา เปิด-ปิดการให้บริการสำหรับร้านที่กำหนดไว้ดังกล่าวผู้เช่าจะต้องได้รับความเห็นชอบเป็นหนังสือจาก ผู้ให้เช่าก่อนทุกครั้ง',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '             ในกรณีผู้เช่าประกอบกิจการร้านอาหารตามชนิดประเภทที่กฎหมายกำหนดให้ต้องได้รับอนุญาตผู้เช่าต้อง ดำเนินการขออนุญาตและต้องได้รับอนุญาตให้ถูกต้องตามกฎหมายหากผู้เช่าไม่ดำเนินการให้ถูกต้องครบถ้วนผู้ให้เช่า มีสิทธิบอกเลิกสัญญาได้ทันที',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '3. ระยะเวลาการเช่า',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              (Form_rtname.toString() == 'รายวัน')
                  ? '3.1.ผู้ให้เช่าตกลงให้เช่าและผู้เช่าตกลงเช่าพื้นที่เช่าเป็นระยะเวลาทั้งสิ้น....$Form_period....วัน....โดยเริ่มเช่าตั้งแต่ เริ่มวันที่....$Form_sdate....ถึงวันที่....$Form_ldate...ซึ่งต่อไปในสัญญานี้เรียกว่า “ระยะเวลาการเช่า”'
                  : (Form_rtname.toString() == 'รายเดือน')
                      ? '3.1.ผู้ให้เช่าตกลงให้เช่าและผู้เช่าตกลงเช่าพื้นที่เช่าเป็นระยะเวลาทั้งสิ้น....$Form_period....เดือน....โดยเริ่มเช่าตั้งแต่ เริ่มวันที่....$Form_sdate....ถึงวันที่....$Form_ldate...ซึ่งต่อไปในสัญญานี้เรียกว่า “ระยะเวลาการเช่า”'
                      : (Form_rtname.toString() == 'รายปี')
                          ? '3.1.ผู้ให้เช่าตกลงให้เช่าและผู้เช่าตกลงเช่าพื้นที่เช่าเป็นระยะเวลาทั้งสิ้น....$Form_period....ปี....โดยเริ่มเช่าตั้งแต่ เริ่มวันที่....$Form_sdate....ถึงวันที่....$Form_ldate...ซึ่งต่อไปในสัญญานี้เรียกว่า “ระยะเวลาการเช่า”'
                          : '3.1.ผู้ให้เช่าตกลงให้เช่าและผู้เช่าตกลงเช่าพื้นที่เช่าเป็นระยะเวลาทั้งสิ้น....$Form_period....$Form_rtname....โดยเริ่มเช่าตั้งแต่ เริ่มวันที่....$Form_sdate....ถึงวันที่....$Form_ldate...ซึ่งต่อไปในสัญญานี้เรียกว่า “ระยะเวลาการเช่า”',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '3.2.โดยดุลพินิจของผู้ให้เช่าแต่เพียงผู้เดียวเมื่อครบกำหนดระยะเวลาการเช่าตามสัญญาฉบับนี้แล้วหากผู้เช่าประสงค์ จะเช่าพื้นที่เช่าต่อไปผู้ให้เช่าอาจจะพิจารณาให้ผู้เช่าเช่าพื้นที่เช่าต่อไปให้อีกคราวละไม่เกิน 1 ปีโดยผู้เช่าจะต้องแจ้ง ความจำนงล่วงหน้าเป็นลายลักษณ์อักษรที่จะเช่าพื้นที่เช่าต่อไปยังผู้ให้เช่าเป็นระยะเวลาอย่างน้อย 90 วัน ก่อนสิ้นสุดกำหนดระยะเวลาการเช่าตามสัญญาฉบับนี้ ทั้งนี้ หากผู้ให้เช่าได้พิจารณาให้ผู้เช่าเช่าพื้นที่เช่าต่อไป คู่สัญญาจะตกลงรายละเอียดและเงื่อนไข พร้อมลงนามทำสัญญาเช่าฉบับใหม่ล่วงหน้าไม่น้อยกว่า 60 วัน',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '3.3.กรณีที่สัญญาเช่าอาคารครบกำหนดอายุตามข้อ3.1แล้วผู้เช่าไม่แสดงความประสงค์ที่จะต่ออายุสัญญาเช่าหรือผู้ให้เช่าไม่อนุญาตให้ผู้เช่าต่ออายุสัญญาเช่าตามข้อ3.2ให้ถือว่าสัญญาเช่าอาคารฉบับนี้สิ้นสุดลงโดยมิพักต้องบอกกล่าวล่วงหน้า อีกผู้เช่าจะต้องดำเนินการขนย้ายทรัพย์สินและบริวารพร้อมส่งมอบพื้นที่โครงการคืนแก่ผู้ให้เช่าในทันที',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '4. ค่าเช่า และการชำระเงิน',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '4.1ผู้เช่าตกลงชำระค่าเช่าให้แก่ผู้ให้เช่าล่วงหน้าเป็นรายเดือนในอัตราเดือนละ....21,000...บาท....(สองหมื่นหนึ่งพันบาทถ้วน)....ภายในทุกวันที่....5....ของทุกเดือนหากวันที่....5....ของเดือนใดตรงกับวันหยุดธนาคารให้เลื่อนการชำระค่าเช่า ของเดือนนั้นไปเป็นวันเปิดทำการธนาคารวันแรกถัดจากวันหยุดเริ่มชำระ...1 สิงหาคม 2566...เป็นต้นไป  ',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '4.2.การชำระค่าเช่าและเงินใดๆที่ผู้เช่าต้องชำระให้แก่ผู้ให้เช่าตามสัญญานี้ผู้เช่าตกลงจะชำระให้แก่ผู้ให้เช่าด้วยโดยโอน เงินเข้าบัญชีธนาคาร....กสิกรไทย....เลขที่บัญชี....1192468120....ชื่อบัญชี....บจ.ด๊อกเตอร์พิมลวรรณและครอบครัว....นั้นในกรณีที่ผู้เช่าโอนเงินค่าเช่าเข้าบัญชีเงินฝากของผู้ให้เช่าตามที่ระบุข้างต้นเป็นที่เรียบร้อยแล้วผู้เช่ามีหน้าที่นำส่งสำเนาใบฝากเงินให้ผู้ให้เช่าเก็บไว้เป็นหลักฐาน',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '4.3.หนี้ใดๆที่ผู้เช่ามีหน้าที่ต้องชำระให้แก่ผู้ให้เช่าตามสัญญาฉบับนี้หากผู้เช่าไม่ชำระภายในระยะเวลาที่กำหนดผู้เช่าตกลงให้ผู้ให้เช่าคิดเบี้ยปรับในอัตราวันละ....500....บาท....(ห้าร้อยบาท)....ของจำนวนวันที่ผิดนัดชำระดังกล่าวจนกว่าจะได้มีการชำระหนี้ครบถ้วน',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '4.4.ในกรณีที่ผู้เช่าผิดนัดชำระค่าเช่าหรือเงินใดๆที่ผู้เช่าต้องชำระให้แก่ผู้ให้เช่าตามสัญญานี้เกินกว่า30วันผู้เช่ายินยอมให้ผู้ให้เช่างดให้การบริการกระแสไฟฟ้าและน้ำประปาจนกว่าผู้เช่าจะได้ชำระค่าเงินดังกล่าวพร้อมเบี้ยปรับครบถ้วนแล้วซึ่งหากผู้ให้เช่าได้งดการให้บริการกระแสไฟฟ้าและน้ำประปาและผู้เช่าชำระค่าเช่าและเบี้ยปรับในภายหลังแล้วผู้เช่ายังคงจะ ต้องชำระค่าดำเนินการจ่ายกระแสไฟฟ้าและน้ำประปาใหม่แก่ผู้ให้เช่าเพิ่มเติมในอัตราครั้งละเป็นเงินไม่น้อยกว่า จำนวน....500....บาท....(ห้าร้อยบาท)....',

              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '5. หลักประกันการปฏิบัติตามสัญญา',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '5.1.เพื่อเป็นหลักประกันการปฏิบัติตามสัญญาผู้เช่าตกลงวางหลักประกันให้แก่ผู้ให้เช่าในวันทำสัญญาฉบับนี้เป็นเงินจำนวนทั้งสิ้น....105,000....บาท....(หนึ่งแสนห้าพันบาทถ้วน)....ซึ่งต่อไปในสัญญาฉบับนี้จะเรียกว่า“หลักประกัน”',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '5.2.ในกรณีที่ผู้เช่าไม่ทำการบำรุงรักษาหรือดูแลพื้นที่เช่าให้อยู่ในสภาพอันดีตามหน้าที่ของผู้เช่าจงใจหรือประมาทเลินเล่อจนก่อให้เกิดความเสียหายต่อพื้นที่เช่าผู้ให้เช่ามีสิทธิที่จะทำการซ่อมแซมพื้นที่เช่าโดยใช้หลักประกันดังกล่าวในการซ่อมแซมพื้นที่เช่าโดยที่หากผู้ให้เช่าได้ใช้หลักประกันไปในการดังกล่าวไม่ว่าทั้งหมดหรือแต่บางส่วนผู้เช่าตกลงจะนำหลักประกันจำนวนใหม่มาวางไว้กับผู้ให้เช่าให้ครบถ้วนภายใน....15....วันนับแต่วันที่ได้รับแจ้งจากผู้ให้เช่า',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '5.3.เมื่อสัญญาฉบับนี้สิ้นสุดลงผู้ให้เช่าจะคืนหลักประกันให้แก่ผู้เช่าโดยไม่มีดอกเบี้ยภายใน....30....วันหลังจากการหักชำระค่าเช่า,ค่าบริการ,ค่าไฟฟ้า,ค่าน้ำประปา,ค่าโทรศัพท์,หนี้และค่าเสียหายหรือค่าใช้จ่ายอื่นๆที่ผู้เช่าจะต้องชำระให้แก่ผู้ให้ เช่า(ถ้ามี)ในกรณีที่หลักประกันดังกล่าวไม่เพียงพอต่อหนี้ค้างชำระหรือความเสียหายใดๆที่เกิดขึ้นผู้เช่าตกลงจะชำระส่วนที่ขาดให้แก่ผู้ให้เช่าเพิ่มเติมจนครบถ้วนโดยมิชักช้า',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '5.4.ในกรณีที่สัญญาฉบับนี้ได้สิ้นสุดลงอันเนื่องมาจากการที่ผู้เช่าได้ฝ่าฝืนหรือปฏิบัติผิดสัญญาฉบับนี้รวมถึงแต่ไม่จำกัดเพียงผู้เช่าเลิกสัญญาฉบับนี้ก่อนกำหนดระยะเวลาการเช่าผู้เช่าตกลงยินยอมให้ผู้ให้เช่าริบหลักประกันได้ทันทีทั้งนี้การริบหลักประกันในกรณีดังกล่าวไม่เป็นการตัดสิทธิของผู้ให้เช่าในการที่จะเรียกร้องความเสียหายที่เกิดขึ้นจริงที่อาจมีสิทธิเรียกร้อง ได้ตามกฎหมายอีกส่วนหนึ่งต่างหากจากกัน',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '5.5.กรณีที่คู่สัญญามีการต่ออายุสัญญาเช่าออกไปทั้งมีการปรับขึ้นค่าเช่าผู้เช่ายินยอมวางเงินประกันการเช่าต่อผู้ให้เช่า เพิ่มเติมตามสัดส่วนของค่าเช่าที่เพิ่มขึ้นเงินประกันเพิ่มเติมนี้ผู้เช่ายินยอมชำระเพิ่มเติมในวันที่ทำสัญญาต่ออายุการเช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '6. ค่าใช้สาธารณูปโภค และค่าภาษีอากร',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '6.1.ผู้เช่าตกลงจะชำระค่าไฟฟ้า,ค่าน้ำประปา,ค่าโทรศัพท์,ค่าส่วนกลางและหรือค่าใช้สาธารณูปโภคอื่นๆ(ถ้ามี)ให้แก่ ผู้ให้เช่าทุกเดือนตามปริมาณการใช้งานจริงในอัตราค่าไฟฟ้าหน่วยละ....7....บาท....และค่าน้ำประปาหน่วยละ....20....บาท....(ซึ่งยังไม่รวมภาษีมูลค่าเพิ่ม)....ภายใน....5....วัน....นับแต่วันที่ผู้เช่าได้รับใบแจ้งหนี้ที่ผู้ให้เช่าเรียกเก็บ ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '6.2.อัตราค่าบริการสาธารณูปโภคดังกล่าวอาจมีการเปลี่ยนแปลงโดยผู้ให้เช่าได้โดยผู้ให้เช่าจะแจ้งให้ผู้เช่าทราบล่วงหน้า ก่อนถึงกำหนดชำระและผู้เช่าตกลงจะชำระค่าบริการสาธารณูปโภคตามอัตราที่ผู้ให้เช่าได้แจ้งให้ทราบดังกล่าว',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '6.3.ผู้เช่าตกลงเป็นผู้รับผิดชอบชำระค่าภาษีที่ดินและสิ่งปลูกสร้างค่าอากรแสตมป์,ค่าภาษีป้ายหรือภาษีอากรอื่นใด อันเกี่ยวเนื่องกับการเช่าพื้นที่เช่าหรือเกิดจากการใช้ประโยชน์จากพื้นที่เช่าตามสัญญาฉบับนี้ตามอัตราส่วนของการเช่า ที่ดินซึ่งผู้ให้เช่าจะเรียกเก็บจากผู้เช่าต่อไปเมื่อถึงกำหนดที่ทางราชการเรียกเก็บตามกฎหมายที่ใช้บังคับอยู่ในขณะนี้หรือในภายภาคหน้า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '7. การทำประกันภัยในพื้นที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '7.1.ผู้เช่าจะต้องทำประกันวินาศภัย,อัคคีภัยและทรัพย์สินสูญหายของสถานที่เช่าในนามผู้เช่าโดยผู้เช่าเป็นผู้ชำระเบี้ยประกันภัยพร้อมส่งสำเนากรมธรรม์แก่ผู้ให้เช่าโดยพลันโดยผู้รับผลประโยชน์จากความเสียหายในส่วนโครงสร้างของอาคาร ผู้รับผลประโยชน์ในสัญญาประกันภัยผู้เช่าต้องระบุให้เจ้าของกรรมสิทธิ์สิ่งปลูกสร้างหรือผู้ให้เช่าเป็นผู้รับผลประโยชน์เท่านั้นยกเว้นในส่วนของทรัพย์สินของผู้เช่าเองโดยตรงและผู้เช่าจะต้องส่งสำเนาสัญญาประกันภัยให้แก่ผู้ให้เช่าโดยพลัน	',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '8. การบำรุงรักษาและใช้ประโยชน์ในพื้นที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '8.1.ผู้เช่าตกลงและให้สัญญาว่าจะไม่ใช้พื้นที่เช่านอกเหนือไปจากวัตถุประสงค์แห่งการเช่าตามที่กำหนดไว้ใน สัญญาฉบับนี้เว้นแต่จะได้รับความยินยอมเป็นลายลักษณ์อักษรจากผู้ให้เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '8.2.ผู้เช่าตกลงและให้สัญญาว่าจะดูแลและบำรุงรักษาพื้นที่เช่าให้อยู่ในสภาพอันดีเช่นเดียวกับที่วิญญูชนจะพึงรักษา ทรัพย์สินของตนเองและดูแลรักษาความสะอาดภายในพื้นที่เช่าไม่ให้สกปรกรุงรังหรือเป็นที่น่ารังเกียจแก่ผู้พบเห็น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '8.3.ผู้เช่าตกลงและให้สัญญาว่าจะใช้ประโยชน์ในพื้นที่เช่าด้วยความสงบเรียบร้อยไม่กระทำการใดหรือยินยอมให้บุคคล อื่นกระทำการใดภายในหรือเกี่ยวเนื่องกับพื้นที่เช่าอันเป็นหรืออาจเป็นการขัดต่อกฎหมายหรือขัดต่อศีลธรรมอันดีของประชาชนหรือโดยเป็นหรืออาจเป็นเหตุให้เกิดอันตรายต่อสุขภาพอนามัยหรือเป็นสิ่งที่น่ารังเกียจหรือก่อให้เกิดความเดือดร้อน รำคาญให้แก่ผู้ให้เช่าหรือบุคคลอื่นใดที่อยู่ใกล้เคียงพื้นที่เช่านั้น ',
              // textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '8.4.ผู้เช่าตกลงและให้สัญญาว่า จะใช้ประโยชน์ในพื้นที่เช่าให้สอดคล้องกับระเบียบ กฎเกณฑ์ ข้อบังคับ และคำสั่งใด ๆ เกี่ยวกับการใช้พื้นที่เช่าไม่ว่าหน่วยงานราชการเป็นผู้ออกใช้บังคับหรือหน่วยงานอื่นที่มีอำนาจออกกฎเกณฑ์บังคับพื้นที่เช่านี้โดยผู้เช่าและบริวารของผู้เช่าจะต้องเชื่อฟังและปฏิบัติตามโดยเคร่งครัด',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '8.5.ผู้เช่าตกลงและให้สัญญาว่าจะใช้ประโยชน์ในพื้นที่เช่าให้สอดคล้องกับระเบียบกฎเกณฑ์ข้อบังคับและคำสั่งใดๆ ที่ผู้ให้เช่าประกาศบังคับใช้ภายในอาคารและบริเวณโครงการเอกมัยช้อปปิ้งมอลล์(เวิ้งโบราณ)ซึ่งพื้นที่เช่าตั้งอยู่รวมถึง แต่ไม่จำกัดเพียงแนวปฏิบัติเพื่อความปลอดภัยวันและเวลาเปิดและปิดทำการระบบสาธารณูปโภคส่วนกลางการซ้อมหนีไฟรวมถึงให้ความร่วมมือในการดังกล่าวทั้งปวงด้วย',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                  fontSize: font_Size, font: ttf, color: PdfColors.black),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '8.6.ผู้เช่าจะไม่ทำการติดตั้งเครื่องมือ,เครื่องใช้,เครื่องจักร,วัตถุสิ่งของที่มีน้ำหนักกดทับเกินกว่า....300....กิโลกรัม.... ต่อตารางเมตร ณ บริเวณพื้นที่เช่าเว้นแต่จะได้รับความยินยอมจากผู้ให้เช่าเป็นลายลักษณ์อักษร ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '8.7.ผู้เช่าต้องใช้ความระมัดระวังและป้องกันไม่ให้เกิดอัคคีภัยในพื้นที่เช่าทั้งไม่เก็บวัตถุไวไฟทั้งห้ามใช้เทียนไขธูปหอมสิ่งที่อาจทำให้เกิดเพลิงไหม้หรือวัตถุที่อาจระเบิดได้ไว้ในพื้นที่เช่าหากเกิดความเสียหายด้วยเหตุฝ่าฝืนดังกล่าวผู้เช่าจะต้องเป็นผู้รับผิดชอบในความเสียหายต่อผู้ให้เช่าและบุคคลภายนอกที่ได้รับผลเสียหายด้วยตนเองอย่างไม่จำกัดจำนวน	',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '8.8.ผู้เช่าจะไม่ทำการโอนสิทธิการเช่าหรือให้บุคคลอื่นทำการเช่าช่วงไม่ว่าทั้งหมดหรือแต่บางส่วนของพื้นที่เช่าเว้นแต่ จะได้รับความยินยอมจากผู้ให้เช่าเป็นลายลักษณ์อักษรเท่านั้น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '8.9.ในระหว่างสัญญาเช่าหากผู้เช่าประพฤติผิดสัญญาเช่าและผู้ให้เช่าได้มีการบอกเลิกสัญญาแล้วผู้เช่ายังคงไม่ปฏิบัติตามผู้เช่ายินยอมให้ผู้ให้เช่าเข้าทำการปิดกั้นปิดกุญแจไม่อนุญาตให้ผู้เช่าเข้าใช้พื้นที่เช่าได้โดยผู้เช่าสละสิทธิที่จะดำเนินคดีทางแพ่งและหรือทางอาญาต่อผู้ให้เช่าทั้งสิ้น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '9. การแก้ไข ดัดแปลง หรือต่อเติมพื้นที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '9.1.ผู้เช่าตกลงจะไม่ทำการแก้ไขดัดแปลงหรือต่อเติมพื้นที่เช่าตลอดระยะเวลาการเช่าตามสัญญาฉบับนี้รวมถึงจะไม่ทำ การติดตั้งสร้างขึ้นหรือติดไว้ซึ่งสิ่งติดตรึงถาวรวัสดุหรือสิ่งใดๆลงในพื้นที่เช่าเว้นแต่จะได้รับความยินยอมเป็น ลายลักษณ์อักษรจากผู้ให้เช่าเสียก่อน ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '9.2.ในการขอความยินยอมจากผู้ให้เช่าในวรรคก่อนผู้เช่าจะยื่นแบบแปลนรายละเอียดรวมถึงประเภทและคุณภาพวัสดุ อุปกรณ์ต่างๆในการแก้ไขดัดแปลงหรือต่อเติมอื่นใดๆกับพื้นที่เช่าเพื่อให้ผู้ให้เช่าตรวจแบบและพิจารณาและยินยอม จึงจะเริ่มดำเนินการตามแบบแปลนนั้นได้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '9.3.ในการดำเนินการแก้ไขดัดแปลงหรือต่อเติมพื้นที่เช่าหลังจากที่ผู้ให้เช่าได้ยินยอมแล้วผู้เช่าจะ(ก)ดำเนินการโดยไม่ก่อ ให้เกิดความเสียหายใดๆต่อโครงสร้างของพื้นที่เช่า(ข)ดำเนินการด้วยความระมัดระวังรวมถึงการจัดหาผู้รับจ้างผู้รับเหมาที่มีมาตรฐานในการดำเนินการในกรณีที่ผู้เช่ามิได้ดำเนินการเอง(ค)ดำเนินการโดยเป็นไปตามกฎหมายกฎระเบียบคำสั่ง ประกาศเกี่ยวข้องกับการแก้ไขดัดแปลงหรือต่อเติมพื้นที่เช่าอันรวมถึงแต่ไม่จำกัดเพียงกฎหมายเกี่ยวกับการควบคุมอาคารกฎหมายการใช้อาคารเพื่อประกอบกิจการที่มีกฎหมายควบคุมกฎหมายเกี่ยวกับผังเมือง  ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '9.4.การดำเนินการตกแต่งพื้นที่เช่าผู้เช่าจะต้องดำเนินการให้แล้วเสร็จภายในกำหนด...45....วัน....นับแต่วันที่ได้รับ ความเห็นชอบในแบบตกแต่งจากผู้ให้เช่า ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '9.5.ระหว่างการดำเนินการตกแต่งพื้นที่เช่าผู้เช่าจะต้องไม่ทำการเปลี่ยนแปลงแก้ไขในส่วนของโครงสร้างอาคาร หรือรูปแบบของอาคารหรือไม่ทำให้ส่วนใดส่วนหนึ่งของโครงสร้างอาคารหรือรูปแบบของอาคารได้รับความเสียหาย กับทั้งไม่ทำการรบกวนผู้เช่ารายอื่นหากเกิดความเสียหายดังกล่าวข้างต้นขึ้นผู้เช่าจะต้องเป็นผู้รับผิดชอบในความเสียหาย ที่ตนก่อขึ้นแต่เพียงผู้เดียว ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '10. ความรับผิดของผู้เช่า    ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ผู้เช่าตกลงจะรับผิดชดใช้แก่ผู้ให้เช่าหากทรัพย์ที่เช่าเกิดความเสียหายอันเกิดจากการกระทำและหรือการละเว้นการกระทำของผู้เช่า,บริวาร,ผู้รับจ้าง หรือตัวแทนใดๆของผู้เช่าโดยผู้เช่าตกลงจะเป็นผู้รับผิดชอบชดใช้ค่าเสียหายให้แก่ผู้ให้เช่าทั้งสิ้น เว้นแต่ในกรณีที่ความเสียหายนั้นเกิดขึ้นจากการใช้งานตามปกติหรือการเสื่อมสภาพจากการใช้งานตามปกติรวมถึง ความชำรุดบกพร่องที่มีอยู่ก่อนการครอบครองทรัพย์ที่เช่าของผู้เช่า',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.1.ผู้เช่ามีหน้าที่ต้องช่วยกันสอดส่องดูแลรักษาความปลอดภัยเกี่ยวกับชีวิตและทรัพย์สินของลูกค้าผู้เข้ามาใช้บริการพื้นที่โครงการตนเองบริวารและบุคคลโดยทั่วไปอย่างสุดความสามารถ',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.2.ผู้เช่ามีหน้าที่จะต้องระมัดระวังเกี่ยวกับไฟฟ้าลัดวงจรในพื้นที่โครงการภายในพื้นที่เช่าตามข้อ(10.1)โดยทำการ ปรับเปลี่ยนซ่อมแซมสายไฟฟ้าและอุปกรณ์ไฟฟ้าในส่วนของผู้เช่าให้อยู่ในสภาพที่ปลอดภัยพร้อมใช้งานอยู่เสมอโดย เฉพาะจุดเชื่อมโยงไฟฟ้าจากมิเตอร์ไฟฟ้าย่อยไปยังตู้ควบคุมไฟฟ้าภายในพื้นที่เช่าและจากตู้ควบคุมไฟฟ้าไปยัง เครื่องใช้ไฟฟ้าของแต่ละจุดภายในพื้นที่เช่าโดยค่าใช้จ่ายของผู้เช่าเองทั้งสิ้นและผู้เช่าต้องส่งเอกสารการรับรองโดยวิศวกรหรือช่างไฟฟ้าที่มีประกาศนียบัตรเกี่ยวกับการรับรองดังกล่าวต่อผู้ให้เช่าเมื่อมีการต่ออายุสัญญาเช่าคราวต่อไป ',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.3.ผู้เช่ามีหน้าที่ติดตั้งเครื่องดับเพลิงเพื่อป้องกันเพลิงไหม้ในเบื้องต้นและเครื่องส่งสัญญาณและตรวจสอบไฟไหม้หรือ กลุ่มควันภายในพื้นที่เช่านับจากวันทำสัญญาฉบับนี้ไม่เกิน....30....วัน',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.4.ผู้เช่ามีหน้าที่ต้องรักษาความสะอาดในพื้นที่เช่าและจุดเชื่อมต่อทางเข้า-ทางออกระหว่างพื้นที่เช่ากับพื้นที่ส่วนกลาง และผู้เช่าจะต้องมีถังดักไขมันในจุดที่รับน้ำเสียจากการชำระล้างจาน-ชามและเครื่องครัวต่างๆก่อนปล่อยน้ำเสีย ออกจากพื้นที่เช่า',
              //textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.5.ผู้เช่ามีหน้าที่ตามกฎหมายและไม่มีสิทธิในการต่อเติมพื้นที่เช่าออกไปด้านข้างหรือด้านหลังนอกเหนือจากสัญญาเช่าพื้นที่อาคารทั้งนี้เพื่อประโยชน์ตามกฎหมายในการหนีไฟและห้ามผู้เช่ากลบฝังหรือปิดฝาท่อหรือทางไหลของรางระบายน้ำทิ้งภายในพื้นที่โครงการ',
//textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.6.ผู้เช่ามีหน้าที่จะต้องจัดให้มีทางออกด้านหลังเพื่อการหนีไฟในกรณีฉุกเฉินการเกิดเพลิงไหม้พื้นที่โครงการหรือภายในอาคารที่เช่าอย่างน้อย 1 จุด',
              //textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.7.ผู้เช่าที่เป็นร้านเหล้า-อาหารและเปิดในเวลาเย็นถึงกลางคืนจะต้องจัดให้มีพนักงานรักษาความสะอาดห้องน้ำ ชาย-ห้องน้ำหญิงของส่วนกลางทุกชั้นและพื้นที่โครงการส่วนกลางที่เชื่อมโยงกับอาคารที่เช่าจุดประสงค์เพื่อทำความสะ อาดตลอดเวลาที่ผู้เช่าเปิดดำเนินกิจการจนถึงหลังเวลาปิดดำเนินกิจการให้สะอาดเรียบร้อยก่อนรุ่งขึ้นของวันใหม่โดยผู้เช่าที่เป็นร้านเหล้า-อาหารจะต้องร่วมกันเฉลี่ยออกค่าใช้จ่ายและมีการประชุมปรึกษาหารือระหว่างกันโดยมีตัวแทนของ ผู้ให้เช่าร่วมประชุมด้วยทุกครั้งทั้งนี้เพื่อความสะอาดเรียบร้อยโดยส่วนรวม',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.8.ผู้เช่าจะต้องไม่รุกล้ำเข้าไปในพื้นที่โครงการส่วนกลางยกเว้นได้รับอนุญาตเป็นลายลักษณ์อักษรจากผู้ให้เช่าในกรณี ผู้เช่าประพฤติปฏิบัติดังกล่าวก่อนวันทำสัญญาเช่าอาคารนี้ผู้เช่ายอมรับว่าสิทธิดังกล่าวไม่หาอาจจะอ้างสิทธิได้ตาม กฎหมายและสัญญาเช่าอาคารฉบับก่อนๆหน้านี้และผู้ให้เช่ามีสิทธิระงับการรุกล้ำดังกล่าวหรือนำพื้นที่รุกล้ำออกให้ทำการ เช่าต่อไปได้',
              //   textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.9.ผู้เช่ามีหน้าที่จะต้องปฏิบัติตามข้อกำหนดในสัญญาให้บริการพื้นที่เครื่องตกแต่งและติดตั้งพร้อมสิ่งอำนวยความ สะดวกและสาธารณูปโภคและจะต้องปฏิบัติอย่างเคร่งครัดในเรื่องพื้นที่จอดรถยนต์ส่วนกลางซึ่งได้มีการระบุรายละเอียด การใช้พื้นที่ส่วนกลางลานจอดรถยนต์และค่าใช้จ่ายในการจอดรถยนต์ของลูกค้าหรือผู้เข้ามาใช้พื้นที่โครงการผู้เช่า และบริวารไว้แล้ว',
              //  textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.10.ผู้เช่ามีหน้าที่แจ้งเหตุที่อาจจะเป็นอันตรายต่อลูกค้าผู้เข้ามาใช้บริการพื้นที่โครงการตนเองบริวารและบุคคลโดย ทั่วไปในพื้นที่โครงการส่วนกลางหรืออาคารที่เช่าที่เป็นความรับผิดชอบของผู้ให้เช่าเพื่อให้ผู้ให้เช่ารีบเข้าดำเนินการแก้ไข ปรับปรุงเพื่อไม่ให้เกิดเหตุร้ายแรง',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.11.ผู้เช่ามีหน้าที่ต้องแจ้งให้ลูกค้าหรือผู้มาใช้บริการภายในอาคารที่เช่าไม่สูบบุหรี่ในพื้นที่โครงการโดยเฉพาะในห้องน้ำ โดยเคร่งครัดยกเว้นพื้นที่ที่ผู้ให้เช่าหรือผู้เช่ากำหนดให้เป็นสถานที่ที่สามารถสูบบุหรี่ได้เท่านั้น',
              //  textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '10.12.ผู้เช่ามีหน้าที่ต้องจัดให้มีชุดปฐมพยาบาลเบื้องต้นฉุกเฉินแก่ลูกค้าหรือผู้มาใช้บริการในอาคารที่เช่าที่อาจเกิดการเจ็บป่วยหรืออุบัติเหตุกะทันหัน',

              ///    textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '11. การรับมอบพื้นที่เช่า',

              ///  textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'ในวันทำสัญญาฉบับนี้ผู้เช่าได้รับมอบพื้นที่เช่าจากผู้ให้เช่าและได้ตรวจดูพื้นที่เช่าอย่างละเอียดแล้วโดยผู้เช่าได้รับมอบพื้นที่เช่าไว้ในสภาพเรียบร้อยดีทุกประการเหมาะสมกับการใช้ประโยชน์ตามวัตถุประสงค์ของการเช่าของผู้เช่าและเมื่อสัญญาฉบับนี้สิ้นสุดลงหรือมีอันเลิกกันไม่ว่าด้วยเหตุประการใดๆก็ตามผู้เช่าจะส่งมอบพื้นที่เช่าคืนแก่ผู้ให้เช่าในสภาพที่ดีหากผู้ให้ เช่าต้องเสียค่าใช้จ่ายที่จำเป็นในการซ่อมแซมหรือปรับปรุงพื้นที่เช่าให้อยู่ในสภาพเดิมผู้เช่ายินยอมรับผิดชดใช้ค่าใช้จ่าย นั้นคืนแก่ผู้ให้เช่าทั้งสิ้นทั้งนี้ไม่รวมถึงความชำรุดบกพร่องที่เกิดจากการใช้งานหรือการเสื่อมสภาพจากการใช้งานตามปกติและความชำรุดบกพร่องที่มีอยู่ก่อนการครอบครองพื้นที่เช่าของผู้เช่า',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '12. การเข้าตรวจดูพื้นที่เช่า',
              //    textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '12.1.ผู้เช่ายินยอมให้ผู้ให้เช่าหรือตัวแทนของผู้ให้เช่าเข้าตรวจตราทรัพย์สินที่เช่าได้ตามสมควรหากผู้ให้เช่าเข้าตรวจสอบ แล้วพบความเสียหายของทรัพย์สินที่เช่าอันเนื่องจากการประกอบการของผู้เช่าเช่นกระจกแตก,ก๊อกน้ำรั่ว,ท่อมีเศษอาหาร,ขยะอุดตันหรือกลิ่นเหม็นเน่าของเศษอาหารเป็นต้นผู้ให้เช่าจะแจ้งแก่ผู้เช่าให้ทำการแก้ไขผู้เช่าจะต้องดำเนินการแก้ไข ปรับปรุงความชำรุดบกพร่องความเสียหายของทรัพย์ที่เช่านั้นภายในกำหนด....7....วัน....นับแต่วันที่ได้รับแจ้งจากผู้ให้เช่า หากผู้เช่าไม่ดำเนินการตามที่ผู้ให้เช่าแจ้งผู้ให้เช่ามีสิทธิให้บุคคลภายนอกทำการแก้ไขปรับปรุงหรือซ่อมแซมความเสียหายต่อสถานที่เช่านั้นได้เองโดยค่าใช้จ่ายเพื่อการดังกล่าวตกเป็นภาระของผู้เช่าทั้งสิ้น',
              //   textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '12.2.ในกรณีผู้เช่ามิได้ใช้สิทธิตามข้อ(3.2)ผู้เช่ายินยอมให้ผู้ให้เช่าติดประกาศรับผู้เช่ารายใหม่ซึ่งผู้ให้เช่าอาจจะนำ ผู้เช่ารายใหม่ดังกล่าวเข้าตรวจดูพื้นที่เช่าได้ตามความเหมาะสม',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '13. การผิดสัญญาและการสิ้นสุดของสัญญา',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              'สัญญาฉบับนี้จะถือว่าสิ้นสุดลงในกรณีดังต่อไปนี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '13.1.สิ้นสุดระยะเวลาการเช่า และคู่สัญญาไม่ตกลงจะเช่ากันต่อไป',
              //textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '13.2.เกิดเหตุสุดวิสัยแก่ทรัพย์สินที่เช่าไม่ว่าทั้งหมดหรือบางส่วนอันเป็นเหตุให้ผู้เช่าไม่สามารถใช้ทรัพย์สินที่เช่าได้ตาม วัตถุประสงค์แห่งการเช่านี้ได้อีกต่อไป',
              //textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '13.3.คู่สัญญาฝ่ายหนึ่งฝ่ายใดผิดสัญญาในสาระสำคัญและคู่สัญญาฝ่ายที่ไม่ผิดสัญญานั้นได้ใช้สิทธิบอกเลิกสัญญาโดยบอกกล่าวเป็นลายลักษณ์อักษรให้อีกฝ่ายหนึ่งทราบ',

              /// textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '13.4.คู่สัญญาฝ่ายหนึ่งฝ่ายใดผิดสัญญาข้อหนึ่งข้อใดและไม่เยียวยาแก้ไขภายใน....15....วัน....นับแต่วันที่ได้รับแจ้งเป็นลายลักษณ์อักษรจากอีกฝ่ายหนึ่งและคู่สัญญาฝ่ายที่ไม่ผิดสัญญานั้นได้ใช้สิทธิบอกเลิกสัญญาโดยบอกกล่าวเป็นลายลักษณ์ อักษรให้อีกฝ่ายหนึ่งทราบ',
              //textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '13.5.คู่สัญญาฝ่ายใดฝ่ายหนึ่งถูกยึดทรัพย์พิทักษ์ทรัพย์หรือล้มละลายตามคำสั่งศาล',
              //  textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '13.6.กรณีที่ดินอันเป็นสถานที่ก่อสร้างสถานประกอบการถูกทางราชการเวนคืนตามกฎหมายให้ถือว่าสัญญาเช่าสิ้นสุดลง โดยผู้เช่ามีสิทธิได้รับเงินหลักประกันการเช่าส่วนที่เหลือคืนเท่านั้น',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '13.7.กรณีที่พื้นที่ให้เช่าเกิดการรอนสิทธิไม่ว่าจากผู้หนึ่งหรือผู้ใดจากเอกชนหรือทางราชการและไม่ว่าจะเป็นความผิดของผู้ให้เช่าหรือไม่ก็ตามผู้ให้เช่ามีหน้าที่เพียงจัดหาสถานที่ในพื้นที่ให้ผู้เช่าทำสัญญาเช่าใหมยกเว้นกรณีที่ผู้ให้เช่าไม่อาจจัดหาพื้นที่ในโครงการให้เช่าได้เช่นนั้นให้ถือว่าสัญญาเช่าอาคารนี้เป็นอันเลิกกันแต่หากมีการทำสัญญาเช่าพื้นที่อาคารกันใหม่ผู้ให้เช่าและผู้เช่าตกลงให้นำค่าเช่าขนาดพื้นที่และเงื่อนไขต่างๆในสัญญาเดิมอ้างอิงกับสัญญาเช่าพื้นที่อาคารฉบับใหม่ได้แต่ทั้งนี้หากมีความเสียหายอย่างใดๆเกิดขึ้นกับผู้เช่าด้วยเหตุผลข้างต้นผู้เช่าไม่มีสิทธิเรียกร้องค่าตกแต่งต่อเติมทั้งอาคารเก่าที่ให้เช่าเดิมและอาคารใหม่ที่อาจจะมีการเช่าใหม่ผลประโยชน์ต่อเนื่องจากการค้าการลงทุนค่าขาดผลประโยชน์ทางการค้าการลงทุนรายได้กำไรโอกาสทางธุรกิจในปัจจุบันและอนาคตหรือค่าเสียหายอื่นใดจากผู้ให้เช่าทั้งสิ้น',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '14. ผลการสิ้นสุดสัญญา',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '14.1.เมื่อครบกำหนดอายุสัญญาเช่าแล้วผู้เช่าตกลงให้กรรมสิทธิ์ในเครื่องตกแต่งอาคารที่เช่าที่ติดตราตรึงอันถือเป็นส่วนควบกับอาคารที่เช่าซึ่งไม่อาจรื้อถอนไปได้โดยโครงสร้างอาคารพื้นอาคารหรือผนังอาคารไม่ได้รับความเสียหายเช่นนั้น ทรัพย์สินดังกล่าวของผู้เช่าในเครื่องตกแต่งอาคารที่เช่าให้ตกแก่ผู้ให้เช่าโดยไม่มีค่าตอบแทนยกเว้นอุปกรณ์ของผู้เช่าแต่ เงื่อนไขดังกล่าวข้างต้นตามสัญญาข้อนี้ยังคงไว้ซึ่งสิทธิของผู้ให้เช่าที่จะแจ้งให้ผู้เช่าทำการรื้อถอนเครื่องตกแต่งอาคารที่เช่าที่ติดตราตรึงอันถือเป็นส่วนควบกับอาคารที่เช่าซึ่งไม่อาจรื้อถอนไปได้โดยโครงสร้างอาคารพื้นอาคารหรือผนังอาคารไม่ได้รับความเสียหายออกไปจากอาคารที่เช่าได้และผู้เช่าต้องปรับปรุงอาคารที่เช่าให้อยู่ในสภาพเดิมมากที่สุดเท่าที่จะทำได้ เหมือนกับในขณะทำสัญญานี้โดยค่าใช้จ่ายของผู้เช่าเองทั้งสิ้นอีกทั้งผู้เช่าจะต้องทำความสะอาดพร้อมทั้งขนย้ายอสังหาริมทรัพย์สินและบริวารของผู้เช่าออกจากสถานที่เช่าและส่งมอบคืนสถานที่เช่าแก่ผู้ให้เช่าโดยพลันและผู้เช่าตกลงจะไม่ยกข้ออ้างใดๆขึ้นปฏิเสธทั้งสิ้น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '14.2.เมื่อสัญญาเช่าฉบับนี้สิ้นสุดลงไม่ว่ากรณีใดๆผู้เช่าตกลงจะขนย้ายทรัพย์สินและบริวารของผู้เช่าออกไปจากพื้นที่เช่า และส่งมอบพื้นที่เช่าในสภาพเรียบร้อยคืนแก่ผู้ให้เช่าทันทีที่สัญญาเช่าสิ้นสุดลงหากผู้เช่าไม่ปฏิบัติตามความดังกล่าว ข้างต้นผู้เช่าตกลงจะให้ผู้ให้เช่ามีสิทธิดังต่อไปนี้ ',
              //textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '(ก)ผู้เช่าตกลงให้ผู้ให้เช่าหรือตัวแทนของผู้ให้เช่ามีสิทธิที่จะเข้าครอบครองพื้นที่เช่าและถือว่าสิทธิการครอบครองพื้นที่เช่าของผู้เช่าได้สิ้นสุดลงทันที',
              //   textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '(ข)ในกรณีที่ผู้เช่าได้ตกแต่งและ/หรือเปลี่ยนแปลงพื้นที่เช่าไม่ว่าการตกแต่งและ/หรือการเปลี่ยนเปลี่ยนแปลงพื้นที่เช่านั้นจะกระทำโดยชอบด้วยสัญญาฉบับนี้หรือไม่ผู้เช่าตกลงจะขนย้ายรื้อถอนทรัพย์ที่ได้ตกแต่งเพิ่มเติมเปลี่ยนแปลงซึ่งติดตรึงตราอยู่กับพื้นที่เช่าออกไปทันทีและส่งมอบพื้นที่เช่าคืนในสภาพเดิมเว้นแต่ทรัพย์ที่ได้ตกแต่งเพิ่มเติมเปลี่ยนแปลงซึ่งติดตรึง ตราอยู่กับพื้นที่เช่าซึ่งการขนย้ายหรือถอดถอนนั้นจะกระทบต่อโครงสร้างของพื้นที่เช่าผู้เช่าตกลงจะยกทรัพย์ดังกล่าวให้ ตกเป็นกรรมสิทธิ์ของผู้ให้เช่าในทันที',
              //textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '14.3.คู่สัญญาได้ตกลงกันโดยชัดแจ้งแล้วว่าการรื้อถอนขนย้ายทรัพย์สินและบริวารของผู้เช่าผู้เช่าจะไม่เรียกร้องค่าทดแทนค่าเสียหายหรือค่าขนย้ายจากผู้ให้เช่าและหากผู้เช่าไม่ขนย้ายทรัพย์สินและบริวารออกจากสถานที่เช่าภายในกำหนดตาม วรรคก่อนยินยอมให้ผู้ให้เช่าปรับเป็นรายวันในอัตราวันละ....2,000....บาท....(สองพันบาท)....นับแต่วันที่ครบกำหนด สัญญาเป็นต้นไปจนกว่าผู้เช่าจะทำการขนย้ายทรัพย์สินและบริวารออกไปจากสถานที่เช่าเสร็จสิ้นหากล่วงพ้นระยะเวลาตามวรรคหนึ่งไปกว่า....7....วัน....ผู้เช่ายังไม่ขนย้ายทรัพย์สินและบริวารออกไปจากสถานที่เช่าผู้เช่ายินยอมให้ผู้ให้เช่าเข้าทำการขนย้ายทรัพย์สินไปไว้ในที่อันควรโดยค่าใช้จ่ายของผู้เช่าและผู้ให้เช่าจะแจ้งให้ผู้เช่ามารับคืนไปทันทีกรณีนี้ผู้ให้เช่าจะไม่รับผิดชอบในความเสียหายหรือสูญหายของทรัพย์สินของผู้เช่าที่ทำการขนย้ายออกมาทั้งสิ้น',
              //textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '15. ข้อสัญญาทั่วไป',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(
              '15.1.เว้นแต่จะได้กำหนดไว้เป็นอย่างอื่นอย่างชัดแจ้งในสัญญานี้ผู้เช่าตกลงจะไม่โอนสิทธิหน้าที่และหรือความรับผิดตาม สัญญาฉบับนี้ให้แก่บุคคลอื่นใดและไม่ว่าในกรณีใดๆตลอดระยะเวลาการเช่าผู้เช่าตกลงจะไม่นำพื้นที่เช่าตามสัญญาฉบับนี้ไม่ว่าส่วนหนึ่งส่วนใดหรือทั้งหมดไปให้บุคคลอื่นใดเช่าช่วงครอบครองหรือใช้ประโยชน์ในพื้นที่เช่าเว้นแต่จะได้รับความยินยอมเป็นลายลักษณ์อักษรจากผู้ให้เช่า',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '15.2.การที่ผู้ให้เช่าไม่ใช้สิทธิหรือใช้สิทธิล่าช้าในเรื่องหนึ่งเรื่องใดหรือคราวหนึ่งคราวใดก็ดีมิให้ถือว่าผู้ให้เช่าสละสิทธิใน เรื่องดังกล่าวและการที่ผู้ให้เช่าใช้สิทธิแต่เพียงบางส่วนหรือสละสิทธิในเรื่องหนึ่งเรื่องใดหรือคราวหนึ่งคราวใดก็มิให้ถือว่า เป็นการสละสิทธิในเรื่องอื่นหรือในคราวอื่นด้วย',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '15.3.คู่สัญญาตกลงกันว่าคำบอกกล่าวหรือหนังสือซึ่งต้องแจ้งให้แก่กันภายใต้สัญญานี้จะถือว่าได้มีการแจ้งแก่กันแล้วหาก ว่าได้มีการส่งไปยังที่อยู่ของคู่สัญญาแต่ละฝ่ายตามที่ระบุไว้ในสัญญานี้โดยทำเป็นหนังสือและส่งโดยทางไปรษณีย์ลง ทะเบียนตอบรับ',
              // textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '15.4.การแก้ไขและเปลี่ยนแปลงข้อความในสัญญานี้ไม่อาจทำได้เว้นแต่คู่สัญญาทั้งสองฝ่ายจะได้ตกลงกันเป็นลายลักษณ์ อักษรและลงลายมือชื่อของคู่สัญญาและให้ถือว่าข้อตกลงดังกล่าวเป็นส่วนหนึ่งของสัญญานี้ด้วย',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '15.5. สัญญาฉบับนี้ให้อยู่ภายใต้บังคับกฎหมายของประเทศไทย ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 10 * PdfPageFormat.mm),
            pw.Text(
              '    สัญญาฉบับนี้คู่สัญญาทั้งสองฝ่ายได้อ่านและเข้าใจข้อความและเงื่อนไขต่างๆแห่งสัญญานี้รวมถึงเอกสารแนบท้าย สัญญา(ถ้ามี)โดยละเอียดตลอดดีแล้วเห็นว่าถูกต้องตามเจตนารมณ์ทุกประการเพื่อเป็นหลักฐานจึงได้ลงลายมือชื่อ และประทับตราไว้เป็นสำคัญ ณ วัน เดือน ปีที่ระบุในสัญญานี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 10 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Column(
                  children: [
                    pw.Text(
                      'ลงนาม______________________________ผู้ให้เช่า',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(height: 5 * PdfPageFormat.mm),
                    pw.Text(
                      '(_______________________________)',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                )),
                pw.Expanded(
                    child: pw.Column(
                  children: [
                    pw.Text(
                      'ลงนาม______________________________ผู้เช่า',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(height: 5 * PdfPageFormat.mm),
                    pw.Text(
                      '($Form_bussshop)',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                )),
              ],
            ),
            pw.SizedBox(height: 10 * PdfPageFormat.mm),
            pw.Center(
              child: pw.Text(
                'เพื่อและในนาม บริษัท ด็อกเตอร์พิมลวรรณและครอบครัว จำกัด',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.SizedBox(height: 10 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Column(
                  children: [
                    pw.Text(
                      'ลงนาม________________________พยาน',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(height: 5 * PdfPageFormat.mm),
                    pw.Text(
                      '(_______________________________)',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(height: 10 * PdfPageFormat.mm),
                  ],
                )),
                pw.Expanded(
                    child: pw.Column(
                  children: [
                    pw.Text(
                      'ลงนาม________________________พยาน',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(height: 5 * PdfPageFormat.mm),
                    pw.Text(
                      '(_______________________________)',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(height: 10 * PdfPageFormat.mm),
                  ],
                )),
              ],
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
                  'เอกมัยช้อปปิ้งมอลล์(เวิ้งโบราณ) หน้า ${context.pageNumber} จาก ${context.pagesCount} ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: 10,
                    font: ttf,
                    color: PdfColors.black,
                    // fontWeight: pw.FontWeight.bold
                  ),
                ),
              )
            ],
          );
        },
      ),
    );

    //////////////------------------------------------------------------------------->
    //pageCount++;
    pdf.addPage(pw.MultiPage(header: (context) {
      return pw.Column(children: [
        pw.Row(
          children: [
            (netImage.isEmpty)
                ? pw.Container(
                    height: 72,
                    width: 70,
                    color: PdfColors.grey200,
                    child: pw.Center(
                      child: pw.Text(
                        '$bill_name ',
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: 10,
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
                    '$bill_name',
                    maxLines: 2,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                    ),
                  ),
                  pw.Text(
                    '$bill_addr',
                    maxLines: 3,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      color: PdfColors.grey800,
                      font: ttf,
                    ),
                  ),
                ],
              ),
            ),
            pw.Spacer(),
            pw.Container(
              width: 190,
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
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.grey800),
                  ),
                  pw.Text(
                    'อีเมล: $bill_email',
                    maxLines: 2,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.grey800),
                  ),
                  pw.Text(
                    'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                    maxLines: 2,
                    style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.grey800),
                  ),
                  pw.Text(
                    'ณ วันที่:  $thaiDate ${DateTime.now().year + 543}',
                    maxLines: 2,
                    style: pw.TextStyle(
                        fontSize: font_Size,
                        font: ttf,
                        color: PdfColors.grey800),
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
    }, build: (context) {
      return [
        pw.Center(
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
              pw.SizedBox(height: 4 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'สัญญาให้บริการพื้นที่  เครื่องตกแต่งและติดตั้ง  พร้อมสิ่งอำนวยความสะดวกและสาธารณูปโภค',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 4 * PdfPageFormat.mm),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.SizedBox(height: 3 * PdfPageFormat.mm),
                      pw.Text(
                        'เอกมัยช้อปปิ้งมอลล์ (เวิ้งโบราณ)',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 3 * PdfPageFormat.mm),
                      pw.Text(
                        'วันที่.................',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                    ]),
              ]),
              pw.SizedBox(height: 10 * PdfPageFormat.mm),
              pw.Text(
                'สัญญาให้บริการพื้นที่  เครื่องตกแต่งและติดตั้ง  พร้อมสิ่งอำนวยความสะดวกและสาธารณูปโภค ฉบับนี้ทำขึ้นระหว่าง',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 4 * PdfPageFormat.mm),
              pw.Text(
                '1). บริษัท ด๊อกเตอร์พิมลวรรณและครอบครัว จำกัด โดย ผู้มีอำนาจลงนามท้ายสัญญา ทะเบียนนิติบุคคลเลขที่ 0-1055-65003-24-4 สำนักงานแห่งใหญ่ตั้งอยู่ที่ เลขที่ 86/1 ซอยเจริญมิตร ถนนสุขุมวิท แขวงพระโขนงเหนือ เขตวัฒนา กรุงเทพมหานคร 10110 ซึ่งต่อไปในสัญญาฉบับนี้จะเรียกว่า “ผู้ให้บริการ”',
                //textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                '2). กับ....$Form_bussshop.....บัตรประจำตัวประชาชนเลขที่....$Form_tax....อยู่ที่....$Form_address....ซึ่งต่อไปในสัญญานี้เรียกว่า “ผู้รับบริการ” อีกฝ่ายหนึ่ง',
                // textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                '    คู่สัญญาทั้งสองฝ่ายตกลงทำสัญญาเช่าพื้นที่ภายในอาคารโครงการเอกมัยช้อปปิ้งมอลล์(เวิ้งโบราณ)โดยที่ผู้ให้บริการ เป็นเจ้าของสิทธิการเช่าที่ดินและอาคารทั้งหมดภายในโครงการพื้นที่บริการและสาธารณูปโภคภายในโครงการซึ่งตั้งอยู่เลขที่ 3 ซอย เจริญมิตร  แขวง คลองตันเหนือ เขต วัฒนา  กรุงเทพมหานคร  10110  ซึ่งต่อไปในสัญญานี้เรียกว่า ',
                // textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                '    “พื้นที่โครงการ”ผู้ให้บริการมีสิทธิโดยสมบูรณ์ตามกฎหมายในการให้บริการพื้นที่เครื่องตกแต่งและติดตั้งพร้อม สิ่งอำนวยความสะดวกและสาธารณูปโภคซึ่งต่อไปในสัญญาฉบับนี้จะเรียกว่า“ค่าใช้จ่ายส่วนกลาง” ผู้รับบริการเป็นผู้เช่าพื้นที่ภายในอาคารโครงการตามสัญญาเช่าระหว่างผู้ให้บริการกับผู้รับบริการ     ฉบับลงวันที่.............ซึ่งถือเป็นส่วนหนึ่งแห่งสัญญาบริการฉบับนี้ซึ่งต่อไปในสัญญานี้เรียกว่า“พื้นที่รับบริการ” คู่สัญญาทั้งสองฝ่ายตกลงทำสัญญาให้บริการดังมีข้อความต่อไปนี้',
                //textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Row(
                children: [
                  pw.Text(
                    'ข้อ 1.ข้อตกลงการบริการ',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                'ผู้ให้บริการตกลงให้บริการและผู้รับบริการตกลงรับบริการเครื่องตกแต่งและติดตั้งพร้อมสิ่งอำนวยความสะดวกและ สาธารณูปโภคมีกำหนดระยะเวลา....1....ปี....ผู้รับบริการยินยอมจ่ายค่าใช้จ่ายส่วนกลาง เริ่มนับตั้งแต่วันที่.........วันที่..........โดยทั้งสองฝ่ายตกลงที่จะปฏิบัติตามเงื่อนไขดังนี้',
                // textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                '1.1.ผู้รับบริการยินยอมจ่ายค่าใช้จ่ายส่วนกลางของแต่ละเดือนล่วงหน้าเป็นเงิน....14,000....บาท....(หนึ่งหมื่นสี่พันบาทถ้วน)....ไม่รวมภาษีมูลค่าเพิ่มโดยจะจ่ายให้แก่ผู้ให้บริการภายในวันที่....5....ของทุกเดือนเริ่มวันที่.......เป็นต้นไป',
                // textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Text(
                '1.2.ผู้รับบริการจะดูแลรักษาสิ่งติดตั้ง สิ่งอำนวยความสะดวก ภายในสถานที่รับบริการ ให้อยู่ในสภาพใช้งานได้ตลอดเวลา ซึ่งค่าบำรุงรักษาถือเป็นภาระของผู้รับบริการ',

                /// textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Text(
                '1.3.สัญญานี้ยกเว้นที่จอดรถยนต์...1....คัน....และค่าใช้บริการจอดรถยนต์ซึ่งผู้ให้บริการจะได้มีการกำหนดค่าใช้บริการจอดรถยนต์โดยการประกาศ ณ สถานที่ให้เช่าจอดรถยนต์ต่อไป	',
                //  textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Row(
                children: [
                  pw.Text(
                    'ข้อ2. เงื่อนไขบังคับ',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                'เงื่อนไขและการปฏิบัติ นอกเหนือจากที่จะบุไว้ในสัญญาบริการฉบับนี้ ให้ยึดถือตามสัญญาเช่าอาคาร ระหว่าง ผู้ให้บริการ (ผู้ให้เช่า) กับ ผู้รับบริการ(ผู้เช่า) ฉบับลงวันที่.........',

                /// textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Text(
                'เงื่อนไขและการปฏิบัตินอกเหนือจากที่จะบุไว้ในสัญญาบริการฉบับนี้ให้ยึดถือตามสัญญาเช่าอาคาร ระหว่าง ผู้ให้บริการ (ผู้ให้เช่า) กับ ผู้รับบริการ(ผู้เช่า) ฉบับลงวันที่...........',
                // textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 25 * PdfPageFormat.mm),
              pw.Text(
                '    สัญญาให้บริการฉบับนี้ ทำขึ้นมีข้อความตรงกันสองฉบับ คู่สัญญาทั้งสองฝ่ายได้อ่านและเข้าใจตรงกันทั้งสองฝ่ายแล้ว จึงลงชื่อต่อหน้าพยาน และให้เก็บไว้ฝ่ายละหนึ่งฉบับ',

                ///textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 10 * PdfPageFormat.mm),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Column(
                    children: [
                      pw.Text(
                        'ลงนาม______________________________ผู้ให้เช่า',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5 * PdfPageFormat.mm),
                      pw.Text(
                        '(_______________________________)',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  )),
                  pw.Expanded(
                      child: pw.Column(
                    children: [
                      pw.Text(
                        'ลงนาม______________________________ผู้เช่า',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5 * PdfPageFormat.mm),
                      pw.Text(
                        '($Form_bussshop)',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              pw.SizedBox(height: 10 * PdfPageFormat.mm),
              pw.Center(
                child: pw.Text(
                  'เพื่อและในนาม บริษัท ด็อกเตอร์พิมลวรรณและครอบครัว จำกัด',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.SizedBox(height: 10 * PdfPageFormat.mm),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Column(
                    children: [
                      pw.Text(
                        'ลงนาม________________________พยาน',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5 * PdfPageFormat.mm),
                      pw.Text(
                        '(_______________________________)',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 10 * PdfPageFormat.mm),
                    ],
                  )),
                  pw.Expanded(
                      child: pw.Column(
                    children: [
                      pw.Text(
                        'ลงนาม________________________พยาน',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5 * PdfPageFormat.mm),
                      pw.Text(
                        '(_______________________________)',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 10 * PdfPageFormat.mm),
                    ],
                  )),
                ],
              ),
            ])),
      ];
    }, footer: (context) {
      return pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Align(
            alignment: pw.Alignment.bottomRight,
            child: pw.Text(
              'เอกมัยช้อปปิ้งมอลล์(เวิ้งโบราณ) หน้า ${context.pageNumber} จาก ${context.pagesCount} ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: 10,
                font: ttf,
                color: PdfColors.black,
                // fontWeight: pw.FontWeight.bold
              ),
            ),
          )
        ],
      );
    }));
    ////////////------------------------------------------------------------------------->

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
