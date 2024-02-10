import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetInvoiceRe_Model.dart';
import '../Model/GetInvoice_diapay_Model.dart';
import '../Model/GetInvoice_history_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/Get_ExcReceivable_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class Verifi_Exc_Billing extends StatefulWidget {
  final InvoiceModelss;
  const Verifi_Exc_Billing({super.key, this.InvoiceModelss});

  @override
  State<Verifi_Exc_Billing> createState() => _Verifi_Exc_BillingState();
}

class _Verifi_Exc_BillingState extends State<Verifi_Exc_Billing> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("###0.00", "en_US");
  DateTime datex = DateTime.now();
  int Ser_Tap = 0;
  List<InvoiceHistoryModel> _InvoiceHistoryModels = [];
  List<BankExcBilling_Model> bankExcBilling = [];
  List<BankExcBilling_Model> _bankExcBilling = <BankExcBilling_Model>[];
  List<InvoiceReModel> limitedList_InvoiceModels_ = [];
  List<InvoiceReModel> InvoiceModels = [];
  List<InvoiceReModel> _InvoiceModels = <InvoiceReModel>[];
  List<TransModel> _TransModels = [];
  List<PayMentModel> _PayMentModels = [];
  ///////////--------------------------------------------->
  int limit = 50; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  ///////////--------------------------------------------->
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0,
      sum_Pakan = 0,
      sum_Pakan_KF = 0,
      dis_Pakan = 0,
      dis_matjum = 0,
      dis_sum_Pakan = 0.00,
      dis_sum_Matjum = 0.00,
      sum_Matjum_KF = 0,
      sum_tran_dis = 0,
      sum_matjum = 0.00,
      sum_tran_fine = 0,
      fine_total = 0,
      fine_total2 = 0,
      sum_fine = 0;
  String? cFinn,
      doctax,
      paymentSer1,
      paymentSer2,
      paymentName1,
      selectedValue,
      bname1,
      bills_name_,
      bill_tser;
  String? bneme_check, bno_check, bser_check;
  List Default_ = [
    'บิลธรรมดา',
  ];
  List Default2_ = [
    'บิลธรรมดา',
    'ใบกำกับภาษี',
  ];
  ///////////--------------------------------------------->
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
    read_GC_rental();
    red_payMent();
  }

///////////--------------------------------------------->
  Future<Null> checkPreferance() async {
    setState(() {
      limitedList_InvoiceModels_ = widget.InvoiceModelss;
    });
    read_Invoice_limit();
  }

  ///////////--------------------------------------------->
  Future<Null> red_payMent() async {
    // if (_PayMentModels.length != 0) {
    //   setState(() {
    //     _PayMentModels.clear();
    //   });
    // }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['datex'] = '';
      map['timex'] = '';
      map['ptser'] = '';
      map['ptname'] = 'เลือก';
      map['bser'] = '';
      map['bank'] = '';
      map['bno'] = '';
      map['bname'] = '';
      map['bsaka'] = '';
      map['btser'] = '';
      map['btype'] = '';
      map['st'] = '1';
      map['rser'] = '';
      map['accode'] = '';
      map['co'] = '';
      map['data_update'] = '';
      map['auto'] = '0';
      map['fine'] = '0';
      map['fine_a'] = '0';
      map['fine_c'] = '0';

      PayMentModel _PayMentModel = PayMentModel.fromJson(map);

      setState(() {
        _PayMentModels.add(_PayMentModel);
      });
      if (result.toString() != 'null') {
        for (var map in result) {
          PayMentModel _PayMentModel = PayMentModel.fromJson(map);

          setState(() {
            if (_PayMentModel.ptser == '6') {
              _PayMentModels.add(_PayMentModel);
              // paymentSer1 = serx.toString();
              // paymentName1 = ptnamex.toString();
              // selectedValue = _PayMentModel.bno.toString();
              // bname1 = _PayMentModel.bname.toString();
              // fine_total = fine_amt;
            }
          });
        }
      }
    } catch (e) {}
  }

  ///////////--------------------------------------------->
  Future<Null> read_GC_rental() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);

          var bill_defaultx = renTalModel.bill_default;
          var bill_tserx = renTalModel.tser;
          setState(() {
            bill_tser = bill_tserx;
            if (bill_defaultx == 'P') {
              bills_name_ = 'บิลธรรมดา';
            } else {
              bills_name_ = 'ใบกำกับภาษี';
            }
          });
        }
      } else {}
    } catch (e) {}
  }

  ///////////--------------------------------------------->
  Future<void> selectFileAndReadExcel() async {
    int index = 0;
    setState(() {
      bankExcBilling.clear();
      index = 0;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'xlsx',
          'csv'
        ], // Add the file extensions you want to allow
      );

      if (result != null) {
        final file = result.files.single;
        print('Selected file: ${file.name}');

        // Access the file bytes
        final Uint8List bytes = file.bytes!;

        // Decode the Excel file using the excel package
        final excel = Excel.decodeBytes(bytes);

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            if (index <= 2) {
              index++;
              print(index);
            } else {
              var record_type = '${row[0]!.value}';
              var sequence_no = '${row[1]!.value}';
              var bank_code = '${row[2]!.value}';

              var company_account = '${row[3]!.value}';
              var payment_date = '${row[4]!.value}';
              var payment_time = '${row[5]!.value}';
              var customer_name = '${row[6]!.value}';

              var ref1 = '${row[7]!.value}';
              var ref2 = '${row[8]!.value}';
              var ref3 = '${row[9]!.value}';
              var branch_no = '${row[10]!.value}';
              var teller_no = '${row[11]!.value}';
              var kind_Of_transaction = '${row[12]!.value}';
              var transaction_code = '${row[13]!.value}';
              var cheque_no = '${row[14]!.value}';
              var amount = '${row[15]!.value}';
              var cheque_bank_code = '${row[16]!.value}';

              Map<String, dynamic> map = Map();

              map['record_type'] = '$record_type';
              map['sequence_no'] = '$sequence_no';
              map['bank_code'] = '$bank_code';

              map['company_account'] = '$company_account';
              map['payment_date'] = '$payment_date';
              map['payment_time'] = '$payment_time';
              map['customer_name'] = '$customer_name';
              map['ref1'] = '$ref1';
              map['ref2'] = '$ref2';
              map['ref3'] = '$ref3';
              map['branch_no'] = '$branch_no';
              map['teller_no'] = '$teller_no';
              map['kind_Of_transaction'] = '$kind_Of_transaction';
              map['transaction_code'] = '$transaction_code';
              map['cheque_no'] = '$cheque_no';
              map['amount'] = '$amount';
              map['cheque_bank_code'] = '$cheque_bank_code';

              try {
                BankExcBilling_Model bankExcBillingss =
                    BankExcBilling_Model.fromJson(map);

                setState(() {
                  bankExcBilling.add(bankExcBillingss);
                });
                // print('table ---------------- >${sname}');
              } catch (e) {}
              print(map);
            }
          }
        }
      } else {
        // User canceled the file selection.
        print('File selection canceled.');
      }
    } catch (e) {
      print('Error selecting or reading the file: $e');
    }
  }

  ///----------------------->
  Future<Null> read_Invoice_limit() async {
    setState(() {
      endIndex = offset + limit;
      InvoiceModels = limitedList_InvoiceModels_.sublist(
          offset, // Start index
          (endIndex <= limitedList_InvoiceModels_.length)
              ? endIndex
              : limitedList_InvoiceModels_.length // End index
          );
    });
  }

