// import 'dart:developer';

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
// import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:math' as math;

// class Excgen_DailyReport_cm {
//   static void exportExcel_DailyReport_cm(
//       context,
//       NameFile_,
//       _verticalGroupValue_NameFile,
//       Value_Report,
//       _TransReBillModels,
//       TransReBillModels,
//       renTal_name,
//       Value_selectDate,
//       rent_CM,
//       tank_CM,
//       electricity_CM,
//       MOMO_CM,
//       rent_area_CM,
//       sum_numDay_refno_CM,
//       zoneModels) async {
//     final x.Workbook workbook = x.Workbook();

//     final x.Worksheet sheet = workbook.worksheets[0];
//     sheet.pageSetup.topMargin = 1;
//     sheet.pageSetup.bottomMargin = 1;
//     sheet.pageSetup.leftMargin = 1;
//     sheet.pageSetup.rightMargin = 1;
//     var nFormat = NumberFormat("#,##0.00", "en_US");
// //     //Adding a picture
// //     final ByteData bytes_image = await rootBundle.load('images/LOGO.png');
// //     final Uint8List image = bytes_image.buffer
// //         .asUint8List(bytes_image.offsetInBytes, bytes_image.lengthInBytes);
// // // Adding an image.
// //     sheet.pictures.addStream(1, 1, image);
// //     final x.Picture picture = sheet.pictures[0];

// // // Re-size an image
// //     picture.height = 200;
// //     picture.width = 200;

// // // rotate an image.
// //     picture.rotation = 100;

// // // Flip an image.
// //     picture.horizontalFlip = true;
//     x.Style globalStyle = workbook.styles.add('style');
//     globalStyle.fontName = 'Angsana New';
//     globalStyle.numberFormat = '_(\$* #,##0_)';
//     globalStyle.fontSize = 17;
//     globalStyle.backColorRgb = Color(0xFFF5F7FA);

//     x.Style globalStyle2 = workbook.styles.add('style2');
//     globalStyle2.backColorRgb = Color(0xFFFFFFFF);
//     globalStyle2.numberFormat = '_(\$* #,##0_)';
//     globalStyle2.fontSize = 12;
//     globalStyle2.hAlign = x.HAlignType.center;

//     x.Style globalStyle22 = workbook.styles.add('style22');
//     globalStyle22.backColorRgb = Color(0xC7F5F7FA);
//     globalStyle22.numberFormat = '_(\* #,##0.00_)';
//     globalStyle22.fontSize = 12;
//     globalStyle22.numberFormat;
//     globalStyle22.hAlign = x.HAlignType.center;

//     x.Style globalStyle222 = workbook.styles.add('style222');
//     globalStyle222.backColorRgb = Color(0xC7E1E2E6);
//     globalStyle222.numberFormat = '_(\* #,##0.00_)';
//     // globalStyle222.numberFormat;
//     globalStyle222.fontSize = 12;
//     globalStyle222.hAlign = x.HAlignType.center;

//     x.Style globalStyle3 = workbook.styles.add('style3');
//     globalStyle3.backColorRgb = Color(0xFF729DD6);
//     globalStyle3.borders.bottom.colorRgb = Colors.black;
//     globalStyle3.fontName = 'Angsana New';
//     globalStyle3.fontSize = 15;
//     globalStyle3.hAlign = x.HAlignType.center;
//     globalStyle3.borders;

//     x.Style globalStyle33 = workbook.styles.add('style33');
//     globalStyle33.backColorRgb = Color(0xFF627C9E);
//     globalStyle33.fontName = 'Angsana New';
//     globalStyle33.fontSize = 15;
//     globalStyle33.hAlign = x.HAlignType.center;
//     globalStyle33.borders;

//     x.Style globalStyle4 = workbook.styles.add('style4');
//     globalStyle4.backColorRgb = Color(0xFFDA97AD);
//     globalStyle4.hAlign = x.HAlignType.center;
//     globalStyle4.fontName = 'Angsana New';
//     globalStyle4.fontSize = 15;
//     globalStyle4.borders;

//     x.Style globalStyle44 = workbook.styles.add('style44');
//     globalStyle44.backColorRgb = Color(0xFF9C5B7A);
//     globalStyle44.fontName = 'Angsana New';
//     globalStyle44.hAlign = x.HAlignType.center;
//     globalStyle44.fontSize = 15;
//     globalStyle44.borders;

//     x.Style globalStyle5 = workbook.styles.add('style5');
//     globalStyle5.backColorRgb = Color(0xFF84BD89);
//     globalStyle5.fontName = 'Angsana New';
//     globalStyle5.hAlign = x.HAlignType.center;
//     globalStyle5.fontSize = 15;
//     globalStyle5.borders;

//     x.Style globalStyle55 = workbook.styles.add('style55');
//     globalStyle55.backColorRgb = Color(0xFF6B8D6D);
//     globalStyle55.fontName = 'Angsana New';
//     globalStyle55.hAlign = x.HAlignType.center;
//     globalStyle55.fontSize = 15;
//     globalStyle55.borders;

