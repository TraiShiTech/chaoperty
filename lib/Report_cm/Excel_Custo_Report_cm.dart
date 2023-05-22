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

class Excgen_Custo_cm {
  static void exportExcel_Custo_cm(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Report,
      teNantModels,
      renTal_name,
      Value_selectDate,
      coutumer_MOMO_CM,
      coutumer_tank_CM,
      coutumer_rent_area_CM,
      coutumer_electricity_CM,
      coutumer_total_sum_CM,
      custo_TransReBillHistoryModels,
      YE_,
      Mon_) async {
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;
    var nFormat = NumberFormat("#,##0.00", "en_US");
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
    globalStyle.fontSize = 17;
    globalStyle.backColorRgb = Color(0xFFF5F7FA);

    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = Color(0xFFFFFFFF);
    globalStyle2.numberFormat = '_(\$* #,##0_)';
    globalStyle2.fontSize = 12;
    globalStyle2.hAlign = x.HAlignType.center;

    x.Style globalStyle22 = workbook.styles.add('style22');
    globalStyle22.backColorRgb = Color(0xC7F5F7FA);
    globalStyle22.numberFormat = '_(\$* #,##0_)';
    globalStyle22.fontSize = 12;
    globalStyle22.hAlign = x.HAlignType.center;

    x.Style globalStyle222 = workbook.styles.add('style222');
    globalStyle222.backColorRgb = Color(0xC7E1E2E6);
    globalStyle222.numberFormat = '_(\$* #,##0_)';
    globalStyle222.fontSize = 12;
    globalStyle222.hAlign = x.HAlignType.center;

    x.Style globalStyle3 = workbook.styles.add('style3');
    globalStyle3.backColorRgb = Color(0xFF729DD6);
    globalStyle3.borders.bottom.colorRgb = Colors.black;
    globalStyle3.fontName = 'Angsana New';
    globalStyle3.fontSize = 15;
    globalStyle3.hAlign = x.HAlignType.center;
    globalStyle3.borders;

    x.Style globalStyle33 = workbook.styles.add('style33');
    globalStyle33.backColorRgb = Color(0xFF627C9E);
    globalStyle33.fontName = 'Angsana New';
    globalStyle33.fontSize = 15;
    globalStyle33.hAlign = x.HAlignType.center;
    globalStyle33.borders;

    x.Style globalStyle4 = workbook.styles.add('style4');
    globalStyle4.backColorRgb = Color(0xFFDA97AD);
    globalStyle4.hAlign = x.HAlignType.center;
    globalStyle4.fontName = 'Angsana New';
    globalStyle4.fontSize = 15;
    globalStyle4.borders;

    x.Style globalStyle44 = workbook.styles.add('style44');
    globalStyle44.backColorRgb = Color(0xFF9C5B7A);
    globalStyle44.fontName = 'Angsana New';
    globalStyle44.hAlign = x.HAlignType.center;
    globalStyle44.fontSize = 15;
    globalStyle44.borders;

    x.Style globalStyle5 = workbook.styles.add('style5');
    globalStyle5.backColorRgb = Color(0xFF84BD89);
    globalStyle5.fontName = 'Angsana New';
    globalStyle5.hAlign = x.HAlignType.center;
    globalStyle5.fontSize = 15;
    globalStyle5.borders;

    x.Style globalStyle55 = workbook.styles.add('style55');
    globalStyle55.backColorRgb = Color(0xFF6B8D6D);
    globalStyle55.fontName = 'Angsana New';
    globalStyle55.hAlign = x.HAlignType.center;
    globalStyle55.fontSize = 15;
    globalStyle55.borders;

    x.Style globalStyle6 = workbook.styles.add('style6');
    globalStyle6.backColorRgb = Color(0xFFE9BFA3);
    globalStyle6.fontName = 'Angsana New';
    globalStyle6.hAlign = x.HAlignType.center;
    globalStyle6.fontSize = 15;
    globalStyle6.borders;

    x.Style globalStyle66 = workbook.styles.add('style66');
    globalStyle66.backColorRgb = Color(0xFFBD9B84);
    globalStyle66.fontName = 'Angsana New';
    globalStyle55.hAlign = x.HAlignType.center;
    globalStyle66.fontSize = 15;
    globalStyle66.borders;

    x.Style globalStyle77 = workbook.styles.add('style77');
    //globalStyle66.backColorRgb = Color(0xFFBD9B84);
    globalStyle77.fontName = 'Angsana New';
    globalStyle77.hAlign = x.HAlignType.center;
    globalStyle77.fontSize = 14;
    globalStyle77.borders;
    globalStyle77.fontColorRgb = Color(0xFF388121);

    x.Style globalStyle88 = workbook.styles.add('style88');
    //globalStyle66.backColorRgb = Color(0xFFBD9B84);
    globalStyle88.fontName = 'Angsana New';
    globalStyle88.hAlign = x.HAlignType.center;
    globalStyle88.fontSize = 14;
    globalStyle88.borders;
    globalStyle88.fontColorRgb = Color(0xFFC52611);

    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    sheet.getRangeByName('K1').cellStyle = globalStyle;
    sheet.getRangeByName('K1').cellStyle = globalStyle;
    sheet.getRangeByName('L1').cellStyle = globalStyle;
    sheet.getRangeByName('M1').cellStyle = globalStyle;
    sheet.getRangeByName('N1').cellStyle = globalStyle;
    sheet.getRangeByName('O1').cellStyle = globalStyle;
    sheet.getRangeByName('P1').cellStyle = globalStyle;

    sheet.getRangeByName('Q1').cellStyle = globalStyle;
    sheet.getRangeByName('R1').cellStyle = globalStyle;
    sheet.getRangeByName('S1').cellStyle = globalStyle;
    sheet.getRangeByName('T1').cellStyle = globalStyle;
    sheet.getRangeByName('U1').cellStyle = globalStyle;
    sheet.getRangeByName('V1').cellStyle = globalStyle;
    sheet.getRangeByName('W1').cellStyle = globalStyle;
    sheet.getRangeByName('X1').cellStyle = globalStyle;
    sheet.getRangeByName('Y1').cellStyle = globalStyle;
    sheet.getRangeByName('Z1').cellStyle = globalStyle;

    sheet.getRangeByName('AA1').cellStyle = globalStyle;
    sheet.getRangeByName('AB1').cellStyle = globalStyle;
    sheet.getRangeByName('AC1').cellStyle = globalStyle;
    sheet.getRangeByName('AD1').cellStyle = globalStyle;
    sheet.getRangeByName('AE1').cellStyle = globalStyle;
    sheet.getRangeByName('AF1').cellStyle = globalStyle;
    sheet.getRangeByName('AG1').cellStyle = globalStyle;
    sheet.getRangeByName('AH1').cellStyle = globalStyle;
    sheet.getRangeByName('AI1').cellStyle = globalStyle;
    sheet.getRangeByName('AJ1').cellStyle = globalStyle;
    sheet.getRangeByName('AK1').cellStyle = globalStyle;
    sheet.getRangeByName('AL1').cellStyle = globalStyle;
    sheet.getRangeByName('AM1').cellStyle = globalStyle;
    sheet.getRangeByName('AN1').cellStyle = globalStyle;
    sheet.getRangeByName('AO1').cellStyle = globalStyle;
    sheet.getRangeByName('AP1').cellStyle = globalStyle;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานผู้เช่า $renTal_name');

// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle;
    sheet.getRangeByName('B2').cellStyle = globalStyle;
    sheet.getRangeByName('C2').cellStyle = globalStyle;
    sheet.getRangeByName('D2').cellStyle = globalStyle;
    sheet.getRangeByName('E2').cellStyle = globalStyle;
    sheet.getRangeByName('F2').cellStyle = globalStyle;
    sheet.getRangeByName('G2').cellStyle = globalStyle;
    sheet.getRangeByName('H2').cellStyle = globalStyle;
    sheet.getRangeByName('I2').cellStyle = globalStyle;
    sheet.getRangeByName('J2').cellStyle = globalStyle;
    sheet.getRangeByName('L2').cellStyle = globalStyle;
    sheet.getRangeByName('M2').cellStyle = globalStyle;
    sheet.getRangeByName('N2').cellStyle = globalStyle;
    sheet.getRangeByName('O2').cellStyle = globalStyle;
    sheet.getRangeByName('P2').cellStyle = globalStyle;

    sheet.getRangeByName('Q2').cellStyle = globalStyle;
    sheet.getRangeByName('R2').cellStyle = globalStyle;
    sheet.getRangeByName('S2').cellStyle = globalStyle;
    sheet.getRangeByName('T2').cellStyle = globalStyle;
    sheet.getRangeByName('U2').cellStyle = globalStyle;
    sheet.getRangeByName('V2').cellStyle = globalStyle;
    sheet.getRangeByName('W2').cellStyle = globalStyle;
    sheet.getRangeByName('X2').cellStyle = globalStyle;
    sheet.getRangeByName('Y2').cellStyle = globalStyle;
    sheet.getRangeByName('Z2').cellStyle = globalStyle;

    sheet.getRangeByName('AA2').cellStyle = globalStyle;
    sheet.getRangeByName('AB2').cellStyle = globalStyle;
    sheet.getRangeByName('AC2').cellStyle = globalStyle;
    sheet.getRangeByName('AD2').cellStyle = globalStyle;
    sheet.getRangeByName('AE2').cellStyle = globalStyle;
    sheet.getRangeByName('AF2').cellStyle = globalStyle;
    sheet.getRangeByName('AG2').cellStyle = globalStyle;
    sheet.getRangeByName('AH2').cellStyle = globalStyle;
    sheet.getRangeByName('AI2').cellStyle = globalStyle;
    sheet.getRangeByName('AJ2').cellStyle = globalStyle;
    sheet.getRangeByName('AK2').cellStyle = globalStyle;
    sheet.getRangeByName('AL2').cellStyle = globalStyle;
    sheet.getRangeByName('AM2').cellStyle = globalStyle;
    sheet.getRangeByName('AN2').cellStyle = globalStyle;
    sheet.getRangeByName('AO2').cellStyle = globalStyle;
    sheet.getRangeByName('AP2').cellStyle = globalStyle;
    // sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('A2').setText((YE_ == null || Mon_ == null)
        ? 'เดือน : ? ( ปี : ? )'
        : 'เดือน : $Mon_ ( ปี : $YE_ )');
    sheet.getRangeByName('A2').cellStyle = globalStyle;
    sheet.getRangeByName('K2').cellStyle = globalStyle;

