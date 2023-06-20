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

class Excgen_IncomeReport_cm {
  static void exportExcel_IncomeReport_cm(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Report,
      _TransReBillModels_Income,
      TransReBillModels_Income,
      renTal_name,
      sDate,
      lDate) async {
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
    globalStyle22.hAlign = x.HAlignType.center;

    x.Style globalStyle222 = workbook.styles.add('style222');
    globalStyle222.backColorRgb = Color(0xC7E1E2E6);
    globalStyle222.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle222.fontSize = 12;
    globalStyle222.hAlign = x.HAlignType.center;

    x.Style globalStyle7 = workbook.styles.add('style7');
    globalStyle7.backColorRgb = Color(0xFFD4E6A3);
    globalStyle7.fontName = 'Angsana New';
    globalStyle7.numberFormat = '_(\* #,##0.00_)';
    globalStyle7.hAlign = x.HAlignType.center;
    globalStyle7.fontSize = 15;
    globalStyle7.bold = true;
    globalStyle7.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle77 = workbook.styles.add('style77');
    globalStyle7.backColorRgb = Color(0xFFD4E6A3);
    globalStyle77.fontName = 'Angsana New';
    globalStyle77.numberFormat = '_(\* #,##0.00_)';
    globalStyle77.hAlign = x.HAlignType.center;
    globalStyle77.fontSize = 15;
    globalStyle77.bold = true;
    globalStyle77.fontColorRgb = Color(0xFFC52611);

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
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานรายรับ');
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
    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('K2').setText('ณ วันที่: ${sDate}-${lDate}');

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

    sheet.getRangeByName('A4').columnWidth = 18;
    sheet.getRangeByName('B4').columnWidth = 18;
    sheet.getRangeByName('C4').columnWidth = 18;
    sheet.getRangeByName('D4').columnWidth = 18;
    sheet.getRangeByName('E4').columnWidth = 18;
    sheet.getRangeByName('F4').columnWidth = 18;
    sheet.getRangeByName('G4').columnWidth = 18;
    sheet.getRangeByName('H4').columnWidth = 18;
    sheet.getRangeByName('I4').columnWidth = 18;
    sheet.getRangeByName('J4').columnWidth = 18;
    sheet.getRangeByName('K4').columnWidth = 18;
    sheet.getRangeByName('L4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('เลขที่');
    sheet.getRangeByName('B4').setText('ลำดับ');
    sheet.getRangeByName('C4').setText('วันที่');
    sheet.getRangeByName('D4').setText('รูปแบบชำระ');
    sheet.getRangeByName('E4').setText('รายการ');
    sheet.getRangeByName('F4').setText('ร้าน');
    sheet.getRangeByName('G4').setText('Vat%');
    sheet.getRangeByName('H4').setText('VAT');
    sheet.getRangeByName('I4').setText('70%');
    sheet.getRangeByName('J4').setText('30%');
    sheet.getRangeByName('K4').setText('ราคาก่อน Vat');
    sheet.getRangeByName('L4').setText('ราคาราม Vat');

    int indextotol = 0;
    int indextotol_ = 0;
    for (var i1 = 0; i1 < _TransReBillModels_Income.length; i1++) {
      for (var i2 = 0; i2 < TransReBillModels_Income[i1].length; i2++) {
        var index = indextotol;
        dynamic numberColor = index % 2 == 0 ? globalStyle22 : globalStyle222;

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
        sheet.getRangeByName('L${indextotol + 5 - 1}').cellStyle = numberColor;

        sheet.getRangeByName('A${indextotol + 5 - 1}').setText(
            TransReBillModels_Income[i1][i2].doctax == ''
                ? ' ${TransReBillModels_Income[i1][i2].docno}'
                : '${TransReBillModels_Income[i1][i2].doctax}');

        sheet.getRangeByName('B${indextotol + 5 - 1}').setText('${i2 + 1}');

        sheet
            .getRangeByName('C${indextotol + 5 - 1}')
            .setText('${TransReBillModels_Income[i1][i2].date}');
        sheet
            .getRangeByName('D${indextotol + 5 - 1}')
            .setText('${TransReBillModels_Income[i1][i2].type}');
        sheet
            .getRangeByName('E${indextotol + 5 - 1}')
            .setText('${TransReBillModels_Income[i1][i2].expname}');

        sheet.getRangeByName('F${indextotol + 5 - 1}').setText(
            (TransReBillModels_Income[i1][i2].sname == null)
                ? '${TransReBillModels_Income[i1][i2].remark}'
                : '${TransReBillModels_Income[i1][i2].sname}');

        sheet.getRangeByName('G${indextotol + 5 - 1}').setNumber(
            double.parse('${TransReBillModels_Income[i1][i2].nvat}'));

        sheet
            .getRangeByName('H${indextotol + 5 - 1}')
            .setNumber(double.parse('${TransReBillModels_Income[i1][i2].vat}'));
        sheet.getRangeByName('I${indextotol + 5 - 1}').setNumber(
            double.parse('${TransReBillModels_Income[i1][i2].ramt}'));
        sheet.getRangeByName('J${indextotol + 5 - 1}').setNumber(
            double.parse('${TransReBillModels_Income[i1][i2].ramtd}'));
        sheet
            .getRangeByName('K${indextotol + 5 - 1}')
            .setNumber(double.parse('${TransReBillModels_Income[i1][i2].amt}'));
        sheet.getRangeByName('L${indextotol + 5 - 1}').setNumber(
            double.parse('${TransReBillModels_Income[i1][i2].total}'));
      }
      print('-------------------------');
    }
    sheet.getRangeByName('F${indextotol + 5 + 0}').setText('รวม : ');

    sheet
        .getRangeByName('G${indextotol + 5 + 0}')
        .setFormula('=SUM(G5:G${indextotol + 5 - 1})');

    sheet
        .getRangeByName('H${indextotol + 5 + 0}')
        .setFormula('=SUM(H5:H${indextotol + 5 - 1})');
    sheet
        .getRangeByName('I${indextotol + 5 + 0}')
        .setFormula('=SUM(I5:I${indextotol + 5 - 1})');
    sheet
        .getRangeByName('J${indextotol + 5 + 0}')
        .setFormula('=SUM(J5:J${indextotol + 5 - 1})');
    sheet
        .getRangeByName('K${indextotol + 5 + 0}')
        .setFormula('=SUM(K5:K${indextotol + 5 - 1})');
    sheet
        .getRangeByName('L${indextotol + 5 + 0}')
        .setFormula('=SUM(L5:L${indextotol + 5 - 1})');

    sheet.getRangeByName('F${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('G${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('H${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('I${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('J${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('K${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('L${indextotol + 5 + 0}').cellStyle = globalStyle7;

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance
          .saveFile("รายงานรายรับ", data, "xlsx", mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }
}
