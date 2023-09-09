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

class Excgen_Historybills_Cancel_Report {
  static void exportExcel_Historybills_Cancel_Report(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      renTal_name,
      _TransReBillModels_cancel,
      Value_selectDate_Historybills,
      Value_Chang_Zone_historybill) async {
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

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
    range.setText(
        'รายงานประวัติบิล(ยกเลิก) (โซน : $Value_Chang_Zone_historybill)');
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
    sheet.getRangeByName('A2').setText('${renTal_name}');

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
    sheet.getRangeByName('J2').setText(
          'วันที่ : ${Value_selectDate_Historybills}',
        );
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
    sheet.getRangeByName('A4').columnWidth = 10;
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

    sheet.getRangeByName('A4').setText('เลขที่สัญญา');
    sheet.getRangeByName('B4').setText('วันที้ทำรายการ');
    sheet.getRangeByName('C4').setText('วันที่รับชำระ');
    sheet.getRangeByName('D4').setText('เลขที่ใบเสร็จ');
    sheet.getRangeByName('E4').setText('เลขที่ใบวางบิล');

    sheet.getRangeByName('F4').setText('โซน');
    sheet.getRangeByName('G4').setText('รหัสพื้นที่');
    sheet.getRangeByName('H4').setText('ชื่อร้านค้า');
    sheet.getRangeByName('I4').setText('จำนวนเงิน');
    sheet.getRangeByName('J4').setText('กำหนดชำระ');
    sheet.getRangeByName('K4').setText('สถานะ');
    sheet.getRangeByName('L4').setText('เหตุผล');
    int index1 = 0;
    for (int index = 0; index < _TransReBillModels_cancel.length; index++) {
      dynamic numberColor =
          (0 * _TransReBillModels_cancel.length + index) % 2 == 0
              ? globalStyle22
              : globalStyle222;
      sheet.getRangeByName('A${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('B${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('C${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('D${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('E${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('F${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('G${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('H${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('I${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('J${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('K${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('L${index + 5}').cellStyle = numberColor;

      sheet.getRangeByName('A${index + 5}').setText(
            '${_TransReBillModels_cancel[index].cid}',
          );
      sheet.getRangeByName('B${index + 5}').setText(
            (_TransReBillModels_cancel[index].daterec == null)
                ? ''
                : '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels_cancel[index].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${_TransReBillModels_cancel[index].daterec}'))}') + 543}',
          );
      sheet.getRangeByName('C${index + 5}').setText(
            (_TransReBillModels_cancel[index].pdate == null)
                ? ''
                : '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels_cancel[index].pdate} 00:00:00'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${_TransReBillModels_cancel[index].pdate} 00:00:00'))}') + 543}',
          );
      sheet.getRangeByName('D${index + 5}').setText(
            _TransReBillModels_cancel[index].doctax == ''
                ? '${_TransReBillModels_cancel[index].docno}'
                : '${_TransReBillModels_cancel[index].doctax}',
          );
      sheet.getRangeByName('E${index + 5}').setText(
            '${_TransReBillModels_cancel[index].inv}',
          );

      sheet.getRangeByName('F${index + 5}').setText(
            _TransReBillModels_cancel[index].zn == null
                ? '${_TransReBillModels_cancel[index].room_number}'
                : '${_TransReBillModels_cancel[index].zn}',
          );

      sheet.getRangeByName('G${index + 5}').setText(
            _TransReBillModels_cancel[index].ln == null
                ? '${_TransReBillModels_cancel[index].room_number}'
                : '${_TransReBillModels_cancel[index].ln}',
          );

      sheet.getRangeByName('H${index + 5}').setText(
            _TransReBillModels_cancel[index].sname == null
                ? '${_TransReBillModels_cancel[index].remark}'
                : '${_TransReBillModels_cancel[index].sname}',
          );

      sheet.getRangeByName('I${index + 5}').setNumber(
            _TransReBillModels_cancel[index].total_dis == null
                ? (_TransReBillModels_cancel[index].total_bill == null)
                    ? 0.00
                    : double.parse(
                        '${_TransReBillModels_cancel[index].total_bill}')
                : double.parse('${_TransReBillModels_cancel[index].total_dis}'),
          );

      sheet.getRangeByName('J${index + 5}').setText(
            (_TransReBillModels_cancel[index].date == null)
                ? ''
                : '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels_cancel[index].date}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${_TransReBillModels_cancel[index].date}'))}') + 543}',
          );
      sheet.getRangeByName('K${index + 5}').setText(
            'ยกเลิก',
          );
      sheet.getRangeByName('L${index + 5}').setText(
            '${_TransReBillModels_cancel[index].remark}',
          );
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    String path = await FileSaver.instance.saveFile(
        "รายงานประวัติบิล(ยกเลิก) (โซน : $Value_Chang_Zone_historybill)",
        data,
        "xlsx",
        mimeType: type);
    log(path);
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