//     x.Style globalStyle6 = workbook.styles.add('style6');
//     globalStyle6.backColorRgb = Color(0xFFE9BFA3);
//     globalStyle6.fontName = 'Angsana New';
//     globalStyle6.hAlign = x.HAlignType.center;
//     globalStyle6.fontSize = 15;
//     globalStyle6.borders;

//     x.Style globalStyle66 = workbook.styles.add('style66');
//     globalStyle66.backColorRgb = Color(0xFFBD9B84);
//     globalStyle66.fontName = 'Angsana New';
//     globalStyle55.hAlign = x.HAlignType.center;
//     globalStyle66.fontSize = 15;
//     globalStyle66.borders;

//     x.Style globalStyle7 = workbook.styles.add('style7');
//     globalStyle7.backColorRgb = Color(0xFFD4E6A3);
//     globalStyle7.fontName = 'Angsana New';
//     globalStyle7.numberFormat = '_(\* #,##0.00_)';
//     globalStyle7.hAlign = x.HAlignType.center;
//     globalStyle7.fontSize = 15;
//     globalStyle7.bold = true;
//     globalStyle7.fontColorRgb = Color(0xFFC52611);

//     x.Style globalStyle77 = workbook.styles.add('style77');
//     globalStyle7.backColorRgb = Color(0xFFD4E6A3);
//     globalStyle77.fontName = 'Angsana New';
//     globalStyle77.numberFormat = '_(\* #,##0.00_)';
//     globalStyle77.hAlign = x.HAlignType.center;
//     globalStyle77.fontSize = 15;
//     globalStyle77.bold = true;
//     globalStyle77.fontColorRgb = Color(0xFFC52611);

//     x.Style globalStyle8 = workbook.styles.add('style8');
//     globalStyle8.backColorRgb = Color.fromARGB(255, 174, 206, 221);
//     globalStyle8.fontName = 'Angsana New';
//     globalStyle8.numberFormat = '_(\* #,##0.00_)';
//     globalStyle8.hAlign = x.HAlignType.center;
//     globalStyle8.fontSize = 15;
//     globalStyle8.bold = true;
//     globalStyle8.fontColorRgb = Color(0xFFC52611);

//     x.Style globalStyle88 = workbook.styles.add('style88');
//     globalStyle88.backColorRgb = Color.fromARGB(255, 213, 225, 240);
//     globalStyle88.fontName = 'Angsana New';
//     globalStyle88.numberFormat = '_(\* #,##0.00_)';
//     globalStyle88.hAlign = x.HAlignType.center;
//     globalStyle88.fontSize = 15;
//     globalStyle88.bold = true;
//     globalStyle88.fontColorRgb = Color(0xFFC52611);

//     sheet.getRangeByName('A1').cellStyle = globalStyle;
//     sheet.getRangeByName('B1').cellStyle = globalStyle;
//     sheet.getRangeByName('C1').cellStyle = globalStyle;
//     sheet.getRangeByName('D1').cellStyle = globalStyle;
//     sheet.getRangeByName('E1').cellStyle = globalStyle;
//     sheet.getRangeByName('F1').cellStyle = globalStyle;
//     sheet.getRangeByName('G1').cellStyle = globalStyle;
//     sheet.getRangeByName('H1').cellStyle = globalStyle;
//     sheet.getRangeByName('I1').cellStyle = globalStyle;
//     sheet.getRangeByName('J1').cellStyle = globalStyle;
//     sheet.getRangeByName('K1').cellStyle = globalStyle;
//     sheet.getRangeByName('K1').cellStyle = globalStyle;
//     sheet.getRangeByName('L1').cellStyle = globalStyle;
//     sheet.getRangeByName('M1').cellStyle = globalStyle;
//     sheet.getRangeByName('N1').cellStyle = globalStyle;
//     sheet.getRangeByName('O1').cellStyle = globalStyle;
//     sheet.getRangeByName('P1').cellStyle = globalStyle;
//     sheet.getRangeByName('Q1').cellStyle = globalStyle;
//     sheet.getRangeByName('R1').cellStyle = globalStyle;
//     final x.Range range = sheet.getRangeByName('E1');
//     range.setText('รายงานประจำวัน (${renTal_name})');
// // ExcelSheetProtectionOption
//     final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
//     options.all = true;

// // Protecting the Worksheet by using a Password

//     sheet.getRangeByName('A2').cellStyle = globalStyle;
//     sheet.getRangeByName('B2').cellStyle = globalStyle;
//     sheet.getRangeByName('C2').cellStyle = globalStyle;
//     sheet.getRangeByName('D2').cellStyle = globalStyle;
//     sheet.getRangeByName('E2').cellStyle = globalStyle;
//     sheet.getRangeByName('F2').cellStyle = globalStyle;
//     sheet.getRangeByName('G2').cellStyle = globalStyle;
//     sheet.getRangeByName('H2').cellStyle = globalStyle;
//     sheet.getRangeByName('I2').cellStyle = globalStyle;
//     sheet.getRangeByName('J2').cellStyle = globalStyle;
//     sheet.getRangeByName('L2').cellStyle = globalStyle;
//     sheet.getRangeByName('M2').cellStyle = globalStyle;
//     sheet.getRangeByName('N2').cellStyle = globalStyle;
//     sheet.getRangeByName('O2').cellStyle = globalStyle;
//     sheet.getRangeByName('P2').cellStyle = globalStyle;
//     sheet.getRangeByName('Q2').cellStyle = globalStyle;
//     sheet.getRangeByName('R2').cellStyle = globalStyle;
//     // sheet.getRangeByName('A2').setText('${renTal_name}');
//     sheet
//         .getRangeByName('A2')
//         .setText('ข้อมูลประจำวันที่ : ${Value_selectDate}');
//     sheet.getRangeByName('A2').cellStyle = globalStyle;
//     sheet.getRangeByName('K2').cellStyle = globalStyle;

