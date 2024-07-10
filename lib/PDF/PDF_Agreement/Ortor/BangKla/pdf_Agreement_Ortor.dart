import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../PeopleChao/Rental_Information.dart';
import '../../../../Style/ThaiBaht.dart';

class Pdfgen_Agreement_Ortor {
//////////---------------------------------------------------->( **** เอกสารสัญญาเช่า  Ortor)

  static void exportPDF_Agreement_Ortor(
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
      _ReportValue_type_docOttor) async {
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
    int space_Size = 10;
    DateTime date = DateTime.now();
    // var formatter = DateFormat('MMMMd', 'th');
    String thaiDate = DateFormat('d เดือน MMM', 'th').format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
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
    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    // final tableData = [
    //   for (int index = 0; index < quotxSelectModels.length; index++)
    //     [
    //       '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
    //     ],
    // ];
    // double Sumtotal = 0;
    // for (int index = 0; index < quotxSelectModels.length; index++)
    //   Sumtotal = Sumtotal +
    //       (int.parse(quotxSelectModels[index].term!) *
    //           double.parse(quotxSelectModels[index].total!));
    String Howday = (Form_rtname.toString() == 'รายวัน')
        ? 'วัน'
        : (Form_rtname.toString() == 'รายเดือน')
            ? 'เดือน'
            : (Form_rtname.toString() == 'รายปี')
                ? 'ปี'
                : '$Form_rtname';
///////////////////////------------------------------------------------->
    pdf.addPage(
      pw.MultiPage(
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
                  (netImage.isEmpty)
                      ? pw.Container(
                          height: 72,
                          width: 70,
                          color: PdfColors.grey200,
                          child: pw.Center(
                            child: pw.Text(
                              '$renTal_name ',
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ))

                      // pw.Image(
                      //     pw.MemoryImage(iconImage),
                      //     height: 72,
                      //     width: 70,
                      //   )
                      : pw.Image(
                          (netImage[0]),
                          height: 72,
                          width: 70,
                        ),
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
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
            ],
          );
        },
        build: (context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'สัญญาเช่าที่ดินและสิ่งปลูกสร้าง ',
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
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ประเภท ${_ReportValue_type_docOttor} ',
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
            pw.Row(
              children: [
                pw.Spacer(),
                pw.Container(
                  width: 180,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'สัญญาเลขที่ : ${Datex_text.text}',
                        // 'ทำที่ $renTal_name ',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'วันที่ทำสัญญา ............. ',
                      //   style: pw.TextStyle(
                      //     fontSize: font_Size,
                      //     font: ttf,
                      //     color: Colors_pd,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            // pw.Text(
            //   'สัญญาเช่าฉบับนี้ทำ ณ องค์การตลาด สำนักงานตลาดสาขาบางคล้า
            //เลขที่ ๑/๒๕-๒๖ถนน ๓๐๔ ฉะเชิงเทรา กบินทร์บุรี หมู่ที่ ๓ ตำบลเสม็ดเหนือ อำเภอบางคล้า จังหวัดฉะเซิงเทรา ๒๔ด๑๐
            //เมื่อวันที่ 290966
            //ระหว่าง องค์การตลาด กระหวงมหาดไทย
            //โดยนายศิริชัย แสงศรี ผู้จัดการตลาดสาขาบางคล้า ปฏิบัติงานแทน ผู้อำนวยการองค์การตลาด ตามคำสั่งองค์การตลาด ที่ ๑๙๘/๒๕๖๕ ลงวันที่๑ หฤศจิกายน ๒๕๖๕
            //รายละเอียดปรากฏตามสำเนาคำสั่งองค์การตลาดเอกสารแนบท้ายสัญญา ซึ่งถือเป็นส่วนหนึ่งของสัญญาด้วย สำนักงานใหญ่ ตั้งอยู่เลขที่ ๕๑/๔๗ ถนนสวนผัก ซอยสวนผัก ๔ แขวงตลิ่งชันเขตตลิ่งชัน กรุงเทพมหานคร ซึ่งต่อไปในสัญญาเรียกว่า "ผู้ให้เช่า" ฝ่ายหนึ่ง',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.Row(
              children: [
                pw.Text(
                  'สัญญาเช่าฉบับนี้ทำ ณ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "ณ องค์การตลาด สำนักงานตลาดสาขาบางคล้า",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'เลขที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๑/๒๕-๒๖ถนน ๓๐๔ ฉะเชิงเทรา กบินทร์บุรี หมู่ที่ ๓ ตำบลเสม็ดเหนือ อำเภอบางคล้า จังหวัดฉะเซิงเทรา ๒๔ด๑๐",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'เมื่อวันที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "290966",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ระหว่าง ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "องค์การตลาด กระหวงมหาดไทย",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.Text(
              'โดยนายศิริชัย แสงศรี ผู้จัดการตลาดสาขาบางคล้า ปฏิบัติงานแทน ผู้อำนวยการองค์การตลาด ตามคำสั่งองค์การตลาด ที่ ๑๙๘/๒๕๖๕ ลงวันที่๑ หฤศจิกายน ๒๕๖๕ ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.Text(
              'รายละเอียดปรากฏตามสำเนาคำสั่งองค์การตลาดเอกสารแนบท้ายสัญญา ซึ่งถือเป็นส่วนหนึ่งของสัญญาด้วย สำนักงานใหญ่ ตั้งอยู่เลขที่ ๕๑/๔๗ ถนนสวนผัก ซอยสวนผัก ๔ แขวงตลิ่งชันเขตตลิ่งชัน กรุงเทพมหานคร ซึ่งต่อไปในสัญญาเรียกว่า "ผู้ให้เช่า" ฝ่ายหนึ่ง',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'กับนางสาวทัษณี รัตนพันธ์ ถือบัตรประจำตัวประชาซนเลขที่ ๓ ๘๐๑๒ 0๐๗๕๓ ๓๕ ๓
            //อยู่บ้านเลขที่ ๒๕๓ หมู่ที่ ๒ ตำบล ปากพนังฝั่งตะวันออก อำเภอ ปากพนัง จังหวัด นครศรีธรรมราช
            //รายละเอียดปรากฎตามสำเนาบัตรประจำตัวประชาชน ซึ่งถือเป็นส่วนหนึ่งของสัญญาด้วย ซึ่งต่อไปในสัญญาเรียกว่า "ผู้เช่า" อีกฝ่ายหนึ่ง โดยทั้งสองฝายได้ตกลงทำสัญญากันดังต่อไปนี้',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.Row(
              children: [
                pw.Text(
                  'กับ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "นางสาวทัษณี รัตนพันธ์",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ถือบัตรประจำตัวประชาซนเลขที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๓ ๘๐๑๒ 0๐๗๕๓ ๓๕ ๓",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'อยู่บ้านเลขที่ ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๒๕๓ หมู่ที่ ๒ ตำบล ปากพนังฝั่งตะวันออก อำเภอ ปากพนัง จังหวัด นครศรีธรรมราช",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ซึ่งถือเป็นส่วนหนึ่งของสัญญาด้วย ซึ่งต่อไปในสัญญาเรียกว่า "ผู้เช่า" อีกฝ่ายหนึ่ง โดยทั้งสองฝายได้ตกลงทำสัญญากันดังต่อไปนี้ ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'ข้อ ๑ ผู้ให้เช่าตกลงให้เช่าและผู้เช่าตกลงเช่าพื้นที่อาการพาณิชย์ ๒ ชั้น จำนวน ๑ (หนึ่ง) คูหา/แผง/อื่น ๆ หมวด ดี
            //   หมายเลข ดด รวม ๑ (หนึ่ง) คูหาแผง/อื่น ๆ คิดเป็นพื้นที่ - () ตารางเมตร
            //รวมถึงทรัพย์สินขององค์การตลาด สำนักงานตลาดสาขาบางคล้า ตั้งอยู่เลขที่ 2/๓๕ ถนน ๓๐๔ ฉะเชิงเทรากบินทร์บุรี หมู่ที่๓ ตำบลเสม็ดเหนือ อำเภอบางคล้า จังหวัดฉะเชิงเทรา ๒๔ด๑0 เพื่อใช้สำหรับอยู่อาศัย ซึ่งต่อไปในสัญญาฉบับนี้จะเรียกว่า "พื้นที่เช่า" รายละเอียดปรากฎตามเผนผังบริเวณพื้นที่เช่าเอกสารแนบท้ายสัญญาซึ่งถือเป็นส่วนหนึ่งของสัญญาตัวย โดยผู้เช่าได้รับมอบพื้นที่เข่าดังกล่าวในสภาพที่สมบูรณ์เรียบร้อยถูกต้องครบถ้วนแล้ววันทำสัญญาฉบับนี้',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ข้อ ๑ ผู้ให้เช่าตกลงให้เช่าและผู้เช่าตกลงเช่าพื้นที่อาการพาณิชย์ ๒ ชั้น จำนวน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๑ (หนึ่ง)",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'คูหา/แผง/อื่น ๆ หมวด',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "ดี ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'หมายเลข',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "ดด",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'รวม',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๑ (หนึ่ง)",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'คูหาแผง/อื่น ๆ คิดเป็นพื้นที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "- ()",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ตารางเมตร',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.Row(
              children: [
                pw.Text(
                  'รวมถึงทรัพย์สินขององค์การตลาด',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "สำนักงานตลาดสาขาบางคล้า",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.Row(
              children: [
                pw.Text(
                  'ตั้งอยู่เลขที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "2/๓๕ ถนน ๓๐๔ ฉะเชิงเทรากบินทร์บุรี หมู่ที่๓ ตำบลเสม็ดเหนือ อำเภอบางคล้า จังหวัดฉะเชิงเทรา ๒๔ด๑0 ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'เพื่อใช้สำหรับอยู่อาศัย ซึ่งต่อไปในสัญญาฉบับนี้จะเรียกว่า "พื้นที่เช่า" รายละเอียดปรากฎตามเผนผังบริเวณพื้นที่เช่าเอกสารแนบท้ายสัญญาซึ่งถือเป็นส่วนหนึ่งของสัญญาตัวย โดยผู้เช่าได้รับมอบพื้นที่เข่าดังกล่าวในสภาพที่สมบูรณ์เรียบร้อยถูกต้องครบถ้วนแล้ววันทำสัญญาฉบับนี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            // pw.Text(
            //   'ข้อ ๒ สัญญาฉบับนี้มีกำหนดระยะเวลา ๑ (หนึ่ง) ปี ๑ (หนึ่ง) เดือน นับตั้งแต่วันที่ ๑กันยายน ๒๕๖๖ จนถึงวันที่ ๓๐ กันยายน ๒๕๖๗',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ข้อ ๒ สัญญาฉบับนี้มีกำหนดระยะเวลา',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๑ (หนึ่ง) ปี ๑ (หนึ่ง) เดือน",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'นับตั้งแต่วันที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๑กันยายน ๒๕๖๖",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'จนถึงวันที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๓๐ กันยายน ๒๕๖๗",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            // pw.Text(
            //   'ข้อ ๓ ผู้เช่าต กลงชำระค่าเช่าตามข้อ ด ให้แก่ผู้ให้เช่าเป็นรายเดือนในอัตราเดือนละ ๒,๔๐๐ บาท(สองพันสื่ร้อยบาทถ้วน) โดยจะชำระทุกวันที่ ๑0(สิบ) ของเดือนด้วยวิธีการโอนเงินเข้าบัญชีธนาคารของผู้ให้เช่า หรือชำระค่าเช่า ณ สถานที่ทำการของผู้ให้เช่าหรือตามวิธีการที่ผู้ให้เช่ากำหนด',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.Row(
              children: [
                pw.Text(
                  'ข้อ ๓ ผู้เช่าตกลงชำระค่าเช่าตามข้อ ด ให้แก่ผู้ให้เช่าเป็นรายเดือนในอัตราเดือนละ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๒,๔๐๐ บาท(สองพันสื่ร้อยบาทถ้วน)",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.Row(
              children: [
                pw.Text(
                  'โดยจะชำระทุกวันที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๑0(สิบ) ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ของเดือน ด้วยวิธีการโอนเงินเข้าบัญชีธนาคารของผู้ให้เช่า หรือชำระค่าเช่า ณ สถานที่ทำการของผู้ให้เช่าหรือตามวิธีการที่ผู้ให้เช่ากำหนด',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๔ ผู้เช่าตกลงเป็นผู้รับผิดชอบภาษีที่ดินและสิ่งปลูกสร้าง, ภาษีป้าย (ถ้ามี) หรือหรือภาษีอื่นใดที่เกิดขึ้นจากการประกอบกิจการตามสัญญานี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๕ ผู้เช่าตกลงชำระต่ำาไฟฟ้ คำน้ำประปา คำส่วนกลาง ลอดจนหนี้หรือค่สาธารณูปโภคใด ๆ ที่เกิดขึ้นตามใบแจ้งหนี้ที่ผู้ให้เช่าเรียกเก็บ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'ข้อ ๖ผู้เช่าจะต้องนำงินมาชำระค่าเช่าตามข้อ " ค่าไฟฟ้าและค่าน้ำประปา ตลอดจน คำสาธารณูปโภคใด ๆ ตามข้อ ๕ ทุกวันที่ ๑๐ ของเดือน หากผู้เช่าผิดนัดชำระค่าเช่าภายในกำหนดเวลาดังกล่าว ผู้เช่ายินยอมชำระค่าปรับให้แก่ผู้ให้เช่า ในอัตราวันสะ ๑0๐ บาท (หนึ่งร้อยบาทถ้วน) ต่อวัน ไปจนกว่าจะชำระเสร็จสิ้นทั้งนี้ อัตราค่าปรับดังกล่าวผู้ให้เช่าทรงไว้ซึ่งสิทธิที่จะปรับปรุงหรือเปลี่ยนแปลงได้ตามความเหมาะสม โดยผู้ให้เช่าจะ แจ้งให้ผู้เช่าทราบเป็นลายลักษณ์อักษรก่อนทุกครั้ง',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.Row(
              children: [
                pw.Text(
                  'ข้อ ๖ผู้เช่าจะต้องนำงินมาชำระค่าเช่าตามข้อ " ค่าไฟฟ้าและค่าน้ำประปา ตลอดจน คำสาธารณูปโภคใด ๆ ตามข้อ ๕ ทุกวันที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๑๐",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ของเดือน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.Row(
              children: [
                pw.Text(
                  'หากผู้เช่าผิดนัดชำระค่าเช่าภายในกำหนดเวลาดังกล่าว ผู้เช่ายินยอมชำระค่าปรับให้แก่ผู้ให้เช่า ในอัตราวันสะ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๑0๐ บาท (หนึ่งร้อยบาทถ้วน) ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ต่อวัน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ไปจนกว่าจะชำระเสร็จสิ้นทั้งนี้อัตราค่าปรับดังกล่าวผู้ให้เช่าทรงไว้ซึ่งสิทธิที่จะปรับปรุงหรือเปลี่ยนแปลงได้ตามความเหมาะสมโดยผู้ให้เช่าจะแจ้งให้ผู้เช่า ทราบเป็นลายลักษณ์อักษรก่อนทุกครั้ง',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๗ ผู้เช่าตกลงวางเงินประกันความเสียหายหรือเงินประกันการปฏิบัติตามสัญญา ตลอดอายุสัญญาฉบับนี้ไว้แก่ผู้ให้เช่าในวันที่ทำสัญญาฉบับนี้ ดังต่อไปนี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.Row(
              children: [
                pw.Text(
                  '๗.๑ เงินประกันความเสียหายหรือเงินประกันการปฏิบัติตามสัญญา เป็นจำนวนเงินทั้งสิ้น',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๔,๘๐๐ บาท (สี่พันแปดร้อยบาทถ้วน)",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ต่อวัน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ปรากฎตามใบเสร็จรับเงินเลขที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "SR BK/๖๖๐๘๐๐๐๗",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ลงวันที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๓๐ สิงหาคม ๒๕๖๖",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'เอกสารแนบท้ายสัญญาฉบับนี้ ขี้งถือเป็นส่วนหนึ่งของสัญญาด้วย',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   '๗.๒ เงินประกันไฟฟ้า เป็นจำนวนเงินทั้งสิ้น - บาท (-) ปรากฎตามใบเสร็จรับเงินเลขที่ - ลงวันที่ - เอกสารแนบท้ายสัญญาฉบับนี้ ซึ่งถือเป็นส่วนหนึ่งของสัญญาด้วย',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.Row(
              children: [
                pw.Text(
                  '๗.๒ เงินประกันไฟฟ้า เป็นจำนวนเงินทั้งสิ้น',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        " - บาท (-) ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ปรากฎตามใบเสร็จรับเงินเลขที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        " - ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ลงวันที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        " - ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'เอกสารแนบท้ายสัญญาฉบับนี้ ซึ่งถือเป็นส่วนหนึ่งของสัญญาด้วย',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   '๗.๓ เงินประกันน้ำประปา เป็นจำนวนเงินทั้งสิ้น - บาท (-) ปรากฎตามใบเสร็จรับเงินเลขที่ - ลงวันที่ - เอกสารแนบท้ายสัญญาฉบับนี้ ซึ่งถือเป็นส่วนหนึ่งของสัญญาด้วย',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.Row(
              children: [
                pw.Text(
                  '๗.๓ เงินประกันน้ำประปา เป็นจำนวนเงินทั้งสิ้น',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "- บาท (-) ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'ปรากฎตามใบเสร็จรับเงินเลขที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        " - ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ลงวันที่',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        " - ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'เอกสารแนบท้ายสัญญาฉบับนี้ ซึ่งถือเป็นส่วนหนึ่งของสัญญาด้วย',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๘ เงินประกันความเสียหายหรือเงินประกันการปฏิบัติสัญญาตามข้อ .๑ ผู้เช่ายินยอมให้ผู้ให้เขายึดไว้ก่อนเพื่อเป็นการประกันความเสียหายและการปฏิบัติตามสัญญา',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  'ตลอดอายุสัญญาฉบับนี้ โดยผู้ให้เช่าจะคืนเงินดังกล่าวให้แก่ผู้เขาโตยไม่มีดอกเบี้ยภายใน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        "๖0 (หกสิบ) ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'วัน นับจากวันที่สัญญาเช่าสิ้นสุด',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ทั้งนี้ต้องปรากฏว่าผู้เช่ามิได้เป็นฝ่ายผิดสัญญารวมถึงไม่มีหนี้อย่างใด 1 ค้างชำระต่อผู้ให้เช่า และไม่มีความเสียหายใด ๆ ต่อทรัพย์สินที่เช่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              ' ' * space_Size +
                  'ในกรณีที่ผู้เช่าผิดสัญญาหรือค้างชำระค่าเช่า,ค่าไฟฟ้า,ค่าน้ำประปา,ค่าส่วนกลางและค่าสุขาภิบาล,ค่าสาธารณูปโภคใดๆตลอดจนค่าเสียหายหรือค่าใช้จ่ายอื่นใด',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ที่เกิดจากการใช้พื้นที่ตามสัญญาฉบับนี้ ผู้เช่ายินยอมให้ผู้ให้เช่าหักเงินที่ค้างชำระจากเงินประกันความเสียหายและเงินประกันการปฏิบัติตามสัญญา ตามวรรคแรก ได้ตามจำนวนที่ค้างชำระถ้าจำนวนเงินที่ค้างชำระมากกว่าเงินประกันความเสียหาย ผู้เช่าตกลงจะชำระเงินที่ค้างชำระให้แก่ผู้ให้เช่าจนครบ และในระหว่างอายุสัญญานี้ หากเป็นกรณีที่ผู้ให้เชาหักเงินซึ่งผู้เช่าต้องชำระให้แก่ผู้ให้เช่าตามสัญญาฉบับฉบับนี้จากเงินประกันไปเป็นจำนวนเท่าใด',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Text(
                  ' ' * space_Size +
                      'ผู้เช่าจะต้องนำเงินจำนวนดังกล่าว มามอบให้เต็มจำนวนเงินประกันภายใน',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        color: Colors_pd,
                        width: 0.3, // Underline thickness
                      ))),
                      child: pw.Text(
                        " ๑๕ (สิบห้า) ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    )),
                pw.Text(
                  'วัน นับตั้งแต่วันที่ใด้รับแจ้งจากผู้ให้เข่า',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'เว้นแต่จะได้รับความยินยอมเป็นลายลักษณ์อักษรจากผู้ให้เข่าก่อน',
            //   textAlign: pw.TextAlign.justify,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ข้อ ๙ ผู้เช่าสัญญาว่าจะประกอบกิจการตามสัญญาฉบับ นี้ด้วยตนเองรวมทั้งจะไม่โอนสิทธิการเขาไม่ว่าทั้งหมดหรือแต่เพียงบางส่วนตามสัญญานี้ ให้บุคคลอื่นเช่าช่วง',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text:
                        'หรือให้บุคคลอื่นใช้ประโยยน์เว้นแต่จะได้รับความยินยอมเป็นลายลักษณ์อักษรจากผู้ให้เข่าก่อน',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'ช้อ ๑๐ ผู้เช่าสัญญาว่าจะตูแลรักษาพื้นที่เข่าตามสัญญาฉบับนี้เสมือนหนึ่งวิญญูชนพึงดูแลและรักษาทรัพย์สินของตนเองโดยให้พื้นที่เช้าอยู่ในสภาพเติมและเรียบร้อยอยู่ตลอดเวลา หากเกิดความชำรุดเสียหายผู้เช่าจะต้องเป็นผู้ทำการซ่อมแชมให้อยู่ในสภาพเดิมและเรียบร้อยอยู่ตลอดเวลาด้วยค่าใช้จ่ายของผู้เช่าเองทั้งสิ้น',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),

            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ช้อ ๑๐ ผู้เช่าสัญญาว่าจะตูแลรักษาพื้นที่เข่าตามสัญญาฉบับนี้ เสมือนหนึ่งวิญญูชนพึงดูแลและรักษาทรัพย์สินของตนเองโดยให้พื้นที่เช้าอยู่ในสภาพเติมและเรียบร้อย',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text:
                        'อยู่ตลอดเวลา หากเกิดความชำรุดเสียหายผู้เช่าจะต้องเป็นผู้ทำการซ่อมแชมให้อยู่ในสภาพเดิมและเรียบร้อยอยู่ตลอดเวลาด้วยค่าใช้จ่ายของผู้เช่าเองทั้งสิ้น',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๑ ผู้ให้เช่าไม่ต้องรับผิดชอบต่อความเสียหายใด ๆ อันเกิดจากความชำรุดของเครื่องมือเครื่องใช้อุปกรณ์ทั้งหมดของผู้เช่าที่มีต่อทรัพย์สิน ชีวิต ร่างกายของบริวาร หรือตัวแทนของผู้เช่า ผู้มาติดต่อกับผู้เช่าหรือบุคคลอื่น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              ' ' * space_Size +
                  'หากมีความชำรุดดังกล่าวเกิดขึ้นเป็นหน้าที่ของผู้เช่าจะต้องดำเนินการซ่อมแชมแก้ไขด้วยค่ใช้จ่ายของผู้เช่าเองทั้งสิ้นผู้เช่าจะต้องรับผิดชอบในความสียหาย หรือบุบสลายที่เกิดขึ้นกับอาคารและทรัพย์สินที่เช่า ทั้งที่มีอยู่แล้วหรือที่จะติดตั้งเพิ่มขึ้น อันเนื่องมาจากการกระทำหรือความประมาทเลินเล่อของผู้เช่าบุคคลภายนอก พนักงานลูกจ้าง หรือตัวแทนของผู้เช่าหรือสาเหตุอันเนื่องมาจากการประกอบกิจการ และหรือการกระทำใต ๆ ที่ผู้เช่าต้องรับผิดชอบ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),

            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๒ ผู้เช่าสัญญาว่าจะไม่ทำกรก่อสร้าง ตกแต่ง ต่อเติมพื้นที่เช่า หรือทำการติตตั้งอุปกรณ์ยึดติดตรึงตรากับพื้นที่เช่าไม่ว่าจะด้วยวิธีการใด ๆเว้นแต่จะได้รับอนุญาต จากผู้ให้เช่าเป็นลายลักษณ์อักษรก่อนและในกรณีที่เกิดความเสียหายใด ๆ ผู้เช่ายินยอมรับผิดซดใช้ค่าเสียหายที่เกิดขึ้นเองทั้งสิ้นและในระหว่างการก่อสร้าง ตามข้อนี้ผู้เช่าจะต้องรับผิดชอบในความเสียหายอันเนื่องมาจากการดำเนินการติดตั้งไม่ว่ากรณีใด ๆและผู้เข่าจะต้องปฏิบัติตามเงื่อนไขตังต่อไปนี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '๑๒.๑ ส่งมอบแบนแปลนรายละเอียดการก่อสร้าง ตกแต่ง ต่อเติมหรือติดตั้งอุปกรณ์บริเวณพื้นที่เช่าเพื่อให้ผู้ให้เช่าตรวจสอบและให้ความยินยอมเป็นลายลักษณ์อักษรก่อน ผู้เช่าจึงจะทำการได้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '๑๒.๒ ปฏิบัติตามข้อกำหนด หรือระเบียบ คำสั่งใตๆของผู้ให้เช่าเกี่ยวกับการตกแต่งพื้นที่เชาตลอดจนจะไม่ทำการอันเป็นเหตุ ให้พื้นที่เช่าหรือทรัพย์สินหรืออาคาร ได้รับความเสียหายหรือขาดความมั่นคงแข็งแรง หรือกระทบกระเทือนต่อโตรงสร้างของอาคารหรือพื้นที่เข่า',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '๑๒.๓ หยุดการก่อสร้าง ตกแต่ง ต่อเติม หรือและติดตั้งอุปกรณ์ในพื้นที่เข่าทันทีเมื่อผู้ให้เช่าแจ้งให้ผู้เช่าทราบว่า ก่อสร้าง ตกแต่ง ต่อเติม หรือและติดตั้งอาจก่อให้เกิด ความเสียหายต่อพื้นที่เช่าหรือทรัพย์สินหรืออาคารของผู้ให้เช่าหรือบุคคลอื่น',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๓ บรรดาทรัพย์สินใด ๆ ที่เกิดขึ้นจากการการก่อสร้าง ตกแต่ง ต่อเติมพื้นที่เข่าตามข้อ ดยให้ตกเป็นของผู้ให้เช่าทันที เว้นแต่กรณีที่ผู้ให้เช่าประสงค์จะให้รื้อถอน ผู้เช่าจะต้องรื้อถอนทรัพย์สินดังกล่าวด้วยคำใช้จ่ายของผู้เช่าเองและผู้เช่าจะเรียกค่าเสียหายใต ๆ ไม่ได้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๔ ผู้เช่าจะไม่เคลื่อน โยกย้าย หรือนำทรัพย์สินที่เช่าไม่ว่าทั้งหมดหรือบางส่วนออกไปจากพื้นที่เข่าเว้นแต่จะได้รับความยินยอมเป็นลายสักษณ์อักษรจากผู้ให้เช่า หรือตัวแทนของผู้ให้เช่าก่อน',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๕ ผู้เช่าตกลงอำนวยความสะดรกและยินยอมให้ผู้ให้เช่า หรือตัวแทนของผู้ให้เช่าเข้าตรวจพื้นที่เช่าได้เสมอ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๖ ผู้เช่าต้องจัดการพื้นที่เช่าอย่าให้มีสิ่งโสโครกและมีกลิ่นเหม็นและไม่ทำการอีกทีกจนผู้อื่นได้รับความเดือดร้อนรำคาญปราศจากความปกติสุขและไม่เก็บรักษา สิ่งที่เป็นเชื้อเพลิงและสิ่งของผิดกฎหมายรวมทั้งไมใช้พื้นที่เช่าเล่นการพนันและไม่เสพยาเสพติดหรือกระทำสิ่งใดๆอันผิดกฎหมายหรือหวาดเสียวน่าจะเป็นอันตราย แก่ผู้อยู่ใกล้เคียง',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๗ ผู้เขาตกลงจะทำประกันภัยพื้นที่เช่าและทรัพย์สินของผู้เช่าที่อยู่ในพื้นที่เช่า  โดยผู้เช่าเป็นผู้ชำระเบี้ยประกันภัยและให้ผู้ให้เช่าเป็นผู้รับผลประโยชน์การทำประกันภัย ดังกล่าวทั้งนี้การทำประกันภัยดังกล่าวผู้เช่าจะต้องขออนุณาตจากผู้ให้เซ่าเป็นลายลักษณ์อักษรก่อน',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๘ ผู้เช่าตกลงที่จะใช้พื้นที่เช่าตามวัตถุประสงค์ที่กำหนดว้ในข้อ ๑ สำหรับการประกอบกิจการที่ถูกต้องตามกฎหมายเท่านั้น และจะต้องปฏิบัติตามกฎหมาย ประกาศ หรือระเบียบข้อบังคับของผู้ให้เช่าและของราชการที่เกี่ยวข้องกับการประกอบกิจการของผู้เซาทั้งที่มีอยู่ในปัจจุบันและอาจจะมีขึ้นในอนาคตโดยเครงครัดรวมทั้งต้องเป็นผู้ นินการเพื่อให้ได้มาและรักษาไว้ซึ่งใบอนุญาตใดๆที่จำเป็นเกี่ยวกับกิจการดังกล่าวด้วยคำาใช้จ่ายของผู้เช่าเองทั้งสิ้น รวมถึงจะไม่กระทำหรือยินยอมให้บุคคลอื่นกระทำการใด ๆ ซึ่งเป็นการกระทำที่ผิตกฎหมาย ผิดศีลธรรมอันตีของประชาชน เป็นที่นำรังเกียจ เป็นอันตราย และเสียหายต่อซื่อเสียงของผู้ให้เช่าเป็นอันขาด',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๑๙ ผู้เช่าสัญญาว่าในกรณีที่ผู้เช่าฝาฝืนหรือปฏิบัติผิดสัญญาหรือข้อตกลในสัญญาแม้แต่ข้อใดข้อหนึ่ง หรือกระทำผิดวัตถุประสงค์การเข่า ตามข้อ ๑ แล้ว ผู้เช่ายินยอมให้ผู้ให้เช่าทรงไว้ซึ่งสิทธิที่จะเข้ายึดครองฟื้นที่เช่าได้โดยพลันและมีสิทธิบอกเลิกสัญญาเช่าทันที',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๒๐ หากผู้เช่าหรือบริวารของผู้เช่าไม่ปฏิบัติตามเงื่อนไขแห่งสัญญานี้ ผู้ให้เช่า มีอำนาจงตให้บริการสารารณูปโภคต่าง ๆ าทิเช่นรวมถึงแต่ไม่จำกัดเพียง ระบบบรับอากาส, น้ำประปา, โทรศัพท์,ไฟฟ้า ฯลฯ และมีสิทธิ์ในการเรียกเก็บค่าเสียหาย ลอดจนการระงับมิให้ดำเนินการให้รื้อถอนส่วนใด ๆ รวมทั้งสั่งการให้ปรับปรุงแก้ไขให้อยู่ในสภาพเดิม โดยผู้เช่าเป็นผู้รับผิดซอบค่าใช้จ่ายดังกล่าว ทั้งนี้ ไม่ตัดสิทธิผู้ให้เช่าจะเลิกสัญญาเช่าฉบับนี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'ข้อ ๒๑ คู่สัญญาทั้งสองฝ่ายลกลงกันให้ถือว่า สัญญาฉบับนี้เป็นอันสิ้นสุดลงทันทีในกรณีตังต่อไปนี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '๒๑.๑ สิ้นสุดตามระยะเวลาที่กำหนดไว้ใน ช้อ ๒ ของสัญญานี้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '๒๑.๒ ผู้ให้เช่า ใช้สิทธิบอกเลิกสัญญา',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '๒๑.๓ ผู้เช่าไม่ปฏิบัติตามข้อกำหนด หรือฝาฝืนข้อกำหนดสัญญาฉบับนี้ข้อใดข้อหนึ่ง ตามข้อ ๑๙',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '๒๑.๔ ในกรณีเกิดอัคคีภัย หรือภัยพิบัติ งทำให้เกิดความเสียหาย หรือชำรุดบกพร่องภายในพื้นที่เช่าหรือโครงสร้างอาคารไม่ว่าทั้งหมดหรือบางส่วน และผู้ให้เช่าเห็นว่าไม่สามารถให้ผู้เช่า ใช้พื้นที่ต่อไปได้',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '๒๑.๕ ในกรณีทรัพย์สินของผู้ให้เช่า พื้นที่เช่าถูกยึด หรืออายัดโดยคำสั่ง หรือคำพิพากษาของศาลหรือผู้เช่าถูกศาลสั่งพิทักษ์ทรัพย์ หรือเป็นบุคคลล้มละลาย หรือเป็นผู้ไร้ความสามารถ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   '๒๑.๖ ผู้เข่าใช้สิทธิบอกเลิกสัญญา ในกรณีที่ผู้ให้เช่าไม่ปฏิบัติตามข้อกำหนด หรือผ้าฝืนข้อกำหนดของสัญญาฉบับนี้ข้อใดข้อหนึ่งและผู้ให้เช่าเพิกเฉยไม่ทำการแก้ไข การปฏิบัติผิดสัญญาคำรับรองหรือเงื่อนเขภายใน ๓0 (สามสิบ) วัน นับตั้งแต่วันที่ได้รับคำบอกกล่าวจากผู้เช่า ผู้เช่ามีสิทธิบอกเลิกสัญญาเข่าพื้นที่พร้อมเรียกค่าเสียหายที่เกิดขึ้น',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    '๒๑.๖ ผู้เข่าใช้สิทธิบอกเลิกสัญญา ในกรณีที่ผู้ให้เช่าไม่ปฏิบัติตามข้อกำหนด หรือผ้าฝืนข้อกำหนดของสัญญาฉบับนี้ข้อใดข้อหนึ่งและผู้ให้เช่าเพิกเฉย ไม่ทำการแก้ไข การปฏิบัติผิดสัญญาคำรับรองหรือเงื่อนเขภาย',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text: 'ใน ๓0 (สามสิบ) วัน',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        ' นับตั้งแต่วันที่ได้รับคำบอกกล่าวจากผู้เช่า ผู้เช่ามีสิทธิบอกเลิกสัญญาเข่าพื้นที่ พร้อมเรียกค่าเสียหายที่เกิดขึ้น',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'ข้อ ๒๒ ในกรณีที่ผู้ให้เช่ามีความประสงค์จะใช้พื้นที่เช่า เพื่อตำเนินกิจการของผู้ให้เข่าหรือปรับปรุงพื้นที่เช่า ผู้เช่ายินยอมให้ผู้ให้เช่าบอกเลิกสัญญาเข่าได้ โดยผู้ให้เช่าจะบอกกล่าวล่วงหน้าไม่น้อยกว่า๓๐ (สามสิบ)วัน หากครบกำหนดลังกล่าวแล้ว ผู้เช่าไม่ยอมออกจากพื้นที่เช่า ผู้เช่ายินยอมให้ผู้ให้เข่าเข้าครอบครองพื้นที่เช่าได้ทันที โตยผู้เข่าไม่ติตใจที่จะเรียกร้องค่าเสียหาย หรือค่ขตเซยไม่ว่าด้วยประการใดจากผู้ให้เช่าการดำเนินการดังกล่าวของผู้ให้เช่าไม่ต้องรับผิดทั้งคดีแพ่ง และคดีอาญาทั้งสิ้น',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),

            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ข้อ ๒๒ ในกรณีที่ผู้ให้เช่ามีความประสงค์จะใช้พื้นที่เช่าเพื่อตำเนินกิจการของผู้ให้เข่าหรือปรับปรุงพื้นที่เช่าผู้เช่ายินยอมให้ผู้ให้เช่าบอกเลิกสัญญาเข่าได้โดยผู้ให้เช่า จะบอกกล่าวล่วงหน้าไม่น้อย ',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text: 'กว่า  ๓๐ (สามสิบ )วัน',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        ' หากครบกำหนดลังกล่าวแล้วผู้เช่าไม่ยอมออกจากพื้นที่เช่าผู้เช่ายินยอมให้ผู้ให้เข่าเข้าครอบครองพื้นที่เช่า ได้ทันทีโตยผู้เข่าไม่ติตใจที่จะเรียกร้องค่าเสียหายหรือค่ขตเซยไม่ว่าด้วยประการใดจากผู้ให้เช่าการดำเนินการดังกล่าวของผู้ให้เช่าไม่ต้องรับผิดทั้งคดีแพ่ง และคดีอาญาทั้งสิ้น',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'ข้อ ๒๓ เมื่อสัญญาฉบับนี้สิ้นสุดไม่ว่ากรณีใด ๆ ผู้เช่ายืนยอมออกจากพื้นที่เช่าโดยทันที โดยผู้เข่าจะต้องส่งมอบพื้นที่เช่ให้แก่ผู้ให้เช่าในสภาพที่สมบูรณ์พร้อมใช้งาน ภายใน ๓๐ (สามสิบ) วัน หากครบกำหนดตังกล่าวแล้ว ผู้เช่าไม่ยอมออกจากพื้นที่เช่า ผู้เช่ายินยอมให้ผู้ให้เช่เข้าครอบครองพื้นที่เช่า ได้ทันที โดยผู้เช่าไม่ติดใจที่จะเรียกร้องคำเสียหาย หรือคำชดเซย์ไม่ว่าด้ายประการใดจากผู้ให้เช่าซึ่งการดำเนินการดังกล่าวผู้ให้เช่าไม่ต้องรับผิดทั้งคดีแห่ง และคดีอาญาทั้งสิ้น และผู้เช่าจะต้องดำเนินการยกเลิก แก้ไขเปลี่ยนแปลงทางทะเบียนที่เกี่ยวข้องกับขออนุณาตสำหรับการประกอบกิจการของผู้เช่าต่อหน่วยงานที่เกี่ยวข้องให้แล้วเสร็จก่อนครบกำหนดสัญญาอย่างน้อย ๓0 (สามสิบ) วัน',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ข้อ ๒๓ เมื่อสัญญาฉบับนี้สิ้นสุด ไม่ว่ากรณีใดๆ ผู้เช่ายืนยอมออกจากพื้นที่เช่าโดยทันที โดยผู้เข่าจะต้องส่งมอบพื้นที่เช่าให้แก่ผู้ให้เช่าในสภาพที่ สมบูรณ์พร้อมใช้งานภายใน ',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text: ' ๓๐ (สามสิบ) วัน ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        ' หากครบกำหนดตังกล่าวแล้ว ผู้เช่าไม่ยอมออกจากพื้นที่เช่า ผู้เช่ายินยอมให้ผู้ให้เช่เข้าครอบครองพื้นที่เช่า ได้ทันที โดยผู้เช่าไม่ติดใจที่จะเรียกร้องคำเสียหายหรือคำชดเชย ไม่ว่าด้ายประการใดจากผู้ให้เช่าซึ่งการดำเนินการดังกล่าวผู้ให้เช่าไม่ต้องรับผิดทั้งคดีแห่ง และคดีอาญาทั้งสิ้น และผู้เช่าจะต้องดำเนินการยกเลิก แก้ไขเปลี่ยนแปลงทางทะเบียนที่เกี่ยวข้อง กับขออนุณาตสำหรับการประกอบกิจการของผู้เช่า ต่อหน่วยงานที่เกี่ยวข้องให้แล้วเสร็จก่อนครบ กำหนดสัญญาอย่าง',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: ' น้อย ๓0 (สามสิบ) วัน ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'ข้อ ๒๔ ในกรณีที่ผู้เช่าประสงค์ที่จะต่ออายุสัญญาเช่าออกไป ผู้เช่าแจ้งความประสงค์ล่วงหน้าไม่น้อยกว่า ๓๐ (สามสิบ) วัน ก่อนครบกำหนดเวลาตามสัญญาฉบับนี้ ทั้งนี้ผู้เช่าจะได้รับการต่ออายุสัญญาหรือไม่และมีเงื่อนไขอย่างไร ขึ้นอยู่กับดุลยพินิจของผู้ให้เช่า โดยผู้เช่ายินยอมชำระค่าธรรมเนียมต่ออายุสัญญาในอัตราร้อยละ ๑- (สิบ) ของค่าเช่าต่อเดือนคูณด้วยจำนวนเดือนที่ต่ออายุสัญญาเชาออกไปอัตราค่าธรรมเนี่ยมห่ออายุสัญญานี้ ผู้ให้เช่าทรงไว้ซึ่งสิทธิที่จะปรับปรุงและเปลี่ยนแปลงได้ตามความเหมาะสม โดยผู้ให้เช่าจะแจ้งให้ผู้เช่าทราบเป็นลายลักษณ์อักษรก่อนทุกครั้ง',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ข้อ ๒๔ ในกรณีที่ผู้เช่าประสงค์ที่จะต่ออายุสัญญาเช่าออกไป ผู้เช่าแจ้งความประสงค์ล่วงหน้าไม่น้อย ',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text: 'กว่า ๓๐ (สามสิบ) วัน',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        ' ก่อนครบกำหนดเวลาตามสัญญาฉบับนี้ทั้งนี้ผู้เช่า จะได้รับการต่ออายุสัญญาหรือไม่และมีเงื่อนไขอย่างไรขึ้นอยู่กับดุลยพินิจของผู้ให้เช่า ',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: 'โดยผู้เช่ายินยอมชำระค่าธรรมเนียมต่ออายุสัญญาในอัตรา',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text: 'ร้อยละ ๑๐ (สิบ) ของ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        'ค่าเช่าต่อเดือนคูณด้วยจำนวนเดือนที่ต่ออายุสัญญาเชาออกไปอัตราค่าธรรมเนี่ยมห่ออายุสัญญานี้ ผู้ให้เช่าทรงไว้ซึ่งสิทธิที่จะปรับปรุงและเปลี่ยนแปลงได้ตามความเหมาะสม โดยผู้ให้เช่าจะแจ้งให้ผู้เช่าทราบเป็นลายลักษณ์อักษรก่อนทุกครั้ง',
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'ข้อ ๒๕ การปรับอัตราคำเซ่า เมื่อครบกำหนดสัญญาที่ได้จัดทำไว้ ผู้ให้เข่าจะปรับอัตราค่าเซ่าขึ้นร้อยละ ๑๕ (สิบห้า) ของอัตราค่าเช่าเดิมหรือตามที่ผู้ให้เช่าเห็นสมควร ทั้งนี้ การปรับอัตราคำเช่านี้ ผู้ให้เช่าทรงไว้ซึ่งสิทธิที่ถูบรับปรุง และเปลี่ยนแปลงได้ตามครามพมาะสม โดยให้เข่าจะแจ้งให้ผู้เช่าทราบเป็นลายลักษณ์อักษรก่อนทุกครั้ง',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ข้อ ๒๕ การปรับอัตราคำเซ่า เมื่อครบกำหนดสัญญาที่ได้จัดทำไว้ ผู้ให้เข่าจะปรับอัตราค่าเซ่าขึ้น ',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text: 'ร้อยละ ๑๕ (สิบห้า) ของ',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        ' อัตราค่าเช่าเดิมหรือตามที่ผู้ให้เช่าเห็นสมควร ทั้งนี้ การปรับอัตราคำเช่านี้ ผู้ให้เช่าทรงไว้ซึ่งสิทธิที่ถูบรับปรุง และเปลี่ยนแปลงได้ตามครามพมาะสม โดยให้เข่าจะแจ้งให้ผู้เช่าทราบเป็นลายลักษณ์อักษรก่อนทุกครั้ง',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            // pw.Text(
            //   'ข้อ ๒๖ การบอกกล่าว การแจ้ง หรือการสื่อสารอันเกี่ยวกับสัญญานี้ ให้ทำเป็นลายลักษณ์อักษรและส่งมอบ ณ ที่อยู่ของคู่สัญญา หรือส่งโดยผู้รับส่งเอกสาร หรือไปรษณีย์ลงทะเบียนตอบรับ โดยให้ส่งตามที่อยู่ที่ระบุข้างต้นนี้ และให้ถือว่าเป็นการส่งโดยชอบและถูกต้องตามกฎหมาย ในกรณีคู่สัญญาฝ่ายหนึ่งฝ่ายใดย้ายที่อยู่จะต้องแจ้งเป็นลายลักษณ์อักษรแก่คู่สัญญาอีกฝ่ายหนึ่งทราบ ภายใน ๑๕ (สิบห้า) วัน นับแต่วันที่ย้ายที่อยู่มิฉะนั้นแล้ว ให้ถือว่าคู่สัญญาทั้งสองฝ่ายยังมีที่อยู่ตามที่ระบุไว้ในสัญญานี้ ทุกประการ',
            //   textAlign: pw.TextAlign.left,
            //   style: pw.TextStyle(
            //     fontSize: font_Size,
            //     font: ttf,
            //     color: Colors_pd,
            //   ),
            // ),
            pw.RichText(
              text: pw.TextSpan(
                text:
                    'ข้อ ๒๖ การบอกกล่าว การแจ้ง หรือการสื่อสารอันเกี่ยวกับสัญญานี้ ให้ทำเป็นลายลักษณ์อักษรและส่งมอบ ณ ที่อยู่ของคู่สัญญา หรือส่งโดยผู้รับส่งเอกสาร หรือไปรษณีย์ลงทะเบียนตอบรับ โดยให้ส่งตามที่อยู่ที่ระบุข้างต้นนี้ และให้ถือว่าเป็นการส่งโดยชอบและถูกต้องตามกฎหมาย ในกรณีคู่สัญญาฝ่ายหนึ่งฝ่ายใดย้ายที่อยู่จะต้องแจ้งเป็นลายลักษณ์อักษรแก่คู่สัญญาอีกฝ่ายหนึ่งทราบ  ',
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  color: Colors_pd,
                  fontWeight: pw.FontWeight.bold,
                ),
                children: <pw.TextSpan>[
                  pw.TextSpan(
                    text: 'ภายใน ๑๕ (สิบห้า) วัน',
                    style: pw.TextStyle(
                      decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.TextSpan(
                    text:
                        ' นับแต่วันที่ย้ายที่อยู่มิฉะนั้นแล้ว ให้ถือว่าคู่สัญญาทั้งสองฝ่ายยังมีที่อยู่ตามที่ระบุไว้ในสัญญานี้ ทุกประการ',
                    style: pw.TextStyle(
                      // decoration: pw.TextDecoration.underline,
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              ' ' * space_Size +
                  'สัญญานี้ทำขึ้นสองฉบับ มีข้อความครบถ้วนและถูกต้องตรงกัน คู่สัญญาทั้งสองฝ่ายได้อ่านและเข้าใจข้อความในสัญญาโดยละเอียดหลอดแล้ว จึงได้ลงลายมือชื่อหร้อมประทับตรา (ถ้ามี) ไว้เป็นสำคัญต่อหน้าพยาน และต่างฝ่ายต่างยืดถือไว้ฝ่ายละฉบับ',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.Text(
              '',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: font_Size,
                font: ttf,
                color: Colors_pd,
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.SizedBox(height: 5 * PdfPageFormat.mm),
              pw.Row(
                // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      '___________________________ผู้เช่า/The Lessee   ',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      '___________________________ผู้ให้เช่า/The Lessor ',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                  pw.Align(
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Text(
                      'หน้า ${context.pageNumber} / ${context.pagesCount} ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 10,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );

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