//////////////----------------------------->
  Widget Next_page() {
    return Row(
      children: [
        const Expanded(child: Text('')),
        StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 300)),
            builder: (context, snapshot) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.menu_book,
                      color: Colors.grey,
                      size: 20,
                    ),
                    InkWell(
                        onTap: (offset == 0)
                            ? null
                            : () async {
                                if (offset == 0) {
                                } else {
                                  setState(() {
                                    offset = offset - limit;

                                    read_Invoice_limit();
                                    // tappedIndex_ = '';
                                  });
                                  // _scrollController2.animateTo(
                                  //   0,
                                  //   duration: const Duration(seconds: 1),
                                  //   curve: Curves.easeOut,
                                  // );
                                }
                              },
                        child: Icon(
                          Icons.arrow_left,
                          color:
                              (offset == 0) ? Colors.grey[200] : Colors.black,
                          size: 25,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        /// '*//$endIndex /${limitedList_teNantModels.length} ///${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                        '${(endIndex / limit)}/${(limitedList_InvoiceModels_.length / limit).ceil()}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                          //fontSize: 10.0
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (endIndex >= limitedList_InvoiceModels_.length)
                            ? null
                            : () async {
                                setState(() {
                                  offset = offset + limit;
                                  // tappedIndex_ = '';
                                  read_Invoice_limit();
                                });
                                // _scrollController2.animateTo(
                                //   0,
                                //   duration: const Duration(seconds: 1),
                                //   curve: Curves.easeOut,
                                // );
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: (endIndex >= limitedList_InvoiceModels_.length)
                              ? Colors.grey[200]
                              : Colors.black,
                          size: 25,
                        )),
                  ],
                ),
              );
            }),
      ],
    );
  }
  /////////////////----------------------------------------->

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            width: (Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width * 0.85
                : 1200,
            child: Column(
              children: [
                ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      dragStartBehavior: DragStartBehavior.start,
                      child: Row(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  width: (Responsive.isDesktop(context))
                                      ? (Ser_Tap == 0)
                                          ? (MediaQuery.of(context).size.width *
                                                  0.85) +
                                              500
                                          : MediaQuery.of(context).size.width *
                                              0.85
                                      : 1200,
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.TiTile_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          if (Ser_Tap == 0)
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          if (Ser_Tap == 0)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: PopupMenuButton(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[100],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20)),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: const Text(
                                                    ' + Add',
                                                    style: TextStyle(
                                                      color: ReportScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  PopupMenuItem(
                                                      onTap: () async {
                                                        selectFileAndReadExcel();
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          // color: Colors.green[100]!
                                                          //     .withOpacity(0.5),
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1,
                                                            ),
                                                          ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        // width: 200,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'รูปแบบ : ธนาคารกรุงไทย (KTB)  ',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                            CircleAvatar(
                                                              radius: 12.0,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'images/LogoBank/KTB.png'),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),

                                              // InkWell(
                                              //   onTap: () async {
                                              //     selectFileAndReadExcel();
                                              //   },
                                              //   child:
                                              // Container(
                                              //     decoration: BoxDecoration(
                                              //       color: Colors.blue[100],
                                              //       borderRadius:
                                              //           const BorderRadius.only(
                                              //               topLeft:
                                              //                   Radius.circular(
                                              //                       20),
                                              //               topRight:
                                              //                   Radius.circular(
                                              //                       20),
                                              //               bottomLeft:
                                              //                   Radius.circular(
                                              //                       20),
                                              //               bottomRight:
                                              //                   Radius.circular(
                                              //                       20)),
                                              //       border: Border.all(
                                              //           color: Colors.white,
                                              //           width: 1),
                                              //     ),
                                              //     padding:
                                              //         const EdgeInsets.all(4.0),
                                              //     child: const Text(
                                              //       ' + Add',
                                              //       style: TextStyle(
                                              //         color: ReportScreen_Color
                                              //             .Colors_Text2_,
                                              //         // fontWeight: FontWeight.bold,
                                              //         fontFamily: Font_.Fonts_T,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ),
                                          if (Ser_Tap == 0)
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppbackgroundColor
                                                      .Sub_Abg_Colors
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        Ser_Tap = 0;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: (Ser_Tap == 0)
                                                            ? Colors.green[700]
                                                            : Colors.green[200],
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: const Text(
                                                        'ข้อมูลที่ได้จาก Excel ',
                                                        style: TextStyle(
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text2_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (bankExcBilling.length != 0)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          Ser_Tap = 1;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: (Ser_Tap == 1)
                                                              ? Colors
                                                                  .orange[700]
                                                              : Colors
                                                                  .orange[200],
                                                          borderRadius: const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(8),
                                                              bottomLeft: Radius
                                                                  .circular(8),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: const Text(
                                                          'ผลการเปรียบเทียบ Excel ',
                                                          style: TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text2_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            child: Next_page(),
                                          ))
                                        ],
                                      ),
                                      const Divider(
                                        height: 2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            4, 0, 4, 0),
                                        child: Container(
                                          color: (Ser_Tap == 0)
                                              ? Colors.green[100]!
                                                  .withOpacity(0.5)
                                              : Colors.orange[100]!
                                                  .withOpacity(0.5),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (Ser_Tap == 0)
                                                      ? 'ข้อมูลที่ได้จาก'
                                                      : 'ผลการเปรียบเทียบ',
                                                  style: const TextStyle(
                                                    color: ReportScreen_Color
                                                        .Colors_Text2_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                      ),
                                      if (Ser_Tap == 1)
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white60
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  // border: Border.all(color: Colors.grey, width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'บัญชีธนาคาร : ',
                                                      style: TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text2_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                    Container(
                                                        width: 300,
                                                        child:
                                                            DropdownBno_bank()),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const Divider(
                                        height: 2,
                                      ),
                                      if (Ser_Tap == 0)
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Record Type',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Sequence No.',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Company Account',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Bank Code',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Payment Date',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Payment Time',
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Customer Name',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Ref 1',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Ref 2',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Reg 3',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Branch No.',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Teller No.',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Kind of Transaction',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Transaction Code',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Cheque No.',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Amount',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Cheque Bank Code',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '...',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: ManageScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (Ser_Tap == 1)
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'เลขสัญญา',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'เลขที่ใบแจ้งหนี้',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'วันที่ออกใบแจ้งหนี้',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'วันที่ครบกำหนดชำระ',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ชื่อร้านค้า',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              // Expanded(
                                              //   flex: 1,
                                              //   child: Text(
                                              //     'โซน',
                                              //     textAlign: TextAlign.start,
                                              //     style: TextStyle(
                                              //       color: ManageScreen_Color
                                              //           .Colors_Text1_,
                                              //       fontWeight: FontWeight.bold,
                                              //       fontFamily:
                                              //           FontWeight_.Fonts_T,
                                              //     ),
                                              //   ),
                                              // ),
                                              // Expanded(
                                              //   flex: 1,
                                              //   child: Text(
                                              //     'รหัสพื้นที่',
                                              //     textAlign: TextAlign.start,
                                              //     style: TextStyle(
                                              //       color: ManageScreen_Color
                                              //           .Colors_Text1_,
                                              //       fontWeight: FontWeight.bold,
                                              //       fontFamily:
                                              //           FontWeight_.Fonts_T,
                                              //     ),
                                              //   ),
                                              // ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ช่องทางชำระ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'บัญชี',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              // Expanded(
                                              //   flex: 1,
                                              //   child: Text(
                                              //     'ส่วนลด',
                                              //     textAlign: TextAlign.end,
                                              //     style: TextStyle(
                                              //       color: ManageScreen_Color
                                              //           .Colors_Text1_,
                                              //       fontWeight: FontWeight.bold,
                                              //       fontFamily:
                                              //           FontWeight_.Fonts_T,
                                              //     ),
                                              //   ),
                                              // ),
                                              // Expanded(
                                              //   flex: 1,
                                              //   child: Text(
                                              //     'ยอดรวม',
                                              //     textAlign: TextAlign.center,
                                              //     style: TextStyle(
                                              //       color: ManageScreen_Color
                                              //           .Colors_Text1_,
                                              //       fontWeight: FontWeight.bold,
                                              //       fontFamily:
                                              //           FontWeight_.Fonts_T,
                                              //     ),
                                              //   ),
                                              // ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ยอดรวมสุทธิ',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                  // onTap: () {
                                                  //   for (var index = 0;
                                                  //       index <
                                                  //           _TransModels.length;
                                                  //       index++) {
                                                  //     de_Trans_item_inv(index);
                                                  //   }
                                                  // },
                                                  child: Text(
                                                    '...',
                                                    // 'ยอดชำระรวม ${nFormat.format(sum_amt + sum_fine + (fine_total * _TransModels.length))}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.63,
                                    width: (Responsive.isDesktop(context))
                                        ? (Ser_Tap == 0)
                                            ? (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85) +
                                                500
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85
                                        : 1200,
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0)),
                                      // border: Border.all(color: Colors.grey, width: 1),
                                    ),
                                    child: (Ser_Tap == 1)
                                        ? Billing()
                                        : bankExcBilling.isEmpty
                                            ? SizedBox(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const CircularProgressIndicator(),
                                                    StreamBuilder(
                                                      stream: Stream.periodic(
                                                          const Duration(
                                                              milliseconds: 25),
                                                          (i) => i),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData)
                                                          return const Text('');
                                                        double elapsed = double
                                                                .parse(snapshot
                                                                    .data
                                                                    .toString()) *
                                                            0.05;
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              (elapsed > 8.00)
                                                                  ? const Text(
                                                                      'ไม่พบข้อมูล',
                                                                      style: TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    )
                                                                  : Text(
                                                                      'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                      // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text2_,
                                                                          fontFamily:
                                                                              Font_.Fonts_T
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : ListView.builder(
                                                // controller: _scrollController2,
                                                // itemExtent: 50,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    bankExcBilling.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      Material(
                                                        child: Container(
                                                          child: ListTile(
                                                              // onTap:
                                                              //     () async {
                                                              //   setState(() {
                                                              //     tappedIndex_ =
                                                              //         '${index}';
                                                              //   });
                                                              // },
                                                              title: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              // color: Colors.green[100]!
                                                              //     .withOpacity(0.5),
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].record_type}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].sequence_no}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].bank_code}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].company_account}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].payment_date}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].payment_time}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      // fontSize: 12.0
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].customer_name}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 12.0
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].ref1}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].ref2}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].ref3}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].branch_no}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].teller_no}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].kind_Of_transaction}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].transaction_code}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].cheque_no}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].amount}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${bankExcBilling[index].cheque_bank_code}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