//     sheet.getRangeByName('A3').cellStyle = globalStyle33;
//     sheet.getRangeByName('B3').cellStyle = globalStyle33;
//     sheet.getRangeByName('C3').cellStyle = globalStyle33;
//     sheet.getRangeByName('D3').cellStyle = globalStyle33;
//     sheet.getRangeByName('E3').cellStyle = globalStyle33;
//     sheet.getRangeByName('F3').cellStyle = globalStyle44;
//     sheet.getRangeByName('G3').cellStyle = globalStyle44;
//     sheet.getRangeByName('H3').cellStyle = globalStyle44;
//     sheet.getRangeByName('I3').cellStyle = globalStyle44;
//     sheet.getRangeByName('J3').cellStyle = globalStyle44;
//     sheet.getRangeByName('K3').cellStyle = globalStyle44;
//     sheet.getRangeByName('L3').cellStyle = globalStyle55;
//     sheet.getRangeByName('M3').cellStyle = globalStyle55;
//     sheet.getRangeByName('N3').cellStyle = globalStyle55;
//     sheet.getRangeByName('O3').cellStyle = globalStyle66;
//     sheet.getRangeByName('P3').cellStyle = globalStyle66;
//     sheet.getRangeByName('Q3').cellStyle = globalStyle66;
//     sheet.getRangeByName('R3').cellStyle = globalStyle66;

//     sheet.getRangeByName('A4').cellStyle = globalStyle3;
//     sheet.getRangeByName('B4').cellStyle = globalStyle3;
//     sheet.getRangeByName('C4').cellStyle = globalStyle3;
//     sheet.getRangeByName('D4').cellStyle = globalStyle3;
//     sheet.getRangeByName('E4').cellStyle = globalStyle3;
//     sheet.getRangeByName('F4').cellStyle = globalStyle3;
//     sheet.getRangeByName('G4').cellStyle = globalStyle4;
//     sheet.getRangeByName('H4').cellStyle = globalStyle4;
//     sheet.getRangeByName('I4').cellStyle = globalStyle4;
//     sheet.getRangeByName('J4').cellStyle = globalStyle4;
//     sheet.getRangeByName('K4').cellStyle = globalStyle4;
//     sheet.getRangeByName('L4').cellStyle = globalStyle4;
//     sheet.getRangeByName('M4').cellStyle = globalStyle5;
//     sheet.getRangeByName('N4').cellStyle = globalStyle5;
//     sheet.getRangeByName('O4').cellStyle = globalStyle5;
//     sheet.getRangeByName('P4').cellStyle = globalStyle6;
//     sheet.getRangeByName('Q4').cellStyle = globalStyle6;
//     sheet.getRangeByName('R4').cellStyle = globalStyle6;

//     sheet.getRangeByName('A4').columnWidth = 18;
//     sheet.getRangeByName('B4').columnWidth = 25;
//     sheet.getRangeByName('C4').columnWidth = 25;
//     sheet.getRangeByName('D4').columnWidth = 30;
//     sheet.getRangeByName('E4').columnWidth = 18;
//     sheet.getRangeByName('F4').columnWidth = 18;
//     sheet.getRangeByName('G4').columnWidth = 18;
//     sheet.getRangeByName('H4').columnWidth = 18;
//     sheet.getRangeByName('I4').columnWidth = 18;
//     sheet.getRangeByName('J4').columnWidth = 18;
//     sheet.getRangeByName('K4').columnWidth = 18;
//     sheet.getRangeByName('L4').columnWidth = 18;
//     sheet.getRangeByName('M4').columnWidth = 18;
//     sheet.getRangeByName('N4').columnWidth = 18;
//     sheet.getRangeByName('O4').columnWidth = 18;
//     sheet.getRangeByName('P4').columnWidth = 18;
//     sheet.getRangeByName('Q4').columnWidth = 18;
//     sheet.getRangeByName('A3:F3').merge();
//     // sheet.getRangeByName('B3:B4').merge();
//     // sheet.getRangeByName('C3:C4').merge();
//     // sheet.getRangeByName('D3:D4').merge();
//     // sheet.getRangeByName('E3:E4').merge();
//     // sheet.getRangeByName('F3:F4').merge();
//     sheet.getRangeByName('G3:L3').merge();
//     sheet.getRangeByName('M3:O3').merge();
//     // sheet.getRangeByName('O4:P4').merge();
//     sheet.getRangeByName('P3:Q3').merge();
//     sheet.getRangeByName('A3').setText('ข้อมูล');
//     sheet.getRangeByName('G3').setText('ยอดรับชำระ');
//     sheet.getRangeByName('M3').setText('ยอดนำส่งธนาคาร');
//     sheet.getRangeByName('P4').setText('สรุป');