    sheet.getRangeByName('A3').cellStyle = globalStyle33;
    sheet.getRangeByName('B3').cellStyle = globalStyle33;
    sheet.getRangeByName('C3').cellStyle = globalStyle33;
    sheet.getRangeByName('D3').cellStyle = globalStyle33;
    sheet.getRangeByName('E3').cellStyle = globalStyle44;
    sheet.getRangeByName('F3').cellStyle = globalStyle44;
    sheet.getRangeByName('G3').cellStyle = globalStyle44;
    sheet.getRangeByName('H3').cellStyle = globalStyle44;
    sheet.getRangeByName('I3').cellStyle = globalStyle44;
    sheet.getRangeByName('J3').cellStyle = globalStyle44;
    sheet.getRangeByName('K3').cellStyle = globalStyle44;
    sheet.getRangeByName('L3').cellStyle = globalStyle55;
    sheet.getRangeByName('M3').cellStyle = globalStyle55;
    sheet.getRangeByName('N3').cellStyle = globalStyle55;
    sheet.getRangeByName('O3').cellStyle = globalStyle55;
    sheet.getRangeByName('P3').cellStyle = globalStyle55;

    sheet.getRangeByName('Q3').cellStyle = globalStyle55;
    sheet.getRangeByName('R3').cellStyle = globalStyle55;
    sheet.getRangeByName('S3').cellStyle = globalStyle55;
    sheet.getRangeByName('T3').cellStyle = globalStyle55;
    sheet.getRangeByName('U3').cellStyle = globalStyle55;
    sheet.getRangeByName('V3').cellStyle = globalStyle55;
    sheet.getRangeByName('W3').cellStyle = globalStyle55;
    sheet.getRangeByName('X3').cellStyle = globalStyle55;
    sheet.getRangeByName('Y3').cellStyle = globalStyle55;
    sheet.getRangeByName('Z3').cellStyle = globalStyle55;

