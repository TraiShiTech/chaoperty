// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member
import 'dart:convert';
import 'dart:html';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto/crypto.dart';
import 'package:excel/excel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetContract_Model.dart';
import '../Model/GetContract_Photo_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetType_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Add_Custo_Screen.dart';
import 'package:universal_html/html.dart' as html;

class CustomerScreen extends StatefulWidget {
  final updateMessage1;
  const CustomerScreen({super.key, this.updateMessage1});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  ScrollController _scrollController1 = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final Form_User = TextEditingController();
  final Form_UserPass = TextEditingController();
  int Status_cuspang = 0;
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  List<CustomerModel> customerModels = [];
  List<CustomerModel> limitedList_customerModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];
  List<TransReBillModel> _TransReBillModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<FinnancetransModel> finnancetransModels = [];
  List<TeNantModel> teNantModels = [];
  List<ContractModel> contractModels = [];
  List<TypeModel> typeModels = [];
  String _verticalGroupValue = '';
  String? renTal_user, renTal_name, zone_ser, zone_name, pdate, numinvoice;
  int select_coutumerindex = 0;
  int? Value_AreaSer_;
  int Total_doctax = 0;
  int Total_late_payment = 0; //ชำระเกินกำหนด
  int Total_early_payment = 0; //ชำระก่อรกำหนด
  int Total_ontime_payment = 0; //ชำระตรงเวลา
  double Total_tenant = 0; //ค้างชำระ
  List<String> addAreaCusto1 = [];
  List<String> addAreaCusto2 = [];
  List<String> addAreaCusto3 = [];
  List<String> addAreaCusto4 = [];
  List<ContractPhotoModel> contractPhotoModels = [];
  List<RenTalModel> renTalModels = [];
  List<String> addrtname = [];
  double Total_amtbill = 0.0;
  String tappedIndex_ = '';
  String tappedIndex_2 = '';
  String? _Form_nameshop,
      _Form_typeshop,
      _Form_bussshop,
      _Form_bussscontact,
      _Form_address,
      _Form_tel,
      _Form_email,
      _Form_tax,
      _Form_Ser,
      pic_tenant,
      pic_shop,
      pic_plan,
      fiew;
/////////---------------------->
  int limit = 100; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;

  ///--------------->
  final Form_nameshop_ = TextEditingController();
  final Form_typeshop_ = TextEditingController();
  final Form_bussshop_ = TextEditingController();
  final Form_bussscontact_ = TextEditingController();
  final Form_address_ = TextEditingController();
  final Form_tel_ = TextEditingController();
  final Form_email_ = TextEditingController();
  final Form_tax_ = TextEditingController();
  String? Form_Img_;
  String? ser_user,
      foder,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      tel_user,
      img_,
      img_logo;
  String? rtname,
      type,
      typex,
      renname,
      pkname,
      ser_Zonex,
      Value_stasus,
      cust_no_;
  int? pkqty, pkuser, countarae;
  @override
  void initState() {
    super.initState();
    Status_cuspang = 0;
    checkPreferance();
    read_GC_rental();
    select_coutumer();
    read_GC_type();
  }