//     // sheet.getRangeByName('A3').setText('ข้อมูลผู้เช่า');

//     sheet.getRangeByName('A4').rowHeight = 18;
//     sheet.getRangeByName('B4').rowHeight = 18;
//     sheet.getRangeByName('C4').rowHeight = 18;
//     sheet.getRangeByName('D4').rowHeight = 18;
//     sheet.getRangeByName('E4').rowHeight = 18;
//     sheet.getRangeByName('F4').rowHeight = 18;
//     sheet.getRangeByName('G4').rowHeight = 18;
//     sheet.getRangeByName('H4').rowHeight = 18;
//     sheet.getRangeByName('I4').rowHeight = 18;
//     sheet.getRangeByName('J4').rowHeight = 18;
//     sheet.getRangeByName('K4').rowHeight = 18;
//     sheet.getRangeByName('L4').rowHeight = 18;
//     sheet.getRangeByName('M4').rowHeight = 18;
//     sheet.getRangeByName('N4').rowHeight = 18;
//     sheet.getRangeByName('O4').rowHeight = 18;
//     sheet.getRangeByName('P4').rowHeight = 18;
//     sheet.getRangeByName('Q4').rowHeight = 18;

//     sheet.getRangeByName('A4').setText('เลขที่');
//     sheet.getRangeByName('B4').setText('รหัสโซน');
//     sheet.getRangeByName('C4').setText('โซน');
//     sheet.getRangeByName('D4').setText('รหัสพื้นที่');
//     sheet.getRangeByName('E4').setText('ผู้เช่า');

//     sheet.getRangeByName('F4').setText('ขนาดพื้นที่ (ต.ร.ม.)');
//     sheet.getRangeByName('G4').setText('ค่าเช่ารายวัน');
//     sheet.getRangeByName('H4').setText('โม่');
//     sheet.getRangeByName('I4').setText('ถัง');
//     sheet.getRangeByName('J4').setText('เช่าพื้นที่');
//     sheet.getRangeByName('K4').setText('ค่าไฟ');
//     sheet.getRangeByName('L4').setText('รวมยอดเก็บรายวัน');
//     sheet.getRangeByName('M4').setText('7 คณา');
//     sheet.getRangeByName('N4').setText('บริหาร');
//     sheet.getRangeByName('O4').setText('ขาจร');
//     sheet.getRangeByName('R4').setText('หมายเหตุ');
//     //sheet.getRangeByName('O4').setText('สรุป');
//     // sheet.getRangeByName('P4').setText('สรุป');
//     int index1 = 0;
//     int indextotol = 0;
//     for (var i2 = 0; i2 < _TransReBillModels.length; i2++) {
//       var index = index1 * _TransReBillModels.length + i2;
//       dynamic numberColor = index % 2 == 0 ? globalStyle22 : globalStyle222;
//       indextotol = indextotol + 1;
//       sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('H${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('I${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('J${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('K${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('K${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('L${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('M${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('N${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('O${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('P${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('Q${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('R${indextotol + 5 - 1}').cellStyle = numberColor;
//       sheet.getRangeByName('A${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('B${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('C${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('D${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('E${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('F${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('G${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('H${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('I${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('J${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('K${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('L${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('M${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('N${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('O${indextotol + 5 - 1}').rowHeight = 30;
//       sheet.getRangeByName('P${indextotol + 5 - 1}').rowHeight = 30;
//       sheet
//           .getRangeByName('P${indextotol + 5 - 1}:Q${indextotol + 5 - 1}')
//           .merge();
//       sheet.getRangeByName('R${indextotol + 5 - 1}').rowHeight = 30;

//       // if (i1 == 0) {
//       //   indextotol = indextotol + 0;
//       // } else {
//       //   indextotol = indextotol + 1;
//       // }

//       // print('${TransReBillModels[i2].expname}');
//       // print('${indextotol}');
//       sheet.getRangeByName('A${indextotol + 5 - 1}').setText('${i2 + 1}');
//       sheet.getRangeByName('B${indextotol + 5 - 1}').setText(
//             (_TransReBillModels[i2].zser == null)
//                 ? '-'
//                 : ((_TransReBillModels[i2].zser.toString() == ''))
//                     ? '${_TransReBillModels[i2].zser}'
//                     : '${_TransReBillModels[i2].zser}',
//           );
//       sheet.getRangeByName('C${indextotol + 5 - 1}').setText(
//             (_TransReBillModels[i2].znn == null)
//                 ? '-'
//                 : ((_TransReBillModels[i2].znn.toString() == ''))
//                     ? '${_TransReBillModels[i2].zn}'
//                     : '${_TransReBillModels[i2].znn}',
//           );

