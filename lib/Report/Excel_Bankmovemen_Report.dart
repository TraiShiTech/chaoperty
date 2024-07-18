import 'dart:developer';

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
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'Report_Screen.dart';

class Excgen_BankmovemenReport {
  static void exportExcel_BankmovemenReport(
      ser_type_repro,
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Report,
      TransReBillBank,
      TransHisBillBank,
      renTal_name,
      zoneModels_report,
      Value_Chang_Zone_Income,
      Mon_Income,
      YE_Income,
      payMentModels) async {
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;

//     //Adding a picture
//     final ByteData bytes_image = await rootBundle.load('images/LOGO.png');
//     final Uint8List image = bytes_image.buffer
//         .asUint8List(bytes_image.offsetInBytes, bytes_image.lengthInBytes);
// // Adding an image.
//     sheet.pictures.addStream(1, 1, image);
//     final x.Picture picture = sheet.pictures[0];

// // Re-size an image
//     picture.height = 200;
//     picture.width = 200;

// // rotate an image.
//     picture.rotation = 100;

// // Flip an image.
//     picture.horizontalFlip = true;

    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    x.Style globalStyle1 = workbook.styles.add('style1');
    globalStyle1.backColorRgb = Color(0xFFD4E6A3);
    globalStyle1.fontName = 'Angsana New';
    globalStyle1.numberFormat = '_(\* #,##0.00_)';
    globalStyle1.hAlign = x.HAlignType.center;
    globalStyle1.fontSize = 16;
    globalStyle1.bold = true;
    globalStyle1.borders;
    globalStyle1.fontColorRgb = Color.fromARGB(255, 3, 3, 3);

    x.Style globalStyle22 = workbook.styles.add('style22');
    globalStyle22.backColorRgb = Color(0xC7F5F7FA);
    globalStyle22.numberFormat = '_(\* #,##0.00_)';
    globalStyle22.fontSize = 12;
    globalStyle22.numberFormat;
    globalStyle22.hAlign = x.HAlignType.left;

    x.Style globalStyle222 = workbook.styles.add('style222');
    globalStyle222.backColorRgb = Color(0xC7E1E2E6);
    globalStyle222.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle222.fontSize = 12;
    globalStyle222.hAlign = x.HAlignType.left;
////////////-------------------------------------------------------->
    x.Style globalStyle220 = workbook.styles.add('style220');
    globalStyle220.backColorRgb = Color(0xC7F5F7FA);
    globalStyle220.numberFormat = '_(\* #,##0.00_)';
    globalStyle220.fontSize = 12;
    globalStyle220.numberFormat;
    globalStyle220.hAlign = x.HAlignType.left;
    globalStyle220.fontColorRgb = Color.fromARGB(255, 37, 127, 179);

    x.Style globalStyle2220 = workbook.styles.add('style2220');
    globalStyle2220.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle2220.fontSize = 12;
    globalStyle2220.hAlign = x.HAlignType.left;
    globalStyle2220.fontColorRgb = Color.fromARGB(255, 37, 127, 179);

    x.Style globalStyle220D = workbook.styles.add('style220D');
    globalStyle220D.backColorRgb = Color(0xC7F5F7FA);
    globalStyle220D.numberFormat = '_(\* #,##0.00_)';
    globalStyle220D.fontSize = 12;
    globalStyle220D.numberFormat;
    globalStyle220D.hAlign = x.HAlignType.center;
    globalStyle220D.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle2220D = workbook.styles.add('style2220D');
    globalStyle2220D.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220D.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle2220D.fontSize = 12;
    globalStyle2220D.hAlign = x.HAlignType.center;
    globalStyle2220D.fontColorRgb = Color(0xFFC52611);
////////////-------------------------------------------------------->
    x.Style globalStyle7 = workbook.styles.add('style7');
    globalStyle7.backColorRgb = Color.fromARGB(255, 230, 199, 163);
    globalStyle7.fontName = 'Angsana New';
    globalStyle7.numberFormat = '_(\* #,##0.00_)';
    globalStyle7.hAlign = x.HAlignType.center;
    globalStyle7.fontSize = 15;
    globalStyle7.bold = true;
    globalStyle7.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle77 = workbook.styles.add('style77');
    globalStyle7.backColorRgb = Color.fromARGB(255, 230, 199, 163);
    globalStyle77.fontName = 'Angsana New';
    globalStyle77.numberFormat = '_(\* #,##0.00_)';
    globalStyle77.hAlign = x.HAlignType.center;
    globalStyle77.fontSize = 15;
    globalStyle77.bold = true;
    globalStyle77.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle8 = workbook.styles.add('style8');
    globalStyle8.backColorRgb = Color(0xC7F5F7FA);
    globalStyle8.fontName = 'Angsana New';
    globalStyle8.numberFormat = '_(\* #,##0.00_)';
    globalStyle8.hAlign = x.HAlignType.center;
    globalStyle8.fontSize = 15;
    globalStyle8.bold = true;
    // globalStyle8.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle88 = workbook.styles.add('style88');
    globalStyle88.backColorRgb = Color(0xC7E1E2E6);
    globalStyle88.fontName = 'Angsana New';
    globalStyle88.numberFormat = '_(\* #,##0.00_)';
    globalStyle88.hAlign = x.HAlignType.center;
    globalStyle88.fontSize = 15;
    globalStyle88.bold = true;
    // globalStyle88.fontColorRgb = Color(0xFFC52611);

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);

