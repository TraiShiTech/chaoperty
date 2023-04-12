// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../PeopleChao/Rental_Information.dart';

// class Pdfgen_Agreement2 {
// //////////---------------------------------------------------->(DOCX)

//   static void exportPDF_Agreement2(
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
//       base64Image_1,
//       base64Image_2,
//       base64Image_3,
//       base64Image_4,
//       name1,
//       name2,
//       name3,
//       name4) async {
//     ////
//     //// ------------>(ใบเสนอราคา)
//     ///////
//     final pdf = pw.Document();
//     // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
//     // var dataint = fontData.buffer
//     //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
//     // final PdfFont font = PdfFont.of(pdf, data: dataint);
//     final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

//     final ttf = pw.Font.ttf(font);
//     DateTime date = DateTime.now();
//     String date_string = '${date.day}/${date.month}/${date.year}';
//     var formatter = new DateFormat.MMMMd('th_TH');
//     String thaiDate = formatter.format(date);
//     var nFormat = NumberFormat("#,##0.00", "en_US");
//     var nFormat2 = NumberFormat("###0.00", "en_US");
//     final iconImage =
//         (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
//     List netImage = [];
//     // SharedPreferences preferences = await SharedPreferences.getInstance();

//     // String? base64Image_1 = preferences.getString('base64Image1');
//     // String? base64Image_2 = preferences.getString('base64Image2');
//     // String? base64Image_3 = preferences.getString('base64Image3');
//     // String? base64Image_4 = preferences.getString('base64Image4');
//     // String base64Image_new1 = (base64Image_1 == null) ? '' : base64Image_1;
//     // String base64Image_new2 = (base64Image_2 == null) ? '' : base64Image_2;
//     // String base64Image_new3 = (base64Image_3 == null) ? '' : base64Image_3;
//     // String base64Image_new4 = (base64Image_4 == null) ? '' : base64Image_4;
//     Uint8List data1 = base64Decode(base64Image_1);
//     Uint8List data2 = base64Decode(base64Image_2);
//     Uint8List data3 = base64Decode(base64Image_3);
//     Uint8List data4 = base64Decode(base64Image_4);

//     for (int i = 0; i < newValuePDFimg.length; i++) {
//       netImage.add(await networkImage('${newValuePDFimg[i]}'));
//     }
//     // final tableData = [
//     //   for (int index = 0; index < quotxSelectModels.length; index++)
//     //     [
//     //       '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
//     //     ],
//     // ];
//     double Sumtotal = 0;
//     for (int index = 0; index < quotxSelectModels.length; index++)
//       Sumtotal = Sumtotal +
//           (int.parse(quotxSelectModels[index].term!) *
//               double.parse(quotxSelectModels[index].total!));
//     ///////////////////////------------------------------------------------->
//     final List<String> _digitThai = [
//       'ศูนย์',
//       'หนึ่ง',
//       'สอง',
//       'สาม',
//       'สี่',
//       'ห้า',
//       'หก',
//       'เจ็ด',
//       'แปด',
//       'เก้า'
//     ];

//     final List<String> _positionThai = [
//       '',
//       'สิบ',
//       'ร้อย',
//       'พัน',
//       'หมื่น',
//       'แสน',
//       'ล้าน'
//     ];
// /////////////////////////////------------------------>(จำนวนเต็ม)
//     String convertNumberToText(int number) {
//       String result = '';
//       int numberIntPart = number.toInt();
//       int numberDecimalPart = ((number - numberIntPart) * 100).toInt();
//       final List<String> digits = numberIntPart.toString().split('');
//       int position = digits.length - 1;
//       for (int i = 0; i < digits.length; i++) {
//         final int digit = int.parse(digits[i]);
//         if (digit != 0) {
//           if (position == 6) {
//             result = '$result${_positionThai[6]}';
//           }
//           if (position != 6 && position != 8) {
//             if (digit == 1 && position == 1) {
//               // result = '$resultเอ็ด';
//               result = '$resultสิบ';
//             } else {
//               result =
//                   '$result${_digitThai[digit]}${_positionThai[position % 6]}';
//             }
//           } else if (position == 8) {
//             result = '$result${_digitThai[digit]}${_positionThai[6]}';
//           }
//         }
//         position--;
//       }
//       // final String decimalText =
//       //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
//       return result;
//     }

// /////////////////////////////------------------------>(จำนวนทศนิยม สตางค์)
//     String convertNumberToText2(int number2) {
//       String result = '';
//       int numberIntPart = number2.toInt();
//       int numberDecimalPart = ((number2 - numberIntPart) * 100).toInt();
//       final List<String> digits = numberIntPart.toString().split('');
//       int position = digits.length - 1;
//       for (int i = 0; i < digits.length; i++) {
//         final int digit = int.parse(digits[i]);
//         if (digit != 0) {
//           if (position == 6) {
//             result = '$result${_positionThai[6]}';
//           }
//           if (position != 6 && position != 8) {
//             if (digit == 1 && position == 1) {
//               // result = '$resultเอ็ด';
//               result = '$resultสิบ';
//             } else {
//               result =
//                   '$result${_digitThai[digit]}${_positionThai[position % 6]}';
//             }
//           } else if (position == 8) {
//             result = '$result${_digitThai[digit]}${_positionThai[6]}';
//           }
//         }
//         position--;
//       }
//       // final String decimalText =
//       //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
//       return result;
//     }