//       sheet
//           .getRangeByName('D${indextotol + 5 - 1}')
//           .setText((_TransReBillModels[i2].ln == null)
//               ? '${_TransReBillModels[i2].room_number}'
//               //'${_TransReBillModels[index1].room_number}'
//               : '${_TransReBillModels[i2].ln}');

//       sheet.getRangeByName('E${indextotol + 5 - 1}').setText(
//           (_TransReBillModels[i2].cname == null)
//               ? '${_TransReBillModels[i2].remark}'
//               : '${_TransReBillModels[i2].cname}');

//       sheet.getRangeByName('F${indextotol + 5 - 1}').setText(
//           (_TransReBillModels[i2].area == null)
//               ? '-'
//               : '${_TransReBillModels[i2].area}');

//       // sheet.getRangeByName('E${indextotol + 5 - 1}').setText(
//       //     (_TransReBillModels[i2].sname == null)
//       //         ? ''
//       //         : '${_TransReBillModels[i2].sname}');

//       // sheet.getRangeByName('E${indextotol + 5 - 1}').setNumber(
//       //     (_TransReBillModels[i2].area == null)
//       //         ? 0.00
//       //         : double.parse('${_TransReBillModels[i2].area}'));

//       // sheet.getRangeByName('F${indextotol + 5 - 1}').setNumber(
//       //     (rent_CM[i2].isEmpty) ? 0.00 : double.parse(rent_CM[i2][0]!));

//       // sheet.getRangeByName('G${indextotol + 5 - 1}').setNumber(
//       //     (MOMO_CM[i2].isEmpty) ? 0.00 : double.parse(MOMO_CM[i2][0]!));

//       // sheet.getRangeByName('H${indextotol + 5 - 1}').setNumber(
//       //     (tank_CM[i2].isEmpty) ? 0.00 : double.parse(tank_CM[i2][0]!));

//       // sheet.getRangeByName('I${indextotol + 5 - 1}').setNumber(
//       //     (rent_area_CM[i2].isEmpty)
//       //         ? 0.00
//       //         : double.parse(rent_area_CM[i2][0]!));

//       // sheet.getRangeByName('J${indextotol + 5 - 1}').setNumber(
//       //     (electricity_CM[i2].isEmpty)
//       //         ? 0.00
//       //         : double.parse(electricity_CM[i2][0]!));

//       // sheet
//       //     .getRangeByName('K${indextotol + 5 - 1}')
//       //     .setNumber(double.parse('${_TransReBillModels[i2].total_bill}')
//       //         // '${_TransReBillModels[i2].total_bill}'
//       //         );
//       sheet.getRangeByName('G${indextotol + 5 - 1}').setNumber(
//           (_TransReBillModels[i2].sum_expser1 == null)
//               ? 0.00
//               : double.parse(_TransReBillModels[i2].sum_expser1!));

//       sheet.getRangeByName('H${indextotol + 5 - 1}').setNumber(
//           (_TransReBillModels[i2].sum_expser9 == null)
//               ? 0.00
//               : double.parse(_TransReBillModels[i2].sum_expser9!));

//       sheet.getRangeByName('I${indextotol + 5 - 1}').setNumber(
//           (_TransReBillModels[i2].sum_expser10 == null)
//               ? 0.00
//               : double.parse(_TransReBillModels[i2].sum_expser10!));

//       sheet.getRangeByName('J${indextotol + 5 - 1}').setNumber(
//           (_TransReBillModels[i2].sum_expser11 == null)
//               ? 0.00
//               : double.parse(_TransReBillModels[i2].sum_expser11!));

//       sheet.getRangeByName('K${indextotol + 5 - 1}').setNumber(
//           (_TransReBillModels[i2].sum_expser12 == null)
//               ? 0.00
//               : double.parse(_TransReBillModels[i2].sum_expser12!));

//       sheet
//           .getRangeByName('L${indextotol + 5 - 1}')
//           .setNumber(double.parse('${_TransReBillModels[i2].total_bill}')
//               // '${_TransReBillModels[i2].total_bill}'
//               );