    sheet.getRangeByName('A1').cellStyle = globalStyle22;
    sheet.getRangeByName('B1').cellStyle = globalStyle22;
    sheet.getRangeByName('C1').cellStyle = globalStyle22;
    sheet.getRangeByName('D1').cellStyle = globalStyle22;
    sheet.getRangeByName('E1').cellStyle = globalStyle22;
    sheet.getRangeByName('F1').cellStyle = globalStyle22;
    sheet.getRangeByName('G1').cellStyle = globalStyle22;
    sheet.getRangeByName('H1').cellStyle = globalStyle22;
    sheet.getRangeByName('I1').cellStyle = globalStyle22;
    sheet.getRangeByName('J1').cellStyle = globalStyle22;
    sheet.getRangeByName('K1').cellStyle = globalStyle22;
    sheet.getRangeByName('L1').cellStyle = globalStyle22;
    sheet.getRangeByName('M1').cellStyle = globalStyle22;
    sheet.getRangeByName('N1').cellStyle = globalStyle22;
    sheet.getRangeByName('O1').cellStyle = globalStyle22;
    sheet.getRangeByName('P1').cellStyle = globalStyle22;
    sheet.getRangeByName('Q1').cellStyle = globalStyle22;
    sheet.getRangeByName('R1').cellStyle = globalStyle22;
    sheet.getRangeByName('S1').cellStyle = globalStyle22;
    sheet.getRangeByName('T1').cellStyle = globalStyle22;
    sheet.getRangeByName('U1').cellStyle = globalStyle22;
    sheet.getRangeByName('V1').cellStyle = globalStyle22;
    sheet.getRangeByName('W1').cellStyle = globalStyle22;

    sheet.getRangeByName('X1').cellStyle = globalStyle22;
    sheet.getRangeByName('Y1').cellStyle = globalStyle22;
    sheet.getRangeByName('Z1').cellStyle = globalStyle22;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText(
      (ser_type_repro == '1')
          ? 'รายงานการเคลื่อนไหวธนาคาร ( โซน : $Value_Chang_Zone_Income)'
          : (ser_type_repro == '2')
              ? 'รายงานการเคลื่อนไหวธนาคาร เฉพาะรายการที่มีส่วนลด ( โซน : $Value_Chang_Zone_Income)'
              : (ser_type_repro == '3')
                  ? 'รายงานการเคลื่อนไหวธนาคาร เฉพาะล็อคเสียบ ( โซน : $Value_Chang_Zone_Income)'
                  : (ser_type_repro == '4')
                      ? 'รายงานการเคลื่อนไหวธนาคาร เฉพาะรายการที่ออกใบกำกับภาษี ( โซน : $Value_Chang_Zone_Income)'
                      : 'รายงานประวัติชำระรอตรวจสอบ ( โซน : $Value_Chang_Zone_Income)',
      // 'รายงานการเคลื่อนไหวธนาคาร ( โซน : $Value_Chang_Zone_Income)'
    );
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle22;
    sheet.getRangeByName('B2').cellStyle = globalStyle22;
    sheet.getRangeByName('C2').cellStyle = globalStyle22;
    sheet.getRangeByName('D2').cellStyle = globalStyle22;
    sheet.getRangeByName('E2').cellStyle = globalStyle22;
    sheet.getRangeByName('F2').cellStyle = globalStyle22;
    sheet.getRangeByName('G2').cellStyle = globalStyle22;
    sheet.getRangeByName('H2').cellStyle = globalStyle22;
    sheet.getRangeByName('I2').cellStyle = globalStyle22;
    sheet.getRangeByName('K1').cellStyle = globalStyle22;
    sheet.getRangeByName('J2').cellStyle = globalStyle22;
    sheet.getRangeByName('L2').cellStyle = globalStyle22;
    sheet.getRangeByName('M2').cellStyle = globalStyle22;
    sheet.getRangeByName('N2').cellStyle = globalStyle22;
    sheet.getRangeByName('O2').cellStyle = globalStyle22;
    sheet.getRangeByName('P2').cellStyle = globalStyle22;
    sheet.getRangeByName('Q2').cellStyle = globalStyle22;
    sheet.getRangeByName('R2').cellStyle = globalStyle22;
    sheet.getRangeByName('S2').cellStyle = globalStyle22;
    sheet.getRangeByName('T2').cellStyle = globalStyle22;
    sheet.getRangeByName('U2').cellStyle = globalStyle22;
    sheet.getRangeByName('V2').cellStyle = globalStyle22;
    sheet.getRangeByName('W2').cellStyle = globalStyle22;