// ////////////////----------------------------->(ตัด หน้าจุดกับหลังจุดออกจากกัน)
//     var number_ = "${nFormat2.format(Sumtotal)}";
//     var parts = number_.split('.');
//     var front = parts[0];
//     var back = parts[1];

// ////////////////--------------------------------->(บาท)
//     double number = double.parse(front);
//     final int numberIntPart = number.toInt();
//     final double numberDecimalPart = (number - numberIntPart) * 100;
//     final String numberText = convertNumberToText(numberIntPart);
//     final String decimalText = convertNumberToText(numberDecimalPart.toInt());
// ////////////////---------------------------------->(สตางค์)
//     double number2 = double.parse(number_);
//     final int numberIntPart2 = number.toInt();
//     final int numberDecimalPart2 = ((number2 - numberIntPart2) * 100).round();
//     final String numberText2 = convertNumberToText2(numberIntPart2);
//     final String decimalText2 =
//         convertNumberToText2(numberDecimalPart2.toInt());
// ////////////////------------------------------->(เช็คและเพิ่มตัวอักษร)
//     final String formattedNumber = (decimalText2.replaceAll(
//                 _digitThai[0], "") ==
//             '')
//         ? '$numberTextบาทถ้วน'
//         : (back[0].toString() == '0')
//             ? '$numberTextบาทศูนย์${decimalText2.replaceAll(_digitThai[0], "")}สตางค์'
//             : '$numberTextบาท${decimalText2.replaceAll(_digitThai[0], "")}สตางค์';