//       // (_TransReBillModels[i2].zser.toString() != '11' ||
//       //         _TransReBillModels[i2].zser.toString() != '12' ||
//       //         _TransReBillModels[i2].zser.toString() != '0' ||
//       //         _TransReBillModels[i2].zser == null ||
//       //         _TransReBillModels[i2].zser1 != null)
//       //     ? sheet.getRangeByName('L${indextotol + 5 - 1}').setText((_TransReBillModels[
//       //                     i2]
//       //                 .zser
//       //                 .toString() ==
//       //             '1')
//       //         ? '${nFormat.format(double.parse('200') * double.parse('${sum_numDay_refno_CM[i2][0]!}'))}'
//       //         : (_TransReBillModels[i2].zser.toString() == '8')
//       //             ? '${nFormat.format(double.parse('100') * double.parse('${sum_numDay_refno_CM[i2][0]!}'))}'
//       //             : (_TransReBillModels[i2].zser.toString() == '9')
//       //                 ? '${nFormat.format(double.parse('50') * double.parse('${sum_numDay_refno_CM[i2][0]!}'))}'
//       //                 : (_TransReBillModels[i2].zn.toString() == 'A' &&
//       //                         sum_numDay_refno_CM[i2].length != 0)
//       //                     ? '${nFormat.format(double.parse('200') * double.parse('${sum_numDay_refno_CM[i2][0]!}'))}'
//       //                     : (_TransReBillModels[i2].zn.toString() == 'B' &&
//       //                             sum_numDay_refno_CM[i2].length != 0)
//       //                         ? '${nFormat.format(double.parse('100') * double.parse('${sum_numDay_refno_CM[i2][0]!}'))}'
//       //                         : (_TransReBillModels[i2].zn.toString() == 'C' &&
//       //                                 sum_numDay_refno_CM[i2].length != 0)
//       //                             ? '${nFormat.format(double.parse('50') * double.parse('${sum_numDay_refno_CM[i2][0]!}'))}'
//       //                             : '${nFormat.format(double.parse('0'))}')
//       //     : sheet.getRangeByName('L${indextotol + 5 - 1}').setText('');
//       (_TransReBillModels[i2].zser.toString() != '11' ||
//               _TransReBillModels[i2].zser.toString() != '12' ||
//               _TransReBillModels[i2].zser.toString() != '0' ||
//               _TransReBillModels[i2].zser == null ||
//               _TransReBillModels[i2].zser1 != null)
//           ? sheet.getRangeByName('M${indextotol + 5 - 1}').setNumber(
//               (_TransReBillModels[i2].zser.toString() == '1')
//                   ? double.parse('200') *
//                       double.parse('${sum_numDay_refno_CM[i2][0]!}')
//                   : (_TransReBillModels[i2].zser.toString() == '8')
//                       ? double.parse('100') *
//                           double.parse('${sum_numDay_refno_CM[i2][0]!}')
//                       : (_TransReBillModels[i2].zser.toString() == '9')
//                           ? double.parse('50') *
//                               double.parse('${sum_numDay_refno_CM[i2][0]!}')
//                           : (_TransReBillModels[i2].zn.toString() == 'A')
//                               ? double.parse('200') *
//                                   double.parse('${sum_numDay_refno_CM[i2][0]!}')
//                               : (_TransReBillModels[i2].zn.toString() == 'B')
//                                   ? double.parse('100') *
//                                       double.parse(
//                                           '${sum_numDay_refno_CM[i2][0]!}')
//                                   : (_TransReBillModels[i2].zn.toString() ==
//                                           'C')
//                                       ? double.parse('50') *
//                                           double.parse(
//                                               '${sum_numDay_refno_CM[i2][0]!}')
//                                       : double.parse('0'))
//           : sheet.getRangeByName('M${indextotol + 5 - 1}').setNumber(0.00);

//       // sheet.getRangeByName('M${indextotol + 5 - 1}').setText((_TransReBillModels[
//       //                 i2]
//       //             .zser
//       //             .toString() ==
//       //         '1')
//       //     ? '${nFormat.format(double.parse('${_TransReBillModels[i2].total_bill}') - (double.parse('200') * double.parse('${sum_numDay_refno_CM[i2][0]!}')))}'
//       //     : (_TransReBillModels[i2].zser.toString() == '8')
//       //         ? '${nFormat.format(double.parse('${_TransReBillModels[i2].total_bill}') - (double.parse('100') * double.parse('${sum_numDay_refno_CM[i2][0]!}')))}'
//       //         : (_TransReBillModels[i2].zser.toString() == '9')
//       //             ? '${nFormat.format(double.parse('${_TransReBillModels[i2].total_bill}') - (double.parse('50') * double.parse('${sum_numDay_refno_CM[i2][0]!}')))}'
//       //             : (_TransReBillModels[i2].zser.toString() == '11') //ขาจร (B)
//       //                 ? '${nFormat.format(double.parse('${_TransReBillModels[i2].total_bill}') - (double.parse(rent_CM[i2][0]!) - double.parse('195')))}'
//       //                 : (_TransReBillModels[i2].zser.toString() ==
//       //                         '12') //ขาจร (C)
//       //                     ? '${nFormat.format(double.parse('${_TransReBillModels[i2].total_bill}') - (double.parse(rent_CM[i2][0]!) - double.parse('100')))}'
//       //                     : (_TransReBillModels[i2].zn.toString() == 'A')
//       //                         ? '${nFormat.format(double.parse('${_TransReBillModels[i2].total_bill}') - (double.parse('200') * double.parse('${sum_numDay_refno_CM[i2][0]!}')))}'
//       //                         : (_TransReBillModels[i2].zn.toString() == 'B')
//       //                             ? '${nFormat.format(double.parse('${_TransReBillModels[i2].total_bill}') - (double.parse('100') * double.parse('${sum_numDay_refno_CM[i2][0]!}')))}'
//       //                             : (_TransReBillModels[i2].zn.toString() ==
//       //                                     'C')
//       //                                 ? '${nFormat.format(double.parse('${_TransReBillModels[i2].total_bill}') - (double.parse('50') * double.parse('${sum_numDay_refno_CM[i2][0]!}')))}'
//       //                                 : '0.00');
//       sheet.getRangeByName('N${indextotol + 5 - 1}').setNumber((_TransReBillModels[i2]
//                   .zser
//                   .toString() ==
//               '1')
//           ? double.parse('${_TransReBillModels[i2].total_bill}') -
//               (double.parse('200') *
//                   double.parse('${_TransReBillModels[i2][0]!}'))
//           : (_TransReBillModels[i2].zser.toString() == '8')
//               ? double.parse('${_TransReBillModels[i2].total_bill}') -
//                   (double.parse('100') *
//                       double.parse('${sum_numDay_refno_CM[i2][0]!}'))
//               : (_TransReBillModels[i2].zser.toString() == '9')
//                   ? double.parse('${_TransReBillModels[i2].total_bill}') -
//                       (double.parse('50') *
//                           double.parse('${sum_numDay_refno_CM[i2][0]!}'))
//                   : (_TransReBillModels[i2].zser.toString() == '11') //ขาจร (B)
//                       ? double.parse('${_TransReBillModels[i2].total_bill}') -
//                           (double.parse(rent_CM[i2][0]!) - double.parse('195'))
//                       : (_TransReBillModels[i2].zser.toString() ==
//                               '12') //ขาจร (C)
//                           ? double.parse('${_TransReBillModels[i2].total_bill}') -
//                               (double.parse(rent_CM[i2][0]!) -
//                                   double.parse('100'))
//                           : (_TransReBillModels[i2].zn.toString() == 'A')
//                               ? double.parse('${_TransReBillModels[i2].total_bill}') -
//                                   (double.parse('200') *
//                                       double.parse(
//                                           '${sum_numDay_refno_CM[i2][0]!}'))
//                               : (_TransReBillModels[i2].zn.toString() == 'B')
//                                   ? double.parse('${_TransReBillModels[i2].total_bill}') -
//                                       (double.parse('100') *
//                                           double.parse(
//                                               '${sum_numDay_refno_CM[i2][0]!}'))
//                                   : (_TransReBillModels[i2].zn.toString() ==
//                                           'C')
//                                       ? double.parse('${_TransReBillModels[i2].total_bill}') -
//                                           (double.parse('50') *
//                                               double.parse(
//                                                   '${sum_numDay_refno_CM[i2][0]!}'))
//                                       : 0.00);