////////////////////123456
  int Status_ = 1;
  List Status = [
    'ทะเบียนลูกค้า',
    'ทะเบียนมิเตอร์',
  ];
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;
  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
  }
  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      //  print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);
          var rtnamex = renTalModel.rtname;
          var typexs = renTalModel.type;
          var typexx = renTalModel.typex;
          var name = renTalModel.pn!.trim();
          var pkqtyx = int.parse(renTalModel.pkqty!);
          var pkuserx = int.parse(renTalModel.pkuser!);
          var pkx = renTalModel.pk!.trim();
          var foderx = renTalModel.dbn;
          var img = renTalModel.img;
          var imglogo = renTalModel.imglogo;
          var open_set_datex = int.parse(renTalModel.open_set_date!);
          setState(() {
            // open_set_date = open_set_datex == 0 ? 30 : open_set_datex;
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            pkqty = pkqtyx;
            pkuser = pkuserx;
            // DBN_ = renTalModel.dbn;
            pkname = pkx;
            img_ = img;
            img_logo = imglogo;
            // ser_Floor_plans = renTalModel.Floor_plans!;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }
  // Future<Null> read_GC_rental() async {
  //   if (renTalModels.isNotEmpty) {
  //     renTalModels.clear();
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var utype = preferences.getString('utype');
  //   var seruser = preferences.getString('ser');
  //   String url =
  //       '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result != null) {
  //       for (var map in result) {
  //         RenTalModel renTalModel = RenTalModel.fromJson(map);
  //         var rtnamex = renTalModel.rtname;
  //         var typexs = renTalModel.type;
  //         var typexx = renTalModel.typex;
  //         var name = renTalModel.pn!.trim();
  //         var pkqtyx = int.parse(renTalModel.pkqty!);
  //         var pkuserx = int.parse(renTalModel.pkuser!);
  //         var pkx = renTalModel.pk!.trim();
  //         var foderx = renTalModel.dbn;
  //         var img = renTalModel.img;
  //         var imglogo = renTalModel.imglogo;
  //         setState(() {
  //           foder = foderx;
  //           rtname = rtnamex;
  //           type = typexs;
  //           typex = typexx;
  //           renname = name;
  //           pkqty = pkqtyx;
  //           pkuser = pkuserx;
  //           pkname = pkx;
  //           img_ = img;
  //           img_logo = imglogo;
  //           renTalModels.add(renTalModel);
  //         });
  //       }
  //     } else {}
  //   } catch (e) {}
  //   print('name>>>>>  $renname');
  // }

  Future<Null> read_GC_Contract(custno_) async {
    if (contractModels.isNotEmpty) {
      contractModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');
    String url =
        '${MyConstant().domain}/GC_ContractAll_Bureau_Custo.php?isAdd=true&ren=$ren&zone=$zone&custno_c=$custno_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      //print(result);
      if (result != null) {
        for (var map in result) {
          ContractModel contractModelss = ContractModel.fromJson(map);
          setState(() {
            contractModels.add(contractModelss);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_tenant(custno_) async {
    DateTime datex = DateTime.now();
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');

    String url =
        '${MyConstant().domain}/GC_tenantAll_Bureau_Custo.php?isAdd=true&ren=$ren&zone=$zone&custno_c=$custno_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            teNantModels.add(teNantModel);
          });
        }
        for (int index = 0; index < teNantModels.length; index++) {
          if (teNantModels[index].rtname.toString() != 'null') {
            if (!addrtname.contains(
              '${teNantModels[index].rtname}',
            )) {
              addrtname.add(
                '${teNantModels[index].rtname}',
              );

              addrtname.sort();
            }
          }

          if (teNantModels[index].quantity == '1') {
            if (datex.isAfter(
                    DateTime.parse('${teNantModels[index].ldate} 00:00:00.000')
                        .subtract(const Duration(days: 0))) ==
                true) {
              ///////////--------------------------->(1)
              if (!addAreaCusto1.contains(
                teNantModels[index].ln_c == null
                    ? teNantModels[index].ln_q == null
                        ? ''
                        : '${teNantModels[index].ln_q}'
                    : '${teNantModels[index].ln_c}',
              )) {
                addAreaCusto1.add(
                  teNantModels[index].ln_c == null
                      ? teNantModels[index].ln_q == null
                          ? ''
                          : '${teNantModels[index].ln_q}'
                      : '${teNantModels[index].ln_c}',
                );

                addAreaCusto1.sort();
              }
              ///////////--------------------------->(1)
            } else if (datex.isAfter(
                    DateTime.parse('${teNantModels[index].ldate} 00:00:00.000')
                        .subtract(const Duration(days: 30))) ==
                true) {
              ///////////--------------------------->(2)
              if (!addAreaCusto2.contains(
                teNantModels[index].ln_c == null
                    ? teNantModels[index].ln_q == null
                        ? ''
                        : '${teNantModels[index].ln_q}'
                    : '${teNantModels[index].ln_c}',
              )) {
                addAreaCusto2.add(
                  teNantModels[index].ln_c == null
                      ? teNantModels[index].ln_q == null
                          ? ''
                          : '${teNantModels[index].ln_q}'
                      : '${teNantModels[index].ln_c}',
                );

                addAreaCusto2.sort();
              }
              ///////////--------------------------->(2)
            } else {
              ///////////--------------------------->(3)
              if (!addAreaCusto3.contains(
                teNantModels[index].ln_c == null
                    ? teNantModels[index].ln_q == null
                        ? ''
                        : '${teNantModels[index].ln_q}'
                    : '${teNantModels[index].ln_c}',
              )) {
                addAreaCusto3.add(
                  teNantModels[index].ln_c == null
                      ? teNantModels[index].ln_q == null
                          ? ''
                          : '${teNantModels[index].ln_q}'
                      : '${teNantModels[index].ln_c}',
                );

                addAreaCusto3.sort();
              }
              ///////////--------------------------->(3)
            }
          } else if (teNantModels[index].quantity == '2') {
            ///////////--------------------------->(4)
            if (!addAreaCusto4.contains(
              teNantModels[index].ln_c == null
                  ? teNantModels[index].ln_q == null
                      ? ''
                      : '${teNantModels[index].ln_q}'
                  : '${teNantModels[index].ln_c}',
            )) {
              addAreaCusto4.add(
                teNantModels[index].ln_c == null
                    ? teNantModels[index].ln_q == null
                        ? ''
                        : '${teNantModels[index].ln_q}'
                    : '${teNantModels[index].ln_c}',
              );

              addAreaCusto4.sort();
            }
            ///////////--------------------------->(4)
          } else if (teNantModels[index].quantity == '3') {}
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_tenant1(custno_) async {
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');

    String url = zone == null
        ? '${MyConstant().domain}/GC_tenantAll_setring1_Customer.php?isAdd=true&ren=$ren&custno_c=$custno_'
        : zone == '0'
            ? '${MyConstant().domain}/GC_tenantAll_setring1_Customer.php?isAdd=true&ren=$ren&custno_c=$custno_'
            : '${MyConstant().domain}/GC_tenantAll_setring1_Customer.php?isAdd=true&ren=$ren&custno_c=$custno_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          if (teNantModel.count_bill != null) {
            setState(() {
              Total_tenant = Total_tenant +
                  double.parse(teNantModel.count_bill.toString());
            });
          }

          setState(() {
            if (teNantModel.cid != '') {
              var daterx = teNantModel.ldate;
              if (daterx != null) {
                // int daysBetween(DateTime from, DateTime to) {
                //   from = DateTime(from.year, from.month, from.day);
                //   to = DateTime(to.year, to.month, to.day);
                //   return (to.difference(from).inHours / 24).round();
                // }

                // var birthday = DateTime.parse('$daterx 00:00:00.000')
                //     .add(const Duration(days: -30));
                // var date2 = DateTime.now();
                // var difference = daysBetween(birthday, date2);

                // print('difference == $difference');

                // var daterx_now = DateTime.now();

                var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

                final now = DateTime.now();
                final earlier = daterx_ldate.subtract(const Duration(days: 0));
                var daterx_A = now.isAfter(earlier);
                print(now.isAfter(earlier)); // true
                print(now.isBefore(earlier)); // true

                if (daterx_A != true) {
                  setState(() {
                    teNantModels.add(teNantModel);
                  });
                }
              }

              // setState(() {
              //   teNantModels.add(teNantModel);
              // });
            }
            // teNantModels.add(teNantModel);
          });
        }
      } else {
        setState(() {
          if (teNantModels.isEmpty) {
            preferences.remove('zonePSer');
            preferences.remove('zonesPName');
            zone_ser = null;
            zone_name = null;
          }
        });
      }

      setState(() {
        zone_ser = preferences.getString('zonePSer');
        zone_name = preferences.getString('zonesPName');
      });
    } catch (e) {}
  }

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

  Future<Null> red_Invoice(index) async {
    if (finnancetransModels.length != 0) {
      setState(() {
        finnancetransModels.clear();
        sum_disamt = 0;
        sum_disp = 0;
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = _TransReBillModels[index].ser;
    var qutser = _TransReBillModels[index].ser_in;
    var docnoin = _TransReBillModels[index].docno;
    print('>>>>>>>>>>>dd>>> in d  $docnoin');

    String url =
        '${MyConstant().domain}/GC_bill_pay_amt.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      print('BBBBBBBBBBBBBBBB>>>> $result');
      if (result.toString() != 'null') {
        for (var map in result) {
          FinnancetransModel finnancetransModel =
              FinnancetransModel.fromJson(map);

          var sidamt = double.parse(finnancetransModel.amt!);
          var siddisper = double.parse(finnancetransModel.disper!);
          var pdatex = finnancetransModel.pdate!;
          setState(() {
            pdate = pdatex;
          });
          print(
              '>>>>>red_Invoice>>>>>>dd>>> in $sidamt $siddisper >>>>>>>>>>>dd>>> in  $pdatex ///$pdate');
          if (int.parse(finnancetransModel.receiptSer!) != 0) {
            finnancetransModels.add(finnancetransModel);
          } else {
            if (finnancetransModel.type!.trim() == 'DISCOUNT') {
              setState(() {
                sum_disamt = sidamt;
                sum_disp = siddisper;
              });
            }
          }
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_select(index) async {
    if (_TransReBillHistoryModels.length != 0) {
      setState(() {
        _TransReBillHistoryModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        // sum_disamt = 0;
        // sum_disp = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = _TransReBillModels[index].ser;
    var qutser = _TransReBillModels[index].ser_in;
    var docnoin = _TransReBillModels[index].docno;
    String url =
        '${MyConstant().domain}/GC_bill_pay_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel _TransReBillHistoryModel =
              TransReBillHistoryModel.fromJson(map);

          var sum_pvatx = double.parse(_TransReBillHistoryModel.pvat!);
          var sum_vatx = double.parse(_TransReBillHistoryModel.vat!);
          var sum_whtx = double.parse(_TransReBillHistoryModel.wht!);
          var sum_amtx = double.parse(_TransReBillHistoryModel.total!);
          // var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
          // var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
          var numinvoiceent = _TransReBillHistoryModel.docno;
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            // sum_disamt = sum_disamtx;
            // sum_disp = sum_dispx;
            numinvoice = _TransReBillHistoryModel.docno;
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          });
        }
      }
      // setState(() {
      //   red_Invoice();
      // });
    } catch (e) {}
  }

  Future<Null> red_Trans_bill(custno_) async {
    if (_TransReBillModels.length != 0) {
      setState(() {
        _TransReBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_Customer.php?isAdd=true&ren=$ren&cust=$custno_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          String sdatex = '${transReBillModel.date.toString()}';
          String ldatex = '${transReBillModel.pdate.toString()}';

          DateTime startDate = DateTime.parse(sdatex);
          DateTime endDate = DateTime.parse(ldatex);
          if (transReBillModel.doctax.toString() != '') {
            setState(() {
              Total_doctax = Total_doctax + 1;
            });
          } else {}
          if (endDate.isAfter(startDate)) {
            Total_late_payment = Total_late_payment + 1;
          } else if (startDate.isAfter(endDate)) {
            Total_early_payment = Total_early_payment + 1;
          } else if (startDate == endDate) {
            Total_ontime_payment = Total_ontime_payment + 1;
          }
          setState(() {
            Total_amtbill = Total_amtbill +
                double.parse(transReBillModel.total_bill.toString());

            // if (!addAreaCusto.contains(transReBillModel.ln.toString())) {
            //   addAreaCusto.add(
            //     transReBillModel.ln == null
            //         ? '${transReBillModel.room_number}'
            //         : '${transReBillModel.ln}',
            //   );

            //   addAreaCusto.sort();
            // }

            _TransReBillModels.add(transReBillModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }

        print('result ${_TransReBillModels.length}');
        // setState(() {
        //   TransReBillModels =
        //       List.generate(_TransReBillModels.length, (_) => []);
        // });

        // for (int index = 0; index < _TransReBillModels.length; index++) {
        //   red_Trans_select(index);
        // }
      }
    } catch (e) {}
  }

  Future<Null> read_GC_photo(custno_) async {
    setState(() {
      contractPhotoModels.clear();
      pic_tenant = null;
      pic_shop = null;
      pic_plan = null;
    });
    ////////////////------------------------------------------------------>
    SharedPreferences preferences = await SharedPreferences.getInstance();

    ////////////////------------------------------------------------------>
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_photo_cont_Bureau.php?isAdd=true&ren=$ren&Custno=$custno_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          ContractPhotoModel contractPhotoModel =
              ContractPhotoModel.fromJson(map);

          var pic_tenantx = contractPhotoModel.pic_tenant!.trim();
          var pic_shopx = contractPhotoModel.pic_shop!.trim();
          var pic_planx = contractPhotoModel.pic_plan!.trim();
          setState(() {
            pic_tenant = pic_tenantx;
            pic_shop = pic_shopx;
            pic_plan = pic_planx;
            contractPhotoModels.add(contractPhotoModel);
          });
          // print('pic_tenantx');
          // print(pic_tenantx);
        }
      }
    } catch (e) {}
  }

  _searchBar() {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 0)),
        builder: (context, snapshot) {
          return TextField(
            autofocus: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              // fontSize: 22.0,
              color: TextHome_Color.TextHome_Colors,
            ),
            decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.white,
              hintText: ' Search...',
              hintStyle: const TextStyle(
                  color: CustomerScreen_Color.Colors_Text2_,
                  // fontWeight: FontWeight.bold,
                  fontFamily: Font_.Fonts_T),
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: const BorderSide(color: Colors.white),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (text) {
              text = text.toLowerCase();
              // print(text);

              // print(customerModels.map((e) => e.docno));
              // print(_customerModels.map((e) => e.docno));
///_customerModels
              setState(() {
                customerModels = _customerModels.where((customerModel) {
                  var notTitle = customerModel.cname.toString().toLowerCase();
                  var notTitle2 = customerModel.custno.toString().toLowerCase();
                  var notTitle3 = customerModel.scname.toString().toLowerCase();
                  return notTitle.contains(text) ||
                      notTitle2.contains(text) ||
                      notTitle3.contains(text);
                }).toList();
              });
              if (text.toString() == '') {
                setState(() {
                  select_coutumer();
                  tappedIndex_ = '';
                  tappedIndex_2 = '';
                  _Form_Ser = null;

                  _verticalGroupValue = '';

                  Form_nameshop_.clear();
                  Form_typeshop_.clear();
                  Form_bussshop_.clear();
                  Form_bussscontact_.clear();
                  Form_address_.clear();
                  Form_tel_.clear();
                  Form_email_.clear();
                  Form_tax_.clear();
                  _TransReBillModels = [];
                });
              }
            },
          );
        });
  }

///////////////////------------------------------------------------------>
  Future<Null> select_coutumer() async {
    //UP_TEST_PICTENANT.php
    if (limitedList_customerModels.isNotEmpty) {
      setState(() {
        limitedList_customerModels.clear();
        _customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_custo_se.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            limitedList_customerModels.add(customerModel);
          });
        }
      }
      setState(() {
        _customerModels = limitedList_customerModels;
      });
      read_customer_limit();
    } catch (e) {}
    if (tappedIndex_ != '') {
      Form_User.text = customerModels[int.parse(tappedIndex_)].user_name!;
    } else {}
  }

  /////////////////--------------------------->
  Future<Null> read_customer_limit() async {
    setState(() {
      endIndex = offset + limit;
      customerModels = limitedList_customerModels.sublist(
          offset, // Start index
          (endIndex <= limitedList_customerModels.length)
              ? endIndex
              : limitedList_customerModels.length // End index
          );
    });
    //limitedList_teNantModels
  }
////////////////////------------------------------------------------>

  ///---------->อัพเดตรูปในสัญญาให้ต้องกับทะเบียนลูกค้า
  // Future<Null> up_photo_tenan(custno, addr2) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   var user = preferences.getString('ser');

  //   String url =
  //       '${MyConstant().domain}/UP_TEST_PICTENANT.php?isAdd=true&ren=$ren&custno=$custno&fileName=$addr2';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result.toString() == 'true') {
  //       print('up_photo_tenan--------------> $custno ---->$addr2');
  //       print('true');
  //     }
  //   } catch (e) {
  //     print('up_photo_tenan--------------> $custno ---->$addr2');
  //     print('false');
  //   }
  // }

///////////////------------------------------------------------------->
  Future<Null> Save_FormText() async {
    // Value_AreaSer_ = int.parse(value!.ser!) - 1;
    // _verticalGroupValue = value.type!;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');
    String? Ser = _Form_Ser.toString();
    String? nameshop = Form_nameshop_.text.toString();
    String? typeshop = Form_typeshop_.text.toString();
    String? bussshop = Form_bussshop_.text.toString();
    String? bussscontact =
        (_verticalGroupValue.toString().trim() == 'ส่วนตัว/บุคคลธรรมดา')
            ? Form_bussshop_.text.toString()
            : Form_bussscontact_.text.toString();
    String? address = Form_address_.text.toString();
    String? tel = Form_tel_.text.toString();
    String? email = Form_email_.text.toString();
    String? tax = Form_tax_.text.toString();
    String? typerser = '${int.parse(Value_AreaSer_.toString()) + 1}';
    print('--------------------------------------');
    print(typerser);
    print(_verticalGroupValue);
    print('--------------------------------------');
    print(Ser);
    print(nameshop);
    print(typeshop);
    print(bussshop);
    print(bussscontact);
    print(address);
    print(tel);
    print(email);
    print(tax);
    print(ren);
    print('--------------------------------------');

    String url =
        '${MyConstant().domain}/Inc_customer_Bureau.php?isAdd=true&ren=$ren&user=$Ser&nameshop=$nameshop&typeshop=$typeshop&bussshop=$bussshop&bussscontact=$bussscontact&address=$address&tel=$tel&email=$email&tax=$tax&type=$_verticalGroupValue&typeser=$typerser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      if (result.toString() == 'true') {
        print('true');
        Insert_log.Insert_logs('ทะเบียน', 'ทะเบียนลูกค้า>>แก้ไข($nameshop)');
        setState(() {
          select_coutumer();
        });
      } else {}
    } catch (e) {}

    // String url =
    //     '${MyConstant().domain}/Inc_customer_Bureau.php?isAdd=true&ren=$ren';

    // var response = await http.post(Uri.parse(url), body: {
    //   'user': '',
    //   'nameshop': '',
    //   'typeshop': '',
    //   'bussshop': '',
    //   'bussscontact': '',
    //   'address': '',
    //   'tel': '',
    //   'email': '',
    //   'tax': '',
    //   'type': '',
    //   'typeser': '',
    // }).then((value) async {
    //   Insert_log.Insert_logs('ทะเบียน', 'ทะเบียนลูกค้า>>แก้ไข($nameshop)');
    //   select_coutumer();
    // });
  }

  ///---------------------------------------------------------------------->
  Future<Null> checkshowDialog(index) async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          // 'เลขที่บิล ${_TransReBillModels[index].docno}',
                          _TransReBillModels[index].doctax == ''
                              ? 'เลขที่บิล ${_TransReBillModels[index].docno}'
                              : 'เลขที่บิล ${_TransReBillModels[index].doctax}',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        dragStartBehavior: DragStartBehavior.start,
                        child: Row(
                          children: [
                            Container(
                                width: (Responsive.isDesktop(context))
                                    ? MediaQuery.of(context).size.width * 0.85
                                    : 1200,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.orange[100],
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                            ),
                                            // border: Border.all(
                                            //     color: Colors.grey, width: 1),
                                          ),
                                          // padding: const EdgeInsets.all(8.0),
                                          child: const Center(
                                            child: Text(
                                              'รายละเอียดบิล', //numinvoice
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.orange[100],
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                            ),
                                            // border: Border.all(
                                            //     color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                              // border: Border.all(
                                              //     color: Colors.grey, width: 1),
                                            ),
                                            child: Center(
                                              child: Text(
                                                _TransReBillModels[index]
                                                            .doctax ==
                                                        ''
                                                    ? 'เลขที่บิล ${_TransReBillModels[index].docno}'
                                                    : 'เลขที่บิล ${_TransReBillModels[index].doctax}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 50,
                                    color: Colors.brown[200],
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'ลำดับ',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'กำหนดชำระ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'รายการ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'VAT %',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'หน่วย',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'VAT',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        if (renTal_user.toString() == '65' ||
                                            renTal_user.toString() == '50')
                                          const Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                '70',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        if (renTal_user.toString() == '65' ||
                                            renTal_user.toString() == '50')
                                          const Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                '30',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        const Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 2,
                                              'ราคารวมก่อน VAT',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'ราคารวม VAT',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 220,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: StreamBuilder(
                                        stream: Stream.periodic(
                                            const Duration(seconds: 0)),
                                        builder: (context, snapshot) {
                                          return ListView.builder(
                                            // controller: _scrollController2,
                                            // itemExtent: 50,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: _TransReBillHistoryModels
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                title: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        maxLines: 1,
                                                        '${index + 1}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].date}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].expname}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].nvat}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].vtype}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        maxLines: 1,
                                                        '${nFormat.format(double.parse(_TransReBillHistoryModels[index].vat!))}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    if (renTal_user
                                                                .toString() ==
                                                            '65' ||
                                                        renTal_user
                                                                .toString() ==
                                                            '50')
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          maxLines: 1,
                                                          (_TransReBillHistoryModels[
                                                                          index]
                                                                      .ramt
                                                                      .toString() ==
                                                                  'null')
                                                              ? '-'
                                                              : '${nFormat.format(double.parse(_TransReBillHistoryModels[index].ramt!))}',
                                                          //  '${_TransReBillHistoryModels[index].ramt}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  //fontSize: 10.0
                                                                  ),
                                                        ),
                                                      ),
                                                    if (renTal_user
                                                                .toString() ==
                                                            '65' ||
                                                        renTal_user
                                                                .toString() ==
                                                            '50')
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          maxLines: 1,
                                                          (_TransReBillHistoryModels[
                                                                          index]
                                                                      .ramtd
                                                                      .toString() ==
                                                                  'null')
                                                              ? '-'
                                                              : '${nFormat.format(double.parse(_TransReBillHistoryModels[index].ramtd!))}',
                                                          // '${_TransReBillHistoryModels[index].ramtd}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  //fontSize: 10.0
                                                                  ),
                                                        ),
                                                      ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        maxLines: 1,
                                                        '${nFormat.format(double.parse(_TransReBillHistoryModels[index].amt!))}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 15,
                                                        maxLines: 1,
                                                        '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 20, 8, 8),
                                    child: Container(
                                      width: (Responsive.isDesktop(context))
                                          ? MediaQuery.of(context).size.width *
                                              0.85
                                          : 1200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 250,
                                            // height: 50,
                                            // color: Colors.red,
                                            child: StreamBuilder(
                                                stream: Stream.periodic(
                                                    const Duration(seconds: 0)),
                                                builder: (context, snapshot) {
                                                  return Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          'วันที่ชำระ : ${DateFormat('dd-MM').format(DateTime.parse('$pdate 00:00:00'))}-${DateTime.parse('$pdate 00:00:00').year + 543}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text1_,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  ),
                                                        ),
                                                      ),
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          'รูปแบบการชำระ',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T
                                                              //fontSize: 10.0
                                                              ),
                                                        ),
                                                      ),
                                                      for (var i = 0;
                                                          i <
                                                              finnancetransModels
                                                                  .length;
                                                          i++)
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            // minFontSize: 10,
                                                            // maxFontSize: 15,
                                                            '${i + 1}.(${finnancetransModels[i].type}) จำนวน ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท',
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                }),
                                          ),
                                          Container(
                                            width: 350,
                                            // height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0),
                                                      topRight:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0)),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: StreamBuilder(
                                              stream: Stream.periodic(
                                                  const Duration(seconds: 0)),
                                              builder: (context, snapshot) {
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child:
                                                              const AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            'รวม(บาท)',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          // flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            textAlign:
                                                                TextAlign.end,
                                                            '${nFormat.format(sum_pvat)}',
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child:
                                                              const AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            'ภาษีมูลค่าเพิ่ม(vat)',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          // flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            textAlign:
                                                                TextAlign.end,
                                                            '${nFormat.format(sum_vat)}',
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child:
                                                              const AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            'หัก ณ ที่จ่าย',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          // flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            textAlign:
                                                                TextAlign.end,
                                                            '${nFormat.format(sum_wht)}',
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child:
                                                              const AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            'ยอดรวม',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            textAlign:
                                                                TextAlign.end,
                                                            '${nFormat.format(sum_amt)}',
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            'ส่วนลด $sum_disp  %',
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          // flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            '${nFormat.format(sum_disamt)}',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child:
                                                              const AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            'ยอดชำระ',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          // flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 15,
                                                            textAlign:
                                                                TextAlign.end,
                                                            '${nFormat.format(sum_amt - sum_disamt)}',
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 200,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6)),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.highlight_off,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ปิด',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight:
                                      //     FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ]),
            ));
  }

  int? _message;
  void updateMessage(int newMessage) {
    setState(() {
      _message = newMessage;
      Status_cuspang = newMessage;
      checkPreferance();
      select_coutumer();
      read_GC_type();
    });
  }

  Future<void> downloadImage(String imageUrl, String name) async {
    try {
      // first we make a request to the url like you did
      // in the android and ios version
      final http.Response r = await http.get(
        Uri.parse(imageUrl),
      );

      // we get the bytes from the body
      final data = r.bodyBytes;
      // and encode them to base64
      final base64data = base64Encode(data);

      // then we create and AnchorElement with the html package
      final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');

      // set the name of the file we want the image to get
      // downloaded to
      a.download = 'Load_CusID_$cust_no_.jpg';

      // and we click the AnchorElement which downloads the image
      a.click();
      // finally we remove the AnchorElement
      a.remove();
    } catch (e) {
      print(e);
    }
  }

  ///////////-------------------------------------------------------->
  String? fileName_Slip;
  int in_dex = 0;