//     String text_Number1 = formattedNumber;
//     RegExp exp1 = RegExp(r"สองสิบ");
//     if (exp1.hasMatch(text_Number1)) {
//       text_Number1 = text_Number1.replaceAll(exp1, 'ยี่สิบ');
//     }
//     String text_Number2 = text_Number1;
//     RegExp exp2 = RegExp(r"สิบหนึ่ง");
//     if (exp2.hasMatch(text_Number2)) {
//       text_Number2 = text_Number2.replaceAll(exp2, 'สิบเอ็ด');
//     }
// ///////////////////////------------------------------------------------->
//     pdf.addPage(
//       pw.MultiPage(
//         // header: (context) {
//         //   return pw.Text(
//         //     'Flutter Approach',
//         //     style: pw.TextStyle(
//         //       fontWeight: pw.FontWeight.bold,
//         //       fontSize: 15.0,
//         //     ),
//         //   );
//         // },
//         build: (context) {
//           return [
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
//                               fontSize: 8,
//                               font: ttf,
//                               color: PdfColors.grey300,
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
//                         '$renTal_name',
//                         maxLines: 2,
//                         style: pw.TextStyle(
//                           fontSize: 14.0,
//                           fontWeight: pw.FontWeight.bold,
//                           font: ttf,
//                         ),
//                       ),
//                       pw.Text(
//                         '$bill_addr',
//                         maxLines: 3,
//                         style: pw.TextStyle(
//                           fontSize: 10.0,
//                           color: PdfColors.grey800,
//                           font: ttf,
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
//                         'โทรศัพท์: $bill_tel',
//                         textAlign: pw.TextAlign.right,
//                         maxLines: 1,
//                         style: pw.TextStyle(
//                             fontSize: 10.0,
//                             font: ttf,
//                             color: PdfColors.grey800),
//                       ),
//                       pw.Text(
//                         'อีเมล: $bill_email',
//                         maxLines: 1,
//                         textAlign: pw.TextAlign.right,
//                         style: pw.TextStyle(
//                             fontSize: 10.0,
//                             font: ttf,
//                             color: PdfColors.grey800),
//                       ),
//                       pw.Text(
//                         'เลขประจำตัวผู้เสียภาษี: $bill_tax',
//                         maxLines: 2,
//                         style: pw.TextStyle(
//                             fontSize: 10.0,
//                             font: ttf,
//                             color: PdfColors.grey800),
//                       ),
//                       pw.Text(
//                         'ณ วันที่:  $thaiDate ${DateTime.now().year + 543}',
//                         maxLines: 2,
//                         style: pw.TextStyle(
//                             fontSize: 10.0,
//                             font: ttf,
//                             color: PdfColors.grey800),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Divider(),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.center,
//               children: [
//                 pw.Text(
//                   'สัญญาเช่าพื้นที่ $renTal_name ',
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                     fontSize: 11.0,
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
//                             fontSize: 10.0, font: ttf, color: PdfColors.black),
//                       ),
//                       pw.Text(
//                         'ทำที่ $renTal_name ',
//                         textAlign: pw.TextAlign.right,
//                         style: pw.TextStyle(
//                             fontSize: 10.0, font: ttf, color: PdfColors.black),
//                       ),
//                       pw.Text(
//                         'วันที่ทำสัญญา ............. ',
//                         style: pw.TextStyle(
//                             fontSize: 10.0, font: ttf, color: PdfColors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 5 * PdfPageFormat.mm),
//             pw.Text(
//               'สัญญานี้ทำขึ้นระหว่าง $renTal_name  โดย  นายณรงค์  ตนานุวัฒน์   และ    นางรัตนา  ตนานุวัฒน์ \nกรรมการผู้จัดการผู้มีอำนาจกระทำการแทน $renTal_name สำนักงานตั้งอยู่ที่ $bill_addr   ซึ่งต่อไปนี้ในสัญญาฉบับนี้เรียกว่า  ผู้ให้เช่า  ฝ่ายหนึ่งกับ     ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '$Form_bussshop........โดย.....$Form_bussscontact............................................',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ที่อยู่..............$Form_address.................. ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'เบอร์โทรศัพท์.....$Form_tel...........Email........$Form_email................................... ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ซึ่งต่อไปนี้ในสัญญาฉบับนี้เรียกว่า ผู้เช่า อีกฝ่ายหนึ่งได้ตกลงให้ผู้เช่าและผู้ให้เช่าใช้ที่อยู่ของแต่ละฝ่ายตามสัญญานี้ \nสำหรับการติดต่อส่งหนังสือถึงกันและตกลงทำสัญญาเช่าต่อกันมีข้อความดังต่อไปนี้ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 1. ทรัพย์สินที่เช่า และอายุสัญญาเช่า ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ผู้เช่าตกลงเช่าและผู้ให้เช่าตกลงให้เช่าพื้นที่บางส่วนใน....$renTal_name............ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ซึ่งเป็นพื้นที่ล๊อค........$Form_ln($Form_zn)..............พื้นที่ประมาณ...$Form_area.....ตารางเมตร  ตั้งอยู่ที่....$bill_addr..........',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'เริ่มเช่าตั้งแต่วันที่.......$Form_sdate......สิ้นสุดสัญญาเช่าวันที่....$Form_ldate.....ประเภทการเช่า...$Form_rtname....ระยะเวลา.....$Form_period.. ดังรายละเอียดแบบแปลนแนบท้ายสัญญาซึ่งถือเป็นส่วนหนึ่งของสัญญาฉบับนี้ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 2.  ค่าเช่า  ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '2.1  อัตราค่าเช่าเดือนละ.....${nFormat.format(Sumtotal).toString()}....บาท..(....~${text_Number2}~....)..โดยผู้เช่าต้องชำระค่าเช่าเป็นรายเดือน ไม่เกิน วันที่ 5 ของทุกเดือน โดยผู้เช่าจะต้องนำเงินค่าเช่าเข้าบัญชีเงินฝากของ    ผู้ให้เช่า ธนาคารกรุงเทพ สาขาตลาดมีโชค ชื่อบัญชี บจ.ขันแก้ว บัญชีเลขที่ 675-0-22186-0 หรือบัญชีอื่นใดที่ทางผู้ให้เช่าแจ้งเปลี่ยนแปลงภายหลังจากวันทำสัญญา',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'กรณีผู้ให้เช่าไม่สามารถเรียกเก็บเงินค่าเช่าตามเช็คได้ภายในกำหนดเวลาผู้เช่ายินยอมชำระดอกเบี้ยอัตรา ร้อยละ 15 ต่อปี ผู้เช่าตกลงให้ผู้ให้เช่าปรับขึ้นอัตราค่าเช่าเพิ่มขึ้นเมื่อครบสัญญาเช่าฉบับนี้โดยผู้ให้เช่าจะมีหนังสือแจ้งเป็น ลายลักษณ์อักษรให้ผู้เช่าได้รับทราบทุกครั้งที่มีการปรับขึ้นราคาค่าเช่า ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '2.2  ผู้เช่าตกลงยินยอมจ่ายค่าตอบแทนในการได้สิทธิการเช่าให้แก่ผู้ให้เช่าในวันทำสัญญาเช่าเป็นจำนวน',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'เงิน.........280,800.00.........บาท(...สองแสนแปดหมื่นแปดร้อยบาทถ้วน...)ซึ่งเงินจำนวนดังกล่าวผู้ให้เช่าจะ ไม่คืนให้ผู้เช่าไม่ว่ากรณีใด ๆทั้งสิ้น  ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '2.3  เงินประกันค่าเสียหาย ผู้เช่าได้วางเงินประกันค่าเสียหายไว้กับผู้ให้เช่า ตลอดอายุสัญญาเช่ารวมถึงที่ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ได้ต่อสัญญาเช่าไปด้วยแล้ว เป็นจำนวนเงิน...39,000.00..บาท..............(...สามหมื่นเก้าพันบาทถ้วน..........) ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'เงินประกันค่าเสียหายดังกล่าวผู้ให้เช่าจะคืนให้เท่ากับจำนวนเดิม เมื่อครบกำหนดอายุสัญญาเช่าโดยผู้ให้เช่าไม่คิด',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ดอกเบี้ยจากเงินประกันดังกล่าวข้างต้นหรือคืนให้ตามส่วนหรือให้ถือเป็นการชดใช้ค่าเสียหาย  บางส่วนเมื่อผู้เช่าผิด  ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'สัญญาหรือกรณีที่ผู้เช่าจะต้องรับผิดในความเสียหายที่เกิดขึ้นแก่ทรัพย์สินที่เช่า และหากเงินประกันไม่เพียงพอ ผู้ให้ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'เช่ามีสิทธิที่จะเรียกร้องค่าเสียหายจากผู้เช่าให้จนครบจำนวนและเงินประกันนี้ไม่สามารถชำระเป็นค่าเช่าล่วงหน้า หรือไม่ถือเป็นค่าเช่ารายเดือนได้  ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '2.4  ในกรณีสุดวิสัยไม่ว่าด้วยเหตุใดภายหลังจากวันทำสัญญาเช่าภายในศูนย์การค้าฉบับนี้ ทำให้ผู้เช่าไม่ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'สามารถเปิดธุรกิจได้ทั้งหมด หรือส่วนหนึ่งส่วนใด หรือมีการแก้ไขปรับปรุงแบบ ซึ่งทำให้ทรัพย์สินที่เช่าเปลี่ยนแปลง ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ไปไม่ว่าจะเป็นสาระสำคัญหรือไม่ก็ตาม และทำให้วัตถุประสงค์ในการนำศูนย์การค้าออกให้เช่าเปลี่ยนแปลงไปและ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ผู้ให้เช่าได้แจ้งยกเลิกการเช่าให้ผู้เช่าทราบแล้วในกรณีนี้ให้ถือว่าสัญญาเช่าฉบับนี้สิ้นสุดลง  โดยผู้เช่ายินยอมสละ ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'สิทธิที่จะเรียกร้องค่าเสียหายใด ๆ จากผู้ให้เช่า ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 15 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 3. เงื่อนไขและรายละเอียดการเช่า ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '3.1  ผู้เช่าต้องทำสัญญาอย่างน้อย.....36......ถ้าผู้เช่าอยู่ไม่ครบกำหนดสัญญาเช่า......36.....เดือน หรือ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ถ้าผู้เช่าผิดสัญญาเช่านี้ ผู้เช่ายอมให้ผู้ให้เช่าบอกเลิกสัญญาได้ทันที ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '3.2  ภาษีโรงเรือน ผู้ให้เช่าจะเรียกเก็บค่าภาษีโรงเรือน และที่ดินหรือภาษี หรือค่าธรรมเนียม หรือเงินได ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'อื่นใดที่รัฐบาลเรียกเก็บที่เกี่ยวข้องกับทรัพย์สินที่เช่า จากผู้เช่าในอัตราร้อยละ 12.50 ของค่าเช่าทั้งปี.................',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'หมายเหตุ  รอเอกสารจากทางเทศบาล ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ผู้ให้เช่ายินยอมให้ผู้เช่าติดตั้งแผ่นป้ายโฆษณาของผู้เช่าได้ โดยหากมีภาษีป้ายในส่วนนี้ผู้เช่าต้องรับผิดชอบเป็นผู้ชำระเอง ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '3.3  ผู้เช่าจะใช้พื้นที่นี้ประกอบกิจการค้าประเภท...............$Form_typeshop .............เท่านั้นห้ามผู้เช่าใช้สถาน   ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ที่นี้ในการเก็บสารหรือวัตถุไวไฟทุกชนิด และยอมให้ความสะดวกแก่ผู้ให้เช่าตรวจพื้นที่ ที่เช่านี้ได้เสมอผู้เช่าจะใช้พื้นที่นี้',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'เพื่อเป็นที่พักอย่างเดียวโดยไม่ประกอบกิจการค้าไม่ได้และจะดูแลสภาพตัวอาคารให้ดีหากเกิดความเสียหายในระหว่างการเช่าผู้เช่าต้องเข้าซ่อมแซมแก้ไขทันทีและเมื่อเลิกเช่าต้องส่งมอบพื้นที่คืนในสภาพที่ดีเหมือนตอนที่ได้รับมอบไปจากผู้ให้เช่าหากผู้เช่าประสงค์จะเปลี่ยนแปลงกิจการค้าในภายหลังต้องขออนุญาตเป็นหนังสือจากผู้ให้เช่าหากผู้ให้เช่าอนุญาตจะมี หนังสือแจ้งให้ทราบผู้เช่าต้องไม่กระทำการใดอันเป็นการรบกวนผู้เช่ารายอื่น',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '3.4  ผู้เช่าต้องประกอบกิจการค้าอย่างจริงจัง โดยเริ่มเปิดหน้าร้านไม่เกิน 9.00 น.  และปิดหน้าร้านหลังเวลา 20.00 น.    ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.Text(
//               'ทุกวันและต้องมีการตกแต่งหน้าร้านและจัดทำป้ายชื่อร้านจัดวางสินค้าหรืออุปกรณ์ให้เป็นระเบียบไม่วางสินค้าหรืออุปกรณ์วัตถุใดลงบนทางเท้าหรือลงบนถนนหน้าอาคารหรือบนทางเดินด้านหลังอาคารและจัดให้มีพนักงานประจำร้านตามปกติวิสัยของการประกอบการค้า ',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ห้ามผู้เช่าปิดร้านเกินสัปดาห์ละ..1..วันแต่ยกเว้นวันหยุดตามประกาศของทางโครงการ...แคนนาส...หากเช่าปิดร้านเกินกว่าที่กำหนดไว้ผู้เช่ายินยอมเสียค่าปรับเป็นวันละ...1,000.-...บาท..(..หนึ่งพันบาทถ้วน..)ยกเว้นมีเหตุจำเป็นผู้เช่าต้องบอกกล่าวให้ผู้ให้เช่าทราบถึงความจำเป็นนั้นก่อนล่วงหน้า   ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               '3.5  หากผู้เช่าทอดทิ้งสถานที่เช่าทั้งหมดหรือส่วนใหญ่ ให้อยู่ในสภาพปราศจากการครอบครองหรือปราศจากการ ทำประโยชน์เป็นระยะเวลาเกิน 7 วันติดต่อกันโดยไม่ได้รับความยินยอมจากผู้ให้เช่าผู้ให้เช่ามีสิทธิบอกเลิกสัญญาได้ โดยส่งคำบอกกล่าวเป็นหนังสือไปยังผู้เช่า ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                   fontSize: 10.0, font: ttf, color: PdfColors.black),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 4. ถ้าผู้เช่าต้องการโอนสิทธิตามสัญญาเช่านี้แก่บุคคลอื่นหรือต้องการเปลี่ยนตัวผู้เช่าเป็นบุคคลอื่นผู้เช่าต้องแจ้ง ให้ผู้ให้เช่าพิจารณาหากผู้ให้เช่าให้ความยินยอมเปลี่ยนสัญญาเช่าให้ผู้เช่าต้องเสียค่าใช้จ่ายในการเปลี่ยนสัญญาจำนวน  ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.Text(
//               '.............................บาท  (...  ...............................-...........................)ผู้เช่าจะติดป้ายให้เช่า หรือให้เซ้ง หรือป้ายอื่นใดที่มี  ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.Text(
//               'ข้อความทำนองดังกล่าวไม่ได้ ยกเว้นจะได้รับอนุญาตจากผู้ให้เช่าก่อน ผู้เช่าจะนำพื้นที่นี้ไปให้เช่าช่วงต่อหรือมีภาระผูกพัน ใดๆกับบุคคลอื่นไม่ว่าบางส่วนหรือทั้งหมดโดยไม่มีหนังสือยินยอมจากผู้ให้เช่าไม่ได้  ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 5. . การตกแต่งปรับปรุงเปลี่ยนแปลง นับตั้งแต่วันที่ผู้เช่าได้รับหนังสือมอบการครอบครองทรัพย์สินที่เช่าผู้เช่ามีสิทธิเข้า ปรับปรุงตกแต่งเพื่อใช้ประโยชน์ในทรัพย์สินที่เช่าซึ่งรวมถึงการติดป้ายหรือข้อความอย่างอื่นภายในทรัพย์สินที่เช่าได้ โดยผู้เช่าจะต้องเสนอรายละเอียดในการปรับปรุงตกแต่งเป็นหนังสือและต้องให้ผู้ให้เช่าเห็นชอบด้วยก่อนการปรับปรุงตกแต่งจะต้องไม่ทำให้เกิดความเสียหายใดๆแก่ตัวอาคารถ้าเกิดความเสียหายผู้เช่าต้องรับผิดชอบความเสียหายที่เกิดขึ้นทั้งสิ้น   ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'อนึ่ง สิ่งที่ตกแต่งและ / หรือปรับปรุงที่ติดตรึงตรากับทรัพย์สินที่เช่าซึ่งสามารถจะเคลื่อนย้ายโดยไม่ก่อให้เกิดความ ความเสียหายแก่ทรัพย์สินที่เช่านั้นไม่ว่าจะเป็นส่วนควบหรืออุปกรณ์ให้คงเป็นกรรมสิทธิ์ของผู้เช่าในระหว่างที่สัญญาเช่านี้มีผลบังคับ และเมื่อสิ้นสุดสัญญาไม่ว่ากรณีใด ๆ ทั้งสิ้น   ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 6.  หากผู้เช่าประสงค์ต่อสัญญาเช่าคราวต่อไป ให้แจ้งแก่ผู้ให้เช่าทราบไม่น้อยกว่า 90 วัน ก่อนวันครบสัญญา เช่า หากผู้ให้เช่าตกลงให้เช่าต่อผู้เช่าต้องเข้าทำสัญญาเช่าใหม่ก่อนสัญญาเช่านี้ครบกำหนดไม่น้อยกว่า 90 วันแต่ทั้งนี้ให้  ปฏิบัติตามเงื่อนไขและอัตราค่าเช่าในสัญญาเช่าฉบับใหม่ด้วยหากพ้นกำหนดนี้ถือว่าผู้เช่าไม่ประสงค์จะเช่าต่อผู้เช่าต้อง ทำการส่งมอบพื้นที่คืนแก่ผู้ให้เช่าโดยการที่ผู้เช่าต้องขนย้ายทรัพย์สินและบริวารออกจากสถานที่เช่าและทำการซ่อมแซมอาคารให้มีสภาพดังเดิมเหมือนสภาพที่ได้รับมอบไปจากผู้ให้เช่าให้เสร็จเรียบร้อยในวันที่สิ้นสุดสัญญาเช่าพร้อมทั้งนำกุญแจไปคืนแก่ผู้ให้เช่าหากเกินกำหนดนี้ผู้เช่าต้องรับผิดชอบค่าเสียหายและปฏิบัติตามข้อความในสัญญาข้อ 11. อีก     ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 7.  เมื่อผู้ให้เช่าต้องการสถานที่คืน ผู้ให้เช่าจะแจ้งให้ผู้เช่าทราบล่วงหน้า 3 เดือน โดยผู้เช่าจะไม่เรียกร้องค่าขนย้ายใด ๆ ทั้งสิ้น ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 8.  เมื่อครบกำหนดสัญญาเช่าแล้ว  ผู้เช่ายังไม่ออกจากสถานที่ให้เช่า  ผู้เช่ายินยอมให้ผู้ให้เช่าปรับวันละ \n5,000.- บาท ( ห้าพันบาทถ้วน )  ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 9. เมื่อผู้เช่ายกเลิกสัญญาเช่าแล้ว ผู้เช่าจะรับผิดชอบรื้อถอนตู้เซฟ หรือประตูห้องนิรภัยออกไปให้เรียบร้อย (สำหรับผู้ประกอบธุรกิจธนาคารหรือธุรกิจที่เกี่ยวข้อง)และทำการซ่อมแซมอาคารให้มีสภาพดังเดิมเหมือนสภาพที่ได้\nรับมอบไปจากผู้ให้เช่าให้เสร็จเรียบร้อยในวันที่สิ้นสุดสัญญาเช่า ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 10. หากผู้เช่าประสงค์จะเลิกเช่าก่อนที่จะครบกำหนดตามสัญญาเช่าผู้เช่าต้องมีหนังสือแจ้งให้ผู้ให้เช่าทราบล่วง หน้าไม่น้อยกว่า 90 วัน และผู้เช่าต้องส่งมอบห้องคืนตามข้อ 11. ด้วย    ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 11. ผู้เช่าต้องส่งมอบพื้นที่นี้คืนแก่ผู้ให้เช่าเมื่อสิ้นสุดสัญญาเช่าหรือเมื่อผู้ให้เช่าบอกเลิกสัญญาเช่าหรือผู้เช่าบอกเลิก สัญญาเช่าหากผู้เช่าไม่ยอมหรือไม่ยินยอมขนย้ายทรัพย์สินและบริวารออกไปหรือไม่ส่งมอบพื้นที่นี้ผู้เช่ายอมให้ ผู้ให้เช่ากระทำการต่อไปนี้ได้โดยผู้เช่าจะไม่เอาผิดกับผู้ให้เช่าไม่ว่าในทางแพ่งหรือทางอาญาคือ       ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 11.1  ผู้เช่ายอมให้ผู้ให้เช่าริบเงินประกันในข้อ 2.3 ได้ทันทีและผู้เช่าต้องรับผิดชอบชดใช้ค่าปรับแก่ผู้ให้เช่าเดือน \nละ 2เท่าของอัตราค่าเช่าที่ใช้อยู่ในสัญญาฉบับนี้นับจากวันที่สิ้นสุดสัญญาเช่าหรือเมื่อผู้ให้เช่าบอกเลิกสัญญาเช่าหรือ ไปจนถึงวันที่ผู้เช่ากระทำการส่งมอบพื้นที่คืนแก่ผู้ให้เช่าเป็นที่เรียบร้อยเพื่อให้ผู้ให้เช่าจะได้ครอบครองและเข้าไปใช้ ประโยชน์ในพื้นที่นี้ได้อย่างสมบูรณ์           ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 11.2 ผู้เช่ายอมให้ผู้ให้เช่านำกุญแจเข้าปิด เปิด หรือทำลายกุญแจหรือสิ่งกีดขวางใดที่เป็นของผู้เช่าหรือบริวาร อันเป็นอุปสรรคในการเข้าครอบครองพื้นที่นี้ของผู้ให้เช่าและขนย้ายทรัพย์สินเหล่านั้นกลับไปภายใน7 วัน นับจากวันที่ ผู้ให้เช่าได้มีหนังสือส่งไปและหากเกิดความเสียหายหรือสูญหายของทรัพย์สินอันใดไม่ว่าในระหว่างการขนย้ายหรือระหว่างการรอให้ผู้เช่าเข้ามาขนย้ายก็ตามผู้ให้เช่าไม่ต้องรับผิดชอบทุกกรณีค่าใช้จ่ายในการขนย้ายและค่าใช้จ่ายในการเก็บทรัพย์สินของผู้เช่าที่ผู้ให้เช่าได้ใช้จ่ายไปผู้เช่าต้องเป็นผู้รับผิดชอบชำระให้แก่ผู้ให้เช่าทั้งหมดหากพ้นกำหนดนี้ไปให้ถือว่าผู้เช่า สละสิทธิ์ในทรัพย์เหล่านั้นโดยยินยอมให้ตกเป็นของผู้ให้เช่าโดยผู้เช่าจะไม่ติดใจเอาความหรือเรียกร้องสิ่งใดจากผู้ให้เช่าอีกทั้งนั้น           ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 12. ผู้เช่ายอมปฏิบัติตามกฎระเบียบของผู้ให้เช่าในการรักษาความเป็นระเบียบเรียบร้อยความสะอาดต้องจัดการภายใน บริเวณสถานที่เช่าโดยกำจัดสิ่งโสโครกและกลิ่นเหม็นและนำไปทิ้งยังสถานที่ที่ผู้ให้เช่าจัดไว้และไม่กระทำการอึกทึกเป็น ประจำจนคนอื่นได้รับความรำคาญจากความปกติสุขและความสะดวกสบายของลูกค้าหรือผู้มาติดต่อการค้าทั้ง ของผู้เช่าเองและของผู้เช่ารายอื่นด้วยเช่นกัน       ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 12.1 พื้นที่ทางเดินบริเวณทางเท้าด้านหน้า และด้านหลังของพื้นที่ที่เช่าเป็นกรรมสิทธิ์ของผู้ให้เช่าเท่านั้นห้ามมิให้ มีการนำสินค้าหรืออุปกรณ์ทุกชนิดมาวางหรือติดตั้งเป็นการชั่วคราวหรือถาวรไม่ว่ากรณีใด ๆ ทั้งสิ้น     ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 12.2 รถยนต์หรือพาหนะอื่น ๆ ของผู้เช่า ผู้เช่ายอมให้ความร่วมมือในการนำไปจอดบริเวณลานจอดรถที่ผู้ให้เช่าจัด ให้เพื่อความสะดวกในการจอดรถของลูกค้าของศูนย์การค้า ในวันเสาร์ หรือวันอาทิตย์หรือวันอื่นที่ผู้ให้เช่าได้จัดตลาดนัด หรือจัดงานต่าง ๆ ผู้เช่ายอมนำรถไปจอดบริเวณที่จะจัดให้แต่ละคราวไป       ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 13. ถ้าผู้ให้เช่าบอกเลิกสัญญาเช่านี้ก่อนวันสิ้นสุดสัญญาเช่าโดยผู้เช่ามิได้เป็นฝ่ายผิดสัญญาก่อนผู้ให้เช่าต้องคืนเงินประกันแก่ ผู้เช่าภายใน 30 วัน นับจากวันที่ผู้เช่าได้ส่งมอบพื้นที่เช่าคืนตามข้อ 11. เรียบร้อย         ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 14. ในกรณีเกิดอัคคีภัยหรือภัยพิบัติอย่างอื่นใดทั้งหมดหรือแต่บางส่วนจนไม่เหมาะสมที่จะเช่าต่อไปอีกตามความ เป็นจริงให้ถือว่าเป็นการสิ้นสุดสัญญาเช่าลง           ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 15. ในกรณีที่เกิดอุบัติเหตุขัดข้องสำหรับการให้บริการส่วนกลางเฉพาะส่วนพื้นที่เช่าของผู้เช่าบกพร่องในบางครั้งผู้เช่า จะไม่ถือเป็นเหตุที่จะลดอัตราค่าบริการตามที่กำหนดไว้             ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 16. พื้นที่ถนนในส่วนต่าง ๆ และทางเท้าเป็นกรรมสิทธิ์ของผู้ให้เช่าเท่านั้น ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 17. ผู้เช่าสัญญาว่าจะไม่ใช้สถานที่เช่า ทำการค้าอย่างใดอันมิชอบด้วยกฎหมายหรือเป็นที่น่ารังเกียจหรืออาจจะเป็น เชื้อเพลิงหรือทำให้สถานที่เช่าชำรุดเป็นอันตรายไปโดยเร็วพลันทั้งจะไม่ยอมให้ผู้อื่นกระทำการใด ๆ ดังกล่าวด้วย   ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Text(
//               'ข้อ 18. หากผู้เช่าผิดสัญญาข้อหนึ่งข้อใด ผู้ให้เช่าสามารถทำการเอาผิดกับผู้เช่าได้ทั้งทางแพ่งและทางอาญา    ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 40 * PdfPageFormat.mm),
//             pw.SizedBox(height: 10 * PdfPageFormat.mm),
//             pw.Text(
//               'สัญญาฉบับนี้ทำเป็นสองฉบับมีข้อความถูกต้องตรงกันคู่สัญญาได้อ่านและเข้าใจข้อความนี้โดยตลอดแล้วเห็นว่า ถูกต้องตามเจตนาของคู่สัญญาทุกประการ จึงได้ลงลายมือชื่อไว้เป็นหลักฐานต่อหน้าพยาน  ',
//               textAlign: pw.TextAlign.left,
//               style: pw.TextStyle(
//                 fontSize: 10.0,
//                 font: ttf,
//                 color: PdfColors.black,
//               ),
//             ),
//             pw.SizedBox(height: 30 * PdfPageFormat.mm),
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//               (base64Image_1 == '')
//                   ? pw.Text(
//                       'ลงชื่อ.............................................ผู้ให้เช่า   ',
//                       textAlign: pw.TextAlign.justify,
//                       style: pw.TextStyle(
//                         fontSize: 10.0,
//                         font: ttf,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     )
//                   : pw.Column(
//                       mainAxisAlignment: pw.MainAxisAlignment.center,
//                       children: [
//                         pw.Padding(
//                           padding: const pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
//                           child: pw.Center(
//                             child: pw.Image(pw.MemoryImage(data1),
//                                 width: 100, height: 100),
//                           ),
//                         ),
//                         pw.Text(
//                           'ลงชื่อ.............................................ผู้ให้เช่า   ',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                             fontSize: 10.0,
//                             font: ttf,
//                             fontWeight: pw.FontWeight.bold,
//                           ),
//                         )
//                       ],
//                     )