    sheet.getRangeByName('X2').cellStyle = globalStyle22;
    sheet.getRangeByName('Y2').cellStyle = globalStyle22;
    sheet.getRangeByName('Z2').cellStyle = globalStyle22;
    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('I2').setText('เดือน : ${Mon_Income} (${YE_Income}) ');

    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A2').cellStyle = globalStyle22;
    sheet.getRangeByName('K2').cellStyle = globalStyle22;
    sheet.getRangeByName('A3').cellStyle = globalStyle22;
    sheet.getRangeByName('B3').cellStyle = globalStyle22;
    sheet.getRangeByName('C3').cellStyle = globalStyle22;
    sheet.getRangeByName('D3').cellStyle = globalStyle22;
    sheet.getRangeByName('E3').cellStyle = globalStyle22;
    sheet.getRangeByName('F3').cellStyle = globalStyle22;
    sheet.getRangeByName('G3').cellStyle = globalStyle22;
    sheet.getRangeByName('H3').cellStyle = globalStyle22;
    sheet.getRangeByName('I3').cellStyle = globalStyle22;
    sheet.getRangeByName('J3').cellStyle = globalStyle22;
    sheet.getRangeByName('K3').cellStyle = globalStyle22;
    sheet.getRangeByName('L3').cellStyle = globalStyle22;
    sheet.getRangeByName('M3').cellStyle = globalStyle22;
    sheet.getRangeByName('N3').cellStyle = globalStyle22;
    sheet.getRangeByName('O3').cellStyle = globalStyle22;
    sheet.getRangeByName('P3').cellStyle = globalStyle22;
    sheet.getRangeByName('Q3').cellStyle = globalStyle22;
    sheet.getRangeByName('R3').cellStyle = globalStyle22;
    sheet.getRangeByName('S3').cellStyle = globalStyle22;
    sheet.getRangeByName('T3').cellStyle = globalStyle22;
    sheet.getRangeByName('U3').cellStyle = globalStyle22;
    sheet.getRangeByName('V3').cellStyle = globalStyle22;
    sheet.getRangeByName('W3').cellStyle = globalStyle22;

    sheet.getRangeByName('X3').cellStyle = globalStyle22;
    sheet.getRangeByName('Y3').cellStyle = globalStyle22;
    sheet.getRangeByName('Z3').cellStyle = globalStyle22;

    sheet.getRangeByName('A3').setText('ใบเสร็จ : ${TransReBillBank.length}');
    sheet.getRangeByName('B3').setText('รายการ : ${TransHisBillBank.length}');
    sheet.getRangeByName('A3').columnWidth = 18;
    sheet.getRangeByName('B3').columnWidth = 18;
    sheet.getRangeByName('C3').columnWidth = 18;
    sheet.getRangeByName('D3').columnWidth = 18;
    sheet.getRangeByName('E3').columnWidth = 18;
    sheet.getRangeByName('F3').columnWidth = 18;
    sheet.getRangeByName('G3').columnWidth = 18;
    sheet.getRangeByName('H3').columnWidth = 18;
    sheet.getRangeByName('I3').columnWidth = 18;
    sheet.getRangeByName('J3').columnWidth = 18;
    sheet.getRangeByName('K3').columnWidth = 18;
    sheet.getRangeByName('L3').columnWidth = 18;
    sheet.getRangeByName('M3').columnWidth = 18;
    sheet.getRangeByName('N3').columnWidth = 18;
    sheet.getRangeByName('O3').columnWidth = 18;
    sheet.getRangeByName('P3').columnWidth = 18;
    sheet.getRangeByName('Q3').columnWidth = 18;
    sheet.getRangeByName('R3').columnWidth = 18;
    sheet.getRangeByName('S3').columnWidth = 18;
    sheet.getRangeByName('T3').columnWidth = 18;
    sheet.getRangeByName('U3').columnWidth = 18;
    sheet.getRangeByName('V3').columnWidth = 18;
    sheet.getRangeByName('W3').columnWidth = 18;

    sheet.getRangeByName('X3').columnWidth = 18;
    sheet.getRangeByName('Y3').columnWidth = 18;
    sheet.getRangeByName('Z3').columnWidth = 18;