//       // sheet.getRangeByName('N${indextotol + 5 - 1}').setText((_TransReBillModels[
//       //                 i2]
//       //             .zser
//       //             .toString() ==
//       //         '11') //ขาจร (B)
//       //     ? '${nFormat.format(double.parse(rent_CM[i2][0]!) - double.parse('195'))}'
//       //     : (_TransReBillModels[i2].zser.toString() == '12') //ขาจร (C)
//       //         ? '${nFormat.format(double.parse(rent_CM[i2][0]!) - double.parse('100'))}'
//       //         : '0.00');
//       sheet
//           .getRangeByName('O${indextotol + 5 - 1}')
//           .setNumber((_TransReBillModels[i2].zser.toString() == '11') //ขาจร (B)
//               ? double.parse(rent_CM[i2][0]!) - double.parse('195')
//               : (_TransReBillModels[i2].zser.toString() == '12') //ขาจร (C)
//                   ? double.parse(rent_CM[i2][0]!) - double.parse('100')
//                   : 0.00);

//       sheet.getRangeByName('P${indextotol + 5 - 1}').setText(

//           // (_TransReBillModels[
//           //               i2]
//           //           .zser
//           //           .toString() ==
//           //       '11') //ขาจร (B)
//           //   ? 'ขาจร (B) = เอายอด ค่าเช่ารายวัน ขาจร B 330 หรือ 248 บาท (หรือยอดอะไรก็ตามที่กรอdไว้) หัก ค่าเช่ารายวัน ของแผง B ปรกติ 195 บาท จะเท่ากับ ยอดที่จะต้องใส่ไว้ในช่อง ยอดนำส่งธนาคาร ขาจร แล้วส่วนที่เหลือ 499-135 = 364 เอาไว้ช่อง บริหาร'
//           //   : (_TransReBillModels[i2].zser.toString() == '12') //ขาจร (C)
//           //       ? 'ขาจร (C) = เอายอด ค่าเช่ารายวัน ขาจร C 165 บาท หัก ค่าเช่ารายวัน ของแผง C ปรกติ 100 บาท = ยอดที่จะเอาไว้ในช่อง ยอดนำส่งธนาคารขาจร แล้วส่วนที่เหลือ 204-65 = 139 เอาไว้ช่อง บริหาร'
//           //       :
//           // (sum_numDay_refno_CM[i2].isEmpty)
//           //     ? ''
//           //     : 'เลข 7คณาต้อง คูณ ${sum_numDay_refno_CM[i2][0]!} วัน'
//           '');
//       sheet.getRangeByName('R${indextotol + 5 - 1}').setText(
//           (_TransReBillModels[i2].descr == null)
//               ? ''
//               : '${_TransReBillModels[i2].descr.toString()}');
//     }
//     // sheet.getRangeByName('A${indextotol + 5 + 1}').setText('');
//     // sheet.getRangeByName('B${indextotol + 5 + 1}').setText('');
//     // sheet.getRangeByName('C${indextotol + 5 + 1}').setText('รวม');
//     // sheet.getRangeByName('D${indextotol + 5 + 1}').setText('');
//     sheet.getRangeByName('F${indextotol + 5 + 0}').setText('รวมทั้งหมด : ');
//     sheet
//         .getRangeByName('G${indextotol + 5 + 0}')
//         .setFormula('=SUM(G5:G${indextotol + 5 - 1})');
//     sheet
//         .getRangeByName('H${indextotol + 5 + 0}')
//         .setFormula('=SUM(H5:H${indextotol + 5 - 1})');
//     sheet
//         .getRangeByName('I${indextotol + 5 + 0}')
//         .setFormula('=SUM(I5:I${indextotol + 5 - 1})');
//     sheet
//         .getRangeByName('J${indextotol + 5 + 0}')
//         .setFormula('=SUM(J5:J${indextotol + 5 - 1})');
//     sheet
//         .getRangeByName('K${indextotol + 5 + 0}')
//         .setFormula('=SUM(K5:K${indextotol + 5 - 1})');
//     sheet
//         .getRangeByName('L${indextotol + 5 + 0}')
//         .setFormula('=SUM(L5:L${indextotol + 5 - 1})');
//     sheet
//         .getRangeByName('M${indextotol + 5 + 0}')
//         .setFormula('=SUM(M5:M${indextotol + 5 - 1})');
//     sheet
//         .getRangeByName('N${indextotol + 5 + 0}')
//         .setFormula('=SUM(N5:N${indextotol + 5 - 1})');
//     sheet
//         .getRangeByName('O${indextotol + 5 + 0}')
//         .setFormula('=SUM(O5:O${indextotol + 5 - 1})');