    sheet.getRangeByName('AA3').cellStyle = globalStyle55;
    sheet.getRangeByName('AB3').cellStyle = globalStyle55;
    sheet.getRangeByName('AC3').cellStyle = globalStyle55;
    sheet.getRangeByName('AD3').cellStyle = globalStyle55;
    sheet.getRangeByName('AE3').cellStyle = globalStyle55;
    sheet.getRangeByName('AF3').cellStyle = globalStyle55;
    sheet.getRangeByName('AG3').cellStyle = globalStyle55;
    sheet.getRangeByName('AH3').cellStyle = globalStyle55;
    sheet.getRangeByName('AI3').cellStyle = globalStyle55;
    sheet.getRangeByName('AJ3').cellStyle = globalStyle55;
    sheet.getRangeByName('AK3').cellStyle = globalStyle55;
    sheet.getRangeByName('AL3').cellStyle = globalStyle55;
    sheet.getRangeByName('AM3').cellStyle = globalStyle55;
    sheet.getRangeByName('AN3').cellStyle = globalStyle55;
    sheet.getRangeByName('AO3').cellStyle = globalStyle55;
    sheet.getRangeByName('AP3').cellStyle = globalStyle55;

    sheet.getRangeByName('A4').cellStyle = globalStyle3;
    sheet.getRangeByName('B4').cellStyle = globalStyle3;
    sheet.getRangeByName('C4').cellStyle = globalStyle3;
    sheet.getRangeByName('D4').cellStyle = globalStyle3;
    sheet.getRangeByName('E4').cellStyle = globalStyle4;
    sheet.getRangeByName('F4').cellStyle = globalStyle4;
    sheet.getRangeByName('G4').cellStyle = globalStyle4;
    sheet.getRangeByName('H4').cellStyle = globalStyle4;
    sheet.getRangeByName('I4').cellStyle = globalStyle4;
    sheet.getRangeByName('J4').cellStyle = globalStyle4;
    sheet.getRangeByName('K4').cellStyle = globalStyle4;

