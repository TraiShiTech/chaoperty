import 'dart:typed_data';
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

class Excgen_History_debt_Edit_Report_Report {
  static void exportExcel_History_debt_Edit_Report_Report(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Chang_Zone_People_Ser_History_debt,
      Value_Chang_Zone_People_History_debt,
      teNantModels,
      _TransBillModels) async {
    DateTime datex = DateTime.now();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    //Adding a picture
    // final ByteData bytes_image = await rootBundle.load('images/LOGO.png');
    // final Uint8List image = bytes_image.buffer
    //     .asUint8List(bytes_image.offsetInBytes, bytes_image.lengthInBytes);
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook();
    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;

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

///////////////////////////////----------------------->
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
    // sheet.getRangeByName('K1').cellStyle = globalStyle22;

    sheet.getRangeByName('A2').setText(
        (Value_Chang_Zone_People_History_debt == null)
            ? 'โซน : (กรุณาเลือกโซน)'
            : 'โซน : $Value_Chang_Zone_People_History_debt');
    sheet.getRangeByName('E1').setText('รายงานประวัติการเปลี่ยนแปลงตั้งหนี้');
    // sheet
    //     .getRangeByName('J1')
    //     .setText((zone_name == null) ? 'โซน : ทั้งหมด' : 'โซน : $zone_name');
    // sheet
    //     .getRangeByName('J1')
    //     .setText('โทรศัพท์ : ${renTalModels[0].bill_tel}');

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
    sheet.getRangeByName('J2').cellStyle = globalStyle22;
    sheet.getRangeByName('K2').cellStyle = globalStyle22;
    sheet.getRangeByName('L2').cellStyle = globalStyle22;
    sheet.getRangeByName('M2').cellStyle = globalStyle22;
    // sheet.getRangeByName('K2').cellStyle = globalStyle22;
    // sheet.getRangeByName('A2').setText('${renTalModels[0].bill_addr}');
    // sheet.getRangeByName('J2').setText('อีเมล : ${renTalModels[0].bill_email}');

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
    sheet.getRangeByName('N3').cellStyle = globalStyle22;
    // sheet.getRangeByName('K3').cellStyle = globalStyle22;

    sheet
        .getRangeByName('I2')
        .setText('ข้อมูล ณ วันที่ : $thaiDate ${DateTime.now().year + 543}');

    globalStyle2.hAlign = x.HAlignType.center;
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
    // sheet.getRangeByName('N4').cellStyle = globalStyle1;

    sheet.getRangeByName('A4').columnWidth = 18;
    sheet.getRangeByName('B4').columnWidth = 18;
    sheet.getRangeByName('C4').columnWidth = 18;
    sheet.getRangeByName('D4').columnWidth = 18;
    sheet.getRangeByName('E4').columnWidth = 18;
    sheet.getRangeByName('F4').columnWidth = 18;
    sheet.getRangeByName('G4').columnWidth = 18;
    sheet.getRangeByName('H4').columnWidth = 18;
    sheet.getRangeByName('I4').columnWidth = 18;
    sheet.getRangeByName('J4').columnWidth = 28;
    sheet.getRangeByName('K4').columnWidth = 40;
    sheet.getRangeByName('L4').columnWidth = 40;
    sheet.getRangeByName('M4').columnWidth = 40;

    sheet.getRangeByName('A4').setText('ลำดับ');
    sheet.getRangeByName('B4').setText('เลขที่สัญญา/เสนอราคา');
    sheet.getRangeByName('C4').setText('ชื่อผู้ติดต่อ');
    sheet.getRangeByName('D4').setText('โซนพื้นที่');
    sheet.getRangeByName('E4').setText('รหัสพื้นที่');
    sheet.getRangeByName('F4').setText('สถานะ');

    sheet.getRangeByName('G4').setText('เลขตั้งหนี้');
    sheet.getRangeByName('H4').setText('กำหนดชำระ');
    sheet.getRangeByName('I4').setText('รายการ');
    sheet.getRangeByName('J4').setText('VAT');
    sheet.getRangeByName('K4').setText('VAT %');
    sheet.getRangeByName('L4').setText('WHT %');
    sheet.getRangeByName('M4').setText('ยอด');
    // sheet.getRangeByName('N4').setText('รูปแผนผัง');
    int indextotol = 0;
    int indextotol_ = 0;
    for (int index1 = 0; index1 < teNantModels.length; index1++) {
      var index = indextotol;
      dynamic numberColor = index1 % 2 == 0 ? globalStyle22 : globalStyle222;

      ///---------------------------------------------------------->contractPhotoModels

      // sheet.getRangeByName('N${i + 5}').cellStyle = numberColor;
      for (int index2 = 0; index2 < _TransBillModels[index1].length; index2++) {
        sheet.getRangeByName('A${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('B${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('C${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('D${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('E${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('F${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('G${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('H${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('I${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('J${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('K${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('L${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('M${index1 + 5}').cellStyle = numberColor;
        sheet.getRangeByName('A${indextotol + 5}').setText(
              '${index1 + 1}',
            );
        sheet.getRangeByName('B${indextotol + 5}').setText(
              teNantModels[index1].docno == null
                  ? teNantModels[index1].cid == null
                      ? ''
                      : '${teNantModels[index1].cid}'
                  : '${teNantModels[index1].docno}',
            );
        sheet.getRangeByName('C${indextotol + 5}').setText(
              teNantModels[index1].cname == null
                  ? teNantModels[index1].cname_q == null
                      ? ''
                      : '${teNantModels[index1].cname_q}'
                  : '${teNantModels[index1].cname}',
            );
        sheet.getRangeByName('D${indextotol + 5}').setText(
              '${teNantModels[index1].zn}',
            );
        sheet.getRangeByName('E${indextotol + 5}').setText(
              teNantModels[index1].ln_c == null
                  ? teNantModels[index1].ln_q == null
                      ? ''
                      : '${teNantModels[index1].ln_q}'
                  : '${teNantModels[index1].ln_c}',
            );
        sheet.getRangeByName('F${indextotol + 5}').setText(teNantModels[index1]
                    .quantity ==
                '1'
            ? datex.isAfter(DateTime.parse(
                            '${teNantModels[index1].ldate} 00:00:00.000')
                        .subtract(const Duration(days: 0))) ==
                    true
                ? 'หมดสัญญา'
                : datex.isAfter(DateTime.parse(
                                '${teNantModels[index1].ldate} 00:00:00.000')
                            .subtract(const Duration(days: 30))) ==
                        true
                    ? 'ใกล้หมดสัญญา'
                    : 'เช่าอยู่'
            : teNantModels[index1].quantity == '2'
                ? 'เสนอราคา'
                : teNantModels[index1].quantity == '3'
                    ? 'เสนอราคา(มัดจำ)'
                    : 'ว่าง');

        sheet.getRangeByName('G${indextotol + 5}').setText(
              '${_TransBillModels[index1][index2].docno} ',
            );

        sheet.getRangeByName('H${indextotol + 5}').setText(
              '${DateFormat('dd-MM').format(DateTime.parse('${_TransBillModels[index1][index2].date} 00:00:00'))}-${DateTime.parse('${_TransBillModels[index1][index2].date} 00:00:00').year + 543}',
            );
        sheet.getRangeByName('I${indextotol + 5}').setText(
            _TransBillModels[index1][index2].descr == null
                ? '${_TransBillModels[index1][index2].expname}'
                : '${_TransBillModels[index1][index2].descr}');
        sheet.getRangeByName('J${indextotol + 5}').setText(
              '${_TransBillModels[index1][index2].vtype}',
            );
        sheet.getRangeByName('K${indextotol + 5}').setText(
              '${_TransBillModels[index1][index2].nvat}',
            );
        sheet.getRangeByName('L${indextotol + 5}').setText(
              '${_TransBillModels[index1][index2].nwht}',
            );
        sheet.getRangeByName('M${indextotol + 5}').setText(
              '${_TransBillModels[index1][index2].total}',
            );
        indextotol = indextotol + 1;
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานประวัติการเปลี่ยนแปลงตั้งหนี้ (โซน ${Value_Chang_Zone_People_Ser_History_debt})",
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
//2470 / 7 = 