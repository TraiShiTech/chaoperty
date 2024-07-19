class MyConstant {
  // https://mbstar.co.th
  // String domain =
  //     '${Uri.base.toString().substring(0, Uri.base.toString().length - 3)}/chao_api';
  // String domain = 'https://dzentric.com/chao_perty/chao_api';
  String domain = 'https://chaoperties.com/chao_api';
  // String domain = 'http://tananuwat.dynns.com:8080/APIQ';
  // String domain = 'http://goodviewcmu.cnxsolution.net:94/APIQ';
  // http://tananuwat.dynns.com:7080/webQR/#?1658194561/18,T01
  // String domain = 'http://192.168.1.23/chao_api';
  // String domain = 'http://192.168.1.152/chao_api';
}

// class MyImage {
//   String domainActivity = 'https://mbstar.co.th/admin/files/activity/';
//   String domainCar = 'https://mbstar.co.th/admin/files/car/';
//   String domainCard = 'https://mbstar.co.th/admin/files/card/';
//   String domainCover = 'https://mbstar.co.th/admin/files/cover/';
//   String domainPromotion = 'https://mbstar.co.th/admin/files/promotion/';
//   String domainSalary = 'https://mbstar.co.th/admin/files/salary/';
//   String domainheaderweb_img =
//       'https://mbstar.co.th/admin/files/headerweb_img/';
// }tys
  /////////////////////////////////-------------------------------------------->
  //  List<AreaModel> tenants = [];
  // List<AreaModel> _tenants = <AreaModel>[];
 		

 
  // Future<Null> read_GC_area(ser) async {
  //   if (areaModels.isNotEmpty) {
  //     setState(() {
  //       areaModels.clear();
  //       _areaModels.clear();

  //       selected_Area.clear();
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var ren = preferences.getString('renTalSer');
  //   var zone = preferences.getString('zoneSer');

  //   //print('zone >>>>>> $zone');

  //   String url =
  //       '${MyConstant().domain}/GC_area_calendar.php?isAdd=true&ren=$ren&zone=$zone';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result != null) {
  //       for (var map in result) {
  //         AreaModel areaModel = AreaModel.fromJson(map);

  //         setState(() {
  //           areaModels.add(areaModel);
  //         });
  //       }
  //     }
  //     setState(() {
  //       _areaModels = areaModels;
  //     });
  //     _resources = _getResources();
  //     _dataSource = _getCalendarDataSource();
  //   } catch (e) {}
  // }

  // /////////////////////////////////-------------------------------------------->
  // Future<Null> read_GC_Tenant(ser) async {
  //   if (tenants.isNotEmpty) {
  //     setState(() {
  //       tenants.clear();
  //       _tenants.clear();

  //       // selected_Area.clear();
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var ren = preferences.getString('renTalSer');
  //   var zone = preferences.getString('zoneSer');

  //   //print('zone >>>>>> $zone');

  //   String url =
  //       '${MyConstant().domain}/GC_areaAll_booking_calendar.php?isAdd=true&ren=$ren&zone=$ser&datelok=$SDatex_total1_&Ldate_x=$LDatex_total1_';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result != null) {
  //       for (var map in result) {
  //         AreaModel areaModel = AreaModel.fromJson(map);

  //         setState(() {
  //           tenants.add(areaModel);
  //         });
  //       }
  //     }
  //     setState(() {
  //       _tenants = tenants;
  //     });
  //     // _resources = _getResources();
  //     // _dataSource = _getCalendarDataSource();
  //   } catch (e) {}
  // }