    sheet.getRangeByName('A4').cellStyle = globalStyle1;
    sheet.getRangeByName('B4').cellStyle = globalStyle1;
    sheet.getRangeByName('C4').cellStyle = globalStyle1;
    sheet.getRangeByName('D4').cellStyle = globalStyle1;
    sheet.getRangeByName('E4').cellStyle = globalStyle1;
    sheet.getRangeByName('F4').cellStyle = globalStyle1;
    sheet.getRangeByName('G4').cellStyle = globalStyle1;
    sheet.getRangeByName('H4').cellStyle = globalStyle1;
    sheet.getRangeByName('I4').cellStyle = globalStyle1;
    sheet.getRangeByName('J4').cellStyle = globalStyle1;
    sheet.getRangeByName('K4').cellStyle = globalStyle1;
    sheet.getRangeByName('L4').cellStyle = globalStyle1;
    sheet.getRangeByName('M4').cellStyle = globalStyle1;
    sheet.getRangeByName('N4').cellStyle = globalStyle1;
    sheet.getRangeByName('O4').cellStyle = globalStyle1;
    sheet.getRangeByName('P4').cellStyle = globalStyle1;
    sheet.getRangeByName('Q4').cellStyle = globalStyle1;
    sheet.getRangeByName('R4').cellStyle = globalStyle1;
    sheet.getRangeByName('S4').cellStyle = globalStyle1;
    sheet.getRangeByName('T4').cellStyle = globalStyle1;
    sheet.getRangeByName('U4').cellStyle = globalStyle1;
    sheet.getRangeByName('V4').cellStyle = globalStyle1;
    sheet.getRangeByName('W4').cellStyle = globalStyle1;
    sheet.getRangeByName('X4').cellStyle = globalStyle1;
    sheet.getRangeByName('Y4').cellStyle = globalStyle1;
    sheet.getRangeByName('Z4').cellStyle = globalStyle1;

    sheet.getRangeByName('A4').columnWidth = 18;
    sheet.getRangeByName('B4').columnWidth = 18;
    sheet.getRangeByName('C4').columnWidth = 18;
    sheet.getRangeByName('D4').columnWidth = 18;
    sheet.getRangeByName('E4').columnWidth = 18;
    sheet.getRangeByName('F4').columnWidth = 18;
    sheet.getRangeByName('G4').columnWidth = 18;
    sheet.getRangeByName('H4').columnWidth = 18;
    sheet.getRangeByName('I4').columnWidth = 30;
    sheet.getRangeByName('J4').columnWidth = 18;
    sheet.getRangeByName('K4').columnWidth = 18;
    sheet.getRangeByName('L4').columnWidth = 18;
    sheet.getRangeByName('M4').columnWidth = 18;
    sheet.getRangeByName('N4').columnWidth = 18;

