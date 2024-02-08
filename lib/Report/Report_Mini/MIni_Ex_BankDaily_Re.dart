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

class Mini_Ex_BankdailyReport {
  static void mini_exportExcel_BankdailyReport(
      ser_type_repro,
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Report,
      TransReBillBank,
      TransHisBillBank,
      renTal_name,
      zoneModels_report,
      Value_TransDate_Daily,
      zone_name_Trans_Daily,
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
    globalStyle220.hAlign = x.HAlignType.center;
    globalStyle220.fontColorRgb = Color.fromARGB(255, 37, 127, 179);

    x.Style globalStyle2220 = workbook.styles.add('style2220');
    globalStyle2220.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle2220.fontSize = 12;
    globalStyle2220.hAlign = x.HAlignType.center;
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
    final x.Range range = sheet.getRangeByName('E1');
    range.setText(
      (ser_type_repro == '1')
          ? 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ ( โซน : $zone_name_Trans_Daily)'
          : (ser_type_repro == '2')
              ? 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ เฉพาะรายการที่มีส่วนลด ( โซน : $zone_name_Trans_Daily)'
              : (ser_type_repro == '3')
                  ? 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ เฉพาะล็อคเสียบ ( โซน : $zone_name_Trans_Daily)'
                  : (ser_type_repro == '4')
                      ? 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ เฉพาะรายการที่ออกใบกำกับภาษี ( โซน : $zone_name_Trans_Daily)'
                      : 'รายงานประวัติชำระรอตรวจสอบประจำวันแบบย่อ ( โซน : $zone_name_Trans_Daily)',
      // 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ ( โซน : $Value_Chang_Zone_Daily)'
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
    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('K2').setText('วันที่ : ${Value_TransDate_Daily}');

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
    sheet.getRangeByName('A3').setText('ใบเสร็จ : ${TransReBillBank.length}');

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
    // sheet.getRangeByName('O4').cellStyle = globalStyle1;

    sheet.getRangeByName('A4').columnWidth = 18;
    sheet.getRangeByName('B4').columnWidth = 18;
    sheet.getRangeByName('C4').columnWidth = 18;
    sheet.getRangeByName('D4').columnWidth = 18;
    sheet.getRangeByName('E4').columnWidth = 18;
    sheet.getRangeByName('F4').columnWidth = 18;
    sheet.getRangeByName('G4').columnWidth = 18;
    sheet.getRangeByName('H4').columnWidth = 20;
    sheet.getRangeByName('I4').columnWidth = 25;
    sheet.getRangeByName('J4').columnWidth = 18;
    sheet.getRangeByName('K4').columnWidth = 18;
    sheet.getRangeByName('L4').columnWidth = 18;
    sheet.getRangeByName('M4').columnWidth = 18;
    sheet.getRangeByName('N4').columnWidth = 18;
    sheet.getRangeByName('O4').columnWidth = 18;
    sheet.getRangeByName('P4').columnWidth = 18;
    sheet.getRangeByName('Q4').columnWidth = 18;

    // sheet.getRangeByName('O4').columnWidth = 18;
    sheet.getRangeByName('P4').columnWidth = 18;
    sheet.getRangeByName('Q4').columnWidth = 18;
    sheet.getRangeByName('R4').columnWidth = 18;
    sheet.getRangeByName('S4').columnWidth = 18;
    sheet.getRangeByName('T4').columnWidth = 18;
    sheet.getRangeByName('U4').columnWidth = 18;
    sheet.getRangeByName('V4').columnWidth = 18;
    // sheet.getRangeByName('O4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('ลำดับ');
    sheet.getRangeByName('B4').setText('เลขที่');
    sheet.getRangeByName('C4').setText('วันที่');
    sheet.getRangeByName('D4').setText('รหัสโซน');
    sheet.getRangeByName('E4').setText('โซน');
    sheet.getRangeByName('F4').setText('รหัสพื้นที่');
    sheet.getRangeByName('G4').setText('ร้าน');
    sheet.getRangeByName('H4').setText('รูปแบบชำระ');
    sheet.getRangeByName('I4').setText('ธนาคาร');
    sheet.getRangeByName('J4').setText('เลขบช.');
    sheet.getRangeByName('K4').setText('Slip');
    // sheet.getRangeByName('L4').setText('ส่วนลด');
    // sheet.getRangeByName('M4').setText('ราคารวม');
    // sheet.getRangeByName('N4').setText('หักส่วนลด');
    sheet.getRangeByName('L4').setText('ค่าธรรมเนียม');
    sheet.getRangeByName('M4').setText('ราคารวม');
    sheet.getRangeByName('N4').setText('ส่วนลด');
    sheet.getRangeByName('O4').setText('หักส่วนลด');
    sheet.getRangeByName('P4').setText('ประเภท');
    sheet.getRangeByName('Q4').setText('สถานะ');

    ///---------------------------------------------------------->
    int all_Total = 0;
    int indextotol = 0;
    int indextotol_ = 0;
    int ser_dis = 0;

    for (var index1 = 0; index1 < TransReBillBank.length; index1++) {
      all_Total = all_Total + 1;
      var index = indextotol;
      dynamic numberColor = index1 % 2 == 0 ? globalStyle22 : globalStyle222;

      dynamic numberColor_s =
          index1 % 2 == 0 ? globalStyle220 : globalStyle2220;

      dynamic numberColor_ss =
          index1 % 2 == 0 ? globalStyle220D : globalStyle2220D;
      indextotol = indextotol + 1;
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('H${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('I${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('J${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('K${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('L${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('M${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('N${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('O${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('P${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('Q${indextotol + 5 - 1}').cellStyle = numberColor;

      sheet.getRangeByName('A${indextotol + 5 - 1}').setText('${index1 + 1}');
      sheet.getRangeByName('B${indextotol + 5 - 1}').setText(
            (TransReBillBank[index1].doctax != '')
                ? '${TransReBillBank[index1].doctax}'
                : TransReBillBank[index1].docno == ''
                    ? '${TransReBillBank[index1].refno}'
                    : '${TransReBillBank[index1].docno}',
          );
      sheet
          .getRangeByName('C${indextotol + 5 - 1}')
          .setText('${TransReBillBank[index1].daterec}');
      sheet.getRangeByName('D${indextotol + 5 - 1}').setText(
            (TransReBillBank[index1].zser1 == null)
                ? '${TransReBillBank[index1].zser}'
                : '${TransReBillBank[index1].zser1}',
          );

      sheet.getRangeByName('E${indextotol + 5 - 1}').setText(
            (TransReBillBank[index1].zn == null)
                ? '${TransReBillBank[index1].znn}'
                : '${TransReBillBank[index1].zn}',
          );
      sheet.getRangeByName('F${indextotol + 5 - 1}').setText(
          (TransReBillBank[index1].ln == null)
              ? '${TransReBillBank[index1].room_number}'
              : '${TransReBillBank[index1].ln}');
      sheet.getRangeByName('G${indextotol + 5 - 1}').setText(
            (TransReBillBank[index1].sname == null ||
                    TransReBillBank[index1].sname.toString() == '' ||
                    TransReBillBank[index1].sname.toString() == 'null')
                ? '${TransReBillBank[index1].remark}'
                : '${TransReBillBank[index1].sname}',
          );
      sheet.getRangeByName('H${indextotol + 5 - 1}').setText(
            '${TransReBillBank[index1].type}',
          );
      sheet.getRangeByName('I${indextotol + 5 - 1}').setText(
          (TransReBillBank[index1].bank == null)
              ? ''
              : '${TransReBillBank[index1].bank!}');
      sheet.getRangeByName('J${indextotol + 5 - 1}').setText(
          (TransReBillBank[index1].bno == null)
              ? ''
              : '${TransReBillBank[index1].bno!}');
      sheet.getRangeByName('K${indextotol + 5 - 1}').setText(
          (TransReBillBank[index1].slip == null ||
                  TransReBillBank[index1].slip! == 'null')
              ? ''
              : '${TransReBillBank[index1].slip}');

      sheet.getRangeByName('L${indextotol + 5 - 1}').setNumber(
          (TransReBillBank[index1].total_duesbill == null)
              ? 0
              : double.parse(TransReBillBank[index1].total_duesbill!));

      sheet.getRangeByName('M${indextotol + 5 - 1}').setNumber(
            (TransReBillBank[index1].total_bill == null)
                ? 0
                : double.parse(TransReBillBank[index1].total_bill!),
          );
      sheet.getRangeByName('N${indextotol + 5 - 1}').setNumber(
            (TransReBillBank[index1].total_dis == null)
                ? 0.00
                : double.parse(TransReBillBank[index1].total_dis!),
          );
      sheet.getRangeByName('O${indextotol + 5 - 1}').setNumber(
            (TransReBillBank[index1].total_dis == null)
                ? double.parse(TransReBillBank[index1].total_bill!)
                : double.parse(TransReBillBank[index1].total_bill!) -
                    double.parse(TransReBillBank[index1].total_dis!),
          );
      sheet.getRangeByName('P${indextotol + 5 - 1}').setText(
            (TransReBillBank[index1].room_number.toString() == '' ||
                    TransReBillBank[index1].room_number == null)
                ? ''
                : 'ล็อคเสียบ',
          );
      sheet.getRangeByName('Q${indextotol + 5 - 1}').setText(
            (TransReBillBank[index1].doctax == '' ||
                    TransReBillBank[index1].doctax == null)
                ? ''
                : 'ใบกำกับภาษี',
          );
      print('-------------------------');
    }

    /////////////////////////////////------------------------------------------------>
    ///

    sheet.getRangeByName('K${indextotol + 5 + 0}').setText('เฉพาะล็อคเสียบ: ');
    sheet.getRangeByName('K${indextotol + 5 + 1}').setText('เฉพาะล็อคธรรมดา: ');
    sheet.getRangeByName('K${indextotol + 5 + 2}').setText('รวมทั้งหมด: ');

    sheet.getRangeByName('L${indextotol + 5 + 0}').setFormula(
        '=SUMIF(P5:P${indextotol + 5 - 1}, "ล็อคเสียบ",L5:L${indextotol + 5 - 1})');
    sheet.getRangeByName('L${indextotol + 5 + 1}').setFormula(
        '=SUMIF(P5:P${indextotol + 5 - 1}, "<>ล็อคเสียบ",L5:L${indextotol + 5 - 1})');
    sheet
        .getRangeByName('L${indextotol + 5 + 2}')
        .setFormula('=SUM(L5:L${indextotol + 5 - 1})');

    ///---------->
    ///
    sheet.getRangeByName('M${indextotol + 5 + 0}').setFormula(
        '=SUMIF(P5:P${indextotol + 5 - 1}, "ล็อคเสียบ",M5:M${indextotol + 5 - 1})');
    sheet.getRangeByName('M${indextotol + 5 + 1}').setFormula(
        '=SUMIF(P5:P${indextotol + 5 - 1}, "<>ล็อคเสียบ",M5:M${indextotol + 5 - 1})');
    sheet
        .getRangeByName('M${indextotol + 5 + 2}')
        .setFormula('=SUM(M5:M${indextotol + 5 - 1})');

    ///---------->
    sheet.getRangeByName('N${indextotol + 5 + 0}').setFormula(
        '=SUMIF(P5:P${indextotol + 5 - 1}, "ล็อคเสียบ",N5:N${indextotol + 5 - 1})');
    sheet.getRangeByName('N${indextotol + 5 + 1}').setFormula(
        '=SUMIF(P5:P${indextotol + 5 - 1}, "<>ล็อคเสียบ",N5:N${indextotol + 5 - 1})');
    sheet
        .getRangeByName('N${indextotol + 5 + 2}')
        .setFormula('=SUM(N5:N${indextotol + 5 - 1})');

    ///---------->
    sheet.getRangeByName('O${indextotol + 5 + 0}').setFormula(
        '=SUMIF(P5:P${indextotol + 5 - 1}, "ล็อคเสียบ",O5:O${indextotol + 5 - 1})');
    sheet.getRangeByName('O${indextotol + 5 + 1}').setFormula(
        '=SUMIF(P5:P${indextotol + 5 - 1}, "<>ล็อคเสียบ",O5:O${indextotol + 5 - 1})');
    sheet
        .getRangeByName('O${indextotol + 5 + 2}')
        .setFormula('=SUM(O5:O${indextotol + 5 - 1})');
///////-------------------------------------------------------------------->

    for (var index = 0; index < 3; index++) {
      sheet.getRangeByName('K${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('L${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('M${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('N${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('O${indextotol + 5 + index}').cellStyle =
          globalStyle7;
    }

/////////////////////////////////------------------------------------------------>
    sheet.getRangeByName('H${indextotol + 5 + 5}').setText('ธนาคาร');
    sheet.getRangeByName('I${indextotol + 5 + 5}').setText('ชื่อบช.');
    sheet.getRangeByName('J${indextotol + 5 + 5}').setText('เลขบช.');
    sheet.getRangeByName('K${indextotol + 5 + 5}').setText('สาขา');

    sheet.getRangeByName('L${indextotol + 5 + 5}').setText('รวมค่าธรรมเนียม');
    sheet.getRangeByName('M${indextotol + 5 + 5}').setText('ราคารวม');
    sheet.getRangeByName('N${indextotol + 5 + 5}').setText('รวมส่วนลด');
    sheet.getRangeByName('O${indextotol + 5 + 5}').setText('ราคารวมหักส่วนลด');
    sheet.getRangeByName('H${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('I${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('J${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('K${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('L${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('M${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('N${indextotol + 5 + 5}').cellStyle = globalStyle1;
    sheet.getRangeByName('O${indextotol + 5 + 5}').cellStyle = globalStyle1;

    for (var index = 0; index < payMentModels.length; index++) {
      sheet
          .getRangeByName('H${indextotol + 5 + 6 + index}')
          .setText('${payMentModels[index].bank}');
      sheet
          .getRangeByName('I${indextotol + 5 + 6 + index}')
          .setText('${payMentModels[index].bname}');
      sheet
          .getRangeByName('J${indextotol + 5 + 6 + index}')
          .setText('${payMentModels[index].bno}');
      sheet
          .getRangeByName('K${indextotol + 5 + 6 + index}')
          .setText('${payMentModels[index].bsaka}');

      sheet.getRangeByName('L${indextotol + 5 + 6 + index}').setFormula(
          '=SUMIF(J5:J${indextotol + 5 - 1}, "${payMentModels[index].bno}",L5:L${indextotol + 5 - 1})');
      sheet.getRangeByName('M${indextotol + 5 + 6 + index}').setFormula(
          '=SUMIF(J5:J${indextotol + 5 - 1}, "${payMentModels[index].bno}",M5:M${indextotol + 5 - 1})');

      sheet.getRangeByName('N${indextotol + 5 + 6 + index}').setFormula(
          '=SUMIF(J5:J${indextotol + 5 - 1}, "${payMentModels[index].bno}", N5:N${indextotol + 5 - 1})');
      sheet.getRangeByName('O${indextotol + 5 + 6 + index}').setFormula(
          '=SUMIF(J5:J${indextotol + 5 - 1}, "${payMentModels[index].bno}", O5:O${indextotol + 5 - 1})');
          
      sheet.getRangeByName('H${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
      sheet.getRangeByName('I${indextotol + 5 + 6 + index}').cellStyle =
          globalStyle22;
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
    }
/////////////////////////////////------------------------------------------------>

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          (ser_type_repro == '1')
              ? 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ ( โซน : $zone_name_Trans_Daily)'
              : (ser_type_repro == '2')
                  ? 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ เฉพาะรายการที่มีส่วนลด ( โซน : $zone_name_Trans_Daily)'
                  : (ser_type_repro == '3')
                      ? 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ เฉพาะล็อคเสียบ ( โซน : $zone_name_Trans_Daily)'
                      : (ser_type_repro == '4')
                          ? 'รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ เฉพาะรายการที่ออกใบกำกับภาษี ( โซน : $zone_name_Trans_Daily)'
                          : 'รายงานประวัติชำระรอตรวจสอบประจำวันประจำวันแบบย่อ ( โซน : $zone_name_Trans_Daily)',
          // "รายงานการเคลื่อนไหวธนาคารประจำวันแบบย่อ",
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
