import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import 'Beam_apiPassw.dart';

Future<void> Beam_purchase_disabled(
    purchaseId, Pay_Ke, Ser_, cFinnc_s, Form_because) async {
  /////////------------------------------------------------>
  String decodedPassword = retrieveDecodedPassword(Pay_Ke.toString());
  String basicAuth = generateBasicAuth(decodedPassword);
  /////////------------------------------------------------>
  var headers = {'Authorization': '$basicAuth'};
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://partner-api.beamdata.co/purchases/chaoperty/$purchaseId/disable'));
  request.body = '''''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    pPC_finantIbill(Ser_, cFinnc_s, purchaseId, Form_because);
    // print(await response.stream.bytesToString());
  } else {
    // print(response.reasonPhrase);
  }
}

Future<Null> pPC_finantIbill(Ser_, cFinnc_s, purchaseId, Form_because) async {
  var ren = Ser_;

  SharedPreferences preferences = await SharedPreferences.getInstance();
  // var ren = preferences.getString('renTalSer');
  var user = preferences.getString('ser');
  // var ciddoc = widget.Get_Value_cid;
  // var qutser = widget.Get_Value_NameShop_index;

  var numin = cFinnc_s;
  var Formbecause = (Form_because == null || Form_because.toString() == '')
      ? 'ยกเลิกรับชำระ :$cFinnc_s'
      : '$cFinnc_s';

  String url_1 =
      '${MyConstant().domain}/UPC_finant_bill.php?isAdd=true&ren=$ren&user=$user&numin=$numin&because=$Formbecause';
  try {
    var response = await http.get(Uri.parse(url_1));

    var result = json.decode(response.body);
    // print(result);
    if (result.toString() == 'true') {}
  } catch (e) {}
  ////////---------------------------->
  String url_2 =
      '${MyConstant().domain}/UP_Beam_disabled.php?isAdd=true&serren=$ren&iddocno=$cFinnc_s&beamid=$purchaseId';
  try {
    var response = await http.get(Uri.parse(url_2));

    var result = json.decode(response.body);
    // print(result);
    if (result.toString() == 'true') {}
  } catch (e) {}
}