    ///----------------------------------------------------------------->
    sheet.getRangeByName('L4').cellStyle = globalStyle5;
    sheet.getRangeByName('M4').cellStyle = globalStyle5;
    sheet.getRangeByName('N4').cellStyle = globalStyle5;
    sheet.getRangeByName('O4').cellStyle = globalStyle5;
    sheet.getRangeByName('P4').cellStyle = globalStyle5;
    sheet.getRangeByName('Q4').cellStyle = globalStyle5;
    sheet.getRangeByName('R4').cellStyle = globalStyle5;
    sheet.getRangeByName('S4').cellStyle = globalStyle5;
    sheet.getRangeByName('T4').cellStyle = globalStyle5;
    sheet.getRangeByName('U4').cellStyle = globalStyle5;
    sheet.getRangeByName('V4').cellStyle = globalStyle5;
    sheet.getRangeByName('W4').cellStyle = globalStyle5;
    sheet.getRangeByName('X4').cellStyle = globalStyle5;
    sheet.getRangeByName('Y4').cellStyle = globalStyle5;
    sheet.getRangeByName('Z4').cellStyle = globalStyle5;

    sheet.getRangeByName('AA4').cellStyle = globalStyle5;
    sheet.getRangeByName('AB4').cellStyle = globalStyle5;
    sheet.getRangeByName('AC4').cellStyle = globalStyle5;
    sheet.getRangeByName('AD4').cellStyle = globalStyle5;
    sheet.getRangeByName('AE4').cellStyle = globalStyle5;
    sheet.getRangeByName('AF4').cellStyle = globalStyle5;
    sheet.getRangeByName('AG4').cellStyle = globalStyle5;
    sheet.getRangeByName('AH4').cellStyle = globalStyle5;
    sheet.getRangeByName('AI4').cellStyle = globalStyle5;
    sheet.getRangeByName('AJ4').cellStyle = globalStyle5;
    sheet.getRangeByName('AK4').cellStyle = globalStyle5;
    sheet.getRangeByName('AL4').cellStyle = globalStyle5;
    sheet.getRangeByName('AM4').cellStyle = globalStyle5;
    sheet.getRangeByName('AN4').cellStyle = globalStyle5;
    sheet.getRangeByName('AO4').cellStyle = globalStyle5;
    sheet.getRangeByName('AP4').cellStyle = globalStyle5;

