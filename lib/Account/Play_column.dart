import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/Get_Trans_play.dart';
import '../Model/Get_trans_playx.dart';
import '../Style/colors.dart';

class PlayColumn extends StatefulWidget {
  const PlayColumn({super.key});

  @override
  State<PlayColumn> createState() => _PlayColumnState();
}

class _PlayColumnState extends State<PlayColumn> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  List<ExpModel> expModels = [];
  List<TransPlayModel> transPlayModels = [];
  List<TransPlayxModel> transPlayxModels = [];
  List<TransModel> _TransModels = [];
  List<String> listcolor = [];
  double sum = 0.00;
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;
  String? refnoselect;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_GC_Exp();
    read_GC_Playcolumn();
    d_tran_selectall();
  }

  Future<Null> d_tran_selectall() async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    String url =
        '${MyConstant().domain}/D_tran_select.php?isAdd=true&ren=$ren&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print("....................... $result");
      if (result.toString() == 'true') {
        setState(() {
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
        });
      }

      setState(() {
        // Form_payment1.text =
        //     (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      });
    } catch (e) {}
  }

  Future<Null> read_GC_Playcolumn() async {
    if (transPlayModels.isNotEmpty) {
      transPlayModels.clear();
      transPlayxModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    String url = '${MyConstant().domain}/GC_Playcolumn.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      // print(result);

      print(
          '----------------------------------------------------333----------------------------------------------------------');
      if (result != null) {
        for (var map in result) {
          TransPlayModel transPlayModel = TransPlayModel.fromJson(map);
          var vv = transPlayModel.cid;
          List<dynamic> successList = transPlayModel.play_amt;
          // List<dynamic> successList = result[][transPlayModel.play_amt];

          setState(() {
            transPlayModels.add(transPlayModel);
          });

          for (int i = 0; i < successList.length; i++) {
            //     var znx = transPlayModels[v].play_amt[i];
            for (int ii = 0; ii < expModels.length; ii++) {
              var result = successList[i][expModels[ii].ser];
              if (result != null) {
                var encodedString = jsonEncode(result);
                Map<String, dynamic> valueMap = json.decode(encodedString);
                TransPlayxModel transPlayxModel =
                    TransPlayxModel.fromJson(valueMap);
                // print(
                //     '----------ccccc $vv  --------${transPlayxModel.refno_trans}----->');
                if (vv == transPlayxModel.refno_trans) {
                  // if (expModels[ii].ser == transPlayxModel.expx_row) {
                  setState(() {
                    transPlayxModels.add(transPlayxModel);
                  });
                }
                // }

                // break;
              }
              // break;
            }
          }
        }
      } else {}
    } catch (e) {
      print('e -------------> $e');
    }
  }

  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      expModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_exp_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      if (result != null) {
        for (var map in result) {
          ExpModel expModel = ExpModel.fromJson(map);
          var au = expModel.auto;
          setState(() {
            if (au == '1') {
              expModels.add(expModel);
            }
          });
        }
      } else {}
      // print('-------------> ${expModels.length}');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.shade200),
                      dataRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      columns: [
                        DataColumn(
                          label: Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey.shade200,
                              child: Text(
                                'พื้นที่',
                                style: TextStyle(
                                  color: ReportScreen_Color.Colors_Text1_,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            flex: 6,
                            child: Text(
                              'ชื่อ - นามสกุล',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                        for (int i = 0; i < expModels.length; i++)
                          DataColumn(
                            label: Expanded(
                              flex: 1,
                              child: Text(
                                '${expModels[i].expname}',
                                style: TextStyle(
                                  color: ReportScreen_Color.Colors_Text1_,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                      ],
                      rows: [
                        for (int index = 0;
                            index < transPlayModels.length;
                            index++)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                          Text('${transPlayModels[index].ln}'),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                          '${transPlayModels[index].sname}'),
                                    ),
                                  ],
                                ),
                              ),
                              for (int v = 0; v < transPlayxModels.length; v++)
                                if (transPlayModels[index].cid ==
                                    transPlayxModels[v].refno_trans)
                                  // for (int i = 0; i < expModels.length; i++)
                                  //   (transPlayxModels[v].expx_row ==
                                  //           expModels[i].ser)
                                  //       ?
                                  DataCell(
                                    Row(
                                      children: [
                                        for (int i = 0;
                                            i < expModels.length;
                                            i++)
                                          (transPlayxModels[v].expx_row ==
                                                  expModels[i].ser)
                                              ? Expanded(
                                                  child: Card(
                                                    color: Colors.white,
                                                    child: SizedBox(
                                                      child: InkWell(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          onTap: () async {
                                                            in_Trans_select(v);
                                                            setState(() {});
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child: Text(
                                                                transPlayxModels[v]
                                                                            .pvat_trans ==
                                                                        null
                                                                    ? '0'
                                                                    : '${nFormat.format(double.parse(transPlayxModels[v].pvat_trans!))}',
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                      ],
                                    ),
                                  )
                            ],
                          ),
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Container(
                        child: Text('$sum'),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Future<Null> in_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = transPlayxModels[index].refno_trans;
    var qutser = '1';

    var tser = transPlayxModels[index].ser_trans;
    var tdocno = transPlayxModels[index].docno_trans;

    print('object $tdocno');
    String url =
        '${MyConstant().domain}/In_tran_select_column.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          sum = sum + double.parse(transPlayxModels[index].pvat_trans!);
          red_Trans_select2(index);
        });
        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        deall_Trans_select(index);
        setState(() {
          red_Trans_select2(index);
        });
        print('rrrrrrrrrrrrrrfalse');
      } else {
        // setState(() {
        //   red_Trans_select2();
        // });
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text(
      //           'มีผู้ใช้อื่นกำลังทำรายการอยู่ หรือ ท่านเลือกรายการนี้แล้ว....',
      //           style:
      //               TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      // );
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> deall_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = transPlayxModels[index].docno_trans;

    String url =
        '${MyConstant().domain}/D_tran_select_column.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2(index);
          sum = sum - double.parse(transPlayxModels[index].pvat_trans!);
        });
        print('rrrrrrrrrrrrrr');
      } else if (result.toString() == 'false') {
        setState(() {});
        print('rrrrrrrrrrrrrrfalse');
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text('มีผู้ใช้อื่นกำลังทำรายการอยู่....',
        //           style: TextStyle(
        //               color: Colors.white, fontFamily: Font_.Fonts_T))),
        // );
      }
    } catch (e) {
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> red_Trans_select2(index) async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        listcolor.clear();
        refnoselect = null;
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = transPlayxModels[index].refno_trans;
    var qutser = '1';

    String url =
        '${MyConstant().domain}/GC_tran_select.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        setState(() {
          listcolor.clear();
          _TransModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          refnoselect = null;
        });
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);
          var refnox = _TransModel.refno.toString().trim();
          var docnox = _TransModel.docno.toString().trim();
          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          setState(() {
            listcolor.add(docnox);
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            refnoselect = refnox;
            _TransModels.add(_TransModel);
          });
        }
      }

      print('${listcolor.length}  ${listcolor.map((e) => e)}');
      for (var i = 0; i < expModels.length; i++) {}

      setState(() {
        // Form_payment1.text =
        //     (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      });
    } catch (e) {}
  }
}
