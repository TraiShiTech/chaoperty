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

class Mini_Ex_IncomeReport {
  static void mini_exportExcel_IncomeReport(
      ser_type_repro,
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Report,
      TransReBillModels,
      TranHisBillModels,
      renTal_name,
      zoneModels_report,
      zone_name_Trans_Mon,
      Mon_Trans_Mon,
      YE_Trans_Mon) async {
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;
    int all_Total = 0;
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
    sheet.getRangeByName('R1').cellStyle = globalStyle22;
    sheet.getRangeByName('S1').cellStyle = globalStyle22;
    sheet.getRangeByName('T1').cellStyle = globalStyle22;
    sheet.getRangeByName('U1').cellStyle = globalStyle22;
    sheet.getRangeByName('V1').cellStyle = globalStyle22;

    final x.Range range = sheet.getRangeByName('E1');
    range.setText((ser_type_repro == '1')
        ? 'รายงานรายรับแบบย่อ ( โซน : $zone_name_Trans_Mon)'
        : (ser_type_repro == '2')
            ? 'รายงานรายรับแบบย่อ เฉพาะรายการที่มีส่วนลด ( โซน : $zone_name_Trans_Mon)'
            : (ser_type_repro == '3')
                ? 'รายงานรายรับแบบย่อ เฉพาะล็อคเสียบ ( โซน : $zone_name_Trans_Mon)'
                : 'รายงานรายรับแบบย่อ เฉพาะรายการที่ออกใบกำกับภาษี ( โซน : $zone_name_Trans_Mon)');

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

    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet
        .getRangeByName('I2')
        .setText('เดือน : ${Mon_Trans_Mon} (${YE_Trans_Mon}) ');

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
    sheet.getRangeByName('A3').setText('ใบเสร็จ : ${TransReBillModels.length}');

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

    sheet.getRangeByName('J4').columnWidth = 18;
    sheet.getRangeByName('K4').columnWidth = 18;
    sheet.getRangeByName('L4').columnWidth = 18;
    sheet.getRangeByName('M4').columnWidth = 18;
    sheet.getRangeByName('N4').columnWidth = 18;
    sheet.getRangeByName('O4').columnWidth = 18;
    sheet.getRangeByName('P4').columnWidth = 18;
    sheet.getRangeByName('Q4').columnWidth = 18;
    sheet.getRangeByName('R4').columnWidth = 18;

    sheet.getRangeByName('A4').columnWidth = 18;
    sheet.getRangeByName('B4').columnWidth = 18;
    sheet.getRangeByName('C4').columnWidth = 18;
    sheet.getRangeByName('D4').columnWidth = 18;
    sheet.getRangeByName('E4').columnWidth = 18;
    sheet.getRangeByName('F4').columnWidth = 18;
    sheet.getRangeByName('G4').columnWidth = 25;
    sheet.getRangeByName('H4').columnWidth = 18;
    sheet.getRangeByName('I4').columnWidth = 18;
    sheet.getRangeByName('J4').columnWidth = 18;
    sheet.getRangeByName('K4').columnWidth = 18;
    sheet.getRangeByName('L4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('ลำดับ');
    sheet.getRangeByName('B4').setText('เลขที่');
    sheet.getRangeByName('C4').setText('วันที่ทำรายการ');
    sheet.getRangeByName('D4').setText('วันที่ชำระ');

    sheet.getRangeByName('E4').setText('รหัสโซน');
    sheet.getRangeByName('F4').setText('โซน');
    sheet.getRangeByName('G4').setText('รหัสพื้นที่');
    sheet.getRangeByName('H4').setText('ร้าน');
    sheet.getRangeByName('I4').setText('รูปแบบชำระ');
    sheet.getRangeByName('J4').setText('รายการทั้งหมด');
    sheet.getRangeByName('K4').setText('ค่าธรรมเนียม');
    sheet.getRangeByName('L4').setText('ราคารวม');
    sheet.getRangeByName('M4').setText('ส่วนลด');
    sheet.getRangeByName('N4').setText('หักส่วนลด');
    sheet.getRangeByName('O4').setText('ประเภท');
    sheet.getRangeByName('P4').setText('สถานะ');
    sheet.getRangeByName('Q4').setText('อ้างถึง');
    sheet.getRangeByName('R4').setText('เลขที่สัญญา');
    sheet.getRangeByName('S4').setText('วันที่เริ่มต้น');

    sheet.getRangeByName('T4').setText('วันที่เริ่มสิ้นสุด');
    sheet.getRangeByName('U4').setText('ล็อกเสียบ');
    sheet.getRangeByName('V4').setText('เวลา');

    int indextotol = 0;
    int indextotol_ = 0;

    for (var index1 = 0; index1 < TransReBillModels.length; index1++) {
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
      sheet.getRangeByName('R${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('S${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('T${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('U${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('V${indextotol + 5 - 1}').cellStyle = numberColor;

      sheet.getRangeByName('A${indextotol + 5 - 1}').setText('${index1 + 1}');
      sheet.getRangeByName('B${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].doctax != '')
                ? '${TransReBillModels[index1].doctax}'
                : TransReBillModels[index1].docno == ''
                    ? '${TransReBillModels[index1].refno}'
                    : '${TransReBillModels[index1].docno}',
          );
      sheet.getRangeByName('C${indextotol + 5 - 1}').setText((TransReBillModels[
                      index1]
                  .daterec ==
              null)
          ? ''
          : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels[index1].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillModels[index1].daterec}'))}') + 543}');
      // sheet.getRangeByName('C${indextotol + 5 - 1}').setText(
      //       '${TransReBillModels[index1].daterec}',
      //     );
      sheet.getRangeByName('D${indextotol + 5 - 1}').setText((TransReBillModels[
                      index1]
                  .dateacc ==
              null)
          ? ''
          : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels[index1].dateacc}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillModels[index1].dateacc}'))}') + 543}');
      // sheet.getRangeByName('D${indextotol + 5 - 1}').setText(
      //       '${TransReBillModels[index1].dateacc}',
      //     );

      sheet.getRangeByName('E${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].zser1 == null)
                ? '${TransReBillModels[index1].zser}'
                : '${TransReBillModels[index1].zser1}',
          );
      sheet.getRangeByName('F${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].zn == null)
                ? '${TransReBillModels[index1].znn}'
                : '${TransReBillModels[index1].zn}',
          );
      sheet.getRangeByName('G${indextotol + 5 - 1}').setText(
          (TransReBillModels[index1].ln == null)
              ? '${TransReBillModels[index1].room_number}'
              : '${TransReBillModels[index1].ln}');

      sheet.getRangeByName('H${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].sname == null ||
                    TransReBillModels[index1].sname.toString() == '' ||
                    TransReBillModels[index1].sname.toString() == 'null')
                ? '${TransReBillModels[index1].remark}'
                : '${TransReBillModels[index1].sname}',
          );
      sheet.getRangeByName('I${indextotol + 5 - 1}').setText(
            '${TransReBillModels[index1].type}',
          );
      sheet.getRangeByName('J${indextotol + 5 - 1}').setNumber(
          (TransReBillModels[index1].sum_items == null)
              ? 0
              : double.parse(TransReBillModels[index1].sum_items.toString()));

      sheet.getRangeByName('K${indextotol + 5 - 1}').setNumber(
          (TransReBillModels[index1].total_duesbill == null)
              ? 0
              : double.parse(TransReBillModels[index1].total_duesbill!));

      sheet.getRangeByName('L${indextotol + 5 - 1}').setNumber(
            (TransReBillModels[index1].total_bill == null)
                ? 0
                : double.parse(TransReBillModels[index1].total_bill!),
          );
      sheet.getRangeByName('M${indextotol + 5 - 1}').setNumber(
            (TransReBillModels[index1].total_dis == null)
                ? 0.00
                : double.parse(TransReBillModels[index1].total_dis!),
          );
      sheet.getRangeByName('N${indextotol + 5 - 1}').setNumber(
            (TransReBillModels[index1].total_dis == null)
                ? double.parse(TransReBillModels[index1].total_bill!)
                : double.parse(TransReBillModels[index1].total_bill!) -
                    double.parse(TransReBillModels[index1].total_dis!),
          );
      sheet.getRangeByName('O${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].room_number.toString() == '' ||
                    TransReBillModels[index1].room_number == null)
                ? ''
                : 'ล็อคเสียบ',
          );
      sheet.getRangeByName('P${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].doctax == '' ||
                    TransReBillModels[index1].doctax == null)
                ? ''
                : 'ใบกำกับภาษี',
          );
      sheet.getRangeByName('Q${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].inv == '' ||
                    TransReBillModels[index1].inv == null)
                ? ''
                : '${TransReBillModels[index1].inv}',
          );

      sheet.getRangeByName('R${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].cid == '' ||
                    TransReBillModels[index1].cid == null)
                ? ''
                : '${TransReBillModels[index1].cid}',
          );

      sheet.getRangeByName('S${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].sdate == '' ||
                    TransReBillModels[index1].sdate == null)
                ? ''
                : '${TransReBillModels[index1].sdate}',
          );
      sheet.getRangeByName('T${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].ldate == '' ||
                    TransReBillModels[index1].ldate == null)
                ? ''
                : '${TransReBillModels[index1].ldate}',
          );
      sheet.getRangeByName('U${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].date_book == '' ||
                    TransReBillModels[index1].date_book == null)
                ? ''
                : '${TransReBillModels[index1].date_book}',
          );
      sheet.getRangeByName('V${indextotol + 5 - 1}').setText(
            (TransReBillModels[index1].timex == '' ||
                    TransReBillModels[index1].timex == null)
                ? ''
                : '${TransReBillModels[index1].timex}',
          );

      // print('-------------------------');
    }

    /////////////////////////////////------------------------------------------------>
    sheet.getRangeByName('I${indextotol + 5 + 0}').setText('เฉพาะล็อคเสียบ: ');
    sheet.getRangeByName('I${indextotol + 5 + 1}').setText('เฉพาะล็อคธรรมดา: ');
    sheet.getRangeByName('I${indextotol + 5 + 2}').setText('รวมทั้งหมด: ');

    sheet.getRangeByName('J${indextotol + 5 + 0}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "ล็อคเสียบ",J5:J${indextotol + 5 - 1})');
    sheet.getRangeByName('J${indextotol + 5 + 1}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "<>ล็อคเสียบ",J5:J${indextotol + 5 - 1})');
    sheet
        .getRangeByName('J${indextotol + 5 + 2}')
        .setFormula('=SUM(J5:J${indextotol + 5 - 1})');

    // ///---------->
    sheet.getRangeByName('K${indextotol + 5 + 0}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "ล็อคเสียบ",K5:K${indextotol + 5 - 1})');
    sheet.getRangeByName('K${indextotol + 5 + 1}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "<>ล็อคเสียบ",K5:K${indextotol + 5 - 1})');
    sheet
        .getRangeByName('K${indextotol + 5 + 2}')
        .setFormula('=SUM(K5:K${indextotol + 5 - 1})');

    ///---------->
    sheet.getRangeByName('L${indextotol + 5 + 0}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "ล็อคเสียบ",L5:L${indextotol + 5 - 1})');
    sheet.getRangeByName('L${indextotol + 5 + 1}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "<>ล็อคเสียบ",L5:L${indextotol + 5 - 1})');
    sheet
        .getRangeByName('L${indextotol + 5 + 2}')
        .setFormula('=SUM(L5:L${indextotol + 5 - 1})');

    ///---------->
    sheet.getRangeByName('M${indextotol + 5 + 0}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "ล็อคเสียบ",M5:M${indextotol + 5 - 1})');
    sheet.getRangeByName('M${indextotol + 5 + 1}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "<>ล็อคเสียบ", M5:M${indextotol + 5 - 1})');

    sheet
        .getRangeByName('M${indextotol + 5 + 2}')
        .setFormula('=SUM(M5:M${indextotol + 5 - 1})');

    ///---------->
    sheet.getRangeByName('N${indextotol + 5 + 0}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "ล็อคเสียบ",N5:N${indextotol + 5 - 1})');
    sheet.getRangeByName('N${indextotol + 5 + 1}').setFormula(
        '=SUMIF(O5:O${indextotol + 5 - 1}, "<>ล็อคเสียบ", N5:N${indextotol + 5 - 1})');

    sheet
        .getRangeByName('N${indextotol + 5 + 2}')
        .setFormula('=SUM(N5:N${indextotol + 5 - 1})');
///////-------------------------------------------------------------------->

    for (var index = 0; index < 3; index++) {
      sheet.getRangeByName('I${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('J${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('K${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('L${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('M${indextotol + 5 + index}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('N${indextotol + 5 + index}').cellStyle =
          globalStyle7;
    }

/////////////////////////////////------------------------------------------------>

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          (ser_type_repro == '1')
              ? 'รายงานรายรับแบบย่อ ( โซน : $zone_name_Trans_Mon)'
              : (ser_type_repro == '2')
                  ? 'รายงานรายรับแบบย่อ เฉพาะรายการที่มีส่วนลด ( โซน : $zone_name_Trans_Mon)'
                  : (ser_type_repro == '3')
                      ? 'รายงานรายรับแบบย่อ เฉพาะล็อคเสียบ ( โซน : $zone_name_Trans_Mon)'
                      : 'รายงานรายรับแบบย่อ เฉพาะรายการที่ออกใบกำกับภาษี ( โซน : $zone_name_Trans_Mon)',
          // "รายงานรายรับแบบย่อ",

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
