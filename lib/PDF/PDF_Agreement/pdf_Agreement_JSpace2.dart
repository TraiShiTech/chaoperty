import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../PeopleChao/Rental_Information.dart';
import '../../Style/ThaiBaht.dart';
import '../../Style/loadAndCacheImage.dart';

class Pdfgen_Agreement_JSpace2 {
//////////---------------------------------------------------->( **** เอกสารสัญญาเช่า ปกติ  J Space Sansai)

  static void exportPDF_Agreement_JSpace2(
      context,
      Get_Value_NameShop_index,
      Get_Value_cid,
      _verticalGroupValue,
      Form_nameshop,
      Form_typeshop,
      Form_bussshop,
      Form_bussscontact,
      Form_address,
      Form_tel,
      Form_email,
      Form_tax,
      Form_ln,
      Form_zn,
      Form_area,
      Form_qty,
      Form_sdate,
      Form_ldate,
      Form_period,
      Form_rtname,
      quotxSelectModels,
      _TransModels,
      renTal_name,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      tableData00,
      TitleType_Default_Receipt_Name,
      Datex_text,
      Pri1_text,
      Pri2_text,
      Pri3_text) async {
    ////
    //// ------------>(J Space Sansai)
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;
    var Colors_pd2 = PdfColors.grey;
    final ttf = pw.Font.ttf(font);
    double font_Size = 12.5;
    DateTime date = DateTime.now();
    // var formatter = DateFormat('MMMMd', 'th');
    String thaiDate = DateFormat('d เดือน MMM', 'th').format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    Uint8List? resizedLogo = await getResizedLogo();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int pageCount = 1; // Initialize the page count
    String? base64Image_1 = preferences.getString('base64Image1');
    // String? base64Image_2 = preferences.getString('base64Image2');
    // String? base64Image_3 = preferences.getString('base64Image3');
    // String? base64Image_4 = preferences.getString('base64Image4');
    String base64Image_new1 = (base64Image_1 == null) ? '' : base64Image_1;
    // String base64Image_new2 = (base64Image_2 == null) ? '' : base64Image_2;
    // String base64Image_new3 = (base64Image_3 == null) ? '' : base64Image_3;
    // String base64Image_new4 = (base64Image_4 == null) ? '' : base64Image_4;
    // Uint8List data1 = base64Decode(base64Image_new1);
    // Uint8List data2 = base64Decode(base64Image_new2);
    // Uint8List data3 = base64Decode(base64Image_new3);
    // Uint8List data4 = base64Decode(base64Image_new4);
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   netImage.add(await networkImage('${newValuePDFimg[i]}'));
    // }

///////////////////////------------------------------------------------->

    // pageCount++;
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 18.00,
        marginLeft: 18.00,
        marginRight: 18.00,
        marginTop: 18.00,
      ),
      header: (context) {
        return pw.Column(
          children: [
            pw.Row(
              children: [
                pw.Container(
                  height: 60,
                  width: 60,
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey200,
                    border: pw.Border.all(color: PdfColors.grey300),
                  ),
                  child: resizedLogo != null
                      ? pw.Image(
                          pw.MemoryImage(resizedLogo),
                          height: 60,
                          width: 60,
                        )
                      : pw.Center(
                          child: pw.Text(
                            '$bill_name ',
                            maxLines: 1,
                            style: pw.TextStyle(
                              fontSize: 10,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ),
                ),
                // (netImage.isEmpty)
                //     ? pw.Container(
                //         height: 72,
                //         width: 70,
                //         color: PdfColors.grey200,
                //         child: pw.Center(
                //           child: pw.Text(
                //             '$renTal_name ',
                //             maxLines: 1,
                //             style: pw.TextStyle(
                //               fontSize: 10,
                //               font: ttf,
                //               color: Colors_pd,
                //             ),
                //           ),
                //         ))

                //     // pw.Image(
                //     //     pw.MemoryImage(iconImage),
                //     //     height: 72,
                //     //     width: 70,
                //     //   )
                //     : pw.Image(
                //         (netImage[0]),
                //         height: 72,
                //         width: 70,
                //       ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Container(
                  width: 280,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '${bill_name.toString().trim()}',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        '${bill_addr.toString().trim()}',
                        maxLines: 3,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          color: Colors_pd,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Spacer(),
                pw.Container(
                  width: 180,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      if (TitleType_Default_Receipt_Name != null &&
                          TitleType_Default_Receipt_Name.toString().trim() !=
                              '')
                        pw.Text(
                          '[ $TitleType_Default_Receipt_Name ]',
                          maxLines: 1,
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey400,
                          ),
                        ),
                      // pw.Text(
                      //   'ใบเสนอราคา',
                      //   style: pw.TextStyle(
                      //     fontSize: 12.00,
                      //     fontWeight: pw.FontWeight.bold,
                      //     font: ttf,
                      //   ),
                      // ),
                      // pw.Text(
                      //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                      //   textAlign: pw.TextAlign.right,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      pw.Text(
                        'โทรศัพท์ : $bill_tel',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'อีเมล : $bill_email',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                      //   maxLines: 2,
                      //   style: pw.TextStyle(
                      //     fontSize: font_Size,
                      //     font: ttf,
                      //     color: Colors_pd,
                      //   ),
                      // ),
                      pw.Text(
                        'วันที่ทำสัญญา :${Datex_text.text}',
                        // 'วันที่ทำสัญญา :____/________/____',
                        // '${DateFormat('ณ วันที่: d เดือน MMM ปี ', 'th').format(DateTime.now())}${DateTime.now().year + 543}',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(height: 2),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
          ],
        );
      },
      build: (context) {
        return [
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'แนบท้าย.________________________________________________________________________________________   ',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  color: Colors_pd,
                  fontSize: font_Size,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5 * PdfPageFormat.mm),
          pw.Text(
            'รายละเอียดแนบท้าย:' + '_' * 746,
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(
              color: Colors_pd,
              fontSize: font_Size,
              fontWeight: pw.FontWeight.bold,
              font: ttf,
            ),
          ),
          pw.SizedBox(height: 5 * PdfPageFormat.mm),
          pw.Text(
            'อิงตามเลขที่สัญญา.________________________________________________________________________________________________________________ ',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              color: Colors_pd,
              fontSize: font_Size,
              fontWeight: pw.FontWeight.bold,
              font: ttf,
            ),
          ),
          pw.SizedBox(height: 10 * PdfPageFormat.mm),
          pw.Text(
            'แนบท้ายสัญญาเช่านี้ทำขึั้นสองฉบับมีข้อความตรงกัน คู่สัญญาได้อ่านและเข้าใจข้อความนี้โดยตลอดแล้วเห็นว่าถูกต้องตามเจตนาของคู่สัญญาทุกประการ จึงได้ลงลายมือชื่อไว้เป็นหลักฐานต่อหน้าพยาน ',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              color: Colors_pd,
              fontSize: font_Size,
              fontWeight: pw.FontWeight.bold,
              font: ttf,
            ),
          ),
          pw.SizedBox(height: 20 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              'ลงชื่อ___________________________ผู้ให้เช่า',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                color: Colors_pd,
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              '(___________________________) ',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              'วันที่____/________/____',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 5 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              'ลงชื่อ___________________________ผู้ให้เช่า',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                color: Colors_pd,
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              '(___________________________) ',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              'วันที่____/________/____',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 15 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              'ลงชื่อ___________________________ผู้เช่า',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                color: Colors_pd,
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              '(___________________________) ',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              'วันที่____/________/____',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 15 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Expanded(
              flex: 1,
              child: pw.Text(
                'ลงชื่อ___________________________พยาน',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              flex: 1,
              child: pw.Text(
                'ลงชื่อ___________________________พยาน',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Expanded(
              flex: 1,
              child: pw.Text(
                '(___________________________) ',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              flex: 1,
              child: pw.Text(
                '(___________________________) ',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ]),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Expanded(
              flex: 1,
              child: pw.Text(
                'วันที่____/________/____',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              flex: 1,
              child: pw.Text(
                'วันที่____/________/____',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ]),
        ];
      },
      // footer: (context) {
      //   return pw.Column(
      //     mainAxisSize: pw.MainAxisSize.min,
      //     children: [
      //       pw.SizedBox(height: 5 * PdfPageFormat.mm),
      //       pw.Row(
      //         // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      //         children: [
      //           pw.Expanded(
      //             flex: 1,
      //             child: pw.Text(
      //               '___________________________ผู้เช่า/The Lessee   ',
      //               textAlign: pw.TextAlign.center,
      //               style: pw.TextStyle(
      //                 fontSize: 10,
      //                 font: ttf,
      //                 color: Colors_pd,
      //                 // fontWeight: pw.FontWeight.bold
      //               ),
      //             ),
      //           ),
      //           pw.Expanded(
      //             flex: 1,
      //             child: pw.Text(
      //               '___________________________ผู้ให้เช่า/The Lessor ',
      //               textAlign: pw.TextAlign.center,
      //               style: pw.TextStyle(
      //                 fontSize: 10,
      //                 font: ttf,
      //                 color: Colors_pd,
      //                 // fontWeight: pw.FontWeight.bold
      //               ),
      //             ),
      //           ),
      //           pw.Align(
      //             alignment: pw.Alignment.bottomRight,
      //             child: pw.Text(
      //               'หน้า ${context.pageNumber} / ${context.pagesCount} ',
      //               textAlign: pw.TextAlign.left,
      //               style: pw.TextStyle(
      //                 fontSize: 10,
      //                 font: ttf,
      //                 color: Colors_pd,
      //                 // fontWeight: pw.FontWeight.bold
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   );
      // },
    ));
    // final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/name');
    // await file.writeAsBytes(bytes);
    // return file;
    // final List<int> bytes = await pdf.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    // final dir = await FileSaver.instance.saveFile(
    //     "ใบเสนอราคา(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RentalInforman_Agreement(
            doc: pdf,
            context: context,
            ////////////------------------->
            ///
            Get_Value_NameShop_index: Get_Value_NameShop_index,
            Get_Value_cid: Get_Value_cid,
            verticalGroupValue: _verticalGroupValue,
            Form_nameshop: Form_nameshop,
            Form_typeshop: Form_typeshop,
            Form_bussshop: Form_bussshop,
            Form_bussscontact: Form_bussscontact,
            Form_address: Form_address,
            Form_tel: Form_tel,
            Form_email: Form_email,
            Form_tax: Form_tax,
            Form_ln: Form_ln,
            Form_zn: Form_zn,
            Form_area: Form_area,
            Form_qty: Form_qty,
            Form_sdate: Form_sdate,
            Form_ldate: Form_ldate,
            Form_period: Form_period,
            Form_rtname: Form_rtname,
            quotxSelectModels: quotxSelectModels,
            TransModels: _TransModels,
            renTal_name: renTal_name,
            bill_addr: bill_addr,
            bill_email: bill_email,
            bill_tel: bill_tel,
            bill_tax: bill_tax,
            bill_name: bill_name,
            newValuePDFimg: newValuePDFimg,
          ),
        ));
  }
}