//               // pw.Row(
//               //     crossAxisAlignment: pw.CrossAxisAlignment.end,
//               //     mainAxisAlignment: pw.MainAxisAlignment.center,
//               //     children: [
//               //       pw.Text(
//               //         'ลงชื่อ',
//               //         textAlign: pw.TextAlign.justify,
//               //         style: pw.TextStyle(
//               //           fontSize: 10.0,
//               //           font: ttf,
//               //           fontWeight: pw.FontWeight.bold,
//               //         ),
//               //       ),
//               //       pw.Padding(
//               //         padding: const pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
//               //         child: pw.Center(
//               //           child: pw.Image(pw.MemoryImage(data1),
//               //               width: 100, height: 100),
//               //         ),
//               //       ),
//               //       pw.Text(
//               //         'ผู้ให้เช่า',
//               //         textAlign: pw.TextAlign.justify,
//               //         style: pw.TextStyle(
//               //           fontSize: 10.0,
//               //           font: ttf,
//               //           fontWeight: pw.FontWeight.bold,
//               //         ),
//               //       ),
//               //     ],
//               //   )
//             ]),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//               pw.Text(
//                 '( $name1 ) ',
//                 textAlign: pw.TextAlign.justify,
//                 style: pw.TextStyle(
//                   fontSize: 10.0,
//                   font: ttf,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ]),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//               pw.Text(
//                 'บริษัท ขันแก้ว จำกัด ',
//                 textAlign: pw.TextAlign.justify,
//                 style: pw.TextStyle(
//                   fontSize: 10.0,
//                   font: ttf,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ]),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//               pw.Text(
//                 'วันที่ $date_string ',
//                 textAlign: pw.TextAlign.justify,
//                 style: pw.TextStyle(
//                   fontSize: 10.0,
//                   font: ttf,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ]),
//             pw.SizedBox(height: 30 * PdfPageFormat.mm),
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//               (base64Image_2 == '')
//                   ? pw.Text(
//                       'ลงชื่อ.............................................ผู้เช่า   ',
//                       textAlign: pw.TextAlign.justify,
//                       style: pw.TextStyle(
//                         fontSize: 10.0,
//                         font: ttf,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     )
//                   : pw.Column(
//                       mainAxisAlignment: pw.MainAxisAlignment.center,
//                       children: [
//                         pw.Padding(
//                           padding: const pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
//                           child: pw.Center(
//                             child: pw.Image(pw.MemoryImage(data2),
//                                 width: 100, height: 100),
//                           ),
//                         ),
//                         pw.Text(
//                           'ลงชื่อ.............................................ผู้เช่า   ',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                             fontSize: 10.0,
//                             font: ttf,
//                             fontWeight: pw.FontWeight.bold,
//                           ),
//                         )
//                       ],
//                     )
//             ]),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//               pw.Text(
//                 '( $name2 ) ',
//                 textAlign: pw.TextAlign.justify,
//                 style: pw.TextStyle(
//                   fontSize: 10.0,
//                   font: ttf,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ]),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//               pw.Text(
//                 'ห้างหุ้นส่วนจำกัด ลาแปงคาเฟ่ ',
//                 textAlign: pw.TextAlign.justify,
//                 style: pw.TextStyle(
//                   fontSize: 10.0,
//                   font: ttf,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ]),
//             pw.SizedBox(height: 2 * PdfPageFormat.mm),
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
//               pw.Text(
//                 'วันที่ $date_string ',
//                 textAlign: pw.TextAlign.justify,
//                 style: pw.TextStyle(
//                   fontSize: 10.0,
//                   font: ttf,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ]),
//             pw.SizedBox(height: 50 * PdfPageFormat.mm),
//             pw.Row(children: [
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Column(
//                     children: [
//                       (base64Image_3 == '')
//                           ? pw.Text(
//                               'ลงชื่อ.............................................พยาน 1   ',
//                               textAlign: pw.TextAlign.justify,
//                               style: pw.TextStyle(
//                                 fontSize: 10.0,
//                                 font: ttf,
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             )
//                           : pw.Column(
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               children: [
//                                 pw.Padding(
//                                   padding:
//                                       const pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
//                                   child: pw.Center(
//                                     child: pw.Image(pw.MemoryImage(data3),
//                                         width: 100, height: 100),
//                                   ),
//                                 ),
//                                 pw.Text(
//                                   'ลงชื่อ.............................................พยานที่1   ',
//                                   textAlign: pw.TextAlign.justify,
//                                   style: pw.TextStyle(
//                                     fontSize: 10.0,
//                                     font: ttf,
//                                     fontWeight: pw.FontWeight.bold,
//                                   ),
//                                 )
//                               ],
//                             ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         '( $name3 ) ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           fontSize: 10.0,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         'วันที่ $date_string ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           fontSize: 10.0,
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
//                       (base64Image_4 == '')
//                           ? pw.Text(
//                               'ลงชื่อ.............................................พยาน 2   ',
//                               textAlign: pw.TextAlign.justify,
//                               style: pw.TextStyle(
//                                 fontSize: 10.0,
//                                 font: ttf,
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             )
//                           : pw.Column(
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               children: [
//                                 pw.Padding(
//                                   padding:
//                                       const pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
//                                   child: pw.Center(
//                                     child: pw.Image(pw.MemoryImage(data4),
//                                         width: 100, height: 100),
//                                   ),
//                                 ),
//                                 pw.Text(
//                                   'ลงชื่อ.............................................พยานที่2   ',
//                                   textAlign: pw.TextAlign.justify,
//                                   style: pw.TextStyle(
//                                     fontSize: 10.0,
//                                     font: ttf,
//                                     fontWeight: pw.FontWeight.bold,
//                                   ),
//                                 )
//                               ],
//                             ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         '( $name4 ) ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           fontSize: 10.0,
//                           font: ttf,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                       pw.Text(
//                         'วันที่ $date_string ',
//                         textAlign: pw.TextAlign.justify,
//                         style: pw.TextStyle(
//                           fontSize: 10.0,
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
//     // if (base64Image_new1 != '')
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               RentalInforman_Agreement2(doc: pdf, context: context),
//         ));
//   }
// }
