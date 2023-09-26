import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Constant/Myconstant.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetType_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class Add_Custo_EXC_Screen extends StatefulWidget {
  const Add_Custo_EXC_Screen({super.key});

  @override
  State<Add_Custo_EXC_Screen> createState() => _Add_Custo_EXC_ScreenState();
}

class _Add_Custo_EXC_ScreenState extends State<Add_Custo_EXC_Screen> {
  List<dynamic> ADD_Cus_finished = [];
  List<dynamic> Select_Cus_index = [];
  List<CustomerModel> customerModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];
  String? renTal_user, renTal_name, fname_;
  List<TypeModel> typeModels = [];
  final _formKey = GlobalKey<FormState>();
  final Status4Form_nameshop = TextEditingController();
  final Status4Form_typeshop = TextEditingController();
  final Status4Form_bussshop = TextEditingController();
  final Status4Form_bussscontact = TextEditingController();
  final Status4Form_address = TextEditingController();
  final Status4Form_tel = TextEditingController();
  final Status4Form_email = TextEditingController();
  final Status4Form_tax = TextEditingController();
  final Status5Form_NoArea_ = TextEditingController();
  final Status5Form_NoArea_ren = TextEditingController();
  String _verticalGroupValue = '';
  int Value_AreaSer_ = 0;
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_type();
  }

  ScrollController _scrollController1 = ScrollController();

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///----------------->
  // GlobalKey qrImageKey = GlobalKey();

  ////////////------------------------------------------------------>
  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');
    });
    // System_New_Update();
  }

  System_New_Update() async {
    // String accept_ = showst_update_!;
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(
          '📢ขออภัย !!!! ',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontFamily: Font_.Fonts_T,
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("images/pngegg.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ขออภัย ขณะนี้ฟังก์ชั่นก์ เพิ่มแบบExcel อยู่ในช่วงทดสอบ... !!!!!! ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () async {
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text(
                                'รับทราบ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

//////////////////////////////------------------------------------->
  Future<Null> read_GC_type() async {
    if (typeModels.isNotEmpty) {
      typeModels.clear();
    }

    String url = '${MyConstant().domain}/GC_type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TypeModel typeModel = TypeModel.fromJson(map);
          setState(() {
            typeModels.add(typeModel);
          });
        }
        // setState(() {
        //   for (var i = 0; i < typeModels.length; i++) {
        //     _verticalGroupValue = typeModels[i].type!;
        //   }
        // });
      } else {}
    } catch (e) {}
  }

//////////----------------------------------------------->
  // Future<void> _importFromRemoteExcel() async {
  //   final url =
  //       'https://www.dzentric.com/chao_perty/chao_api/Awaitdownload/FormMan_ADDCusto.xlsx';
  //   int index = 0;
  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final bytes = response.bodyBytes;
  //       final excel = Excel.decodeBytes(bytes);

  //       for (var table in excel.tables.keys) {
  //         for (var row in excel.tables[table]!.rows) {
  //           if (index == 0) {
  //             index++;
  //             print(index);
  //           } else {
  //             var ser = '${row[0]!.value}';
  //             var cusno = '${row[1]!.value}';
  //             var sname = '${row[2]!.value}';
  //             var cname = '${row[3]!.value}';
  //             var tel = '${row[4]!.value}';
  //             var email = '${row[5]!.value}';
  //             var tax = '${row[6]!.value}';
  //             var type = '${row[7]!.value}';
  //             var addr_1 = '${row[8]!.value}';
  //             var addr_2 = '${row[9]!.value}';

  //             Map<String, dynamic> map = Map();

  //             map['ser'] = '0';
  //             map['user'] = '0';
  //             map['rser'] = '0';
  //             map['datex'] = '0';
  //             map['timex'] = '0';
  //             map['custno'] = '0';
  //             map['taxno'] = '0';
  //             map['scname'] = '0';
  //             map['stype'] = '0';
  //             map['tser'] = '0';
  //             map['typeser'] = '0';
  //             map['type'] = '0';
  //             map['cname'] = '0';
  //             map['branch'] = '0';
  //             map['attn'] = '0';
  //             map['addr_1'] = '0';
  //             map['addr_2'] = '0';
  //             map['zip'] = '0';
  //             map['tel'] = '0';
  //             map['tax'] = '0';
  //             map['fax'] = '0';
  //             map['email'] = '0';
  //             map['lineid'] = '0';
  //             map['lastday'] = '0';
  //             map['status'] = '0';
  //             map['st'] = '0';
  //             map['map_update'] = '0';
  //             map['cid'] = '0';
  //             map['docno'] = '0';
  //             map['sdate'] = '0';
  //             map['ldate'] = '0';
  //             map['period'] = '0';
  //             map['nday'] = '0';
  //             map['ctype'] = '0';
  //             map['zser'] = '0';
  //             map['zn'] = '0';
  //             map['aser'] = '0';
  //             map['ln'] = '0';
  //             map['qty'] = '0';
  //             map['area'] = '0';
  //             map['rtser'] = '0';
  //             map['rtname'] = '0';
  //             map['user_name'] = '0';
  //             map['passw'] = '0';
  //             map['sname'] = '0';

  //             // try {
  //             //   CustomerModel customerModel = CustomerModel.fromJson(map);

  //             //   setState(() {
  //             //     customerModels.add(customerModel);
  //             //   });
  //             //   print('table ---------------- >${sname}');
  //             // } catch (e) {}
  //             print(index);
  //           }
  //         }
  //       }
  //     } else {
  //       print('Failed to download Excel file');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

//////////------------------------------------------------------>

  Future<void> downloadAndSaveFile() async {
    final url =
        'https://www.dzentric.com/chao_perty/chao_api/Awaitdownload/FormMan_ADDCusto.xlsx';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Uint8List data = response.bodyBytes;
      final MimeType type = MimeType.MICROSOFTEXCEL;
      final String fileName = "ไฟล์ตัวอย่างในการเพิ่มข้อมูลลูกค้า.xlsx";

      final Blob blob = Blob([data]);

      FileSaver.instance.saveFile(
        fileName,
        data,
        "xlsx",
        mimeType: type,
      );
    } else {
      throw Exception('Failed to download file');
    }
  }

  Future<void> selectFileAndReadExcel() async {
    int index = 0;
    setState(() {
      customerModels.clear();
      index = 0;
    });
    setState(() {
      Select_Cus_index.clear();
      Select_Cus_index.clear();
      customerModels.clear();
    });
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'xlsx',
          // 'csv'
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
            if (index == 0) {
              index++;
              print(index);
            } else {
              var type = '${row[0]!.value}';
              var nameshop = '${row[1]!.value}';
              var typeshop = '${row[2]!.value}';
              var bussshop = '${row[3]!.value}';
              var bussscontact = '${row[4]!.value}';
              var address = '${row[5]!.value}';
              var tel = '${row[6]!.value}';
              var email = '${row[7]!.value}';
              var tax = '${row[8]!.value}';

              Map<String, dynamic> map = Map();

              map['ser'] = '';
              map['user'] = '';
              map['rser'] = '';
              map['datex'] = '';
              map['timex'] = '';
              map['custno'] = '';
              map['taxno'] = '';
              map['scname'] = '${nameshop.toString().trim()}';
              map['stype'] = '${typeshop.toString().trim()}';
              map['tser'] = '';
              map['typeser'] =
                  (type.toString().trim() == 'ส่วนตัว/บุคคลธรรมดา') ? '0' : '1';
              map['type'] = '${type.toString().trim()}';
              map['cname'] = '${bussshop.toString().trim()}';
              map['branch'] = '';
              map['attn'] = '${bussscontact.toString().trim()}';
              map['addr_1'] = '${address.toString().trim()}';
              map['addr_2'] = '';
              map['zip'] = '';
              map['tel'] = '${tel.toString().trim()}';
              map['tax'] = '${tax.toString().trim()}';
              map['fax'] = '';
              map['email'] = '${email.toString().trim()}';
              map['lineid'] = '';
              map['lastday'] = '';
              map['status'] = '';
              map['st'] = '';
              map['map_update'] = '';
              map['cid'] = '';
              map['docno'] = '';
              map['sdate'] = '';
              map['ldate'] = '';
              map['period'] = '';
              map['nday'] = '';
              map['ctype'] = '';
              map['zser'] = '';
              map['zn'] = '';
              map['aser'] = '';
              map['ln'] = '';
              map['qty'] = '';
              map['area'] = '';
              map['rtser'] = '';
              map['rtname'] = '';
              map['user_name'] = '';
              map['passw'] = '';
              map['sname'] = '';

              try {
                CustomerModel customerModel = CustomerModel.fromJson(map);

                setState(() {
                  customerModels.add(customerModel);
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

  Future<void> updated_Customer(scname, stype, typeser, type, cname, attn,
      addr_1, tel, tax, email, indexToEdit) async {
    Map<String, dynamic> map = Map();

    map['ser'] = '';
    map['user'] = '';
    map['rser'] = '';
    map['datex'] = '';
    map['timex'] = '';
    map['custno'] = '';
    map['taxno'] = '';
    map['scname'] = '$scname';
    map['stype'] = '$stype';
    map['tser'] = '';
    map['typeser'] = '$typeser';
    map['type'] = '$type';
    map['cname'] = '$cname';
    map['branch'] = '';
    map['attn'] = '$attn';
    map['addr_1'] = '$addr_1';
    map['addr_2'] = '';
    map['zip'] = '';
    map['tel'] = '$tel';
    map['tax'] = '$tax';
    map['fax'] = '';
    map['email'] = '$email';
    map['lineid'] = '';
    map['lastday'] = '';
    map['status'] = '';
    map['st'] = '';
    map['map_update'] = '';
    map['cid'] = '';
    map['docno'] = '';
    map['sdate'] = '';
    map['ldate'] = '';
    map['period'] = '';
    map['nday'] = '';
    map['ctype'] = '';
    map['zser'] = '';
    map['zn'] = '';
    map['aser'] = '';
    map['ln'] = '';
    map['qty'] = '';
    map['area'] = '';
    map['rtser'] = '';
    map['rtname'] = '';
    map['user_name'] = '';
    map['passw'] = '';
    map['sname'] = '';

    try {
      // Create a CustomerModel instance from the provided map
      CustomerModel updatedCustomer = CustomerModel.fromJson(map);

      // Update the customerModels list at the specified index
      setState(() {
        customerModels[indexToEdit] = updatedCustomer;
      });

      // Print the updated customer model
      print(' ${map}');
    } catch (e) {
      print('Error: $e');
    }
  }

  // Future<String> check_indexADD(index) async {
  //   bool isOnePresent = ADD_Cus_finished.contains(index);
  //   String bool_ = '';
  //   if (isOnePresent) {
  //     setState(() {
  //       bool_ = 'true';
  //     });
  //     return bool_;
  //   } else {
  //     setState(() {
  //       bool_ = 'true';
  //     });
  //     return bool_;
  //   }
  // }

  String tappedIndex_ = '';
////////----------------------------------------------->
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    minFontSize: 10,
                    maxFontSize: 20,
                    'เพิ่มข้อมูลทะเบียนลูกค้าแบบ ( Excel )',
                    style: TextStyle(
                      color: PeopleChaoScreen_Color.Colors_Text1_,
                      // fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      downloadAndSaveFile();
                    },
                    child: Container(
                      width: 200,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 16,
                          'ตัวอย่าง/รูปแบบไฟล์',
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            // fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      selectFileAndReadExcel();
                    },
                    child: Container(
                      width: 150,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 16,
                          'เลือกไฟล์/นำเข้าไฟล์',
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            // fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      color: AppbackgroundColor.Sub_Abg_Colors,
                      height: MediaQuery.of(context).size.height * 0.48,
                      width: (Responsive.isDesktop(context))
                          ? MediaQuery.of(context).size.width * 0.9
                          : 1000,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppbackgroundColor.TiTile_Colors,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0)),
                              ),
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.9
                                  : 1000,
                              child: Row(
                                children: [
                                  // SizedBox(
                                  //   width: 80,
                                  //   child: AutoSizeText(
                                  //     minFontSize: 10,
                                  //     maxFontSize: 15,
                                  //     '...',
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(
                                  //         color: CustomerScreen_Color
                                  //             .Colors_Text1_,
                                  //         fontWeight: FontWeight.bold,
                                  //         fontFamily: FontWeight_.Fonts_T
                                  //         //fontSize: 10.0
                                  //         //fontSize: 10.0Test_UP_img_Custo
                                  //         ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[300],
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8)),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          'เลือกทั้งหมด',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T
                                              //fontSize: 10.0
                                              //fontSize: 10.0Test_UP_img_Custo
                                              ),
                                        ),
                                      ),
                                      onTap: () {
                                        for (int index = 0;
                                            index < customerModels.length;
                                            index++) {
                                          if (Select_Cus_index.contains(
                                                  index) !=
                                              true) {
                                            setState(() {
                                              Select_Cus_index.add(index);
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'ประเภท',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'ชื่อร้านค้า',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'ประเภทร้านค้า',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'ชื่อผู้เช่า/บริษัท',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'ชื่อผู้ติดต่อ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'ที่อยู่',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'เบอร์โทร',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'อีเมล',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'ID/TAX ID',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      '....',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomerScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T
                                          //fontSize: 10.0
                                          //fontSize: 10.0Test_UP_img_Custo
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  child: ListView.builder(
                                      controller: _scrollController1,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: customerModels.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Material(
                                            color:
                                                tappedIndex_ == index.toString()
                                                    ? tappedIndex_Color
                                                        .tappedIndex_Colors
                                                    : AppbackgroundColor
                                                        .Sub_Abg_Colors,
                                            child: Container(
                                                // color: tappedIndex_ ==
                                                //         index.toString()
                                                //     ? tappedIndex_Color
                                                //         .tappedIndex_Colors
                                                //         .withOpacity(0.5)
                                                //     : null,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: ListTile(
                                                    onTap: () async {
                                                      setState(() {
                                                        tappedIndex_ =
                                                            index.toString();
                                                      });
                                                    },
                                                    title: Row(children: [
                                                      SizedBox(
                                                          width: 80,
                                                          child: (Select_Cus_index
                                                                      .contains(
                                                                          index) ==
                                                                  true)
                                                              ? IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      Select_Cus_index
                                                                          .remove(
                                                                              index);
                                                                    });
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .check_box,
                                                                    color: Colors
                                                                        .red,
                                                                  ))
                                                              : IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      Select_Cus_index
                                                                          .add(
                                                                              index);
                                                                    });
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .check_box_outline_blank))),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 12,
                                                                '${customerModels[index].type}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: CustomerScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  showDialog<
                                                                      String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20.0))),
                                                                      // title: const Center(
                                                                      //     child: Text(
                                                                      //   'เพิ่มข้อมูล',
                                                                      //   style: TextStyle(
                                                                      //       color:
                                                                      //           AdminScafScreen_Color.Colors_Text1_,
                                                                      //       fontWeight: FontWeight.bold,
                                                                      //       fontFamily: FontWeight_.Fonts_T),
                                                                      // )),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            ListBody(
                                                                          children: <Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white.withOpacity(0.3),
                                                                                    borderRadius: const BorderRadius.only(
                                                                                      topLeft: Radius.circular(15),
                                                                                      topRight: Radius.circular(15),
                                                                                      bottomLeft: Radius.circular(15),
                                                                                      bottomRight: Radius.circular(15),
                                                                                    ),
                                                                                    border: Border.all(color: Colors.grey, width: 1),
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: StreamBuilder(
                                                                                      stream: Stream.periodic(const Duration(seconds: 0)),
                                                                                      builder: (context, snapshot) {
                                                                                        return RadioGroup<TypeModel>.builder(
                                                                                          direction: Axis.horizontal,
                                                                                          groupValue: typeModels.elementAt(int.parse(customerModels[index].typeser!)),
                                                                                          horizontalAlignment: MainAxisAlignment.spaceAround,
                                                                                          onChanged: (value) async {
                                                                                            setState(() {
                                                                                              Value_AreaSer_ = int.parse(value!.ser!) - 1;
                                                                                              _verticalGroupValue = value.type!;
                                                                                            });
                                                                                            print(Value_AreaSer_);
                                                                                            print(
                                                                                              'typeModels: ${typeModels.elementAt(Value_AreaSer_).type}',
                                                                                            );
                                                                                            updated_Customer(customerModels[index].scname, customerModels[index].stype, Value_AreaSer_, _verticalGroupValue, customerModels[index].cname, customerModels[index].attn, customerModels[index].addr1, customerModels[index].tel, customerModels[index].tax, customerModels[index].email, index);
                                                                                          },
                                                                                          items: typeModels,
                                                                                          textStyle: const TextStyle(
                                                                                            fontSize: 15,
                                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          ),
                                                                                          itemBuilder: (typeXModels) => RadioButtonBuilder(
                                                                                            typeXModels.type!,
                                                                                          ),
                                                                                        );
                                                                                      })),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: <Widget>[
                                                                        Column(
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 5.0,
                                                                            ),
                                                                            const Divider(
                                                                              color: Colors.grey,
                                                                              height: 4.0,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5.0,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 100,
                                                                                          decoration: const BoxDecoration(
                                                                                            color: Colors.redAccent,
                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: TextButton(
                                                                                            onPressed: () => Navigator.pop(context, 'OK'),
                                                                                            child: const Text(
                                                                                              'ปิด',
                                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                icon: Icon(
                                                                    Icons.edit))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.end,
                                                            // controller:
                                                            //     Add_Number_area_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                              }
                                                              // if (int.parse(value.toString()) < 13) {
                                                              //   return '< 13';
                                                              // }
                                                              return null;
                                                            },
                                                            initialValue:
                                                                customerModels[
                                                                        index]
                                                                    .scname,
                                                            onFieldSubmitted:
                                                                (value) async {
                                                              updated_Customer(
                                                                  value,
                                                                  customerModels[
                                                                          index]
                                                                      .stype,
                                                                  customerModels[
                                                                          index]
                                                                      .typeser,
                                                                  customerModels[
                                                                          index]
                                                                      .type,
                                                                  customerModels[
                                                                          index]
                                                                      .cname,
                                                                  customerModels[
                                                                          index]
                                                                      .attn,
                                                                  customerModels[
                                                                          index]
                                                                      .addr1,
                                                                  customerModels[
                                                                          index]
                                                                      .tel,
                                                                  customerModels[
                                                                          index]
                                                                      .tax,
                                                                  customerModels[
                                                                          index]
                                                                      .email,
                                                                  index);
                                                            },
                                                            // maxLength: 4,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText:
                                                                    //     'เลขเรื่มต้น 1-xxx',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                            // inputFormatters: [
                                                            //   FilteringTextInputFormatter
                                                            //       .deny(RegExp(
                                                            //           r'\s')),
                                                            //   // FilteringTextInputFormatter
                                                            //   //     .deny(RegExp(
                                                            //   //         r'^0')),
                                                            //   FilteringTextInputFormatter
                                                            //       .allow(RegExp(
                                                            //           r'[0-9 .]')),
                                                            // ],
                                                          ),
                                                        ),

                                                        //  AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 18,
                                                        //   '${customerModels[index].scname}',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           color: CustomerScreen_Color
                                                        //               .Colors_Text2_,
                                                        //           // fontWeight: FontWeight.bold,
                                                        //           fontFamily: Font_
                                                        //               .Fonts_T
                                                        // ),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.end,
                                                            // controller:
                                                            //     Add_Number_area_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                              }
                                                              // if (int.parse(value.toString()) < 13) {
                                                              //   return '< 13';
                                                              // }
                                                              return null;
                                                            },
                                                            initialValue:
                                                                customerModels[
                                                                        index]
                                                                    .stype,
                                                            onFieldSubmitted:
                                                                (value) async {
                                                              updated_Customer(
                                                                  customerModels[
                                                                          index]
                                                                      .scname,
                                                                  value,
                                                                  customerModels[
                                                                          index]
                                                                      .typeser,
                                                                  customerModels[
                                                                          index]
                                                                      .type,
                                                                  customerModels[
                                                                          index]
                                                                      .cname,
                                                                  customerModels[
                                                                          index]
                                                                      .attn,
                                                                  customerModels[
                                                                          index]
                                                                      .addr1,
                                                                  customerModels[
                                                                          index]
                                                                      .tel,
                                                                  customerModels[
                                                                          index]
                                                                      .tax,
                                                                  customerModels[
                                                                          index]
                                                                      .email,
                                                                  index);
                                                            },
                                                            // maxLength: 4,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText:
                                                                    //     'เลขเรื่มต้น 1-xxx',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                          ),
                                                        ),

                                                        // AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 18,
                                                        //   '${customerModels[index].stype}',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           color: CustomerScreen_Color
                                                        //               .Colors_Text2_,
                                                        //           // fontWeight: FontWeight.bold,
                                                        //           fontFamily: Font_
                                                        //               .Fonts_T),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.end,
                                                            // controller:
                                                            //     Add_Number_area_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                              }
                                                              // if (int.parse(value.toString()) < 13) {
                                                              //   return '< 13';
                                                              // }
                                                              return null;
                                                            },
                                                            initialValue:
                                                                customerModels[
                                                                        index]
                                                                    .cname,
                                                            onFieldSubmitted:
                                                                (value) async {
                                                              updated_Customer(
                                                                  customerModels[
                                                                          index]
                                                                      .scname,
                                                                  customerModels[
                                                                          index]
                                                                      .stype,
                                                                  customerModels[
                                                                          index]
                                                                      .typeser,
                                                                  customerModels[
                                                                          index]
                                                                      .type,
                                                                  value,
                                                                  customerModels[
                                                                          index]
                                                                      .attn,
                                                                  customerModels[
                                                                          index]
                                                                      .addr1,
                                                                  customerModels[
                                                                          index]
                                                                      .tel,
                                                                  customerModels[
                                                                          index]
                                                                      .tax,
                                                                  customerModels[
                                                                          index]
                                                                      .email,
                                                                  index);
                                                            },
                                                            // maxLength: 4,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText:
                                                                    //     'เลขเรื่มต้น 1-xxx',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                          ),
                                                        ),

                                                        // AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 18,
                                                        //   '${customerModels[index].cname}',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           color: CustomerScreen_Color
                                                        //               .Colors_Text2_,
                                                        //           // fontWeight: FontWeight.bold,
                                                        //           fontFamily: Font_
                                                        //               .Fonts_T),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.end,
                                                            // controller:
                                                            //     Add_Number_area_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                              }
                                                              // if (int.parse(value.toString()) < 13) {
                                                              //   return '< 13';
                                                              // }
                                                              return null;
                                                            },
                                                            initialValue:
                                                                customerModels[
                                                                        index]
                                                                    .attn,
                                                            onFieldSubmitted:
                                                                (value) async {
                                                              updated_Customer(
                                                                  customerModels[
                                                                          index]
                                                                      .scname,
                                                                  customerModels[
                                                                          index]
                                                                      .stype,
                                                                  customerModels[
                                                                          index]
                                                                      .typeser,
                                                                  customerModels[
                                                                          index]
                                                                      .type,
                                                                  customerModels[
                                                                          index]
                                                                      .cname,
                                                                  value,
                                                                  customerModels[
                                                                          index]
                                                                      .addr1,
                                                                  customerModels[
                                                                          index]
                                                                      .tel,
                                                                  customerModels[
                                                                          index]
                                                                      .tax,
                                                                  customerModels[
                                                                          index]
                                                                      .email,
                                                                  index);
                                                            },
                                                            // maxLength: 4,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText:
                                                                    //     'เลขเรื่มต้น 1-xxx',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                          ),
                                                        ),

                                                        //  AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 18,
                                                        //   '${customerModels[index].attn}',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           color: CustomerScreen_Color
                                                        //               .Colors_Text2_,
                                                        //           // fontWeight: FontWeight.bold,
                                                        //           fontFamily: Font_
                                                        //               .Fonts_T),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.end,
                                                            // controller:
                                                            //     Add_Number_area_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                              }
                                                              // if (int.parse(value.toString()) < 13) {
                                                              //   return '< 13';
                                                              // }
                                                              return null;
                                                            },
                                                            initialValue:
                                                                customerModels[
                                                                        index]
                                                                    .addr1,
                                                            onFieldSubmitted:
                                                                (value) async {
                                                              updated_Customer(
                                                                  customerModels[
                                                                          index]
                                                                      .scname,
                                                                  customerModels[
                                                                          index]
                                                                      .stype,
                                                                  customerModels[
                                                                          index]
                                                                      .typeser,
                                                                  customerModels[
                                                                          index]
                                                                      .type,
                                                                  customerModels[
                                                                          index]
                                                                      .cname,
                                                                  customerModels[
                                                                          index]
                                                                      .attn,
                                                                  value,
                                                                  customerModels[
                                                                          index]
                                                                      .tel,
                                                                  customerModels[
                                                                          index]
                                                                      .tax,
                                                                  customerModels[
                                                                          index]
                                                                      .email,
                                                                  index);
                                                            },
                                                            // maxLength: 4,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText:
                                                                    //     'เลขเรื่มต้น 1-xxx',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                          ),
                                                        ),

                                                        //  AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 18,
                                                        //   '${customerModels[index].addr1}',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           color: CustomerScreen_Color
                                                        //               .Colors_Text2_,
                                                        //           // fontWeight: FontWeight.bold,
                                                        //           fontFamily: Font_
                                                        //               .Fonts_T),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.end,
                                                            // controller:
                                                            //     Add_Number_area_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                              }
                                                              // if (int.parse(value.toString()) < 13) {
                                                              //   return '< 13';
                                                              // }
                                                              return null;
                                                            },
                                                            initialValue:
                                                                customerModels[
                                                                        index]
                                                                    .tel,
                                                            onFieldSubmitted:
                                                                (value) async {
                                                              updated_Customer(
                                                                  customerModels[
                                                                          index]
                                                                      .scname,
                                                                  customerModels[
                                                                          index]
                                                                      .stype,
                                                                  customerModels[
                                                                          index]
                                                                      .typeser,
                                                                  customerModels[
                                                                          index]
                                                                      .type,
                                                                  customerModels[
                                                                          index]
                                                                      .cname,
                                                                  customerModels[
                                                                          index]
                                                                      .attn,
                                                                  customerModels[
                                                                          index]
                                                                      .addr1,
                                                                  value,
                                                                  customerModels[
                                                                          index]
                                                                      .tax,
                                                                  customerModels[
                                                                          index]
                                                                      .email,
                                                                  index);
                                                            },
                                                            // maxLength: 4,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText:
                                                                    //     'เลขเรื่มต้น 1-xxx',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .deny(RegExp(
                                                                      r'\s')),
                                                              // FilteringTextInputFormatter
                                                              //     .deny(RegExp(
                                                              //         r'^0')),
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      r'[0-9 .]')),
                                                            ],
                                                          ),
                                                        ),

                                                        //  AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 18,
                                                        //   '${customerModels[index].tel}',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           color: CustomerScreen_Color
                                                        //               .Colors_Text2_,
                                                        //           // fontWeight: FontWeight.bold,
                                                        //           fontFamily: Font_
                                                        //               .Fonts_T),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.end,
                                                            // controller:
                                                            //     Add_Number_area_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                              }
                                                              // if (int.parse(value.toString()) < 13) {
                                                              //   return '< 13';
                                                              // }
                                                              return null;
                                                            },
                                                            initialValue:
                                                                customerModels[
                                                                        index]
                                                                    .email,
                                                            onFieldSubmitted:
                                                                (value) async {
                                                              updated_Customer(
                                                                  customerModels[
                                                                          index]
                                                                      .scname,
                                                                  customerModels[
                                                                          index]
                                                                      .stype,
                                                                  customerModels[
                                                                          index]
                                                                      .typeser,
                                                                  customerModels[
                                                                          index]
                                                                      .type,
                                                                  customerModels[
                                                                          index]
                                                                      .cname,
                                                                  customerModels[
                                                                          index]
                                                                      .attn,
                                                                  customerModels[
                                                                          index]
                                                                      .addr1,
                                                                  customerModels[
                                                                          index]
                                                                      .tel,
                                                                  customerModels[
                                                                          index]
                                                                      .tax,
                                                                  value,
                                                                  index);
                                                            },
                                                            // maxLength: 4,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText:
                                                                    //     'เลขเรื่มต้น 1-xxx',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                          ),
                                                        ),

                                                        // AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 18,
                                                        //   '${customerModels[index].email}',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           color: CustomerScreen_Color
                                                        //               .Colors_Text2_,
                                                        //           // fontWeight: FontWeight.bold,
                                                        //           fontFamily: Font_
                                                        //               .Fonts_T),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.end,
                                                            // controller:
                                                            //     Add_Number_area_,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                              }
                                                              // if (int.parse(value.toString()) < 13) {
                                                              //   return '< 13';
                                                              // }
                                                              return null;
                                                            },
                                                            initialValue:
                                                                customerModels[
                                                                        index]
                                                                    .tax,
                                                            onFieldSubmitted:
                                                                (value) async {
                                                              updated_Customer(
                                                                  customerModels[
                                                                          index]
                                                                      .scname,
                                                                  customerModels[
                                                                          index]
                                                                      .stype,
                                                                  customerModels[
                                                                          index]
                                                                      .typeser,
                                                                  customerModels[
                                                                          index]
                                                                      .type,
                                                                  customerModels[
                                                                          index]
                                                                      .cname,
                                                                  customerModels[
                                                                          index]
                                                                      .attn,
                                                                  customerModels[
                                                                          index]
                                                                      .addr1,
                                                                  customerModels[
                                                                          index]
                                                                      .tel,
                                                                  value,
                                                                  customerModels[
                                                                          index]
                                                                      .email,
                                                                  index);
                                                            },
                                                            // maxLength: 4,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person_pin, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText:
                                                                    //     'เลขเรื่มต้น 1-xxx',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    )),
                                                          ),
                                                        ),

                                                        // AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 18,
                                                        //   '${customerModels[index].tax}',
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           color: CustomerScreen_Color
                                                        //               .Colors_Text2_,
                                                        //           // fontWeight: FontWeight.bold,
                                                        //           fontFamily: Font_
                                                        //               .Fonts_T),
                                                        // ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: InkWell(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: (ADD_Cus_finished
                                                                          .contains(
                                                                              index) ==
                                                                      true)
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .green,
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft:
                                                                      Radius.circular(
                                                                          15),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15)),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 18,
                                                                'เพิ่ม',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: (ADD_Cus_finished
                                                                      .contains(
                                                                          index) ==
                                                                  true)
                                                              ? null
                                                              : () async {
                                                                  setState(() {
                                                                    tappedIndex_ =
                                                                        index
                                                                            .toString();
                                                                  });
                                                                  var scname_ =
                                                                      customerModels[
                                                                              index]
                                                                          .scname!;
                                                                  var stype_ =
                                                                      customerModels[
                                                                              index]
                                                                          .stype!;

                                                                  var type_ = customerModels[
                                                                          index]
                                                                      .type
                                                                      .toString()
                                                                      .trim();

                                                                  var cname_ =
                                                                      customerModels[
                                                                              index]
                                                                          .cname!;

                                                                  var attn_ =
                                                                      customerModels[
                                                                              index]
                                                                          .attn!;

                                                                  var addr1_ =
                                                                      customerModels[
                                                                              index]
                                                                          .addr1!;

                                                                  var tel_ =
                                                                      customerModels[
                                                                              index]
                                                                          .tel!;

                                                                  var tax_ =
                                                                      customerModels[
                                                                              index]
                                                                          .tax!;
                                                                  var email_ =
                                                                      customerModels[
                                                                              index]
                                                                          .email!;

                                                                  showDialog<
                                                                      String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        StreamBuilder(
                                                                            stream:
                                                                                Stream.periodic(const Duration(seconds: 0)),
                                                                            builder: (context, snapshot) {
                                                                              return AlertDialog(
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                title: const Center(
                                                                                    child: Text(
                                                                                  'เพิ่มข้อมูล',
                                                                                  style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                )),
                                                                                content: SingleChildScrollView(
                                                                                  child: ListBody(
                                                                                    children: <Widget>[
                                                                                      Text(
                                                                                        'ลำดับ : ${index + 1}',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'ประเภท : $type_  }',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'ชื่อร้านค้า : $scname_',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'ประเภทร้านค้า : $stype_',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'ชื่อผู้เช่า/บริษัท : $cname_',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'ชื่อผู้ติดต่อ : $attn_',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'ที่อยู่ : $addr1_',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'เบอร์โทร : $tel_',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'อีเมล : $email_',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                      Text(
                                                                                        'ID/TAX ID : $tax_ ',
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  Column(
                                                                                    children: [
                                                                                      const SizedBox(
                                                                                        height: 5.0,
                                                                                      ),
                                                                                      const Divider(
                                                                                        color: Colors.grey,
                                                                                        height: 4.0,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5.0,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Container(
                                                                                                width: 100,
                                                                                                decoration: const BoxDecoration(
                                                                                                  color: Colors.green,
                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                ),
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: TextButton(
                                                                                                  onPressed: () async {
                                                                                                    SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                    var ren = preferences.getString('renTalSer');
                                                                                                    var user = preferences.getString('ser');
                                                                                                    String url = '${MyConstant().domain}/InC_CustoAdd_Bureau.php?isAdd=true&ren=$ren';
                                                                                                    try {
                                                                                                      var response = await http.post(Uri.parse(url), body: {
                                                                                                        'ciddoc': '',
                                                                                                        'qutser': '',
                                                                                                        'user': '',
                                                                                                        'sumdis': '',
                                                                                                        'sumdisp': '',
                                                                                                        'dateY': '',
                                                                                                        'dateY1': '',
                                                                                                        'time': '',
                                                                                                        'payment1': '',
                                                                                                        'payment2': '',
                                                                                                        'pSer1': '',
                                                                                                        'pSer2': '',
                                                                                                        'sum_whta': '',
                                                                                                        'bill': '',
                                                                                                        'fileNameSlip': '',
                                                                                                        'areaSer': (type_ == 'ส่วนตัว/บุคคลธรรมดา') ? '1' : '2',
                                                                                                        'typeModels': '${type_}',
                                                                                                        'typeshop': stype_,
                                                                                                        'nameshop': scname_,
                                                                                                        'bussshop': cname_,
                                                                                                        'bussscontact': attn_,
                                                                                                        'address': addr1_,
                                                                                                        'tel': tel_,
                                                                                                        'tax': tax_,
                                                                                                        'email': email_,
                                                                                                        'Serbool': '',
                                                                                                        'area_rent_sum': '',
                                                                                                        'comment': '',
                                                                                                        'zser': ''.trim().toString(),
                                                                                                      }).then((value) => {
                                                                                                            setState(() {
                                                                                                              ADD_Cus_finished.add(index);
                                                                                                              Navigator.pop(context, 'OK');
                                                                                                            })
                                                                                                          });
                                                                                                    } catch (e) {
                                                                                                      Navigator.pop(context, 'OK');
                                                                                                    }
                                                                                                  },
                                                                                                  child: const Text(
                                                                                                    'ยืนยัน',
                                                                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 100,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      color: Colors.redAccent,
                                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                    ),
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: TextButton(
                                                                                                      onPressed: () => Navigator.pop(context, 'OK'),
                                                                                                      child: const Text(
                                                                                                        'ยกเลิก',
                                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }),
                                                                  );

                                                                  print(
                                                                      '${scname_},  ${email_}');
                                                                },
                                                        ),
                                                      ),
                                                    ]))));
                                      })),
                            ),
                          ),
                        ],
                      ),

                      //  Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Container(
                      //         decoration: const BoxDecoration(
                      //           color: AppbackgroundColor.Sub_Abg_Colors,
                      //           borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(10),
                      //               topRight: Radius.circular(10),
                      //               bottomLeft: Radius.circular(10),
                      //               bottomRight: Radius.circular(10)),
                      //         ),
                      //         child: ScrollConfiguration(
                      //           behavior: ScrollConfiguration.of(context)
                      //               .copyWith(dragDevices: {
                      //             PointerDeviceKind.touch,
                      //             PointerDeviceKind.mouse,
                      //           }),
                      //           child: SingleChildScrollView(
                      //               scrollDirection: Axis.horizontal,
                      //               child: Row(children: [

                      //               ])),
                      //         )))
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: AutoSizeText(
                    minFontSize: 10,
                    maxFontSize: 18,
                    '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: CustomerScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T
                        //fontSize: 10.0
                        //fontSize: 10.0
                        ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: const AutoSizeText(
                      minFontSize: 8,
                      maxFontSize: 12,
                      '**กด Enter ทุกครั้งที่มีการเปลี่ยนแปลงข้อมูล',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T
                          //fontSize: 10.0
                          //fontSize: 10.0
                          ),
                    ),
                  ),
                ),
              ],
            )),
            Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _scrollController1.animateTo(
                                  0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    // color: AppbackgroundColor
                                    //     .TiTile_Colors,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(8)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(3.0),
                                  child: const Text(
                                    'Top',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: FontWeight_.Fonts_T),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_scrollController1.hasClients) {
                                final position =
                                    _scrollController1.position.maxScrollExtent;
                                _scrollController1.animateTo(
                                  position,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  // color: AppbackgroundColor
                                  //     .TiTile_Colors,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(3.0),
                                child: const Text(
                                  'Down',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: FontWeight_.Fonts_T),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: _moveUp1,
                            child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.grey,
                                  ),
                                )),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                // color: AppbackgroundColor
                                //     .TiTile_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(3.0),
                              child: const Text(
                                'Scroll',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                    fontFamily: FontWeight_.Fonts_T),
                              )),
                          InkWell(
                            onTap: _moveDown1,
                            child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Colors.grey,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      minFontSize: 8,
                      maxFontSize: 14,
                      'รายการที่เลือกทั้งหมด : ${Select_Cus_index.length}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        // fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (Select_Cus_index.length == 0)
                          ? null
                          : () async {
                              int serr_showDialog = 0;
                              showDialog<String>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) =>
                                      StreamBuilder(
                                          stream: Stream.periodic(
                                              const Duration(seconds: 0)),
                                          builder: (context, snapshot) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: Center(
                                                child: (serr_showDialog == 1)
                                                    ? Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child:
                                                            const CircularProgressIndicator())
                                                    : Text(
                                                        'ยืนยันการเพิ่มใช่หรือไม่',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T),
                                                      ),
                                              ),
                                              actions: <Widget>[
                                                Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                      height: 4.0,
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: (serr_showDialog ==
                                                                        1)
                                                                    ? Colors.grey[
                                                                        400]
                                                                    : Colors
                                                                        .green,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  setState(() {
                                                                    serr_showDialog =
                                                                        1;
                                                                  });
                                                                  SharedPreferences
                                                                      preferences =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  var ren = preferences
                                                                      .getString(
                                                                          'renTalSer');
                                                                  var user = preferences
                                                                      .getString(
                                                                          'ser');
                                                                  String url =
                                                                      '${MyConstant().domain}/InC_CustoAdd_Bureau.php?isAdd=true&ren=$ren';
                                                                  for (int index =
                                                                          0;
                                                                      index <
                                                                          Select_Cus_index
                                                                              .length;
                                                                      index++) {
                                                                    var scname_ =
                                                                        customerModels[index]
                                                                            .scname!;
                                                                    var stype_ =
                                                                        customerModels[index]
                                                                            .stype!;

                                                                    var type_ = customerModels[
                                                                            index]
                                                                        .type
                                                                        .toString()
                                                                        .trim();

                                                                    var cname_ =
                                                                        customerModels[index]
                                                                            .cname!;

                                                                    var attn_ =
                                                                        customerModels[index]
                                                                            .attn!;

                                                                    var addr1_ =
                                                                        customerModels[index]
                                                                            .addr1!;

                                                                    var tel_ =
                                                                        customerModels[index]
                                                                            .tel!;

                                                                    var tax_ =
                                                                        customerModels[index]
                                                                            .tax!;
                                                                    var email_ =
                                                                        customerModels[index]
                                                                            .email!;
                                                                    try {
                                                                      var response = await http.post(
                                                                          Uri.parse(
                                                                              url),
                                                                          body: {
                                                                            'ciddoc':
                                                                                '',
                                                                            'qutser':
                                                                                '',
                                                                            'user':
                                                                                '',
                                                                            'sumdis':
                                                                                '',
                                                                            'sumdisp':
                                                                                '',
                                                                            'dateY':
                                                                                '',
                                                                            'dateY1':
                                                                                '',
                                                                            'time':
                                                                                '',
                                                                            'payment1':
                                                                                '',
                                                                            'payment2':
                                                                                '',
                                                                            'pSer1':
                                                                                '',
                                                                            'pSer2':
                                                                                '',
                                                                            'sum_whta':
                                                                                '',
                                                                            'bill':
                                                                                '',
                                                                            'fileNameSlip':
                                                                                '',
                                                                            'areaSer': (type_ == 'ส่วนตัว/บุคคลธรรมดา')
                                                                                ? '1'
                                                                                : '2',
                                                                            'typeModels':
                                                                                '${type_}',
                                                                            'typeshop':
                                                                                stype_,
                                                                            'nameshop':
                                                                                scname_,
                                                                            'bussshop':
                                                                                cname_,
                                                                            'bussscontact':
                                                                                attn_,
                                                                            'address':
                                                                                addr1_,
                                                                            'tel':
                                                                                tel_,
                                                                            'tax':
                                                                                tax_,
                                                                            'email':
                                                                                email_,
                                                                            'Serbool':
                                                                                '',
                                                                            'area_rent_sum':
                                                                                '',
                                                                            'comment':
                                                                                '',
                                                                            'zser':
                                                                                ''.trim().toString(),
                                                                          }).then(
                                                                          (value) =>
                                                                              {
                                                                                setState(() {
                                                                                  ADD_Cus_finished.add(index);
                                                                                  // Navigator.pop(context, 'OK');
                                                                                })
                                                                              });
                                                                    } catch (e) {
                                                                      // Navigator.pop(context, 'OK');
                                                                    }
                                                                    if (index +
                                                                            1 ==
                                                                        Select_Cus_index
                                                                            .length) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                            backgroundColor:
                                                                                Colors.green,
                                                                            content: Text('ทำรายการเสร็จสิ้น ...!!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T))),
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        serr_showDialog =
                                                                            0;
                                                                        Select_Cus_index
                                                                            .clear();
                                                                        Select_Cus_index
                                                                            .clear();
                                                                        customerModels
                                                                            .clear();
                                                                      });
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK');
                                                                    }
                                                                  }
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'ยืนยัน',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 100,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context,
                                                                      'OK');
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'ปิด',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          }));
                            },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: (Select_Cus_index.length == 0)
                              ? Colors.blue[100]
                              : Colors.blue,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          // border:
                          //     Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: AutoSizeText(
                            minFontSize: 8,
                            maxFontSize: 14,
                            'ยืนยันการเพิ่ม',
                            style: TextStyle(
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: 200,
            //     // color: Colors.blue,
            //     child: Row(
            //       children: [
            //         Expanded(
            //           flex: 1,
            //           child: Container(
            //             // color: Colors.red,
            //             child: Column(
            //               children: [],
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           flex: 2,
            //           child: Container(
            //             color: AppbackgroundColor.Abg_Colors.withOpacity(0.5),
            //             // decoration: BoxDecoration(
            //             //   color: Colors.green[200],
            //             //   borderRadius: const BorderRadius.only(
            //             //     topLeft: Radius.circular(8),
            //             //     topRight: Radius.circular(8),
            //             //     bottomLeft: Radius.circular(0),
            //             //     bottomRight: Radius.circular(0),
            //             //   ),
            //             //   // border:
            //             //   //     Border.all(color: Colors.white, width: 2),
            //             // ),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Container(
            //                   height: 40,
            //                   decoration: BoxDecoration(
            //                     color: Colors.green[200],
            //                     borderRadius: const BorderRadius.only(
            //                       topLeft: Radius.circular(8),
            //                       topRight: Radius.circular(8),
            //                       bottomLeft: Radius.circular(0),
            //                       bottomRight: Radius.circular(0),
            //                     ),
            //                   ),
            //                 ),
            //                 Expanded(
            //                     child: Container(
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Text(
            //                           'เพิ่มรายการที่เลือกทั้งหมด',
            //                           textAlign: TextAlign.center,
            //                           style: TextStyle(
            //                               color: CustomerScreen_Color
            //                                   .Colors_Text2_,
            //                               fontWeight: FontWeight.bold,
            //                               fontFamily: FontWeight_.Fonts_T
            //                               //fontSize: 10.0
            //                               ),
            //                         ),
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: InkWell(
            //                           onTap: () {},
            //                           child: Container(
            //                             width: 150,
            //                             decoration: BoxDecoration(
            //                               color: Colors.blue,
            //                               borderRadius: const BorderRadius.only(
            //                                 topLeft: Radius.circular(8),
            //                                 topRight: Radius.circular(8),
            //                                 bottomLeft: Radius.circular(8),
            //                                 bottomRight: Radius.circular(8),
            //                               ),
            //                               // border:
            //                               //     Border.all(color: Colors.white, width: 2),
            //                             ),
            //                             padding: const EdgeInsets.all(8.0),
            //                             child: Center(
            //                               child: AutoSizeText(
            //                                 minFontSize: 8,
            //                                 maxFontSize: 14,
            //                                 'ยืนยันการเพิ่ม',
            //                                 style: TextStyle(
            //                                   color: Colors.black,
            //                                   // fontWeight: FontWeight.bold,
            //                                   fontFamily: FontWeight_.Fonts_T,
            //                                   fontWeight: FontWeight.bold,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ))
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