    sheet.getRangeByName('A4').columnWidth = 10;
    sheet.getRangeByName('B4').columnWidth = 20;
    sheet.getRangeByName('C4').columnWidth = 14;
    sheet.getRangeByName('D4').columnWidth = 14;
    sheet.getRangeByName('E4').columnWidth = 14;
    sheet.getRangeByName('F4').columnWidth = 14;
    sheet.getRangeByName('G4').columnWidth = 14;
    sheet.getRangeByName('H4').columnWidth = 14;
    sheet.getRangeByName('I4').columnWidth = 14;
    sheet.getRangeByName('J4').columnWidth = 14;
    // sheet.getRangeByName('K4').columnWidth = 18;
    // sheet.getRangeByName('L4').columnWidth = 18;
    // sheet.getRangeByName('M4').columnWidth = 18;
    // sheet.getRangeByName('N4').columnWidth = 18;
    // sheet.getRangeByName('O4').columnWidth = 18;
    // sheet.getRangeByName('P4').columnWidth = 18;

    // sheet.getRangeByName('A3:E3').merge();
    // sheet.getRangeByName('B3:B4').merge();
    // sheet.getRangeByName('C3:C4').merge();
    // sheet.getRangeByName('D3:D4').merge();
    // sheet.getRangeByName('E3:E4').merge();
    // sheet.getRangeByName('F3:F4').merge();
    // sheet.getRangeByName('F3:K3').merge();
    // sheet.getRangeByName('L3:N3').merge();
    // sheet.getRangeByName('O4:P4').merge();
    // sheet.getRangeByName('O3:P3').merge();
    // sheet.getRangeByName('A3').setText('ข้อมูล');
    // sheet.getRangeByName('F3').setText('ยอดรับชำระ');
    // sheet.getRangeByName('L3').setText('ยอดนำส่งธนาคาร');
    // sheet.getRangeByName('O4').setText('สรุป');
    // sheet.getRangeByName('A3').setText('ข้อมูลผู้เช่า');

    sheet.getRangeByName('A4').rowHeight = 18;
    sheet.getRangeByName('B4').rowHeight = 18;
    sheet.getRangeByName('C4').rowHeight = 18;
    sheet.getRangeByName('D4').rowHeight = 18;
    sheet.getRangeByName('E4').rowHeight = 18;
    sheet.getRangeByName('F4').rowHeight = 18;
    sheet.getRangeByName('G4').rowHeight = 18;
    sheet.getRangeByName('H4').rowHeight = 18;
    sheet.getRangeByName('I4').rowHeight = 18;
    sheet.getRangeByName('J4').rowHeight = 18;
    sheet.getRangeByName('K4').rowHeight = 18;
    sheet.getRangeByName('L4').rowHeight = 18;
    sheet.getRangeByName('M4').rowHeight = 18;
    sheet.getRangeByName('N4').rowHeight = 18;
    sheet.getRangeByName('O4').rowHeight = 18;
    sheet.getRangeByName('P4').rowHeight = 18;
    sheet.getRangeByName('K4').rowHeight = 18;