////////////////////----------------------------->

  bool checkInvoice_docno(index) {
    return bankExcBilling
        .any((item) => item.ref1 == InvoiceModels[index].docno);
  }

  bool checkInvoice_bno(index) {
    return bno_check == InvoiceModels[index].bno;
  }

  bool checkInvoice_datebill(index) {
    var Date =
        '${DateFormat('dMM').format(DateTime.parse('${InvoiceModels[index].daterec}'))}${DateTime.parse('${InvoiceModels[index].daterec}').year + 543}';
    return bankExcBilling.any((item) => item.ref2 == Date);
  }

  bool checkInvoice_total(index) {
    String amount =
        '${double.parse(InvoiceModels[index].total_dis.toString())}';
    double parsedAmount = double.parse(amount);
    int result = (parsedAmount * 100).round();

    return bankExcBilling.any((item) =>
        item.amount.toString() == result.toString() &&
        item.ref1 == InvoiceModels[index].docno);
  }

  bool checkInvoice_Allbill(index) {
    return checkInvoice_docno(index) &&
        checkInvoice_datebill(index) &&
        checkInvoice_total(index) &&
        checkInvoice_bno(index) &&
        (InvoiceModels[index].btype.toString() == 'OP');
  }

  String convertDateString(String date) {
    if (date.length < 8) {
      // Add '0' at the beginning
      date = '0$date';
      String year = date.substring(4);
      String month = date.substring(2, 4);
      String day = date.substring(0, 2);
      DateTime parsedDate = DateTime.parse('$year-$month-$day');
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      return '$formattedDate';
    } else {
      try {
        String year = date.substring(4);
        String month = date.substring(2, 4);
        String day = date.substring(0, 2);
        DateTime parsedDate = DateTime.parse('$year-$month-$day');
        String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
        return '$formattedDate';
      } catch (e) {
        return '0000-00-00';
      }
    }
  }

