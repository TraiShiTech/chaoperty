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

class Excgen_BankmovemenReport_cm {
  static void exportExcel_BankmovemenReport_cm(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Report,
      _TransReBillModels_Bankmovemen,
      TransReBillModels_Bankmovemen,
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

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
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
    sheet.getRangeByName('L1').cellStyle = globalStyle;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานรายรับ');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('B2').cellStyle = globalStyle2;
    sheet.getRangeByName('C2').cellStyle = globalStyle2;
    sheet.getRangeByName('D2').cellStyle = globalStyle2;
    sheet.getRangeByName('E2').cellStyle = globalStyle2;
    sheet.getRangeByName('F2').cellStyle = globalStyle2;
    sheet.getRangeByName('G2').cellStyle = globalStyle2;
    sheet.getRangeByName('H2').cellStyle = globalStyle2;
    sheet.getRangeByName('I2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').cellStyle = globalStyle2;
    sheet.getRangeByName('L2').cellStyle = globalStyle2;
    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('K2').setText('ณ วันที่: ${sDate}-${lDate}');

    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('K2').cellStyle = globalStyle2;
    sheet.getRangeByName('A3').cellStyle = globalStyle2;
    sheet.getRangeByName('B3').cellStyle = globalStyle2;
    sheet.getRangeByName('C3').cellStyle = globalStyle2;
    sheet.getRangeByName('D3').cellStyle = globalStyle2;
    sheet.getRangeByName('E3').cellStyle = globalStyle2;
    sheet.getRangeByName('F3').cellStyle = globalStyle2;
    sheet.getRangeByName('G3').cellStyle = globalStyle2;
    sheet.getRangeByName('H3').cellStyle = globalStyle2;
    sheet.getRangeByName('I3').cellStyle = globalStyle2;
    sheet.getRangeByName('J3').cellStyle = globalStyle2;
    sheet.getRangeByName('K3').cellStyle = globalStyle2;
    sheet.getRangeByName('L3').cellStyle = globalStyle2;

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

    sheet.getRangeByName('A3').setText('เลขที่');
    sheet.getRangeByName('B3').setText('ลำดับ');
    sheet.getRangeByName('C3').setText('วันที่');
    sheet.getRangeByName('D3').setText('รูปแบบชำระ');
    sheet.getRangeByName('E3').setText('รายการ');
    sheet.getRangeByName('F3').setText('ร้าน');
    sheet.getRangeByName('G3').setText('Vat%');
    sheet.getRangeByName('H3').setText('VAT');
    sheet.getRangeByName('I3').setText('70%');
    sheet.getRangeByName('J3').setText('30%');
    sheet.getRangeByName('K3').setText('ราคาก่อน Vat');
    sheet.getRangeByName('L3').setText('ราคาราม Vat');

    int indextotol = 0;
    for (var i1 = 0; i1 < _TransReBillModels_Bankmovemen.length; i1++) {
      if (_TransReBillModels_Bankmovemen[i1].doctax == '') {
        print(_TransReBillModels_Bankmovemen[i1].docno);
      } else {
        print(_TransReBillModels_Bankmovemen[i1].doctax);
      }
      for (var i2 = 0; i2 < TransReBillModels_Bankmovemen[i1].length; i2++) {
        // if (i1 == 0) {
        //   indextotol = indextotol + 0;
        // } else {
        //   indextotol = indextotol + 1;
        // }
        indextotol = indextotol + 1;
        print('${TransReBillModels_Bankmovemen[i1][i2].expname}');
        print('${indextotol}');

        sheet.getRangeByName('A${indextotol + 4 - 1}').setText(
            TransReBillModels_Bankmovemen[i1][i2].doctax == ''
                ? ' ${TransReBillModels_Bankmovemen[i1][i2].docno}'
                : '${TransReBillModels_Bankmovemen[i1][i2].doctax}');

        sheet.getRangeByName('B${indextotol + 4 - 1}').setText('${i2 + 1}');

        sheet
            .getRangeByName('C${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].date}');
        sheet
            .getRangeByName('D${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].type}');
        sheet
            .getRangeByName('E${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].expname}');

        sheet.getRangeByName('F${indextotol + 4 - 1}').setText(
            (TransReBillModels_Bankmovemen[i1][i2].sname == null)
                ? '${TransReBillModels_Bankmovemen[i1][i2].remark}'
                : '${TransReBillModels_Bankmovemen[i1][i2].sname}');

        sheet
            .getRangeByName('G${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].nvat}');

        sheet
            .getRangeByName('H${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].vat}');
        sheet
            .getRangeByName('I${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].ramt}');
        sheet
            .getRangeByName('J${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].ramtd}');
        sheet
            .getRangeByName('K${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].amt}');
        sheet
            .getRangeByName('L${indextotol + 4 - 1}')
            .setText('${TransReBillModels_Bankmovemen[i1][i2].total}');
      }
      print('-------------------------');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานการเคลื่อนไหวธนาคาร(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
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