    sheet.getRangeByName('A4').setText('เลขที่');
    sheet.getRangeByName('B4').setText('ชื่อ-สกุล');
    sheet.getRangeByName('C4').setText('รหัสพื้นที่');
    sheet.getRangeByName('D4').setText('ขนาดพื้นที่(ต.ร.ม.)');

    sheet.getRangeByName('E4').setText('ค่าเช่ารายวัน');
    sheet.getRangeByName('F4').setText('โม่');
    sheet.getRangeByName('G4').setText('ถัง');
    sheet.getRangeByName('H4').setText('เช่าพื้นที่');
    sheet.getRangeByName('I4').setText('ค่าไฟ');
    sheet.getRangeByName('J4').setText('รวม');
    sheet.getRangeByName('K4').setText('TMB');
    sheet.getRangeByName('L4').setText('1');
    sheet.getRangeByName('M4').setText('2');
    sheet.getRangeByName('N4').setText('3');
    sheet.getRangeByName('O4').setText('4');
    sheet.getRangeByName('P4').setText('5');

    sheet.getRangeByName('Q4').setText('6');
    sheet.getRangeByName('R4').setText('7');
    sheet.getRangeByName('S4').setText('8');
    sheet.getRangeByName('T4').setText('9');
    sheet.getRangeByName('U4').setText('10');
    sheet.getRangeByName('V4').setText('11');
    sheet.getRangeByName('W4').setText('12');
    sheet.getRangeByName('X4').setText('13');
    sheet.getRangeByName('Y4').setText('14');
    sheet.getRangeByName('Z4').setText('15');

    sheet.getRangeByName('AA4').setText('16');
    sheet.getRangeByName('AB4').setText('17');
    sheet.getRangeByName('AC4').setText('18');
    sheet.getRangeByName('AD4').setText('19');
    sheet.getRangeByName('AE4').setText('20');
    sheet.getRangeByName('AF4').setText('21');
    sheet.getRangeByName('AG4').setText('22');
    sheet.getRangeByName('AH4').setText('23');
    sheet.getRangeByName('AI4').setText('24');
    sheet.getRangeByName('AJ4').setText('25');
    sheet.getRangeByName('AK4').setText('26');
    sheet.getRangeByName('AL4').setText('27');
    sheet.getRangeByName('AM4').setText('28');
    sheet.getRangeByName('AN4').setText('29');
    sheet.getRangeByName('AO4').setText('30');
    sheet.getRangeByName('AP4').setText('31');