////////////-------------------------------------------->
  Widget DropdownBno_bank() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white60.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        // border: Border.all(color: Colors.grey, width: 1),
      ),
      padding: const EdgeInsets.all(2.0),
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
          //Add isDense true and zero Padding.
          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          //Add more decoration as you want here
          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
        ),
        isExpanded: true,
        // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
        hint: Row(
          children: [
            Text(
              (paymentName1 == null) ? 'เลือก' : '$paymentName1',
              style: const TextStyle(
                  fontSize: 12,
                  color: PeopleChaoScreen_Color.Colors_Text2_,
                  // fontWeight: FontWeight.bold,
                  fontFamily: Font_.Fonts_T),
            ),
          ],
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 25,
        buttonHeight: 30,
        buttonPadding: const EdgeInsets.only(left: 10, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        items: _PayMentModels.map((item) => DropdownMenuItem<String>(
              onTap: () {
                bneme_check = item.bname;
                bno_check = item.bno;
                bser_check = item.ser;
              },
              value: '${item.ser}:${item.ptname}',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${item.ptname!}',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${item.bno!}',
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
        onChanged: (value) async {
          // print(value);
          // // Do something when changing the item if you want.

          // var zones = value!.indexOf(':');
          // var rtnameSer = value.substring(0, zones);
          // var rtnameName = value.substring(zones + 1);
          // // print(
          // //     'mmmmm ${rtnameSer.toString()} $rtnameName');
          // setState(() {
          //   paymentSer1 = rtnameSer.toString();
          //   // Form_payment2.clear();

          //   if (rtnameSer.toString() == '0') {
          //     paymentName1 = null;
          //   } else {
          //     paymentName1 = rtnameName.toString();
          //   }
          //   if (rtnameSer.toString() == '0') {
          //     // Form_payment1.clear();
          //   } else {}
          // });
          // print('mmmmm ${rtnameSer.toString()} $rtnameName');
        },
      ),
    );
  }
////////////-------------------------------------------->

  Widget Billing() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.63,
        width: Responsive.isDesktop(context)
            ? MediaQuery.of(context).size.width * 0.85
            : 1200,
        decoration: const BoxDecoration(
          color: AppbackgroundColor.Sub_Abg_Colors,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0)),
          // border: Border.all(color: Colors.grey, width: 1),
        ),
        child: (bno_check == null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'กรุณาระบุ : บัญชีธนาคาร.. !!!',
                        style: TextStyle(
                          color: AccountScreen_Color.Colors_Text1_,
                          // fontWeight: FontWeight.bold,
                          fontFamily: Font_.Fonts_T,
                          //fontSize: 10.0
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : InvoiceModels.isEmpty
                ? SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        StreamBuilder(
                          stream: Stream.periodic(
                              const Duration(milliseconds: 25), (i) => i),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const Text('');
                            double elapsed =
                                double.parse(snapshot.data.toString()) * 0.05;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (elapsed > 8.00)
                                  ? const Text(
                                      'ไม่พบข้อมูล',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T
                                          //fontSize: 10.0
                                          ),
                                    )
                                  : Text(
                                      'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                      // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                      style: const TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T
                                          //fontSize: 10.0
                                          ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    // controller: _scrollController2,
                    // itemExtent: 50,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: InvoiceModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Material(
                            // color: tappedIndex_ == index.toString()
                            //     ? tappedIndex_Color.tappedIndex_Colors
                            //     : AppbackgroundColor.Sub_Abg_Colors,
                            child: Container(
                              child: ListTile(
                                  // onTap:
                                  //     () async {
                                  //   setState(() {
                                  //     tappedIndex_ =
                                  //         '${index}';
                                  //   });
                                  // },
                                  title: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.green[100]!
                                  //     .withOpacity(0.5),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black12,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          '${InvoiceModels[index].cid}',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                            //fontSize: 10.0
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        color: checkInvoice_docno(index)
                                            ? Colors.green[50]
                                            : null,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          checkInvoice_docno(index)
                                              ? '${InvoiceModels[index].docno} [✔]'
                                              : '${InvoiceModels[index].docno}',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: checkInvoice_docno(index)
                                                ? Colors.green
                                                : ManageScreen_Color
                                                    .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                            //fontSize: 10.0
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          '${DateFormat('dd-MM').format(DateTime.parse('${InvoiceModels[index].daterec}'))}-${DateTime.parse('${InvoiceModels[index].daterec}').year + 543}',
                                          //'${DateFormat('dd-MM-yyyy').format(DateTime.parse('${InvoiceModels[index].daterec}'))}',
                                          textAlign: TextAlign.center,

                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                            // fontSize: 12.0
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        color: (checkInvoice_datebill(index) &&
                                                checkInvoice_docno(index))
                                            ? Colors.green[50]
                                            : null,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          (checkInvoice_datebill(index) &&
                                                  checkInvoice_docno(index))
                                              ? '${DateFormat('dd-MM').format(DateTime.parse('${InvoiceModels[index].date}'))}-${DateTime.parse('${InvoiceModels[index].date}').year + 543} [✔]'
                                              : '${DateFormat('dd-MM').format(DateTime.parse('${InvoiceModels[index].date}'))}-${DateTime.parse('${InvoiceModels[index].date}').year + 543}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: (checkInvoice_datebill(
                                                        index) &&
                                                    checkInvoice_docno(index))
                                                ? Colors.green
                                                : ManageScreen_Color
                                                    .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                            //fontSize: 12.0
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          '${InvoiceModels[index].scname}',
                                          // '${transMeterModels[index].ovalue}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                            //fontSize: 12.0
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: AutoSizeText(
                                    //     minFontSize: 10,
                                    //     maxFontSize: 25,
                                    //     maxLines: 1,
                                    //     '${InvoiceModels[index].zn}',
                                    //     //'${transMeterModels[index].qty}',
                                    //     textAlign: TextAlign.start,
                                    //     style: const TextStyle(
                                    //       color: ManageScreen_Color.Colors_Text2_,
                                    //       // fontWeight:
                                    //       //     FontWeight.bold,
                                    //       fontFamily: Font_.Fonts_T,
                                    //     ),
                                    //   ),
                                    // ),

                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        color: (checkInvoice_docno(index) &&
                                                InvoiceModels[index]
                                                        .btype
                                                        .toString() ==
                                                    'OP')
                                            ? Colors.green[50]
                                            : (checkInvoice_docno(index) &&
                                                    InvoiceModels[index]
                                                            .btype
                                                            .toString() !=
                                                        'OP')
                                                ? Colors.red[50]
                                                : null,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          InvoiceModels[index].btype == null
                                              ? ''
                                              : (checkInvoice_docno(index) &&
                                                      InvoiceModels[index]
                                                              .btype
                                                              .toString() ==
                                                          'OP')
                                                  ? '${InvoiceModels[index].btype} [✔]'
                                                  : '${InvoiceModels[index].btype}',
                                          //'${transMeterModels[index].qty}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: (checkInvoice_docno(index) &&
                                                    InvoiceModels[index]
                                                            .btype
                                                            .toString() ==
                                                        'OP')
                                                ? Colors.green
                                                : (checkInvoice_docno(index) &&
                                                        InvoiceModels[index]
                                                                .btype
                                                                .toString() !=
                                                            'OP')
                                                    ? Colors.red
                                                    : ManageScreen_Color
                                                        .Colors_Text2_,
                                            // fontWeight:
                                            //     FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        color: (checkInvoice_bno(index) &&
                                                checkInvoice_docno(index))
                                            ? Colors.green[50]
                                            : null,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          (checkInvoice_bno(index) &&
                                                  checkInvoice_docno(index))
                                              ? '${InvoiceModels[index].bno} [✔]'
                                              : '${InvoiceModels[index].bno}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: (checkInvoice_bno(index) &&
                                                    checkInvoice_docno(index))
                                                ? Colors.green
                                                : ManageScreen_Color
                                                    .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: AutoSizeText(
                                    //     minFontSize: 10,
                                    //     maxFontSize: 25,
                                    //     maxLines: 1,
                                    //     //'${InvoiceModels[index].total_bill}',
                                    //     '${nFormat.format(double.parse(InvoiceModels[index].total_bill.toString()) - double.parse(InvoiceModels[index].total_dis.toString()))}',
                                    //     textAlign: TextAlign.end,
                                    //     style: const TextStyle(
                                    //       color: ManageScreen_Color.Colors_Text2_,
                                    //       // fontWeight:
                                    //       //     FontWeight.bold,
                                    //       fontFamily: Font_.Fonts_T,
                                    //     ),
                                    //   ),
                                    // ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: AutoSizeText(
                                    //     minFontSize: 10,
                                    //     maxFontSize: 25,
                                    //     maxLines: 1,
                                    //     //'${InvoiceModels[index].total_bill}',
                                    //     '${nFormat.format(double.parse(InvoiceModels[index].total_bill.toString()))}',
                                    //     textAlign: TextAlign.end,
                                    //     style: const TextStyle(
                                    //       color: ManageScreen_Color.Colors_Text2_,
                                    //       // fontWeight:
                                    //       //     FontWeight.bold,
                                    //       fontFamily: Font_.Fonts_T,
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        color: checkInvoice_total(index)
                                            ? Colors.green[50]
                                            : checkInvoice_docno(index)
                                                ? Colors.red[50]
                                                : null,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 25,
                                          maxLines: 1,
                                          checkInvoice_total(index)
                                              ? '${nFormat.format(double.parse(InvoiceModels[index].total_dis.toString()))} [✔]'
                                              : '${nFormat.format(double.parse(InvoiceModels[index].total_dis.toString()))}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: checkInvoice_total(index)
                                                ? Colors.green
                                                : checkInvoice_docno(index)
                                                    ? Colors.red
                                                    : ManageScreen_Color
                                                        .Colors_Text2_,
                                            // fontWeight:
                                            //     FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: checkInvoice_Allbill(index)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      red_Trans_select(index)
                                                          .then((value) {
                                                        _showMyDialog_pay(
                                                            index);
                                                      });

                                                      print(
                                                          '${InvoiceModels[index].ser} ${InvoiceModels[index].cid} ${InvoiceModels[index].docno}');
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[400],
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    010),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 0.5),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 8, 8, 8),
                                                      child: const Center(
                                                        child: AutoSizeText(
                                                          minFontSize: 12,
                                                          maxFontSize: 20,
                                                          maxLines: 1,
                                                          'ถูกต้อง อนุมัติ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const Text(''),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ),
                          if (index + 1 == InvoiceModels.length &&
                              InvoiceModels.length != 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 1,
                                    '<<- End ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: tappedIndex_Color.End_Colors,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // color: Colors
                                        //     .orange,
                                        border: Border.all(
                                            color: tappedIndex_Color.End_Colors,
                                            width: 1),
                                      ),
                                      height: 1,
                                    ),
                                  ),
                                  const AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 1,
                                    ' End ->>',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: tappedIndex_Color.End_Colors,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }));
  }

  /////////----------------------------------------------------------->
  Future<void> _showMyDialog_pay(index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();

        String amount =
            '${double.parse(InvoiceModels[index].total_dis.toString())}';
        double parsedAmount = double.parse(amount);
        int result = (parsedAmount * 100).round();
        DateTime datexDialog = DateTime.now();
        String Value_newDatepay = convertDateString(
                '${bankExcBilling.where((model) => model.ref1.toString() == InvoiceModels[index].docno.toString() && model.amount.toString() == result.toString()).map((model) => model.payment_date).join(',')}')
            .toString();
        String Value_newDateY1 = Value_newDatepay;
        //  '${DateFormat('yyyy-MM-dd').format(datexDialog)}';

        return StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 0)),
          builder: (context, snapshot) {
            return Form(
              key: _formKey,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                content: Container(
                  width: 220,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Text(
                              '${InvoiceModels[index].docno}',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Text(
                              'รายการทั้งหมด ${_InvoiceHistoryModels.length} รายการ',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.5),
                        const Divider(),
                        const SizedBox(height: 0.5),
                        Container(
                          // width: 200,
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'วันที่รับชำระ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    ),
                              ),
                              Container(
                                  height: 35,
                                  width: 200,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(2.0),
                                          child: AutoSizeText(
                                            '$Value_newDatepay',
                                            // '${bankExcBilling.where((model) => model.ref1.toString() == InvoiceModels[index].docno.toString() && model.amount.toString() == result.toString()).map((model) => model.payment_date).join(', ')}',
                                            minFontSize: 10,
                                            maxFontSize: 16,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          // width: 200,
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'ยอดรวมสุทธิ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    ),
                              ),
                              Container(
                                  height: 35,
                                  width: 200,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(2.0),
                                          child: AutoSizeText(
                                            '${InvoiceModels[index].total_dis}',
                                            minFontSize: 10,
                                            maxFontSize: 16,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 0.5),
                        const Divider(),
                        const SizedBox(height: 0.5),
                        Container(
                          // width: 200,
                          // color: AppbackgroundColor.Sub_Abg_Colors,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'รูปแบบบิล',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    ),
                              ),
                              Container(
                                width: 200,
                                height: 35,
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  isExpanded: true,

                                  hint: Text(
                                    bills_name_.toString(),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                  ),
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontFamily: Font_.Fonts_T),
                                  iconSize: 30,
                                  buttonHeight: 40,
                                  // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  items: bill_tser == '1'
                                      ? Default_.map((item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          )).toList()
                                      : Default2_.map((item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          )).toList(),

                                  onChanged: (value) async {
                                    var bill_set =
                                        value == 'บิลธรรมดา' ? 'P' : 'F';
                                    setState(() {
                                      bills_name_ = bill_set;
                                    });
                                    print(bills_name_);
                                  },
                                  // onSaved: (value) {
                                  //   // selectedValue = value.toString();
                                  // },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // width: 200,
                          // color: AppbackgroundColor.Sub_Abg_Colors,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'วันที่ทำรายการ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T
                                    //fontSize: 10.0
                                    ),
                              ),
                              Container(
                                  width: 200,
                                  height: 35,
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            // color: Colors.green[50],
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(0),
                                            ),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(2.0),
                                          child: AutoSizeText(
                                            Value_newDateY1 == ''
                                                ? 'เลือกวันที่'
                                                : '$Value_newDateY1',
                                            minFontSize: 10,
                                            maxFontSize: 16,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                              locale: const Locale('th', 'TH'),
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now().add(
                                                  const Duration(days: -50)),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)),
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary: AppBarColors
                                                          .ABar_Colors, // header background color
                                                      onPrimary: Colors
                                                          .white, // header text color
                                                      onSurface: Colors
                                                          .black, // body text color
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: Colors
                                                            .black, // button text color
                                                      ),
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (newDate == null) {
                                              return;
                                            } else {
                                              String start =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(newDate);

                                              setState(() {
                                                Value_newDateY1 = start;
                                              });
                                            }
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                // color: Colors.green[50],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: const Icon(Icons.edit)))
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  Column(
                    children: [
                      const SizedBox(height: 0.5),
                      const Divider(),
                      const SizedBox(height: 0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () async {
                                in_Trans_invoice_refno(
                                    index, Value_newDateY1, Value_newDatepay);
                                // Pay_Invoice(
                                //     index, Value_newDateY1, Value_newDatepay);
                              },
                              child: Container(
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                    'ยืนยัน',
                                    style: TextStyle(
                                      color: Colors.white,
                                      //fontWeight: FontWeight.bold, color:

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () => Navigator.pop(context, 'OK'),
                              child: Container(
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                    'ปิด',
                                    style: TextStyle(
                                      color: Colors.white,
                                      //fontWeight: FontWeight.bold, color:

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

/////////----------------------------------------------------------->
  Future<Null> red_Trans_select(index) async {
    print(
        'Ser : ${InvoiceModels[index].ser} // docno :  ${InvoiceModels[index].docno} ///total : ${InvoiceModels[index].total_dis}');
    if (_InvoiceHistoryModels.length != 0) {
      setState(() {
        _InvoiceHistoryModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        sum_disamt = 0;
        sum_disp = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = InvoiceModels[index].cid;
    var qutser = '1';
    var docnoin = InvoiceModels[index].docno;

    String url =
        '${MyConstant().domain}/GC_bill_invoice_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          InvoiceHistoryModel _InvoiceHistoryModel =
              InvoiceHistoryModel.fromJson(map);

          var sum_pvatx = double.parse(_InvoiceHistoryModel.pvat_t!);
          var sum_vatx = double.parse(_InvoiceHistoryModel.vat_t!);
          var sum_whtx = double.parse(_InvoiceHistoryModel.wht!);
          var sum_amtx = double.parse(_InvoiceHistoryModel.total_t!);
          var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
          var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_disamt = sum_disamtx;
            sum_disp = sum_dispx;

            _InvoiceHistoryModels.add(_InvoiceHistoryModel);
          });
        }
      } else if (result.toString() == 'false') {
        for (var map in result) {
          InvoiceHistoryModel _InvoiceHistoryModel =
              InvoiceHistoryModel.fromJson(map);

          var sum_pvatx = double.parse(_InvoiceHistoryModel.pvat_t!);
          var sum_vatx = double.parse(_InvoiceHistoryModel.vat_t!);
          var sum_whtx = double.parse(_InvoiceHistoryModel.wht!);
          var sum_amtx = double.parse(_InvoiceHistoryModel.total_t!);
          var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
          var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_disamt = sum_disamtx;
            sum_disp = sum_dispx;

            _InvoiceHistoryModels.add(_InvoiceHistoryModel);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
                style:
                    TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      );
    }
  }

  /////////----------------------------------------------------------->
  Future<Null> in_Trans_invoice_refno(
      index, Value_newDateY1, Value_newDatepay) async {
    var Times = DateFormat('HH:mm:ss').format(datex).toString();
    String? fileName_Slip_;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = InvoiceModels[index].cid;
    var qutser = '1';
    var sumdis = sum_disamt.toString();
    var sumdisp = sum_disp.toString();
    var dateY = Value_newDatepay;
    var dateY1 = Value_newDateY1;
    var time = Times;
    //pamentpage == 0
    var dis_akan = dis_sum_Pakan.toString();
    var dis_Matjum = dis_sum_Matjum.toString();
    var payment1 = InvoiceModels[index].total_dis.toString();
    var payment2 = '';
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var ref = InvoiceModels[index].docno;
    var sum_whta = sum_wht.toString();
    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    var comment = '';
    var sum_fine = sum_tran_fine;
    var fine_total_amt = nFormat.format(fine_total + fine_total2);
    // print('in_Trans_invoice_refno()///$fileName_Slip_');
    // print('in_Trans_invoice_refno >>> $payment1  $payment2  $bill ');

    String url =
        '${MyConstant().domain}/In_tran_finanref2.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_&comment=$comment&dis_Pakan=$dis_akan&dis_Matjum=$dis_Matjum&sum_fine=$sum_fine&fine_total_amt=$fine_total_amt';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'No') {
        print('result.toString() != No');
        for (var map in result) {
          CFinnancetransModel cFinnancetransModel =
              CFinnancetransModel.fromJson(map);
          setState(() {
            cFinn = cFinnancetransModel.docno;

            doctax = cFinnancetransModel.doctax;
          });
          print('zzzzasaaa123454>>>>  $cFinn');
          print(
              'in_Trans_invoice_refno bno123454>>>>  ${cFinnancetransModel.bno}//// ${cFinnancetransModel.doctax}');
        }

        Insert_log.Insert_logs('บัญชี', 'รับชำระ:$cFinn ');

        setState(() async {
          dis_sum_Pakan = 0.00;
          dis_Pakan = 0;
          dis_matjum = 0;
          sum_matjum = 0.00;
          dis_sum_Matjum = 0.00;
          sum_tran_fine = 0;

          fine_total = 0;
          fine_total2 = 0;

          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;

          _InvoiceModels.clear();
          _InvoiceHistoryModels.clear();
        });
        print('rrrrrrrrrrrrrr');
        Navigator.pop(context, 'OK');
      }
    } catch (e) {}
  }

  /////////----------------------------------------------------------->
  // Future<Null> Pay_Invoice(index, Value_newDateY1, Value_newDatepay) async {
  //   var time = DateFormat('HH:mm:ss').format(datex).toString();
  //   print('---------------**********------------->');
  //   print('รูปแบบรับชำระ : ${bser_check}  // ${bno_check} // ${bneme_check}');
  //   print('---------->');
  //   print(
  //       'Ser : ${InvoiceModels[index].ser} // docno :  ${InvoiceModels[index].docno} ///total : ${InvoiceModels[index].total_dis}');
  //   print(
  //       'วันที่ทำรายการ : ${Value_newDateY1} $time /// วันที่รับชำระ : $Value_newDatepay ');

  //   // red_Trans_select(index).then((value) {
  //   //   in_Trans_dis_inv(index);
  //   //   if (widget.can.toString() == 'null') {
  //   //     if (contractxFineModels.isNotEmpty) {
  //   //       in_Trans_fine_re(index);
  //   //       // red_Trans_select2_fin();
  //   //     }
  //   //   }
  //   // });
  // }
}