//     sheet.getRangeByName('F${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('G${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('H${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('I${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('J${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('K${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('L${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('M${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('N${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     sheet.getRangeByName('O${indextotol + 5 + 0}').cellStyle = globalStyle7;
//     // sheet.getRangeByName('N${indextotol + 5 + 0}').cellStyle = globalStyle7;

//     sheet.getRangeByName('A${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('B${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('C${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('D${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('E${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('F${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('G${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('H${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('I${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('J${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('K${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('L${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('M${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('N${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('O${indextotol + 5 + 0}').rowHeight = 30;
//     sheet.getRangeByName('P${indextotol + 5 + 0}').rowHeight = 30;

//     /////----------------------------------------------------------------------->
//     for (var index = 1; index < zoneModels.length; index++) {
//       if (zoneModels[index].zn.toString() == 'ทั้งหมด') {
//       } else {
//         sheet.getRangeByName('F${indextotol + 5 + (index)}').setText(
//             '${zoneModels[index].ser}รวมโซน: ${zoneModels[index].zn} : ');

//         sheet.getRangeByName('G${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((G5:G${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');

//         sheet.getRangeByName('H${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((H5:H${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');

//         sheet.getRangeByName('I${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((I5:I${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');

//         sheet.getRangeByName('J${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((J5:J${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');

//         sheet.getRangeByName('K${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((K5:K${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');

//         sheet.getRangeByName('L${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((L5:L${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');

//         sheet.getRangeByName('M${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((M5:M${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');

//         sheet.getRangeByName('N${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((N5:N${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');

//         sheet.getRangeByName('O${indextotol + 5 + (index)}').setFormula(
//             '=SUMPRODUCT((O5:O${indextotol + 5 - 1})*(B5:B${indextotol + 5 - 1}="${int.parse(zoneModels[index].ser!) - 1}"))');
//       }
//       dynamic numberColor_ = index % 2 == 0 ? globalStyle8 : globalStyle88;
//       sheet.getRangeByName('F${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('G${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('H${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('I${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('J${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('K${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('L${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('M${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('N${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       sheet.getRangeByName('O${indextotol + 5 + (index)}').cellStyle =
//           numberColor_;
//       // sheet.getRangeByName('N${indextotol + 5 + (index)}').cellStyle =
//       //     numberColor_;

//       sheet.getRangeByName('A${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('B${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('C${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('D${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('E${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('F${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('G${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('H${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('I${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('J${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('K${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('L${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('M${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('N${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('O${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('P${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('Q${indextotol + 5 + (index)}').rowHeight = 30;
//       sheet.getRangeByName('r${indextotol + 5 + (index)}').rowHeight = 30;
//     }

//     ///-------------------------------------------------------------------------->
//     final List<int> bytes = workbook.saveAsStream();
//     workbook.dispose();
//     Uint8List data = Uint8List.fromList(bytes);
//     MimeType type = MimeType.MICROSOFTEXCEL;

//     if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
//       String path = await FileSaver.instance
//           .saveFile("รายงานประจำวัน", data, "xlsx", mimeType: type);
//       log(path);
//     } else {
//       String path = await FileSaver.instance
//           .saveFile("$NameFile_", data, "xlsx", mimeType: type);
//       log(path);
//     }
//   }
// }