    int index1 = 0;
    int indextotol = 0;
    for (var index = 0; index < teNantModels.length; index++) {
      var index3 = index1 * teNantModels.length + index;
      dynamic numberColor = index3 % 2 == 0 ? globalStyle22 : globalStyle222;
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
      sheet.getRangeByName('K${indextotol + 5 - 1}').cellStyle = numberColor;
//////////----------------------------------------------------------------->
      sheet.getRangeByName('A${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('B${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('C${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('D${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('E${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('F${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('G${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('H${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('I${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('J${indextotol + 5 - 1}').rowHeight = 30;
      sheet.getRangeByName('K${indextotol + 5 - 1}').rowHeight = 30;

      sheet.getRangeByName('L${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  0 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('M${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  1 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('N${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  2 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('O${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  3 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('P${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  4 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('Q${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  5 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('R${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  6 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('S${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  7 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('T${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  8 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('U${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  9 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;
      sheet.getRangeByName('V${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  10 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('W${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  11 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('X${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  12 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('Y${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  13 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('Z${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  14 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AA${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  15 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AB${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  16 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AC${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  17 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AD${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  18 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AE${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  19 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AF${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  20 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AG${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  21 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AH${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty)
              ? globalStyle88
              : (22 >= custo_TransReBillHistoryModels[index].length)
                  ? globalStyle88
                  : globalStyle77;

      sheet.getRangeByName('AI${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  23 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AJ${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  24 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AK${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  25 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AL${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  26 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AM${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  27 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AN${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  28 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('AO${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  29 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;
      // sheet.getRangeByName('AD${indextotol + 5 - 1}').cellStyle =
      //     (custo_TransReBillHistoryModels[index].isEmpty ||
      //             29 >= custo_TransReBillHistoryModels[index].length)
      //         ? globalStyle88
      //         : globalStyle77;

      sheet.getRangeByName('AP${indextotol + 5 - 1}').cellStyle =
          (custo_TransReBillHistoryModels[index].isEmpty ||
                  30 >= custo_TransReBillHistoryModels[index].length)
              ? globalStyle88
              : globalStyle77;

      sheet.getRangeByName('A${indextotol + 5 - 1}').setText('${index + 1}');

      sheet
          .getRangeByName('B${indextotol + 5 - 1}')
          .setText(teNantModels[index].cname == null
              ? teNantModels[index].cname_q == null
                  ? ''
                  : '${teNantModels[index].cname_q}'
              : '${teNantModels[index].cname}');
      sheet
          .getRangeByName('C${indextotol + 5 - 1}')
          .setText(teNantModels[index].ln_c == null
              ? teNantModels[index].ln_q == null
                  ? ''
                  : '${teNantModels[index].ln_q}'
              : '${teNantModels[index].ln_c}');
      sheet
          .getRangeByName('D${indextotol + 5 - 1}')
          .setText(teNantModels[index].area_c == null
              ? teNantModels[index].area_q == null
                  ? ''
                  : '${teNantModels[index].area_q}'
              : '${teNantModels[index].area_c}');
      sheet
          .getRangeByName('E${indextotol + 5 - 1}')
          .setText('${teNantModels[index].rent}');

      sheet.getRangeByName('F${indextotol + 5 - 1}').setText(
          (coutumer_MOMO_CM[index].isEmpty)
              ? '0.00'
              : '${nFormat.format(double.parse(coutumer_MOMO_CM[index][0]!))}');
      sheet.getRangeByName('G${indextotol + 5 - 1}').setText(
          (coutumer_tank_CM[index].isEmpty)
              ? '0.00'
              : '${nFormat.format(double.parse(coutumer_tank_CM[index][0]!))}');
      sheet.getRangeByName('H${indextotol + 5 - 1}').setText(
          (coutumer_rent_area_CM[index].isEmpty)
              ? '0.00'
              : '${nFormat.format(double.parse(coutumer_rent_area_CM[index][0]!))}');
      sheet.getRangeByName('I${indextotol + 5 - 1}').setText(
          (coutumer_electricity_CM[index].isEmpty)
              ? '0.00'
              : '${nFormat.format(double.parse(coutumer_electricity_CM[index][0]!))}');
      sheet.getRangeByName('J${indextotol + 5 - 1}').setText((coutumer_total_sum_CM[
                  index]
              .isEmpty)
          ? '${nFormat.format(double.parse(teNantModels[index].rent!) + 0.00)}'
          : '${nFormat.format(double.parse(teNantModels[index].rent!) + double.parse(coutumer_total_sum_CM[index][0]!))}');
      sheet.getRangeByName('K${indextotol + 5 - 1}').setText('-');

      sheet
          .getRangeByName('L${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (0 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('M${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (1 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('N${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (2 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('O${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (3 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('P${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (4 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('Q${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (5 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('R${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (6 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('S${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (7 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('T${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (8 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('U${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (9 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('V${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (10 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('W${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (11 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('X${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (12 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('Y${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (13 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('Z${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (14 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');

      sheet
          .getRangeByName('AA${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (15 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AB${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (16 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AC${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (17 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AD${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (18 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AE${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (19 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AF${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (20 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AG${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (21 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AH${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (22 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AI${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (23 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AJ${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (24 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AK${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (25 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AL${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (26 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AM${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (27 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AN${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (28 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AO${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (29 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
      sheet
          .getRangeByName('AP${indextotol + 5 - 1}')
          .setText((custo_TransReBillHistoryModels[index].isEmpty)
              ? '❌'
              : (30 >= custo_TransReBillHistoryModels[index].length)
                  ? '❌'
                  : '✔️');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance
          .saveFile("รายงานผู้เช่า", data, "xlsx", mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }
}
