import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Constant/Myconstant.dart';

String retrieveDecodedPassword(pasw) {
  var decode = utf8.decode(base64Decode(pasw.toString()));
  return '$decode';
}

String generateBasicAuth(String decodedPassword) {
  String username = 'chaoperty';
  String credentials = '$username:$decodedPassword';
  String basicAuth = 'Basic ' + base64.encode(utf8.encode(credentials));
  return basicAuth;

  ////////--------------------------->
  // String input = 'xxxxxx';
  // var key = utf8.encode(input);

  // final String base64 = base64Encode(key);  YncydTBQL2hMbFc3NkpKTFkvWkJRV0lKM2lYbkFqNzVBd1hQc0FvSUs1WT0=
  // print(base64); //เก็บลงฐาน
  
}

dynamic https_Request() {
  var request = http.Request(
      'POST', Uri.parse('https://partner-api.beamdata.co/purchases/chaoperty'));

  return request;
}

dynamic https_Request_check(purchaseId) {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://partner-api.beamdata.co/purchases/chaoperty/$purchaseId'));

  return request;
}

String Qr_Enddatetime(minu_tes) {
  DateTime dateTime = DateTime.now();
  DateTime newDateTime = dateTime.add(Duration(minutes: minu_tes));
  String formattedDateTime =
      DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(newDateTime);

  return '$formattedDateTime';
}

// {
//   "destination": "Uac8a8cf0b3661031d73e7eb0e7a26423",
//   "events": [
//     {
//       "type": "message",
//       "message": {
//         "type": "text",
//         "id": "504171161647841638",
//         "quoteToken": "dlROOGlaDMHiRfsXMk3h2lnQ5jT_2plRPE6juGBRdS6RNPiZ4UBVoCU5OefnZ5joZoPihKbcgAftyltdA1PejtOGWk6libFsagG2DW9XkZ_jLEpjWJsoOd9PGdP5ajUZEF-pqTcvJVDdEKM0oyG2NA",
//         "text": "w"
//       },
//       "webhookEventId": "01HVNH1PRBQJPQJGG8TEYS769X",
//       "deliveryContext": {
//         "isRedelivery": false
//       },
//       "timestamp": 1713340734007,
//       "source": {
//         "type": "user",
//         "userId": "U78dbd74e3c89fc2e539daa14aa3266c8"
//       },
//       "replyToken": "7ed82c1ce3a3498ab31eef1ec5d3e238",
//       "mode": "active"
//     }
//   ]
// }


