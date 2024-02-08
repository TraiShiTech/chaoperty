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

class Excgen_PeopleChoReport {
  static void exportExcel_PeopleChoReport(
      expModels,
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      zone_name,
      Status_pe,
      teNantModels,
      contractPhotoModels,
      quotxSelectModels) async {
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

    List<String> columns = [];

// Add column names from A to Z
    for (int i = 0; i < 26; i++) {
      columns.add(String.fromCharCode(65 + i)); // A-Z
    }

// Add column names from A to Z followed by A to Z (AA to AZ)
    for (int i = 0; i < 26; i++) {
      for (int j = 0; j < 26; j++) {
        columns.add(String.fromCharCode(65 + i) +
            String.fromCharCode(65 + j)); // A-Z followed by A-Z (AA-AZ)
      }
    }

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
    sheet.getRangeByName('L1').cellStyle = globalStyle22;
    sheet.getRangeByName('M1').cellStyle = globalStyle22;
    sheet.getRangeByName('N1').cellStyle = globalStyle22;
    sheet.getRangeByName('K1').cellStyle = globalStyle22;

    sheet.getRangeByName('A2').setText('ผู้เช่า : ${Status_pe}');
    sheet
        .getRangeByName('E1')
        .setText('รายงาน ข้อมูลผู้เช่า (โซน : $zone_name)');
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
    sheet.getRangeByName('L2').cellStyle = globalStyle22;
    sheet.getRangeByName('M2').cellStyle = globalStyle22;
    sheet.getRangeByName('N2').cellStyle = globalStyle22;
    sheet.getRangeByName('K2').cellStyle = globalStyle22;
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
    sheet.getRangeByName('L3').cellStyle = globalStyle22;
    sheet.getRangeByName('M3').cellStyle = globalStyle22;
    sheet.getRangeByName('N3').cellStyle = globalStyle22;
    sheet.getRangeByName('K3').cellStyle = globalStyle22;

    sheet
        .getRangeByName('L2')
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
    sheet.getRangeByName('k4').cellStyle = globalStyle1;
    sheet.getRangeByName('L4').cellStyle = globalStyle1;
    sheet.getRangeByName('M4').cellStyle = globalStyle1;
    sheet.getRangeByName('N4').cellStyle = globalStyle1;

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
    sheet.getRangeByName('L4').columnWidth = 40;
    sheet.getRangeByName('M4').columnWidth = 40;
    sheet.getRangeByName('N4').columnWidth = 40;

    sheet.getRangeByName('A4').setText('ลำดับ');
    sheet.getRangeByName('B4').setText('เลขที่สัญญา/เสนอราคา');
    sheet.getRangeByName('C4').setText('ชื่อผู้ติดต่อ');
    sheet.getRangeByName('D4').setText('ชื่อร้านค้า');
    sheet.getRangeByName('E4').setText('โซนพื้นที่');
    sheet.getRangeByName('F4').setText('รหัสพื้นที่');
    sheet.getRangeByName('G4').setText('ขนาดพื้นที่(ต.ร.ม.)');
    sheet.getRangeByName('H4').setText('ระยะเวลาการเช่า');
    sheet.getRangeByName('I4').setText('วันเริ่มสัญญา');
    sheet.getRangeByName('J4').setText('วันสิ้นสุดสัญญา');
    sheet.getRangeByName('K4').setText('สถานะ');
    sheet.getRangeByName('L4').setText('รูปผู้เช่า');
    sheet.getRangeByName('M4').setText('รูปร้านค้า');
    sheet.getRangeByName('N4').setText('รูปแผนผัง');
    for (int i = 0; i < expModels.length; i++) {
      sheet.getRangeByName('${columns[14 + i]}4').cellStyle = globalStyle1;
      sheet.getRangeByName('${columns[14 + i]}4').columnWidth = 35;
      sheet
          .getRangeByName('${columns[14 + i]}4')
          .setText('${expModels[i].expname}');

      if (i + 1 == expModels.length) {
        sheet.getRangeByName('${columns[14 + i + 1]}4').cellStyle =
            globalStyle1;
        sheet.getRangeByName('${columns[14 + i + 1]}4').columnWidth = 35;
        sheet.getRangeByName('${columns[14 + i + 1]}4').setText('อื่นๆ');
      }
    }
    int indextotol = 0;
    int indextotol_ = 0;
    for (int i = 0; i < teNantModels.length; i++) {
      var index = indextotol;
      dynamic numberColor = i % 2 == 0 ? globalStyle22 : globalStyle222;

      indextotol = indextotol + 1;

      ///---------------------------------------------------------->contractPhotoModels
      sheet.getRangeByName('A${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('B${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('C${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('D${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('E${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('F${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('G${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('H${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('I${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('J${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('K${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('L${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('M${i + 5}').cellStyle = numberColor;
      sheet.getRangeByName('N${i + 5}').cellStyle = numberColor;

      sheet.getRangeByName('A${i + 5}').setText(
            '${i + 1}',
          );
      sheet.getRangeByName('B${i + 5}').setText(
            teNantModels[i].docno == null
                ? teNantModels[i].cid == null
                    ? ''
                    : '${teNantModels[i].cid}'
                : '${teNantModels[i].docno}',
          );
      sheet.getRangeByName('C${i + 5}').setText(
            teNantModels[i].cname == null
                ? teNantModels[i].cname_q == null
                    ? ''
                    : '${teNantModels[i].cname_q}'
                : '${teNantModels[i].cname}',
          );
      sheet.getRangeByName('D${i + 5}').setText(
            teNantModels[i].sname == null
                ? teNantModels[i].sname_q == null
                    ? ''
                    : '${teNantModels[i].sname_q}'
                : '${teNantModels[i].sname}',
          );
      sheet.getRangeByName('E${i + 5}').setText(
            '${teNantModels[index].zn}',
          );
      sheet.getRangeByName('F${i + 5}').setText(
            teNantModels[i].ln_c == null
                ? teNantModels[i].ln_q == null
                    ? ''
                    : '${teNantModels[i].ln_q}'
                : '${teNantModels[i].ln_c}',
          );
      sheet.getRangeByName('G${i + 5}').setText(
            teNantModels[i].area_c == null
                ? teNantModels[i].area_q == null
                    ? ''
                    : '${teNantModels[i].area_q}'
                : '${teNantModels[i].area_c}',
          );
      sheet.getRangeByName('H${i + 5}').setText(
            teNantModels[i].period == null
                ? teNantModels[i].period_q == null
                    ? ''
                    : '${teNantModels[i].period_q}  ${teNantModels[i].rtname_q!.substring(3)}'
                : '${teNantModels[i].period}  ${teNantModels[i].rtname!.substring(3)}',
          );
      sheet.getRangeByName('I${i + 5}').setText(
            teNantModels[i].sdate_q == null
                ? teNantModels[i].sdate == null
                    ? ''
                    : DateFormat('dd-MM-yyyy')
                        .format(
                            DateTime.parse('${teNantModels[i].sdate} 00:00:00'))
                        .toString()
                : DateFormat('dd-MM-yyyy')
                    .format(
                        DateTime.parse('${teNantModels[i].sdate_q} 00:00:00'))
                    .toString(),
          );
      sheet.getRangeByName('J${i + 5}').setText(
            teNantModels[i].ldate_q == null
                ? teNantModels[i].ldate == null
                    ? ''
                    : DateFormat('dd-MM-yyyy')
                        .format(
                            DateTime.parse('${teNantModels[i].ldate} 00:00:00'))
                        .toString()
                : DateFormat('dd-MM-yyyy')
                    .format(
                        DateTime.parse('${teNantModels[i].ldate_q} 00:00:00'))
                    .toString(),
          );
      sheet.getRangeByName('K${i + 5}').setText(
            teNantModels[i].quantity == '1'
                ? datex.isAfter(DateTime.parse(
                                '${teNantModels[i].ldate} 00:00:00.000')
                            .subtract(const Duration(days: 0))) ==
                        true
                    ? 'หมดสัญญา'
                    : datex.isAfter(DateTime.parse(
                                    '${teNantModels[i].ldate} 00:00:00.000')
                                .subtract(const Duration(days: 30))) ==
                            true
                        ? 'ใกล้หมดสัญญา'
                        : 'เช่าอยู่'
                : teNantModels[i].quantity == '2'
                    ? 'เสนอราคา'
                    : teNantModels[i].quantity == '3'
                        ? 'เสนอราคา(มัดจำ)'
                        : 'ว่าง',
          );

      sheet
          .getRangeByName('L${i + 5}')
          .setText('${contractPhotoModels[i].pic_tenant}');
      sheet
          .getRangeByName('M${i + 5}')
          .setText('${contractPhotoModels[i].pic_shop}');
      sheet
          .getRangeByName('N${i + 5}')
          .setText('${contractPhotoModels[i].pic_plan}');

      for (int index3 = 0; index3 < expModels.length; index3++) {
        sheet.getRangeByName('${columns[14 + index3]}${i + 5}').cellStyle =
            numberColor;
        for (int index4 = 0; index4 < quotxSelectModels[i].length; index4++) {
          (expModels[index3].ser != quotxSelectModels[i][index4].expser)
              ? null
              : sheet.getRangeByName('${columns[14 + index3]}${i + 5}').setText(
                  '${quotxSelectModels[i][index4].expname} / ${quotxSelectModels[i][index4].unit} ${quotxSelectModels[i][index4].term} (งวด)');
        }
      }
      for (int index5 = 0; index5 < quotxSelectModels[i].length; index5++) {
        ('0' != quotxSelectModels[i][index5].expser)
            ? null
            : sheet
                .getRangeByName(
                    '${columns[14 + int.parse('${expModels.length}')]}${i + 5}')
                .setText(
                    '${quotxSelectModels[i][index5].expname}/ ${quotxSelectModels[i][index5].unit} ${quotxSelectModels[i][index5].term} (งวด)');
      }
      sheet
          .getRangeByName(
              '${columns[14 + int.parse('${expModels.length}')]}${i + 5}')
          .cellStyle = numberColor;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "ผู้เช่า(${Status_pe}โซน$zone_name)(ณ วันที่${day_})", data, "xlsx",
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