    sheet.getRangeByName('O4').columnWidth = 18;
    sheet.getRangeByName('P4').columnWidth = 18;
    sheet.getRangeByName('Q4').columnWidth = 18;
    sheet.getRangeByName('R4').columnWidth = 18;
    sheet.getRangeByName('S4').columnWidth = 18;
    sheet.getRangeByName('T4').columnWidth = 18;
    sheet.getRangeByName('U4').columnWidth = 18;
    sheet.getRangeByName('V4').columnWidth = 18;
    sheet.getRangeByName('O4').columnWidth = 18;
    sheet.getRangeByName('P4').columnWidth = 18;
    sheet.getRangeByName('Q4').columnWidth = 18;
    sheet.getRangeByName('R4').columnWidth = 18;
    sheet.getRangeByName('S4').columnWidth = 18;
    sheet.getRangeByName('T4').columnWidth = 18;
    sheet.getRangeByName('U4').columnWidth = 18;
    sheet.getRangeByName('V4').columnWidth = 18;
    sheet.getRangeByName('W4').columnWidth = 18;
    sheet.getRangeByName('X4').columnWidth = 18;
    sheet.getRangeByName('Y4').columnWidth = 18;
    sheet.getRangeByName('Z4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('เลขที่');
    sheet.getRangeByName('B4').setText('ลำดับ');
    sheet.getRangeByName('C4').setText('วันที่ชำระ');
    sheet.getRangeByName('D4').setText('รหัสโซน');
    sheet.getRangeByName('E4').setText('โซน');
    sheet.getRangeByName('F4').setText('รหัสพื้นที่');
    sheet.getRangeByName('G4').setText('รูปแบบชำระ');
    sheet.getRangeByName('H4').setText('เลขบช.');

    sheet.getRangeByName('I4').setText('รายการ');
    sheet.getRangeByName('J4').setText('ร้าน');
    sheet.getRangeByName('K4').setText('Vat%');
    sheet.getRangeByName('L4').setText('VAT');
    // sheet.getRangeByName('I4').setText('70%');
    // sheet.getRangeByName('J4').setText('30%');
    sheet.getRangeByName('M4').setText('ราคาก่อน Vat');
    sheet.getRangeByName('N4').setText('ค่าธรรมเนียม');
    sheet.getRangeByName('O4').setText('ราคารวม');
    sheet.getRangeByName('P4').setText('ส่วนลด');
    sheet.getRangeByName('Q4').setText('ยอดสุทธิ');
    sheet.getRangeByName('R4').setText('ประเภท');
    sheet.getRangeByName('S4').setText('สถานะ');
    sheet.getRangeByName('T4').setText('วันที่ทำรายการ');
    sheet.getRangeByName('U4').setText('อ้างถึง');
    sheet.getRangeByName('V4').setText('เลขที่สัญญา');
    sheet.getRangeByName('W4').setText('วันที่เริ่มต้น');
    sheet.getRangeByName('X4').setText('วันที่เริ่มสิ้นสุด');
    sheet.getRangeByName('Y4').setText('ล็อกเสียบ');
    sheet.getRangeByName('Z4').setText('เวลา');

    ///---------------------------------------------------------->

    int indextotol = 0;
    int indextotol_ = 0;
    int ser_dis = 0;
    String doc_no = '';

    for (var index2 = 0; index2 < TransHisBillBank.length; index2++) {
      if (doc_no == TransHisBillBank[index2].docno.toString()) {
        ser_dis = ser_dis + 1;
      } else {
        doc_no = TransHisBillBank[index2].docno.toString();
        ser_dis = 1;
      }

///////------------------------->
      var matchingItems = TransReBillBank.where((item) =>
          item.docno.toString() == TransHisBillBank[index2].docno.toString() &&
          ser_dis == 1);
      if (matchingItems.isNotEmpty) {
        indextotol = indextotol + 1;
        matchingItems.forEach((item) {
          sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('H${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('I${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('J${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('K${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('L${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('M${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('N${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('O${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('P${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('Q${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('R${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('S${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('T${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('U${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('V${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('W${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;

          sheet.getRangeByName('X${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('Y${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('Z${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;

          sheet
              .getRangeByName('A${indextotol + 5 - 1}')
              .setText('${TransHisBillBank[index2].docno}');
          sheet.getRangeByName('B${indextotol + 5 - 1}').setText('0');
          sheet.getRangeByName('C${indextotol + 5 - 1}').setText((TransHisBillBank[
                          index2]
                      .dateacc ==
                  null)
              ? ''
              : '${DateFormat('dd-MM').format(DateTime.parse('${TransHisBillBank[index2].dateacc}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransHisBillBank[index2].dateacc}'))}') + 543}');

          sheet.getRangeByName('D${indextotol + 5 - 1}').setText(
                (item.zser1 == null) ? '${item.zser}' : '${item.zser1}',
              );
          sheet
              .getRangeByName('E${indextotol + 5 - 1}')
              .setText((item.zn == null) ? '${item.znn}' : '${item.zn}');
          sheet.getRangeByName('F${indextotol + 5 - 1}').setText(
              (item.ln == null) ? '${item.room_number}' : '${item.ln}');
          sheet
              .getRangeByName('G${indextotol + 5 - 1}')
              .setText('${item.type}');
          sheet.getRangeByName('H${indextotol + 5 - 1}').setText('${item.bno}');
          sheet
              .getRangeByName('I${indextotol + 5 - 1}')
              .setText('ยอดรวมทั้งบิล');
          sheet.getRangeByName('J${indextotol + 5 - 1}').setText(
              (TransHisBillBank[index2].sname == null)
                  ? '${TransHisBillBank[index2].remark}'
                  : '${TransHisBillBank[index2].sname}');
          sheet.getRangeByName('K${indextotol + 5 - 1}').setNumber(0.00);
          sheet.getRangeByName('L${indextotol + 5 - 1}').setNumber(0.00);
          sheet.getRangeByName('M${indextotol + 5 - 1}').setNumber(0.00);
          sheet
              .getRangeByName('N${indextotol + 5 - 1}')
              .setNumber(double.parse(item.total_duesbill!));

          sheet
              .getRangeByName('O${indextotol + 5 - 1}')
              .setNumber(double.parse(item.total_bill!));

          sheet.getRangeByName('P${indextotol + 5 - 1}').setNumber(
              (item.total_dis == null) ? 0.00 : double.parse(item.total_dis!));

          sheet.getRangeByName('Q${indextotol + 5 - 1}').setNumber(
                (item.total_dis == null)
                    ? double.parse(item.total_bill!)
                    : double.parse(item.total_bill!) -
                        double.parse(item.total_dis!),
              );

          sheet.getRangeByName('R${indextotol + 5 - 1}').setText(
                (item.room_number.toString() == '' || item.room_number == null)
                    ? ''
                    : 'ล็อคเสียบ',
              );
          sheet.getRangeByName('S${indextotol + 5 - 1}').setText(
                (item.doctax == '' || item.doctax == null) ? '' : 'ใบกำกับภาษี',
              );

          sheet.getRangeByName('T${indextotol + 5 - 1}').setText((TransHisBillBank[
                          index2]
                      .daterec ==
                  null)
              ? ''
              : '${DateFormat('dd-MM').format(DateTime.parse('${TransHisBillBank[index2].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransHisBillBank[index2].daterec}'))}') + 543}');

          sheet.getRangeByName('U${indextotol + 5 - 1}').setText(
              (TransHisBillBank[index2].inv == null)
                  ? ''
                  : '${TransHisBillBank[index2].inv}');

          sheet.getRangeByName('V${indextotol + 5 - 1}').setText(
              (TransHisBillBank[index2].cid == null)
                  ? ''
                  : '${TransHisBillBank[index2].cid}');

          sheet.getRangeByName('W${indextotol + 5 - 1}').setText(
              (TransHisBillBank[index2].sdate == null)
                  ? ''
                  : '${TransHisBillBank[index2].sdate}');

          sheet.getRangeByName('X${indextotol + 5 - 1}').setText(
              (TransHisBillBank[index2].ldate == null)
                  ? ''
                  : '${TransHisBillBank[index2].ldate}');
          sheet.getRangeByName('Y${indextotol + 5 - 1}').setText(
              (TransHisBillBank[index2].date_book == null)
                  ? ''
                  : '${TransHisBillBank[index2].date_book}');
          sheet.getRangeByName('Z${indextotol + 5 - 1}').setText(
              (TransHisBillBank[index2].timex == null)
                  ? ''
                  : '${TransHisBillBank[index2].timex}');
        });
      }

///////------------------------->

      // dynamic numberColor_s = i1 % 2 == 0 ? globalStyle220 : globalStyle2220;

      indextotol = indextotol + 1;
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('H${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('I${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('J${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('K${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('L${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('M${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('N${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('O${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('P${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('Q${indextotol + 5 - 1}').cellStyle = globalStyle22;

      sheet.getRangeByName('R${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('S${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('T${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('U${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('V${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('W${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('X${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('Y${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('Z${indextotol + 5 - 1}').cellStyle = globalStyle22;

      sheet
          .getRangeByName('A${indextotol + 5 - 1}')
          .setText('${TransHisBillBank[index2].docno}');
      sheet.getRangeByName('B${indextotol + 5 - 1}').setText('${ser_dis}');
      sheet.getRangeByName('C${indextotol + 5 - 1}').setText((TransHisBillBank[
                      index2]
                  .dateacc ==
              null)
          ? ''
          : '${DateFormat('dd-MM').format(DateTime.parse('${TransHisBillBank[index2].dateacc}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransHisBillBank[index2].dateacc}'))}') + 543}');

      sheet.getRangeByName('D${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].zser1 == null)
              ? '${TransHisBillBank[index2].zser}'
              : '${TransHisBillBank[index2].zser1}');
      sheet.getRangeByName('E${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].zn == null)
              ? '${TransHisBillBank[index2].znn}'
              : '${TransHisBillBank[index2].zn}');
      sheet.getRangeByName('F${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].ln == null)
              ? '${TransHisBillBank[index2].room_number}'
              : '${TransHisBillBank[index2].ln}');
      sheet
          .getRangeByName('G${indextotol + 5 - 1}')
          .setText('${TransHisBillBank[index2].type}');
      sheet
          .getRangeByName('H${indextotol + 5 - 1}')
          .setText('${TransHisBillBank[index2].bno}');
      sheet
          .getRangeByName('I${indextotol + 5 - 1}')
          .setText('${TransHisBillBank[index2].expname}');

      sheet.getRangeByName('J${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].sname == null)
              ? '${TransHisBillBank[index2].remark}'
              : '${TransHisBillBank[index2].sname}');

      sheet.getRangeByName('K${indextotol + 5 - 1}').setNumber(
          (TransHisBillBank[index2].nvat == null)
              ? 0.00
              : double.parse('${TransHisBillBank[index2].nvat}'));

      sheet.getRangeByName('L${indextotol + 5 - 1}').setNumber(
          (TransHisBillBank[index2].vat == null)
              ? 0.00
              : double.parse('${TransHisBillBank[index2].vat}'));

      sheet.getRangeByName('M${indextotol + 5 - 1}').setNumber(
          (TransHisBillBank[index2].pvat == null)
              ? 0.00
              : double.parse('${TransHisBillBank[index2].pvat}'));

      sheet.getRangeByName('N${indextotol + 5 - 1}').setNumber(0.00);

      sheet.getRangeByName('O${indextotol + 5 - 1}').setNumber(
            (TransHisBillBank[index2].amt == null)
                ? 0.00
                : double.parse(TransHisBillBank[index2].amt!),
          );

      sheet.getRangeByName('P${indextotol + 5 - 1}').setNumber(
            (TransHisBillBank[index2].dis == null)
                ? 0.00
                : double.parse(TransHisBillBank[index2].dis!),
          );

      sheet.getRangeByName('Q${indextotol + 5 - 1}').setNumber(
            (TransHisBillBank[index2].total == null)
                ? 0.00 -
                    ((TransHisBillBank[index2].dis == null)
                        ? 0.00
                        : double.parse(TransHisBillBank[index2].dis!))
                : double.parse(TransHisBillBank[index2].total!) -
                    ((TransHisBillBank[index2].dis == null)
                        ? 0.00
                        : double.parse(TransHisBillBank[index2].dis!)),
          );
      sheet.getRangeByName('R${indextotol + 5 - 1}').setText('');
      sheet.getRangeByName('S${indextotol + 5 - 1}').setText('');
      sheet.getRangeByName('T${indextotol + 5 - 1}').setText((TransHisBillBank[
                      index2]
                  .daterec ==
              null)
          ? ''
          : '${DateFormat('dd-MM').format(DateTime.parse('${TransHisBillBank[index2].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransHisBillBank[index2].daterec}'))}') + 543}');

      sheet.getRangeByName('U${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].inv == null ||
                  TransHisBillBank[index2].inv.toString() == '')
              ? ''
              : '${TransHisBillBank[index2].inv}');

      sheet.getRangeByName('V${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].cid == null ||
                  TransHisBillBank[index2].cid.toString() == '')
              ? ''
              : '${TransHisBillBank[index2].cid}');
      sheet.getRangeByName('W${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].sdate == null ||
                  TransHisBillBank[index2].sdate.toString() == '')
              ? ''
              : '${TransHisBillBank[index2].sdate}');

      sheet.getRangeByName('X${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].ldate == null ||
                  TransHisBillBank[index2].ldate.toString() == '')
              ? ''
              : '${TransHisBillBank[index2].ldate}');
      sheet.getRangeByName('Y${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].date_book == null ||
                  TransHisBillBank[index2].date_book.toString() == '')
              ? ''
              : '${TransHisBillBank[index2].date_book}');
      sheet.getRangeByName('Z${indextotol + 5 - 1}').setText(
          (TransHisBillBank[index2].timex == null ||
                  TransHisBillBank[index2].timex.toString() == '')
              ? ''
              : '${TransHisBillBank[index2].timex}');
    }

    /////////////////////////////////------------------------------------------------>
    ///

    sheet.getRangeByName('M${indextotol + 5 + 0}').setText('เฉพาะล็อคเสียบ: ');
    sheet.getRangeByName('M${indextotol + 5 + 1}').setText('เฉพาะล็อคธรรมดา: ');
    sheet.getRangeByName('M${indextotol + 5 + 2}').setText('รวมทั้งหมด: ');

    sheet.getRangeByName('N${indextotol + 5 + 0}').setFormula(
        '=SUMIFS(N5:N${indextotol + 5 - 1}, R5:R${indextotol + 5 - 1}, "ล็อคเสียบ", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');
    sheet.getRangeByName('N${indextotol + 5 + 1}').setFormula(
        '=SUMIFS(N5:N${indextotol + 5 - 1}, R5:R${indextotol + 5 - 1}, "<>ล็อคเสียบ", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');
    sheet.getRangeByName('N${indextotol + 5 + 2}').setFormula(
        '=SUMIF(I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล",N5:N${indextotol + 5 - 1})');

    ///---------->
    sheet.getRangeByName('O${indextotol + 5 + 0}').setFormula(
        '=SUMIFS(O5:O${indextotol + 5 - 1}, R5:R${indextotol + 5 - 1}, "ล็อคเสียบ", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');
    sheet.getRangeByName('O${indextotol + 5 + 1}').setFormula(
        '=SUMIFS(O5:O${indextotol + 5 - 1}, R5:R${indextotol + 5 - 1}, "<>ล็อคเสียบ", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');
    sheet.getRangeByName('O${indextotol + 5 + 2}').setFormula(
        '=SUMIF(I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล",O5:O${indextotol + 5 - 1})');

    ///---------->
    sheet.getRangeByName('P${indextotol + 5 + 0}').setFormula(
        '=SUMIFS(P5:P${indextotol + 5 - 1}, R5:R${indextotol + 5 - 1}, "ล็อคเสียบ", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');
    sheet.getRangeByName('P${indextotol + 5 + 1}').setFormula(
        '=SUMIFS(P5:P${indextotol + 5 - 1}, R5:R${indextotol + 5 - 1}, "<>ล็อคเสียบ", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');
    sheet.getRangeByName('P${indextotol + 5 + 2}').setFormula(
        '=SUMIF(I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล",P5:P${indextotol + 5 - 1})');

    ///---------->

    sheet.getRangeByName('Q${indextotol + 5 + 0}').setFormula(
        '=SUMIFS(Q5:Q${indextotol + 5 - 1}, R5:R${indextotol + 5 - 1}, "ล็อคเสียบ", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');
    sheet.getRangeByName('Q${indextotol + 5 + 1}').setFormula(
        '=SUMIFS(Q5:Q${indextotol + 5 - 1}, R5:R${indextotol + 5 - 1}, "<>ล็อคเสียบ", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');
    sheet.getRangeByName('Q${indextotol + 5 + 2}').setFormula(
        '=SUMIF(I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล",Q5:Q${indextotol + 5 - 1})');

///////-------------------------------------------------------------------->

    for (var index = 0; index < 3; index++) {
      sheet.getRangeByName('M${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('N${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('O${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('P${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('Q${indextotol + 5 + index}').cellStyle =
          globalStyle7;
    }

/////////////////////////////////------------------------------------------------>
    sheet.getRangeByName('J${indextotol + 5 + 5}').setText('ธนาคาร');
    sheet.getRangeByName('K${indextotol + 5 + 5}').setText('ชื่อบช.');
    sheet.getRangeByName('L${indextotol + 5 + 5}').setText('เลขบช.');
    sheet.getRangeByName('M${indextotol + 5 + 5}').setText('สาขา');

    sheet.getRangeByName('N${indextotol + 5 + 5}').setText('รวมค่าธรรมเนียม');
    sheet.getRangeByName('O${indextotol + 5 + 5}').setText('ราคารวม');
    sheet.getRangeByName('P${indextotol + 5 + 5}').setText('รวมส่วนลด');
    sheet.getRangeByName('Q${indextotol + 5 + 5}').setText('ราคารวมหักส่วนลด');

    sheet.getRangeByName('J${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('K${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('L${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('M${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('N${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('O${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('P${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('Q${indextotol + 5 + 5}').cellStyle = globalStyle1;

    for (var index = 0; index < payMentModels.length; index++) {
      sheet
          .getRangeByName('J${indextotol + 5 + 6 + index}')
          .setText('${payMentModels[index].bank}');
      sheet
          .getRangeByName('K${indextotol + 5 + 6 + index}')
          .setText('${payMentModels[index].bname}');
      sheet
          .getRangeByName('L${indextotol + 5 + 6 + index}')
          .setText('${payMentModels[index].bno}');
      sheet
          .getRangeByName('M${indextotol + 5 + 6 + index}')
          .setText('${payMentModels[index].bsaka}');

      sheet.getRangeByName('N${indextotol + 5 + 6 + index}').setFormula(
          '=SUMIFS(N5:N${indextotol + 5 - 1}, H5:H${indextotol + 5 - 1}, "${payMentModels[index].bno}", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');

      sheet.getRangeByName('O${indextotol + 5 + 6 + index}').setFormula(
          '=SUMIFS(O5:O${indextotol + 5 - 1}, H5:H${indextotol + 5 - 1}, "${payMentModels[index].bno}", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');

      sheet.getRangeByName('P${indextotol + 5 + 6 + index}').setFormula(
          '=SUMIFS(P5:P${indextotol + 5 - 1}, H5:H${indextotol + 5 - 1}, "${payMentModels[index].bno}", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');

      sheet.getRangeByName('Q${indextotol + 5 + 6 + index}').setFormula(
          '=SUMIFS(Q5:Q${indextotol + 5 - 1}, H5:H${indextotol + 5 - 1}, "${payMentModels[index].bno}", I5:I${indextotol + 5 - 1}, "ยอดรวมทั้งบิล")');

      // sheet.getRangeByName('O${indextotol + 5 + 6 + index}').setFormula(
      //     '=SUMIF(H5:H${indextotol + 5 - 1}, "${payMentModels[index].bno}",O5:O${indextotol + 5 - 1})');

      // sheet.getRangeByName('P${indextotol + 5 + 6 + index}').setFormula(
      //     '=SUMIF(H5:H${indextotol + 5 - 1}, "${payMentModels[index].bno}", P5:P${indextotol + 5 - 1})');
      // sheet.getRangeByName('Q${indextotol + 5 + 6 + index}').setFormula(
      //     '=SUMIF(H5:H${indextotol + 5 - 1}, "${payMentModels[index].bno}", Q5:Q${indextotol + 5 - 1})');

      sheet.getRangeByName('J${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
      sheet.getRangeByName('K${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
      sheet.getRangeByName('L${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
      sheet.getRangeByName('M${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
      sheet.getRangeByName('N${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
      sheet.getRangeByName('O${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
      sheet.getRangeByName('P${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
      sheet.getRangeByName('Q${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
    }
/////////////////////////////////------------------------------------------------>

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          (ser_type_repro == '1')
              ? 'รายงานการเคลื่อนไหวธนาคาร ( โซน : $Value_Chang_Zone_Income)'
              : (ser_type_repro == '2')
                  ? 'รายงานการเคลื่อนไหวธนาคาร เฉพาะรายการที่มีส่วนลด ( โซน : $Value_Chang_Zone_Income)'
                  : (ser_type_repro == '3')
                      ? 'รายงานการเคลื่อนไหวธนาคาร เฉพาะล็อคเสียบ ( โซน : $Value_Chang_Zone_Income)'
                      : (ser_type_repro == '4')
                          ? 'รายงานการเคลื่อนไหวธนาคาร เฉพาะรายการที่ออกใบกำกับภาษี ( โซน : $Value_Chang_Zone_Income)'
                          : 'รายงานประวัติชำระรอตรวจสอบ ( โซน : $Value_Chang_Zone_Income)',
          // "รายงานการเคลื่อนไหวธนาคาร",

          data,
          "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }
}
