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

import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class Excgen_GetPakanReport_Choice {
  static void exportExcel_GetPakanReport_Choice(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      renTal_name,
      Value_Chang_Zone_Pakan,
      contractxPakanModels,
      Mon_GetPakan_Mon,
      YE_GetPakan_Mon) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    DateTime datex = DateTime.now();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.name = 'รายงานรับเงินประกันผู้เช่า';
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

    final x.Range range = sheet.getRangeByName('D1');
    range.setText(
      (Value_Chang_Zone_Pakan == null)
          ? 'รายงานรับเงินประกัน ประจำเดือน ${Mon_GetPakan_Mon} ${YE_GetPakan_Mon} (กรุณาเลือกโซน)'
          : 'รายงานรับเงินประกัน ประจำเดือน ${Mon_GetPakan_Mon} ${YE_GetPakan_Mon} (โซน : $Value_Chang_Zone_Pakan)',
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
    sheet.getRangeByName('J2').cellStyle = globalStyle22;
    sheet.getRangeByName('K2').cellStyle = globalStyle22;

    sheet.getRangeByName('L2').cellStyle = globalStyle22;
    sheet.getRangeByName('M2').cellStyle = globalStyle22;
    sheet.getRangeByName('N2').cellStyle = globalStyle22;
    // sheet.getRangeByName('G1').setText(
    //       (Mon_GetPakan_Mon == null || YE_GetPakan_Mon == null)
    //           ? 'เดือน: กรุณาเลือก'
    //           : 'เดือน: ${Mon_GetPakan_Mon}(${YE_GetPakan_Mon})',
    //     );
    // sheet.getRangeByName('G2').setText(
    //       '$day_',
    //     );

    // sheet.getRangeByName('H2').setText(' ข้อมูล ณ วันที่: ${day_}');
    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A2').cellStyle = globalStyle1;
    sheet.getRangeByName('B2').cellStyle = globalStyle1;
    sheet.getRangeByName('C2').cellStyle = globalStyle1;
    sheet.getRangeByName('D2').cellStyle = globalStyle1;
    sheet.getRangeByName('E2').cellStyle = globalStyle1;
    sheet.getRangeByName('F2').cellStyle = globalStyle1;
    sheet.getRangeByName('G2').cellStyle = globalStyle1;
    sheet.getRangeByName('H2').cellStyle = globalStyle1;
    sheet.getRangeByName('I2').cellStyle = globalStyle1;
    sheet.getRangeByName('J2').cellStyle = globalStyle1;
    sheet.getRangeByName('K2').cellStyle = globalStyle1;
    sheet.getRangeByName('L2').cellStyle = globalStyle1;
    sheet.getRangeByName('M2').cellStyle = globalStyle1;
    sheet.getRangeByName('N2').cellStyle = globalStyle1;

    sheet.getRangeByName('A2').columnWidth = 10;
    sheet.getRangeByName('B2').columnWidth = 25;
    sheet.getRangeByName('C2').columnWidth = 20;
    sheet.getRangeByName('D2').columnWidth = 15;
    sheet.getRangeByName('E2').columnWidth = 25;
    sheet.getRangeByName('F2').columnWidth = 25;
    sheet.getRangeByName('G2').columnWidth = 18;
    sheet.getRangeByName('H2').columnWidth = 30;
    sheet.getRangeByName('I2').columnWidth = 18;
    sheet.getRangeByName('J2').columnWidth = 18;
    sheet.getRangeByName('K2').columnWidth = 18;
    sheet.getRangeByName('L2').columnWidth = 25;
    sheet.getRangeByName('M2').columnWidth = 18;
    sheet.getRangeByName('N2').columnWidth = 20;

    sheet.getRangeByName('A2').setText('ลำดับ');
    sheet.getRangeByName('B2').setText('เลขที่ใบเสร็จเงินประกัน');
    sheet.getRangeByName('C2').setText('เลขที่สัญญา');
    sheet.getRangeByName('D2').setText('รหัสสาขา');
    sheet.getRangeByName('E2').setText('ชื่อสาขา');
    sheet.getRangeByName('F2').setText('ล็อค');

    sheet.getRangeByName('G2').setText('บัตรประชาชน');
    sheet.getRangeByName('H2').setText('ชื่อผู้เช่า');
    sheet.getRangeByName('I2').setText('รายละเอียดสินค้า');

    sheet.getRangeByName('J2').setText('เงินประกัน');
    sheet.getRangeByName('K2').setText('เริ่มสัญญา');
    sheet.getRangeByName('L2').setText('สิ้นสุดสัญญา  ตามสัญญา');
    sheet.getRangeByName('M2').setText('เดือน');
    sheet.getRangeByName('N2').setText('วันที่ชำระเงินประกันล่าสุด');

    int index1 = 0;
    int indextotol = 0;
    List cid_number = [];
    for (int index = 0; index < contractxPakanModels.length; index++) {
      // // dynamic numberColor = (0 * teNantModels.length + index) % 2 == 0
      // //     ? globalStyle22
      // //     : globalStyle222;

      // // String newCid = '${teNantModels[index].cid}';
      // if (!cid_number.contains(newCid)) {
      //   indextotol = indextotol + 1;
      //   cid_number.add(newCid);
      // } else {
      //   // The value already exists in cid_number, handle it as needed.
      // }
      dynamic numberColor = ((index % 2) == 0) ? globalStyle22 : globalStyle222;

      sheet.getRangeByName('A${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('B${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('C${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('D${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('E${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('F${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('G${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('H${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('I${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('J${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('K${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('L${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('M${index + 3}').cellStyle = numberColor;
      sheet.getRangeByName('N${index + 3}').cellStyle = numberColor;

      sheet.getRangeByName('A${index + 3}').setText('${index + 1}');
      sheet.getRangeByName('B${index + 3}').setText(
            (contractxPakanModels[index].doctax == null ||
                    contractxPakanModels[index].doctax.toString() == '')
                ? '${contractxPakanModels[index].docno}'
                : '${contractxPakanModels[index].doctax}',
          );
      sheet
          .getRangeByName('C${index + 3}')
          .setText('${contractxPakanModels[index].cid}');

      sheet.getRangeByName('D${index + 3}').setText(
            (contractxPakanModels[index].zser != null)
                ? '${contractxPakanModels[index].zser}'
                : '${contractxPakanModels[index].zser1}',
          );

      sheet.getRangeByName('E${index + 3}').setText(
          (contractxPakanModels[index].zn != null)
              ? '${contractxPakanModels[index].zn}'
              : '${contractxPakanModels[index].zn1}');

      sheet.getRangeByName('F${index + 3}').setText(
            '${contractxPakanModels[index].ln}',
          );

      sheet.getRangeByName('G${index + 3}').setText(
            '${contractxPakanModels[index].tax}',
          );

      sheet.getRangeByName('H${index + 3}').setText(
            (contractxPakanModels[index].cname == null)
                ? '${contractxPakanModels[index].remark}'
                : '${contractxPakanModels[index].cname}',
          );
      sheet.getRangeByName('I${index + 3}').setText(
            '${contractxPakanModels[index].stype}',
          );

      sheet.getRangeByName('J${index + 3}').setNumber(
            (contractxPakanModels[index].total == null)
                ? 0.00
                : double.parse('${contractxPakanModels[index].total}'),
          );

      sheet.getRangeByName('K${index + 3}').setText(
            '${contractxPakanModels[index].sdate}',
          );
      sheet.getRangeByName('L${index + 3}').setText(
            '${contractxPakanModels[index].ldate}',
          );
      sheet.getRangeByName('M${index + 3}').setText(
            '${contractxPakanModels[index].datex}',
          );
      sheet.getRangeByName('N${index + 3}').setText(
            '${contractxPakanModels[index].max_date}',
          );
      indextotol = indextotol + 1;
    }
/////////---------------------------->
    sheet.getRangeByName('I${indextotol + 3 + 0}').setText('รวมทั้งหมด: ');
    sheet
        .getRangeByName('J${indextotol + 3 + 0}')
        .setFormula('=SUM(J3:J${indextotol + 3 - 1})');
    sheet.getRangeByName('I${indextotol + 3 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('J${indextotol + 3 + 0}').cellStyle = globalStyle7;

/////////---------------------------->
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    String path = await FileSaver.instance.saveFile(
        (Value_Chang_Zone_Pakan == null)
            ? 'รายงานรับเงินประกัน ประจำเดือน ${Mon_GetPakan_Mon} ${YE_GetPakan_Mon} (กรุณาเลือกโซน)'
            : 'รายงานรับเงินประกัน ประจำเดือน ${Mon_GetPakan_Mon} ${YE_GetPakan_Mon} (โซน : $Value_Chang_Zone_Pakan)',
        data,
        "xlsx",
        mimeType: type);
    log(path);
    cid_number.clear();
    // if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
    //   String path = await FileSaver.instance.saveFile(
    //       "ผู้เช่า(${Status[Status_ - 1]})(ณ วันที่${day_})", data, "xlsx",
    //       mimeType: type);
    //   log(path);
    // } else {
    //   String path = await FileSaver.instance
    //       .saveFile("$NameFile_", data, "xlsx", mimeType: type);
    //   log(path);
    // }
  }
}