///////////-------------------------------------------------------->
  Future<void> uploadImage(ImageSource source) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      fileName_Slip = '${fiew}_${cust_no_}_$timestamp.jpg';
    });
    // print(fileName_Slip);
    // var name_ = 'testforweb_$timestamp';
    // var foder_ = 'kad_taii';
    // 1. Capture an image from the device's gallery or camera
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: source);

    if (pickedFile == null) {
      print('User canceled image selection');
      return;
    }

    try {
      // 2. Read the image as bytes
      final imageBytes = await pickedFile.readAsBytes();

      // 3. Encode the image as a base64 string
      final base64Image = base64Encode(imageBytes);

      // 4. Make an HTTP POST request to your server
      final url =
          '${MyConstant().domain}/File_photo.php?name=$fileName_Slip&Foder=$foder';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'image': base64Image,
          'Foder': foder,
          'name': fileName_Slip
        }, // Send the image as a form field named 'image'
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        deleteFile();
        await Future.delayed(Duration(milliseconds: 100));
        up_photo_string();
      } else {
        print('Image upload failed');
      }
    } catch (e) {
      print('Error during image processing: $e');
    }
  }

  Future<Null> up_photo_string() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');
    String custno_ = cust_no_.toString();

    await Future.delayed(Duration(milliseconds: 500));

    String url =
        '${MyConstant().domain}/Test_UP_img_Custo.php?isAdd=true&ren=$ren&custno=$custno_&img=$fileName_Slip';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        print('true :-$custno_--> ${fileName_Slip}');
        print(
            'Form_Img_ // ${tappedIndex_}  //---> ${customerModels[int.parse(tappedIndex_!)].addr2}');
        select_coutumer();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green[600],
              content: Text(' ทำรายการสำเร็จ... !',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: Font_.Fonts_T))),
        );
      }
    } catch (e) {
      // print(e);
    }
    await Future.delayed(Duration(milliseconds: 200));

    setState(() {
      Form_Img_ = '${customerModels[in_dex].addr2}';
    });

    print(Form_Img_);
    print(in_dex);
  }

  Future<void> deleteFile() async {
    String url =
        '${MyConstant().domain}/File_Deleted_imagCus.php?name=$Form_Img_&Foder=$foder';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody == 'File deleted successfully.') {
          print('File deleted successfully!');
        } else {
          print('Failed to delete file: $responseBody');
        }
      } else {
        print('Failed to delete file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

///////////------------------------------------------------>

  Future<Null> Password(int index) async {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Form(
        key: _formKey,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Center(
              child: Text(
            'แก้ไข User & Password',
            style: TextStyle(
                color: AdminScafScreen_Color.Colors_Text1_,
                fontWeight: FontWeight.bold,
                fontFamily: FontWeight_.Fonts_T),
          )),
          actions: <Widget>[
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'User',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text2_,
                          //fontWeight: FontWeight.bold,
                          fontFamily: Font_.Fonts_T),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    // color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    // border: Border.all(color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    showCursor: true, //add this line
                    readOnly: false,
                    controller: Form_User,
                    cursorColor: Colors.green,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ใส่ข้อมูลให้ครบถ้วน ';
                      }
                      // if (int.parse(value.toString()) < 13) {
                      //   return '< 13';
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.3),
                        // fillColor: Colors.green[100]!.withOpacity(0.5),
                        filled: true,
                        // labelText: 'User',
                        // prefixIcon:
                        //     const Icon(Icons.person, color: Colors.black),
                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        labelStyle: const TextStyle(
                            color: Colors.black54, fontFamily: Font_.Fonts_T)),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("[' ']")),
                      // for below version 2 use this
                      // FilteringTextInputFormatter.allow(
                      //     RegExp(r'[a-z A-Z 1-9]')),
                      // for version 2 and greater youcan also use this
                      // FilteringTextInputFormatter
                      //     .digitsOnly
                    ],
                    onChanged: (value) {
                      // print('User : ${value}');
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Password',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: PeopleChaoScreen_Color.Colors_Text2_,
                          //fontWeight: FontWeight.bold,
                          fontFamily: Font_.Fonts_T),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    // color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    // border: Border.all(color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    showCursor: true, //add this line
                    readOnly: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ใส่ข้อมูลให้ครบถ้วน ';
                      }
                      // if (int.parse(value.toString()) < 13) {
                      //   return '< 13';
                      // }
                      return null;
                    },
                    controller: Form_UserPass,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.3),
                        // fillColor: Colors.green[100]!.withOpacity(0.5),
                        filled: true,
                        // labelText: 'Password',
                        // prefixIcon:
                        //     const Icon(Icons.person, color: Colors.black),
                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        labelStyle: const TextStyle(
                            color: Colors.black54, fontFamily: Font_.Fonts_T)),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("[' ']")),
                      // for below version 2 use this
                      // FilteringTextInputFormatter.allow(
                      //     RegExp(r'[a-z A-Z 1-9]')),
                      // for version 2 and greater youcan also use this
                      // FilteringTextInputFormatter
                      //     .digitsOnly
                    ],
                    onChanged: (value) {
                      // print('Pass_User : ${value}');
                    },
                  ),
                ),
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
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              String? ren = preferences.getString('renTalSer');
                              String? ser_user = preferences.getString('ser');

                              String Cid_ = '${customerModels[index].custno}';
                              // print('User : ${Form_User.text}');
                              // print('Cust_no_ : ${customerModels[index].custno}');

                              String password = md5
                                  .convert(utf8.encode(Form_UserPass.text))
                                  .toString();
                              print('password Md5 $password');
                              if (_formKey.currentState!.validate()) {
                                String url =
                                    '${MyConstant().domain}/UpC_custno_cid_Informa.php?isAdd=true&cust_no=${customerModels[index].custno}&user_U=${Form_User.text}&pass_U=$password&ren=$ren';
                                try {
                                  var response = await http.get(Uri.parse(url));

                                  var result = json.decode(response.body);
                                  Insert_log.Insert_logs('ผู้เช่า',
                                      'ข้อมูลผู้เช่า>>แก้ไขUser&password(${customerModels[index].custno})');
                                  select_coutumer();
                                  setState(() {
                                    Form_UserPass.clear();
                                    Form_User.clear();
                                  });
                                  Navigator.pop(context, 'OK');

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'แก้ไขข้อมูลเสร็จสิ้น !!',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: Font_.Fonts_T))));
                                } catch (e) {
                                  Navigator.pop(context, 'OK');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('เกิดข้อผิดพลาด',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: Font_.Fonts_T))),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'ยืนยัน',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
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
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    Form_UserPass.clear();
                                    Form_User.clear();
                                  });
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text(
                                  'ยกเลิก',
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///----------------------->
  Widget Next_page() {
    return Row(
      children: [
        Expanded(child: Text('')),
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
                    Icon(
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

                                    read_customer_limit();
                                    tappedIndex_ = '';
                                  });
                                  _scrollController1.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeOut,
                                  );
                                }

                                setState(() {
                                  contractPhotoModels.clear();

                                  _TransReBillModels.clear();
                                  teNantModels.clear();
                                  Total_tenant = 0.00;
                                  contractModels.clear();
                                  _Form_nameshop = null;
                                  _Form_typeshop = null;
                                  _Form_bussshop = null;
                                  _Form_bussscontact = null;
                                  _Form_address = null;
                                  _Form_tel = null;
                                  _Form_email = null;
                                  _Form_tax = null;
                                  _Form_Ser = null;
                                  pic_tenant = null;
                                  pic_shop = null;
                                  pic_plan = null;
                                  fiew = null;
                                  _verticalGroupValue = '';
                                  Total_doctax = 0;
                                  Total_late_payment = 0; //ชำระเกินกำหนด
                                  Total_early_payment = 0; //ชำระก่อรกำหนด
                                  Total_ontime_payment = 0; //ชำระตรงเวลา
                                  Total_tenant = 0; //ค้างชำระ
                                  Total_amtbill = 0.0;

                                  Form_nameshop_.clear();
                                  Form_typeshop_.clear();
                                  Form_bussshop_.clear();
                                  Form_bussscontact_.clear();
                                  Form_address_.clear();
                                  Form_tel_.clear();
                                  Form_email_.clear();
                                  Form_tax_.clear();
                                });
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
                        // '*//$endIndex /${limitedList_teNantModels.length} ///${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                        '${(endIndex / limit)}/${(limitedList_customerModels.length / limit).ceil()}',
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
                        onTap: ((endIndex / limit) ==
                                (limitedList_customerModels.length / limit)
                                    .ceil())
                            ? null
                            : () async {
                                setState(() {
                                  offset = offset + limit;
                                  tappedIndex_ = '';
                                  read_customer_limit();
                                });
                                _scrollController1.animateTo(
                                  0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                                setState(() {
                                  contractPhotoModels.clear();

                                  _TransReBillModels.clear();
                                  teNantModels.clear();
                                  Total_tenant = 0.00;
                                  contractModels.clear();
                                  _Form_nameshop = null;
                                  _Form_typeshop = null;
                                  _Form_bussshop = null;
                                  _Form_bussscontact = null;
                                  _Form_address = null;
                                  _Form_tel = null;
                                  _Form_email = null;
                                  _Form_tax = null;
                                  _Form_Ser = null;
                                  pic_tenant = null;
                                  pic_shop = null;
                                  pic_plan = null;
                                  fiew = null;
                                  _verticalGroupValue = '';
                                  Total_doctax = 0;
                                  Total_late_payment = 0; //ชำระเกินกำหนด
                                  Total_early_payment = 0; //ชำระก่อรกำหนด
                                  Total_ontime_payment = 0; //ชำระตรงเวลา
                                  Total_tenant = 0; //ค้างชำระ
                                  Total_amtbill = 0.0;

                                  Form_nameshop_.clear();
                                  Form_typeshop_.clear();
                                  Form_bussshop_.clear();
                                  Form_bussscontact_.clear();
                                  Form_address_.clear();
                                  Form_tel_.clear();
                                  Form_email_.clear();
                                  Form_tax_.clear();
                                });
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: ((endIndex / limit) ==
                                  (limitedList_customerModels.length / limit)
                                      .ceil())
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

  // Widget Next_page() {
  //   return Row(
  //     children: [
  //       Expanded(child: Text('')),
  //       StreamBuilder(
  //           stream: Stream.periodic(const Duration(milliseconds: 300)),
  //           builder: (context, snapshot) {
  //             return Container(
  //               decoration: const BoxDecoration(
  //                 color: AppbackgroundColor.Sub_Abg_Colors,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(10),
  //                     topRight: Radius.circular(10),
  //                     bottomLeft: Radius.circular(10),
  //                     bottomRight: Radius.circular(10)),
  //               ),
  //               padding: const EdgeInsets.all(4.0),
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.menu_book,
  //                     color: Colors.grey,
  //                     size: 20,
  //                   ),
  //                   InkWell(
  //                       onTap: (Count_OFF_SET == 0)
  //                           ? null
  //                           : () async {
  //                               if (Count_OFF_SET == 0) {
  //                               } else {
  //                                 Count_OFF_SET = Count_OFF_SET - 50;
  //                                 setState(() {
  //                                   Status_cuspang = 0;
  //                                   checkPreferance();
  //                                   read_GC_rental();
  //                                   select_coutumer();
  //                                   read_GC_type();
  //                                 });
  //                               }
  //                             },
  //                       child: Icon(
  //                         Icons.arrow_left,
  //                         color: (Count_OFF_SET == 0)
  //                             ? Colors.grey[200]
  //                             : Colors.black,
  //                         size: 25,
  //                       )),
  //                   Padding(
  //                     padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
  //                     child: Text(
  //                       // '$Count_OFF_SET',
  //                       (Count_OFF_SET == 0)
  //                           ? '${Count_OFF_SET + 1}'
  //                           : '${(Count_OFF_SET / 50) + 1}',
  //                       textAlign: TextAlign.start,
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                         color: Colors.green,
  //                         fontWeight: FontWeight.bold,
  //                         fontFamily: FontWeight_.Fonts_T,
  //                         //fontSize: 10.0
  //                       ),
  //                     ),
  //                   ),
  //                   InkWell(
  //                       onTap: (customerModels.length == 0)
  //                           ? null
  //                           : () async {
  //                               Count_OFF_SET = Count_OFF_SET + 50;
  //                               setState(() {
  //                                 Status_cuspang = 0;
  //                                 checkPreferance();
  //                                 read_GC_rental();
  //                                 select_coutumer();
  //                                 read_GC_type();
  //                               });
  //                             },
  //                       child: Icon(
  //                         Icons.arrow_right,
  //                         color: (customerModels.length == 0)
  //                             ? Colors.grey[200]
  //                             : Colors.black,
  //                         size: 25,
  //                       )),
  //                 ],
  //               ),
  //             );
  //           }),
  //     ],
  //   );
  // }

///////////--------------------------------->
  Widget build(BuildContext context) {
    return (Status_cuspang == 1)
        ? Add_Custo_Screen(
            updateMessage: updateMessage,
          )
        : Expanded(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      // decoration: const BoxDecoration(
                      //   color: AppbackgroundColor.Sub_Abg_Colors,
                      //   borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(10),
                      //       topRight: Radius.circular(10),
                      //       bottomLeft: Radius.circular(10),
                      //       bottomRight: Radius.circular(10)),
                      // ),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: (Responsive.isDesktop(context))
                                    ? MediaQuery.of(context).size.width / 1.18
                                    : 800,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                  padding:
                                                       EdgeInsets.all(5),
                                                  decoration:
                                                       BoxDecoration(
                                                    color: AppbackgroundColor
                                                        .TiTile_Colors,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0)),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ทะเบียนลูกค้า :',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: CustomerScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T
                                                              //fontSize: 10.0
                                                              //fontSize: 10.0Test_UP_img_Custo
                                                              ),
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child: InkWell(
                                                      //     child:
                                                      //         const AutoSizeText(
                                                      //       minFontSize: 10,
                                                      //       maxFontSize: 15,
                                                      //       'ทะเบียนลูกค้า :',
                                                      //       textAlign: TextAlign
                                                      //           .center,
                                                      //       style: TextStyle(
                                                      //           color: CustomerScreen_Color
                                                      //               .Colors_Text1_,
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .bold,
                                                      //           fontFamily:
                                                      //               FontWeight_
                                                      //                   .Fonts_T
                                                      //           //fontSize: 10.0
                                                      //           //fontSize: 10.0Test_UP_img_Custo
                                                      //           ),
                                                      //     ),
                                                      //     onTap: () async {
                                                      //       SharedPreferences
                                                      //           preferences =
                                                      //           await SharedPreferences
                                                      //               .getInstance();
                                                      //       String? ren =
                                                      //           preferences
                                                      //               .getString(
                                                      //                   'renTalSer');
                                                      //       String? ser_user =
                                                      //           preferences
                                                      //               .getString(
                                                      //                   'ser');
                                                      //       for (int index = 0;
                                                      //           index <
                                                      //               customerModels
                                                      //                   .length;
                                                      //           index++) {
                                                      //         String custno_ =
                                                      //             customerModels[index]
                                                      //                         .custno ==
                                                      //                     null
                                                      //                 ? ''
                                                      //                 : '${customerModels[index].custno}';

                                                      //         read_GC_photo(
                                                      //             custno_);
                                                      //         await Future.delayed(
                                                      //             Duration(
                                                      //                 milliseconds:
                                                      //                     500));

                                                      //         String tt = '';

                                                      //         String url =
                                                      //             (pic_tenant ==
                                                      //                     null)
                                                      //                 ? '${MyConstant().domain}/Test_UP_img_Custo.php?isAdd=true&ren=$ren&custno=$custno_&img=$tt'
                                                      //                 : '${MyConstant().domain}/Test_UP_img_Custo.php?isAdd=true&ren=$ren&custno=$custno_&img=$pic_tenant';

                                                      //         try {
                                                      //           var response =
                                                      //               await http.get(
                                                      //                   Uri.parse(
                                                      //                       url));

                                                      //           var result =
                                                      //               json.decode(
                                                      //                   response
                                                      //                       .body);
                                                      //           print(result);
                                                      //           if (result
                                                      //                   .toString() ==
                                                      //               'true') {
                                                      //             print(
                                                      //                 'true : ${index + 1} -$custno_--> ${pic_tenant}');
                                                      //           }
                                                      //         } catch (e) {
                                                      //           print(
                                                      //               '${index + 1} error ');
                                                      //           // print(e);
                                                      //         }
                                                      //       }
                                                      //     },
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child:
                                                                _searchBar()),
                                                      ),
                                                    ],
                                                  )),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration:
                                                           BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                      ),
                                                      child: Row(
                                                        children: const [
                                                          // Center(
                                                          //     child:
                                                          //         Text('...')),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 18,
                                                              'รหัสสมาชิก',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: CustomerScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  //fontSize: 10.0
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 18,
                                                              'ชื่อร้าน',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: CustomerScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  //fontSize: 10.0
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 18,
                                                              'ชื่อผู้เช่า/บริษัท',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: CustomerScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  //fontSize: 10.0
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Container(
                                                  // decoration: const BoxDecoration(
                                                  //   color: AppbackgroundColor.Sub_Abg_Colors,
                                                  //   borderRadius: BorderRadius.only(
                                                  //       topLeft: Radius.circular(0),
                                                  //       topRight: Radius.circular(0),
                                                  //       bottomLeft: Radius.circular(0),
                                                  //       bottomRight: Radius.circular(0)),
                                                  //   // border: Border.all(color: Colors.grey, width: 1),
                                                  // ),
                                                  child: customerModels.isEmpty
                                                      ? SizedBox(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const CircularProgressIndicator(),
                                                              StreamBuilder(
                                                                stream: Stream.periodic(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            25),
                                                                    (i) => i),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (!snapshot
                                                                      .hasData)
                                                                    return const Text(
                                                                        '');
                                                                  double
                                                                      elapsed =
                                                                      double.parse(snapshot
                                                                              .data
                                                                              .toString()) *
                                                                          0.05;
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: (elapsed >
                                                                            8.00)
                                                                        ? const Text(
                                                                            'ไม่พบข้อมูล',
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                fontFamily: Font_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          )
                                                                        : Text(
                                                                            'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                            // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
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
                                                          controller:
                                                              _scrollController1,
                                                          physics:
                                                              const AlwaysScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              customerModels
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Material(
                                                              color: tappedIndex_ ==
                                                                      index
                                                                          .toString()
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
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: ListTile(
                                                                  onTap:
                                                                      () async {
                                                                    String
                                                                        custno_ =
                                                                        customerModels[index].custno ==
                                                                                null
                                                                            ? ''
                                                                            : '${customerModels[index].custno}';
                                                                    setState(
                                                                        () {
                                                                      in_dex =
                                                                          index;
                                                                      cust_no_ =
                                                                          custno_;
                                                                      Total_amtbill =
                                                                          0;
                                                                      Total_doctax =
                                                                          0;
                                                                      Total_late_payment =
                                                                          0;
                                                                      Total_early_payment =
                                                                          0;
                                                                      Total_ontime_payment =
                                                                          0;
                                                                      Total_tenant =
                                                                          0;
                                                                      addAreaCusto1 =
                                                                          [];
                                                                      addAreaCusto2 =
                                                                          [];
                                                                      addAreaCusto3 =
                                                                          [];
                                                                      addAreaCusto4 =
                                                                          [];
                                                                      addrtname =
                                                                          [];
                                                                    });
                                                                    read_GC_photo(
                                                                        custno_);
                                                                    red_Trans_bill(
                                                                        custno_);
                                                                    read_GC_tenant1(
                                                                        custno_);
                                                                    read_GC_tenant(
                                                                        custno_);
                                                                    read_GC_Contract(
                                                                        custno_);
                                                                    setState(
                                                                        () {
                                                                      tappedIndex_ =
                                                                          index
                                                                              .toString();
                                                                      tappedIndex_2 =
                                                                          '';
                                                                      _Form_Ser =
                                                                          '${customerModels[index].ser}';

                                                                      _verticalGroupValue =
                                                                          '${customerModels[index].type}'; // ประเภท

                                                                      Form_nameshop_
                                                                          .text = (customerModels[index].scname.toString() ==
                                                                              'null')
                                                                          ? ''
                                                                          : '${customerModels[index].scname}';
                                                                      // Form_User
                                                                      //     .text = customerModels[
                                                                      //         index]
                                                                      //     .user_name!;
                                                                      Form_typeshop_
                                                                              .text =
                                                                          '${customerModels[index].stype}';
                                                                      Form_Img_ =
                                                                          '${customerModels[index].addr2}';
                                                                      Form_bussshop_
                                                                              .text =
                                                                          '${customerModels[index].cname}';
                                                                      Form_bussscontact_
                                                                              .text =
                                                                          '${customerModels[index].attn}';
                                                                      Form_address_
                                                                              .text =
                                                                          '${customerModels[index].addr1}';
                                                                      Form_tel_
                                                                              .text =
                                                                          '${customerModels[index].tel}';
                                                                      Form_email_
                                                                              .text =
                                                                          '${customerModels[index].email}';
                                                                      Form_tax_
                                                                          .text = customerModels[index].tax ==
                                                                              'null'
                                                                          ? "-"
                                                                          : '${customerModels[index].tax}';
                                                                    });

                                                                    for (int i =
                                                                            0;
                                                                        i < typeModels.length;
                                                                        i++) {
                                                                      print(
                                                                          '--------------------------------------');
                                                                      print(customerModels[
                                                                              index]
                                                                          .type
                                                                          .toString());
                                                                      print(typeModels[
                                                                              i]
                                                                          .type
                                                                          .toString());
                                                                      print(
                                                                          '--------------------------------------');
                                                                      if (customerModels[index]
                                                                              .type
                                                                              .toString() ==
                                                                          typeModels[i]
                                                                              .type
                                                                              .toString()) {
                                                                        setState(
                                                                            () {
                                                                          Value_AreaSer_ =
                                                                              int.parse(typeModels[i].ser.toString()) - 1;
                                                                        });
                                                                      } else {}
                                                                    }

                                                                    // Navigator.pop(context);
                                                                  },
                                                                  title:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      // color: Colors.green[100]!
                                                                      //     .withOpacity(0.5),
                                                                      border:
                                                                          Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.black12,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        // AutoSizeText(
                                                                        //   minFontSize:
                                                                        //       10,
                                                                        //   maxFontSize:
                                                                        //       18,
                                                                        //   '${index + 1}',
                                                                        //   textAlign:
                                                                        //       TextAlign.center,
                                                                        //   style: const TextStyle(
                                                                        //       color: CustomerScreen_Color.Colors_Text2_,
                                                                        //       // fontWeight: FontWeight.bold,
                                                                        //       fontFamily: Font_.Fonts_T),
                                                                        // ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                18,
                                                                            customerModels[index].custno == null
                                                                                ? ''
                                                                                : '${customerModels[index].custno}',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                18,
                                                                            '${customerModels[index].scname}',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            minFontSize:
                                                                                10,
                                                                            maxFontSize:
                                                                                18,
                                                                            '${customerModels[index].cname}',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8)),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: InkWell(
                                                              onTap: (_TransReBillModels
                                                                          .length >
                                                                      0)
                                                                  ? null
                                                                  : (tappedIndex_ ==
                                                                          '')
                                                                      ? null
                                                                      : () async {
                                                                          showDialog<
                                                                              String>(
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                AlertDialog(
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                              title: const Center(
                                                                                  child: Text(
                                                                                'ต้องการลบข้อมูลลูกค้าใช่หรือไม่',
                                                                                style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                              )),
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
                                                                                                  String? ren = preferences.getString('renTalSer');
                                                                                                  String? ser_user = preferences.getString('ser');
                                                                                                  String? Ser = _Form_Ser.toString();
                                                                                                  String? nameshop = Form_nameshop_.text.toString();

                                                                                                  String url = '${MyConstant().domain}/De_customer_Bureau.php?isAdd=true&ren=$ren&user=$Ser';

                                                                                                  try {
                                                                                                    var response = await http.get(Uri.parse(url));

                                                                                                    var result = json.decode(response.body);

                                                                                                    if (result.toString() == 'true') {
                                                                                                      Insert_log.Insert_logs('ทะเบียน', 'ทะเบียนลูกค้า>>ลบ($nameshop)');
                                                                                                      setState(() {
                                                                                                        _TransReBillModels = [];
                                                                                                        tappedIndex_ = '';
                                                                                                        select_coutumer();
                                                                                                      });
                                                                                                      Navigator.pop(context, 'OK');
                                                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ลบข้อมูลลูกค้าเรียบร้อย...')));
                                                                                                    } else {
                                                                                                      Navigator.pop(context, 'OK');
                                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                                        SnackBar(content: Text('(ผิดพลาด !! )')),
                                                                                                      );
                                                                                                    }
                                                                                                  } catch (e) {}
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
                                                                            ),
                                                                          );
                                                                        },
                                                              child: Container(
                                                                width: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: (_TransReBillModels.length >
                                                                              0 ||
                                                                          tappedIndex_ ==
                                                                              '')
                                                                      ? Colors.grey[
                                                                          300]
                                                                      : (tappedIndex_ ==
                                                                              '')
                                                                          ? Colors.grey[
                                                                              300]
                                                                          : Colors
                                                                              .red[300],
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
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      8,
                                                                  maxFontSize:
                                                                      12,
                                                                  'ลบ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: CustomerScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T
                                                                      //fontSize: 10.0
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  Status_cuspang =
                                                                      1;
                                                                });
                                                              },
                                                              child: Container(
                                                                width: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .orange[
                                                                      300],
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      8,
                                                                  maxFontSize:
                                                                      12,
                                                                  'เพิ่ม',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: CustomerScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T
                                                                      //fontSize: 10.0
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 0, 4, 0),
                                                      child: Next_page(),
                                                    ))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                         BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .TiTile_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 18,
                                                            'ข้อมูล',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: CustomerScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T
                                                                //fontSize: 10.0
                                                                //fontSize: 10.0
                                                                ),
                                                          ),
                                                        ),
                                                        //// Password(index)
                                                        // if (tappedIndex_ != '')
                                                        //   InkWell(
                                                        //       child: Container(
                                                        //         decoration:
                                                        //             const BoxDecoration(
                                                        //           color: Colors
                                                        //               .red,
                                                        //           borderRadius: BorderRadius.only(
                                                        //               topLeft: Radius
                                                        //                   .circular(
                                                        //                       8),
                                                        //               topRight:
                                                        //                   Radius.circular(
                                                        //                       8),
                                                        //               bottomLeft:
                                                        //                   Radius.circular(
                                                        //                       8),
                                                        //               bottomRight:
                                                        //                   Radius.circular(
                                                        //                       8)),
                                                        //         ),
                                                        //         padding:
                                                        //             const EdgeInsets
                                                        //                     .all(
                                                        //                 4.0),
                                                        //         child:
                                                        //             const Text(
                                                        //           '🔒 User/pass',
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .start,
                                                        //           style: TextStyle(
                                                        //               color: Colors.white,
                                                        //               // fontWeight: FontWeight.bold,
                                                        //               fontFamily: Font_.Fonts_T
                                                        //               //fontSize: 10.0
                                                        //               ),
                                                        //         ),
                                                        //       ),
                                                        //       onTap: () {
                                                        //         Password(int.parse(
                                                        //             tappedIndex_));
                                                        //       })
                                                      ],
                                                    )),
                                                Expanded(
                                                  child: Container(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              children: [
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'ประเภท',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        // (Value_AreaSer_ !=
                                                                        //         null)
                                                                        //     ? Container(
                                                                        //         decoration:
                                                                        //             BoxDecoration(
                                                                        //           color: Colors
                                                                        //               .white
                                                                        //               .withOpacity(0.3),
                                                                        //           borderRadius:
                                                                        //               const BorderRadius.only(
                                                                        //             topLeft:
                                                                        //                 Radius.circular(15),
                                                                        //             topRight:
                                                                        //                 Radius.circular(15),
                                                                        //             bottomLeft:
                                                                        //                 Radius.circular(15),
                                                                        //             bottomRight:
                                                                        //                 Radius.circular(15),
                                                                        //           ),
                                                                        //           border: Border.all(
                                                                        //               color:
                                                                        //                   Colors.grey,
                                                                        //               width: 1),
                                                                        //         ),
                                                                        //         padding:
                                                                        //             const EdgeInsets.all(
                                                                        //                 8.0),
                                                                        //         child: StreamBuilder(
                                                                        //             stream: Stream.periodic(const Duration(seconds: 0)),
                                                                        //             builder: (context, snapshot) {
                                                                        //               return RadioGroup<TypeModel>.builder(
                                                                        //                 direction: Axis.horizontal,
                                                                        //                 groupValue: typeModels.elementAt(Value_AreaSer_!.toInt()),
                                                                        //                 horizontalAlignment: MainAxisAlignment.spaceAround,
                                                                        //                 onChanged: (value) {
                                                                        //                   print(int.parse(value!.ser!) - 1);
                                                                        //                   print(value.type!);
                                                                        //                   setState(() {
                                                                        //                     Value_AreaSer_ = int.parse(value.ser!) - 1;
                                                                        //                     _verticalGroupValue = value.type!;
                                                                        //                   });
                                                                        //                   Save_FormText();
                                                                        //                 },
                                                                        //                 items: typeModels,
                                                                        //                 textStyle: const TextStyle(
                                                                        //                   fontSize: 15,
                                                                        //                   color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //                 ),
                                                                        //                 itemBuilder: (typeXModels) => RadioButtonBuilder(
                                                                        //                   typeXModels.type!,
                                                                        //                 ),
                                                                        //               );
                                                                        //             }))
                                                                        //     :
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        borderRadius:
                                                                            const BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(15),
                                                                          topRight:
                                                                              Radius.circular(15),
                                                                          bottomLeft:
                                                                              Radius.circular(15),
                                                                          bottomRight:
                                                                              Radius.circular(15),
                                                                        ),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        '$_verticalGroupValue',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'รูป(คลิกที่รูปเพื่อดู)',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                      if (tappedIndex_ !=
                                                                          '')
                                                                        IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            deleteFile();
                                                                            setState(() {
                                                                              fiew = 'pic_tenant';
                                                                            });
                                                                            uploadImage(ImageSource.gallery);
                                                                            // _getFromGallery2();
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      StreamBuilder(
                                                                          stream: Stream.periodic(const Duration(
                                                                              seconds:
                                                                                  1)),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                                              child: InkWell(
                                                                                child: (Form_Img_ == null || Form_Img_ == '')
                                                                                    ? Icon(Icons.image_not_supported)
                                                                                    : CircleAvatar(
                                                                                        radius: 30.0,
                                                                                        backgroundImage: NetworkImage(
                                                                                          '${MyConstant().domain}/files/$foder/contract/$Form_Img_',
                                                                                        ),
                                                                                        backgroundColor: Colors.transparent,
                                                                                      ),
                                                                                onTap: (Form_Img_ == null || Form_Img_ == '')
                                                                                    ? null
                                                                                    : () {
                                                                                        final GlobalKey globalKey_Img = GlobalKey();
                                                                                        showDialog<String>(
                                                                                          context: context,
                                                                                          builder: (BuildContext context) => AlertDialog(
                                                                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                            title: Center(child: Text('$Form_Img_')),
                                                                                            // title: Container(
                                                                                            //   width: MediaQuery.of(context).size.width * 0.25,
                                                                                            //   height: MediaQuery.of(context).size.width * 0.32,
                                                                                            //   // child: RepaintBoundary(
                                                                                            //   //   key: globalKey_Img,
                                                                                            //   //   child: Image.network(
                                                                                            //   //     '${MyConstant().domain}/files/$foder/contract/$Form_Img_',
                                                                                            //   //     fit: BoxFit.contain,
                                                                                            //   //   ),
                                                                                            //   // ),
                                                                                            // ),
                                                                                            content: Container(
                                                                                              // width: MediaQuery.of(context).size.width * 0.25,
                                                                                              // height: MediaQuery.of(context).size.width * 0.32,
                                                                                              child: SingleChildScrollView(
                                                                                                child: ListBody(
                                                                                                  children: <Widget>[
                                                                                                    Container(
                                                                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                                                                      height: MediaQuery.of(context).size.width * 0.32,
                                                                                                      child: RepaintBoundary(
                                                                                                        key: globalKey_Img,
                                                                                                        child: Image.network(
                                                                                                          '${MyConstant().domain}/files/$foder/contract/$Form_Img_',
                                                                                                          fit: BoxFit.contain,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
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
                                                                                                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                                                                          child: Container(
                                                                                                            width: 120,
                                                                                                            decoration: const BoxDecoration(
                                                                                                              color: Colors.blue,
                                                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                            ),
                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                            child: TextButton(
                                                                                                              onPressed: () => downloadImage('${MyConstant().domain}/files/$foder/contract/$Form_Img_', '${Form_Img_}'),
                                                                                                              // onPressed: () async {
                                                                                                              //   await WebImageDownloader.downloadImage(globalKey_Img, '${Form_Img_}_download.png');
                                                                                                              // },
                                                                                                              child: const Text(
                                                                                                                'download',
                                                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                                                                          child: Container(
                                                                                                            width: 120,
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
                                                                              ),
                                                                            );
                                                                          }),
                                                                    ],
                                                                  ),
                                                                ),

                                                                // Expanded(
                                                                //   flex: 2,
                                                                //   child:
                                                                //       Container(
                                                                //     decoration:
                                                                //         const BoxDecoration(
                                                                //       // color: Colors.green,
                                                                //       borderRadius:
                                                                //           BorderRadius
                                                                //               .only(
                                                                //         topLeft:
                                                                //             Radius.circular(6),
                                                                //         topRight:
                                                                //             Radius.circular(6),
                                                                //         bottomLeft:
                                                                //             Radius.circular(6),
                                                                //         bottomRight:
                                                                //             Radius.circular(6),
                                                                //       ),
                                                                //       // border: Border.all(color: Colors.grey, width: 1),
                                                                //     ),
                                                                //     padding:
                                                                //         const EdgeInsets.all(
                                                                //             4.0),
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              children: [
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'ชื่อร้านค้า',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor:
                                                                          true, //add this line
                                                                      // readOnly: true,
                                                                      controller:
                                                                          Form_nameshop_,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        Save_FormText();
                                                                      },
                                                                      // maxLines: 2,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        filled:
                                                                            true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.person, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        labelStyle: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'ประเภทร้านค้า',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor:
                                                                          true, //add this line
                                                                      // readOnly: true,
                                                                      controller:
                                                                          Form_typeshop_,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        Save_FormText();
                                                                      },
                                                                      // maxLines: 2,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        filled:
                                                                            true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.person, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        labelStyle: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  // Container(
                                                                  //   decoration:
                                                                  //       BoxDecoration(
                                                                  //     color: Colors
                                                                  //         .white
                                                                  //         .withOpacity(
                                                                  //             0.3),
                                                                  //     borderRadius:
                                                                  //         const BorderRadius
                                                                  //             .only(
                                                                  //       topLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       topRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //     ),
                                                                  //     border: Border.all(
                                                                  //         color: Colors
                                                                  //             .grey,
                                                                  //         width: 1),
                                                                  //   ),
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //           .all(5),
                                                                  //   child: Text(
                                                                  //     (_Form_typeshop ==
                                                                  //             null)
                                                                  //         ? ''
                                                                  //         : '$_Form_typeshop',
                                                                  //     textAlign:
                                                                  //         TextAlign
                                                                  //             .start,
                                                                  //     style: const TextStyle(
                                                                  //         color: CustomerScreen_Color.Colors_Text2_,
                                                                  //         // fontWeight: FontWeight.bold,
                                                                  //         fontFamily: Font_.Fonts_T
                                                                  //         //fontSize: 10.0
                                                                  //         ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              children: [
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'ชื่อผู้เช่า/บริษัท',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor:
                                                                          true, //add this line
                                                                      // readOnly: true,
                                                                      controller:
                                                                          Form_bussshop_,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        Save_FormText();
                                                                      },
                                                                      onChanged:
                                                                          (value) {
                                                                        if (_verticalGroupValue.toString().trim() ==
                                                                            'ส่วนตัว/บุคคลธรรมดา') {
                                                                          setState(
                                                                              () {
                                                                            Form_bussscontact_.text =
                                                                                Form_bussshop_.text;
                                                                          });
                                                                        } else {}
                                                                      },
                                                                      // maxLines: 2,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        filled:
                                                                            true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.person, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        labelStyle: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  // Container(
                                                                  //   decoration:
                                                                  //       BoxDecoration(
                                                                  //     color: Colors
                                                                  //         .white
                                                                  //         .withOpacity(
                                                                  //             0.3),
                                                                  //     borderRadius:
                                                                  //         const BorderRadius
                                                                  //             .only(
                                                                  //       topLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       topRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //     ),
                                                                  //     border: Border.all(
                                                                  //         color: Colors
                                                                  //             .grey,
                                                                  //         width: 1),
                                                                  //   ),
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //           .all(5),
                                                                  //   child: Text(
                                                                  //     (_Form_bussshop ==
                                                                  //             null)
                                                                  //         ? ''
                                                                  //         : '$_Form_bussshop',
                                                                  //     textAlign:
                                                                  //         TextAlign
                                                                  //             .start,
                                                                  //     style: const TextStyle(
                                                                  //         color: CustomerScreen_Color.Colors_Text2_,
                                                                  //         // fontWeight: FontWeight.bold,
                                                                  //         fontFamily: Font_.Fonts_T
                                                                  //         //fontSize: 10.0
                                                                  //         ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'ชื่อบุคคลติดต่อ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor:
                                                                          true, //add this line
                                                                      // readOnly: true,
                                                                      controller:
                                                                          Form_bussscontact_,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        Save_FormText();
                                                                      },
                                                                      onChanged:
                                                                          (value) {
                                                                        if (_verticalGroupValue.toString().trim() ==
                                                                            'ส่วนตัว/บุคคลธรรมดา') {
                                                                          setState(
                                                                              () {
                                                                            Form_bussshop_.text =
                                                                                Form_bussscontact_.text;
                                                                          });
                                                                        } else {}
                                                                      },
                                                                      // maxLines: 2,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        filled:
                                                                            true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.person, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        labelStyle: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  // Container(
                                                                  //   decoration:
                                                                  //       BoxDecoration(
                                                                  //     color: Colors
                                                                  //         .white
                                                                  //         .withOpacity(
                                                                  //             0.3),
                                                                  //     borderRadius:
                                                                  //         const BorderRadius
                                                                  //             .only(
                                                                  //       topLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       topRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //     ),
                                                                  //     border: Border.all(
                                                                  //         color: Colors
                                                                  //             .grey,
                                                                  //         width: 1),
                                                                  //   ),
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //           .all(5),
                                                                  //   child: Text(
                                                                  //     (_Form_bussscontact ==
                                                                  //             null)
                                                                  //         ? ''
                                                                  //         : '$_Form_bussscontact',
                                                                  //     textAlign:
                                                                  //         TextAlign
                                                                  //             .start,
                                                                  //     style: const TextStyle(
                                                                  //         color: CustomerScreen_Color.Colors_Text2_,
                                                                  //         // fontWeight: FontWeight.bold,
                                                                  //         fontFamily: Font_.Fonts_T
                                                                  //         //fontSize: 10.0
                                                                  //         ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              children: [
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'ที่อยู่',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 5,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor:
                                                                          true, //add this line
                                                                      // readOnly: true,
                                                                      controller:
                                                                          Form_address_,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        Save_FormText();
                                                                      },
                                                                      // maxLines: 2,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        filled:
                                                                            true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.person, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        labelStyle: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  // Container(
                                                                  //   decoration:
                                                                  //       BoxDecoration(
                                                                  //     color: Colors
                                                                  //         .white
                                                                  //         .withOpacity(
                                                                  //             0.3),
                                                                  //     borderRadius:
                                                                  //         const BorderRadius
                                                                  //             .only(
                                                                  //       topLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       topRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //     ),
                                                                  //     border: Border.all(
                                                                  //         color: Colors
                                                                  //             .grey,
                                                                  //         width: 1),
                                                                  //   ),
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //           .all(5),
                                                                  //   child: Text(
                                                                  //     (_Form_address ==
                                                                  //             null)
                                                                  //         ? ''
                                                                  //         : '$_Form_address',
                                                                  //     textAlign:
                                                                  //         TextAlign
                                                                  //             .start,
                                                                  //     style: const TextStyle(
                                                                  //         color: CustomerScreen_Color.Colors_Text2_,
                                                                  //         // fontWeight: FontWeight.bold,
                                                                  //         fontFamily: Font_.Fonts_T
                                                                  //         //fontSize: 10.0
                                                                  //         ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              children: [
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'เบอร์โทร',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor:
                                                                          true, //add this line
                                                                      // readOnly: true,
                                                                      controller:
                                                                          Form_tel_,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        Save_FormText();
                                                                      },
                                                                      maxLength:
                                                                          10,
                                                                      // maxLines:
                                                                      //     10,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        filled:
                                                                            true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.person, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        labelStyle: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                      inputFormatters: <TextInputFormatter>[
                                                                        // for below version 2 use this
                                                                        FilteringTextInputFormatter.allow(
                                                                            RegExp(r'[0-9]')),
                                                                        // for version 2 and greater youcan also use this
                                                                        FilteringTextInputFormatter
                                                                            .digitsOnly
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  // Container(
                                                                  //   decoration:
                                                                  //       BoxDecoration(
                                                                  //     color: Colors
                                                                  //         .white
                                                                  //         .withOpacity(
                                                                  //             0.3),
                                                                  //     borderRadius:
                                                                  //         const BorderRadius
                                                                  //             .only(
                                                                  //       topLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       topRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //     ),
                                                                  //     border: Border.all(
                                                                  //         color: Colors
                                                                  //             .grey,
                                                                  //         width: 1),
                                                                  //   ),
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //           .all(5),
                                                                  //   child: Text(
                                                                  //     (_Form_tel ==
                                                                  //             null)
                                                                  //         ? ''
                                                                  //         : '$_Form_tel',
                                                                  //     textAlign:
                                                                  //         TextAlign
                                                                  //             .start,
                                                                  //     style: const TextStyle(
                                                                  //         color: CustomerScreen_Color.Colors_Text2_,
                                                                  //         // fontWeight: FontWeight.bold,
                                                                  //         fontFamily: Font_.Fonts_T
                                                                  //         //fontSize: 10.0
                                                                  //         ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'อีเมล',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor:
                                                                          true, //add this line
                                                                      // readOnly: true,
                                                                      controller:
                                                                          Form_email_,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        Save_FormText();
                                                                      },
                                                                      // maxLines: 2,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        filled:
                                                                            true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.person, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        labelStyle: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // Container(
                                                                  //   decoration:
                                                                  //       BoxDecoration(
                                                                  //     color: Colors
                                                                  //         .white
                                                                  //         .withOpacity(
                                                                  //             0.3),
                                                                  //     borderRadius:
                                                                  //         const BorderRadius
                                                                  //             .only(
                                                                  //       topLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       topRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //     ),
                                                                  //     border: Border.all(
                                                                  //         color: Colors
                                                                  //             .grey,
                                                                  //         width: 1),
                                                                  //   ),
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //           .all(5),
                                                                  //   child: Text(
                                                                  //     (_Form_email ==
                                                                  //             null)
                                                                  //         ? ''
                                                                  //         : '$_Form_email',
                                                                  //     textAlign:
                                                                  //         TextAlign
                                                                  //             .start,
                                                                  //     style: const TextStyle(
                                                                  //         color: CustomerScreen_Color.Colors_Text2_,
                                                                  //         // fontWeight: FontWeight.bold,
                                                                  //         fontFamily: Font_.Fonts_T
                                                                  //         //fontSize: 10.0
                                                                  //         ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              children: [
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'ID/TAX ID',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor:
                                                                          true, //add this line
                                                                      // readOnly: true,
                                                                      controller:
                                                                          Form_tax_,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      // onChanged:
                                                                      //     (value) {
                                                                      //   Form_tax_
                                                                      //       .addListener(
                                                                      //           () {
                                                                      //     print(Form_tax_
                                                                      //         .text
                                                                      //         .toString());

                                                                      //     // Save the email to the database here
                                                                      //   });
                                                                      // },
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        Save_FormText();
                                                                      },
                                                                      // maxLines: 2,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.3),
                                                                        filled:
                                                                            true,
                                                                        // prefixIcon:
                                                                        //     const Icon(Icons.person, color: Colors.black),
                                                                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
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
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        labelStyle: const TextStyle(
                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  //  Container(
                                                                  //   decoration:
                                                                  //       BoxDecoration(
                                                                  //     color: Colors
                                                                  //         .white
                                                                  //         .withOpacity(
                                                                  //             0.3),
                                                                  //     borderRadius:
                                                                  //         const BorderRadius
                                                                  //             .only(
                                                                  //       topLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       topRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomLeft: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //       bottomRight: Radius
                                                                  //           .circular(
                                                                  //               15),
                                                                  //     ),
                                                                  //     border: Border.all(
                                                                  //         color: Colors
                                                                  //             .grey,
                                                                  //         width: 1),
                                                                  //   ),
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //           .all(5),
                                                                  //   child: Text(
                                                                  //     (_Form_tax ==
                                                                  //             null)
                                                                  //         ? ''
                                                                  //         : '$_Form_tax',
                                                                  //     textAlign:
                                                                  //         TextAlign
                                                                  //             .start,
                                                                  //     style: const TextStyle(
                                                                  //         color: CustomerScreen_Color.Colors_Text2_,
                                                                  //         // fontWeight: FontWeight.bold,
                                                                  //         fontFamily: Font_.Fonts_T
                                                                  //         //fontSize: 10.0
                                                                  //         ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(6),
                                                                        topRight:
                                                                            Radius.circular(6),
                                                                        bottomLeft:
                                                                            Radius.circular(6),
                                                                        bottomRight:
                                                                            Radius.circular(6),
                                                                      ),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    // child: Icon(Icons.check_box_outline_blank),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 30,
                                                          )
                                                        ],
                                                      ),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: CustomerScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T
                                                            //fontSize: 10.0
                                                            //fontSize: 10.0
                                                            ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child:
                                                            const AutoSizeText(
                                                          minFontSize: 8,
                                                          maxFontSize: 12,
                                                          '**กด Enter ทุกครั้งที่มีการเปลี่ยนแปลงข้อมูล',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T
                                                              //fontSize: 10.0
                                                              //fontSize: 10.0
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: (Responsive.isDesktop(context))
                                    ? MediaQuery.of(context).size.width * 0.85
                                    : 500,
                                padding: const EdgeInsets.all(8),
                                // decoration: const BoxDecoration(
                                //   color: AppbackgroundColor.Sub_Abg_Colors,
                                //   borderRadius: BorderRadius.only(
                                //       topLeft: Radius.circular(10),
                                //       topRight: Radius.circular(10),
                                //       bottomLeft: Radius.circular(10),
                                //       bottomRight: Radius.circular(10)),
                                // ),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration:  BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                'ประวัติบิล',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: CustomerScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white60,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1),
                                                  ),
                                                  child: const AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'เรียกดูเพิ่มเติม',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  showDialog<void>(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        title: const Center(
                                                          child: Text(
                                                            'รายละเอียดเพิ่มเติม',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: CustomerScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                fontSize: 20.0
                                                                //fontSize: 10.0
                                                                ),
                                                          ),
                                                        ),
                                                        content: Container(
                                                          width: (Responsive
                                                                  .isDesktop(
                                                                      context))
                                                              ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width
                                                              : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width,
                                                          child:
                                                              SingleChildScrollView(
                                                            child:
                                                                // (_TransReBillModels
                                                                //             .length <
                                                                //         1)
                                                                //     ? SizedBox(
                                                                //         child:
                                                                //             Center(
                                                                //           child:
                                                                //               AutoSizeText(
                                                                //             (tappedIndex_ ==
                                                                //                     '')
                                                                //                 ? 'กรุณาเลือกรายชื่อก่อน'
                                                                //                 : 'ไม่พบข้อมูล',
                                                                //             textAlign:
                                                                //                 TextAlign.center,
                                                                //             style: const TextStyle(
                                                                //                 color: CustomerScreen_Color.Colors_Text2_,
                                                                //                 // fontWeight: FontWeight.bold,
                                                                //                 fontFamily: Font_.Fonts_T
                                                                //                 //fontSize: 10.0
                                                                //                 //fontSize: 10.0
                                                                //                 ),
                                                                //           ),
                                                                //         ),
                                                                //       )
                                                                //     :
                                                                ListBody(
                                                              children: <Widget>[
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                               BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.TiTile_Colors,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Text(
                                                                            'ใบกำกับภาษี :',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[200],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${nFormat2.format(Total_doctax)} ',
                                                                            // '$Total_doctax',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight
                                                                                //         .bold,
                                                                                fontFamily: Font_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              AppbackgroundColor.TiTile_Colors,
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Text(
                                                                            'ชำระก่อนกำหนด :',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              Colors.grey[200],
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${nFormat2.format(Total_early_payment)} ครั้ง',
                                                                            // '$Total_amtbill',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight
                                                                                //         .bold,
                                                                                fontFamily: Font_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              AppbackgroundColor.TiTile_Colors,
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Text(
                                                                            'ชำระตรงกำหนด :',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              Colors.grey[200],
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${nFormat2.format(Total_ontime_payment)} ครั้ง',
                                                                            // '$Total_amtbill',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight
                                                                                //         .bold,
                                                                                fontFamily: Font_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              AppbackgroundColor.TiTile_Colors,
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Text(
                                                                            'ชำระเกินกำหนด :',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              Colors.grey[200],
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${nFormat2.format(Total_late_payment)} ครั้ง',
                                                                            // '$Total_amtbill',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight
                                                                                //         .bold,
                                                                                fontFamily: Font_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              AppbackgroundColor.TiTile_Colors,
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Text(
                                                                            'รายการค้างชำระ :',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              Colors.grey[200],
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${nFormat2.format(Total_tenant)} รายการ ',
                                                                            // '$Total_amtbill',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight
                                                                                //         .bold,
                                                                                fontFamily: Font_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              AppbackgroundColor.TiTile_Colors,
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Text(
                                                                            'ยอดชำระรวม :',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          color:
                                                                              Colors.grey[200],
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${nFormat.format(Total_amtbill)} บาท ',
                                                                            // '$Total_amtbill',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: CustomerScreen_Color.Colors_Text2_,
                                                                                // fontWeight:
                                                                                //     FontWeight
                                                                                //         .bold,
                                                                                fontFamily: Font_.Fonts_T
                                                                                //fontSize: 10.0
                                                                                //fontSize: 10.0
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                               BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.TiTile_Colors,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              'ประเภทการเช่า:',
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(color: CustomerScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                  //fontSize: 10.0
                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[200],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ScrollConfiguration(
                                                                            behavior:
                                                                                ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                              PointerDeviceKind.touch,
                                                                              PointerDeviceKind.mouse,
                                                                            }),
                                                                            child: ResponsiveGridList(
                                                                                rowMainAxisAlignment: MainAxisAlignment.end,
                                                                                horizontalGridSpacing: 5, // Horizontal space between grid items

                                                                                horizontalGridMargin: 5, // Horizontal space around the grid
                                                                                verticalGridMargin: 5, // Vertical space around the grid
                                                                                minItemWidth: 10, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                                                                minItemsPerRow: 1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                                                                maxItemsPerRow: (!Responsive.isDesktop(context)) ? 1 : 3, // The maximum items to show in a single row. Can be useful on large screens
                                                                                listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                                                                children: List.generate(
                                                                                  addrtname.length,
                                                                                  (index) => Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white54,
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${addrtname[index]}',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T
                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                          // Text(
                                                                          //   '${addAreaCusto}  ',
                                                                          //   // '$Total_amtbill',
                                                                          //   textAlign:
                                                                          //       TextAlign
                                                                          //           .end,
                                                                          //   style: const TextStyle(
                                                                          //       color: CustomerScreen_Color
                                                                          //           .Colors_Text1_,
                                                                          //       fontWeight:
                                                                          //           FontWeight
                                                                          //               .bold,
                                                                          //       fontFamily:
                                                                          //           FontWeight_.Fonts_T
                                                                          //       //fontSize: 10.0
                                                                          //       //fontSize: 10.0
                                                                          //       ),
                                                                          // ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                               BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.TiTile_Colors,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              'หมดสัญญา:',
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(color: CustomerScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                  //fontSize: 10.0
                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[200],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ScrollConfiguration(
                                                                            behavior:
                                                                                ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                              PointerDeviceKind.touch,
                                                                              PointerDeviceKind.mouse,
                                                                            }),
                                                                            child: ResponsiveGridList(
                                                                                rowMainAxisAlignment: MainAxisAlignment.end,
                                                                                horizontalGridSpacing: 5, // Horizontal space between grid items

                                                                                horizontalGridMargin: 5, // Horizontal space around the grid
                                                                                verticalGridMargin: 5, // Vertical space around the grid
                                                                                minItemWidth: 5, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                                                                minItemsPerRow: (!Responsive.isDesktop(context)) ? 1 : 5, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                                                                maxItemsPerRow: (!Responsive.isDesktop(context)) ? 2 : 5, // The maximum items to show in a single row. Can be useful on large screens
                                                                                listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                                                                children: List.generate(
                                                                                  addAreaCusto1.length,
                                                                                  (index) => Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.red[300],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${addAreaCusto1[index]}',
                                                                                        textAlign: TextAlign.end,
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T
                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                          // Text(
                                                                          //   '${addAreaCusto}  ',
                                                                          //   // '$Total_amtbill',
                                                                          //   textAlign:
                                                                          //       TextAlign
                                                                          //           .end,
                                                                          //   style: const TextStyle(
                                                                          //       color: CustomerScreen_Color
                                                                          //           .Colors_Text1_,
                                                                          //       fontWeight:
                                                                          //           FontWeight
                                                                          //               .bold,
                                                                          //       fontFamily:
                                                                          //           FontWeight_.Fonts_T
                                                                          //       //fontSize: 10.0
                                                                          //       //fontSize: 10.0
                                                                          //       ),
                                                                          // ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                               BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.TiTile_Colors,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              'ใกล้หมดสัญญา :',
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(color: CustomerScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                  //fontSize: 10.0
                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[200],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ScrollConfiguration(
                                                                            behavior:
                                                                                ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                              PointerDeviceKind.touch,
                                                                              PointerDeviceKind.mouse,
                                                                            }),
                                                                            child: ResponsiveGridList(
                                                                                horizontalGridSpacing: 5, // Horizontal space between grid items

                                                                                horizontalGridMargin: 5, // Horizontal space around the grid
                                                                                verticalGridMargin: 5, // Vertical space around the grid
                                                                                minItemWidth: 5, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                                                                minItemsPerRow: (!Responsive.isDesktop(context)) ? 1 : 5, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                                                                maxItemsPerRow: (!Responsive.isDesktop(context)) ? 2 : 5, // The maximum items to show in a single row. Can be useful on large screens
                                                                                listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                                                                children: List.generate(
                                                                                  addAreaCusto2.length,
                                                                                  (index) => Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.orange[300],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${addAreaCusto2[index]}',
                                                                                        textAlign: TextAlign.end,
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T
                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                          // Text(
                                                                          //   '${addAreaCusto}  ',
                                                                          //   // '$Total_amtbill',
                                                                          //   textAlign:
                                                                          //       TextAlign
                                                                          //           .end,
                                                                          //   style: const TextStyle(
                                                                          //       color: CustomerScreen_Color
                                                                          //           .Colors_Text1_,
                                                                          //       fontWeight:
                                                                          //           FontWeight
                                                                          //               .bold,
                                                                          //       fontFamily:
                                                                          //           FontWeight_.Fonts_T
                                                                          //       //fontSize: 10.0
                                                                          //       //fontSize: 10.0
                                                                          //       ),
                                                                          // ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                               BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.TiTile_Colors,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              'เช่าอยู่ :',
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(color: CustomerScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                  //fontSize: 10.0
                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[200],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ScrollConfiguration(
                                                                            behavior:
                                                                                ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                              PointerDeviceKind.touch,
                                                                              PointerDeviceKind.mouse,
                                                                            }),
                                                                            child: ResponsiveGridList(
                                                                                horizontalGridSpacing: 5, // Horizontal space between grid items

                                                                                horizontalGridMargin: 5, // Horizontal space around the grid
                                                                                verticalGridMargin: 5, // Vertical space around the grid
                                                                                minItemWidth: 5, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                                                                minItemsPerRow: (!Responsive.isDesktop(context)) ? 1 : 5, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                                                                maxItemsPerRow: (!Responsive.isDesktop(context)) ? 1 : 5, // The maximum items to show in a single row. Can be useful on large screens
                                                                                listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                                                                children: List.generate(
                                                                                  addAreaCusto3.length,
                                                                                  (index) => Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.green[300],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${addAreaCusto3[index]}',
                                                                                        textAlign: TextAlign.end,
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T
                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                          // Text(
                                                                          //   '${addAreaCusto}  ',
                                                                          //   // '$Total_amtbill',
                                                                          //   textAlign:
                                                                          //       TextAlign
                                                                          //           .end,
                                                                          //   style: const TextStyle(
                                                                          //       color: CustomerScreen_Color
                                                                          //           .Colors_Text1_,
                                                                          //       fontWeight:
                                                                          //           FontWeight
                                                                          //               .bold,
                                                                          //       fontFamily:
                                                                          //           FontWeight_.Fonts_T
                                                                          //       //fontSize: 10.0
                                                                          //       //fontSize: 10.0
                                                                          //       ),
                                                                          // ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                               BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.TiTile_Colors,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              'เสนอราคา :',
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(color: CustomerScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                  //fontSize: 10.0
                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[200],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ScrollConfiguration(
                                                                            behavior:
                                                                                ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                              PointerDeviceKind.touch,
                                                                              PointerDeviceKind.mouse,
                                                                            }),
                                                                            child: ResponsiveGridList(
                                                                                horizontalGridSpacing: 5, // Horizontal space between grid items

                                                                                horizontalGridMargin: 5, // Horizontal space around the grid
                                                                                verticalGridMargin: 5, // Vertical space around the grid
                                                                                minItemWidth: 5, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                                                                minItemsPerRow: (!Responsive.isDesktop(context)) ? 1 : 5, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                                                                maxItemsPerRow: (!Responsive.isDesktop(context)) ? 1 : 5, // The maximum items to show in a single row. Can be useful on large screens
                                                                                listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                                                                children: List.generate(
                                                                                  addAreaCusto4.length,
                                                                                  (index) => Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.blue[300],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        '${addAreaCusto4[index]}',
                                                                                        textAlign: TextAlign.end,
                                                                                        style: const TextStyle(
                                                                                            color: CustomerScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T
                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                          // Text(
                                                                          //   '${addAreaCusto}  ',
                                                                          //   // '$Total_amtbill',
                                                                          //   textAlign:
                                                                          //       TextAlign
                                                                          //           .end,
                                                                          //   style: const TextStyle(
                                                                          //       color: CustomerScreen_Color
                                                                          //           .Colors_Text1_,
                                                                          //       fontWeight:
                                                                          //           FontWeight
                                                                          //               .bold,
                                                                          //       fontFamily:
                                                                          //           FontWeight_.Fonts_T
                                                                          //       //fontSize: 10.0
                                                                          //       //fontSize: 10.0
                                                                          //       ),
                                                                          // ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                               BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.TiTile_Colors,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              'ยกเลิกสัญญา:',
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(color: CustomerScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                  //fontSize: 10.0
                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height: (!Responsive.isDesktop(context))
                                                                              ? 80
                                                                              : 50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[200],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                topRight: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0)),
                                                                            // border: Border.all(
                                                                            //     color: Colors
                                                                            //         .white,
                                                                            //     width:
                                                                            //         1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ScrollConfiguration(
                                                                            behavior:
                                                                                ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                              PointerDeviceKind.touch,
                                                                              PointerDeviceKind.mouse,
                                                                            }),
                                                                            child: ResponsiveGridList(
                                                                                rowMainAxisAlignment: MainAxisAlignment.end,
                                                                                horizontalGridSpacing: 5, // Horizontal space between grid items

                                                                                horizontalGridMargin: 5, // Horizontal space around the grid
                                                                                verticalGridMargin: 5, // Vertical space around the grid
                                                                                minItemWidth: 15, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                                                                minItemsPerRow: 1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                                                                maxItemsPerRow: (!Responsive.isDesktop(context)) ? 1 : 3, // The maximum items to show in a single row. Can be useful on large screens /  Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>ลบ(${areaModels[index].lncode} : ${areaModels[index].ln})');
                                                                                listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                                                                children: List.generate(
                                                                                  contractModels.length,
                                                                                  (index) => Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white54,
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(2.0),
                                                                                    child: PopupMenuButton(
                                                                                      tooltip: 'เหตุผล : ${contractModels[index].cc_remark}',
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          '${contractModels[index].cid} >',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: const TextStyle(
                                                                                              color: CustomerScreen_Color.Colors_Text2_,
                                                                                              // fontWeight: FontWeight.bold,
                                                                                              fontFamily: Font_.Fonts_T
                                                                                              //fontSize: 10.0
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      itemBuilder: (BuildContext context) => [
                                                                                        PopupMenuItem(
                                                                                          mouseCursor: MaterialStateMouseCursor.textable,
                                                                                          child: InkWell(
                                                                                              onTap: () {
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                              child: Container(
                                                                                                  color: Colors.white,
                                                                                                  padding: const EdgeInsets.all(10),
                                                                                                  width: MediaQuery.of(context).size.width,
                                                                                                  child: Text(
                                                                                                    'เหตุผล : ${contractModels[index].cc_remark}',
                                                                                                    style: const TextStyle(
                                                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                                                        //fontWeight: FontWeight.bold,
                                                                                                        fontFamily: Font_.Fonts_T),
                                                                                                  ))),
                                                                                        ),
                                                                                      ],
                                                                                    ),

                                                                                    // Center(
                                                                                    //   child: Text(
                                                                                    //     '${contractModels[index].cid} >',
                                                                                    //     textAlign: TextAlign.center,
                                                                                    //     style: const TextStyle(
                                                                                    //         color: CustomerScreen_Color.Colors_Text2_,
                                                                                    //         // fontWeight: FontWeight.bold,
                                                                                    //         fontFamily: Font_.Fonts_T
                                                                                    //         //fontSize: 10.0
                                                                                    //         ),
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                          // Text(
                                                                          //   '${addAreaCusto}  ',
                                                                          //   // '$Total_amtbill',
                                                                          //   textAlign:
                                                                          //       TextAlign
                                                                          //           .end,
                                                                          //   style: const TextStyle(
                                                                          //       color: CustomerScreen_Color
                                                                          //           .Colors_Text1_,
                                                                          //       fontWeight:
                                                                          //           FontWeight
                                                                          //               .bold,
                                                                          //       fontFamily:
                                                                          //           FontWeight_.Fonts_T
                                                                          //       //fontSize: 10.0
                                                                          //       //fontSize: 10.0
                                                                          //       ),
                                                                          // ),
                                                                        ),
                                                                      ),
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
                                                              const SizedBox(
                                                                  height: 1),
                                                              const Divider(),
                                                              const SizedBox(
                                                                  height: 1),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.black,
                                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6), bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                                                                              border: Border.all(color: Colors.grey, width: 1),
                                                                            ),
                                                                            child: const Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Icon(Icons.highlight_off, color: Colors.white),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    'ปิด',
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      // fontWeight:
                                                                                      //     FontWeight.bold,
                                                                                      fontFamily: Font_.Fonts_T,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration:  BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'เลขที่ใบเสร็จ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: AutoSizeText(
                                          //     minFontSize: 10,
                                          //     maxFontSize: 18,
                                          //     'ชื่อร้าน',
                                          //     textAlign: TextAlign.center,
                                          //     style: TextStyle(
                                          //         color: CustomerScreen_Color.Colors_Text1_,
                                          //         fontWeight: FontWeight.bold,
                                          //         fontFamily: FontWeight_.Fonts_T
                                          //         //fontSize: 10.0
                                          //         //fontSize: 10.0
                                          //         ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'กำหนดชำระ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'วันที่ชำระ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'รหัสพื้นที่',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'จำนวนเงิน',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'สถานะ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                              'เรียกดู',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        // padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          // color: AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: (_TransReBillModels.length < 1)
                                            ? SizedBox(
                                                child: Center(
                                                  child: AutoSizeText(
                                                    (tappedIndex_ == '')
                                                        ? 'กรุณาเลือกรายชื่อก่อน'
                                                        : 'ไม่พบข้อมูล',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount:
                                                    _TransReBillModels.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Material(
                                                    color: tappedIndex_2 ==
                                                            index.toString()
                                                        ? tappedIndex_Color
                                                            .tappedIndex_Colors
                                                        : AppbackgroundColor
                                                            .Sub_Abg_Colors,
                                                    child: Container(
                                                      // color: tappedIndex_2 ==
                                                      //         index.toString()
                                                      //     ? tappedIndex_Color
                                                      //         .tappedIndex_Colors
                                                      //         .withOpacity(0.5)
                                                      //     : null,
                                                      child:ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            tappedIndex_2 =
                                                                index
                                                                    .toString();
                                                          });
                                                        },
                                                        title: Container(
                                                          decoration:
                                                              BoxDecoration(
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
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  _TransReBillModels[index]
                                                                              .doctax ==
                                                                          ''
                                                                      ? '${_TransReBillModels[index].docno}'
                                                                      : '${_TransReBillModels[index].doctax}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: CustomerScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T
                                                                      //fontSize: 10.0
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: AutoSizeText(
                                                              //     minFontSize: 10,
                                                              //     maxFontSize: 18,
                                                              //     '${_TransReBillModels[index].sname}',
                                                              //     textAlign: TextAlign.center,
                                                              //     style: const TextStyle(
                                                              //         color: CustomerScreen_Color
                                                              //             .Colors_Text2_,
                                                              //         // fontWeight: FontWeight.bold,
                                                              //         fontFamily: Font_.Fonts_T
                                                              //         //fontSize: 10.0
                                                              //         //fontSize: 10.0
                                                              //         ),
                                                              //   ),
                                                              // ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  '${_TransReBillModels[index].date}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: CustomerScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T
                                                                      //fontSize: 10.0
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
                                                                      18,
                                                                  '${_TransReBillModels[index].pdate}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: CustomerScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T
                                                                      //fontSize: 10.0
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
                                                                      18,
                                                                  (_TransReBillModels[index]
                                                                              .ln ==
                                                                          null)
                                                                      ? (_TransReBillModels[index].room_number.toString() ==
                                                                              '')
                                                                          ? 'ไม่ระบุ'
                                                                          : '${_TransReBillModels[index].room_number}'
                                                                      : '${_TransReBillModels[index].ln}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: CustomerScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T
                                                                      //fontSize: 10.0
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        18,
                                                                    '${nFormat.format(double.parse(_TransReBillModels[index].total_bill.toString()))}',
                                                                    // '${_TransReBillModels[index].total_bill}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: const TextStyle(
                                                                        color: CustomerScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        //fontSize: 10.0
                                                                        ),
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
                                                                      18,
                                                                  (_TransReBillModels[index]
                                                                              .doctax ==
                                                                          '')
                                                                      ? '-'
                                                                      : 'ใบกำกับภาษี',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: CustomerScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T
                                                                      //fontSize: 10.0
                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'เรียกดู',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T
                                                                              //fontSize: 10.0
                                                                              //fontSize: 10.0
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        tappedIndex_2 =
                                                                            index.toString();
                                                                        red_Trans_select(
                                                                            index);
                                                                        red_Invoice(
                                                                            index);
                                                                      });

                                                                      checkshowDialog(
                                                                          index);
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
