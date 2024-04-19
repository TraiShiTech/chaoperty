import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Constant/Myconstant.dart';
import '../Man_PDF/Man_Pay_Receipt_PDF.dart';
import 'Beam_apiPassw.dart';

///////--------------------------------------------->
Future<void> read_CheckBeamAll(Ser_, Pay_Ke) async {
  var ren = Ser_;

  try {
    /////////------------------------------------------------>
    String decodedPassword = retrieveDecodedPassword(Pay_Ke.toString());
    String basicAuth = generateBasicAuth(decodedPassword);
    // print(basicAuth);
    /////////------------------------------------------------>

    String url =
        '${MyConstant().domain}/UP_Beam_CompleteAll.php?isAdd=true&serren=$ren';
    var response = await http.post(
      Uri.parse(url),
      body: {'Basic_pass': basicAuth.toString()},
    );

    if (response.statusCode == 200) {
      // Request was successful
      print('Response: successful');
      // print('Response: ${response.body}');
    } else {
      print('Response: failed');
      // Request failed
      // print('Failed with status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Response: error');
    // Error occurred during the request
    // print('Error: $error');
  }
}

///////--------------------------------------------->

Future<Null> Beamcheckout_Complete(
    context,
    Ser_ren,
    bill_addr,
    bill_email,
    bill_tel,
    bill_tax,
    bill_name,
    cFinn,
    purchaseId,
    timePaid,
    urlIdpaycomplete) async {
  var cFinnc_s = cFinn;
  var purchaseId_s = purchaseId;
  // String datePayString = "2024-04-02T04:36:56Z";

  // Parse the string into a DateTime object
  DateTime datePay = DateTime.parse(timePaid);
  var Datepay = DateFormat('yyyy-MM-dd').format(datePay);
  DateTime adjustedDateTime = datePay.add(Duration(hours: 7));
  var Timepay = DateFormat.Hms().format(adjustedDateTime);
  // print('purchaseId : $purchaseId');
  // print('cFinn : $cFinn');
  if (purchaseId != null && cFinn != null) {
    String url =
        '${MyConstant().domain}/UP_Beamcheckout_Complete.php?isAdd=true&serren=${Ser_ren}&iddocno=$cFinnc_s&beamid=$purchaseId_s&date_pay=$Datepay&time_pay=$Timepay&urlId_pay=$urlIdpaycomplete';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      if (result.toString() == 'true') {
        //////-----UP_Beam_CompleteAll
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context, 'OK');
          // ManPay_Receipt_PDF.ManPayReceipt_PDF(context, Ser_ren, '$cFinn',
          //     bill_addr, bill_email, bill_tel, bill_tax, bill_name, '1');
        });
      } else {
        // print('result : !result');
      }
    } catch (e) {
      // print('catch : $e');
      // print(e);
    }
  }
}
