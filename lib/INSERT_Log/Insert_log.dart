import 'dart:convert';
import 'dart:html';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/Myconstant.dart';
import 'dart:js' as js;

class Insert_log {
  static void Insert_logs(frm_, fdo_) async {
    String day_ =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ser = preferences.getString('ser');
    var position = preferences.getString('position');
    var fname = preferences.getString('fname');
    var lname = preferences.getString('lname');
    var email = preferences.getString('email');
    var utype = preferences.getString('utype');
    var verify = preferences.getString('verify');
    var permission = preferences.getString('permission');
    // Make an HTTP request to the IP geolocation API
    http.Response response = await http.get(Uri.parse('https://api.ipdata.co'));

    // Parse the response JSON
    Map<String, dynamic> data = json.decode(response.body);

    // Print the user's IP address and location
    print('IP address: ${data['ip']}');
    print('City: ${data['city']}');
    print('Region: ${data['region']}');
    print('Country: ${data['country_name']}');
    final ipv4 = await Ipify.ipv4();
    String? atype = '0';
    String datex = '$day_';
    String? timex = '$Tim_';
    String? ip = '$ipv4';
    String? uid = '0';
    String? username = '$email';
    String? frm = '$frm_';
    String? fdo = '$fdo_';

    print(ipv4);
    String url =
        '${MyConstant().domain}/In_c_syslog.php?isAdd=true&ren=$ren&atype_=$atype&datex_=$datex&timex_=$timex&ip_=$ip&uid_=$uid&username_=$username&frm_=$frm&fdo_=$fdo';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result.toString());
    } catch (e) {}
  }
}
