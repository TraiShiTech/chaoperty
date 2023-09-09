import 'dart:html';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart' as xml;

import '../Model/GetArea_Model.dart';

Future<List<AreaModel>> loadSvgImage(
    {required String svgImage, areaModels}) async {
  List<AreaModel> maps = [];

  // Make a network request to fetch the SVG data
  var response = await http.get(Uri.parse(svgImage));
  if (response.statusCode == 200) {
    String svgString = response.body;

    xml.XmlDocument document = xml.XmlDocument.parse(svgString);
    final paths = document.findAllElements('path');
    int index = 0;
    for (var element in paths) {
      String partId = element.getAttribute('id').toString();
      String partPath = element.getAttribute('d').toString();
      String name = element.getAttribute('name').toString();
      String color = element.getAttribute('color')?.toString() ?? 'D7D3D2';

      // int index = areaModels.indexWhere((area) => area.id == partId);
      maps.add(AreaModel(
          ser: areaModels[index].ser.toString(),
          rser: areaModels[index].rser.toString(),
          zser: areaModels[index].zser.toString(),
          lncode: areaModels[index].lncode.toString(),
          ln: areaModels[index].ln.toString(),
          area: areaModels[index].area.toString(),
          rent: areaModels[index].rent.toString(),
          st: areaModels[index].st.toString(),
          img: areaModels[index].img.toString(),
          data_update: areaModels[index].data_update.toString(),
          quantity: areaModels[index].quantity.toString(),
          ldate: areaModels[index].ldate.toString(),
          cid: areaModels[index].cid.toString(),
          total: areaModels[index].total.toString(),
          ln_c: areaModels[index].ln_c.toString(),
          area_c: areaModels[index].area_c.toString(),
          docno: areaModels[index].docno.toString(),
          ln_q: areaModels[index].ln_q.toString(),
          ldate_q: areaModels[index].ldate_q.toString(),
          area_q: areaModels[index].area_q.toString(),
          total_q: areaModels[index].total_q.toString(),
          sname: areaModels[index].sname.toString(),
          sname_q: areaModels[index].sname_q.toString(),
          cname: areaModels[index].cname.toString(),
          cname_q: areaModels[index].cname_q.toString(),
          custno: areaModels[index].custno.toString(),
          zn: areaModels[index].zn.toString(),
          datex: areaModels[index].datex.toString(),
          timex: areaModels[index].timex.toString(),
          cser: areaModels[index].cser.toString(),
          aser: areaModels[index].aser.toString(),
          aserQout: areaModels[index].aserQout.toString(),
          type: areaModels[index].type.toString(),
          sdate: areaModels[index].sdate.toString(),
          dataUpdate: areaModels[index].dataUpdate.toString(),
          id: partId,
          path: partPath,
          color: color,
          name: name));
      index++;
    }
    print('partId   index++ ///// ${maps.length}');
  }

  return maps;
}

////////////////////--------------------------------------->
// Future<List<AreaModel>> loadSvgImage(
//     {required String svgImage, areaModels}) async {
//   List<AreaModel> maps = [];

//   // Load the SVG image as a string
//   String generalString = await rootBundle.loadString(svgImage);

//   // Parse the SVG string using the xml package
//   final document = xml.XmlDocument.parse(generalString);

//   // Find all 'path' elements in the SVG document
//   final paths = document.findAllElements('path');

//   // Iterate over each 'path' element and create AreaModel objects

//   for (var element in paths) {
//     String partId = element.getAttribute('id').toString();
//     String partPath = element.getAttribute('d').toString();
//     String name = element.getAttribute('name').toString();
//     String color = element.getAttribute('color')?.toString() ?? 'D7D3D2';
//     int index = areaModels.indexWhere((area) => area.id == partId);
//     // Create an AreaModel object and add it to the list
//     maps.add(AreaModel(
//         ser: areaModels[index].ser.toString(),
//         rser: areaModels[index].rser.toString(),
//         zser: areaModels[index].zser.toString(),
//         lncode: areaModels[index].lncode.toString(),
//         ln: areaModels[index].ln.toString(),
//         area: areaModels[index].area.toString(),
//         rent: areaModels[index].rent.toString(),
//         st: areaModels[index].st.toString(),
//         img: areaModels[index].img.toString(),
//         data_update: areaModels[index].data_update.toString(),
//         quantity: areaModels[index].quantity.toString(),
//         ldate: areaModels[index].ldate.toString(),
//         cid: areaModels[index].cid.toString(),
//         total: areaModels[index].total.toString(),
//         ln_c: areaModels[index].ln_c.toString(),
//         area_c: areaModels[index].area_c.toString(),
//         docno: areaModels[index].docno.toString(),
//         ln_q: areaModels[index].ln_q.toString(),
//         ldate_q: areaModels[index].ldate_q.toString(),
//         area_q: areaModels[index].area_q.toString(),
//         total_q: areaModels[index].total_q.toString(),
//         sname: areaModels[index].sname.toString(),
//         sname_q: areaModels[index].sname_q.toString(),
//         cname: areaModels[index].cname.toString(),
//         cname_q: areaModels[index].cname_q.toString(),
//         custno: areaModels[index].custno.toString(),
//         zn: areaModels[index].zn.toString(),
//         datex: areaModels[index].datex.toString(),
//         timex: areaModels[index].timex.toString(),
//         cser: areaModels[index].cser.toString(),
//         aser: areaModels[index].aser.toString(),
//         aserQout: areaModels[index].aserQout.toString(),
//         type: areaModels[index].type.toString(),
//         sdate: areaModels[index].sdate.toString(),
//         dataUpdate: areaModels[index].dataUpdate.toString(),
//         id: partId,
//         path: partPath,
//         color: color,
//         name: name));
//   }

//   return maps;
// }

class Clipper extends CustomClipper<Path> {
  Clipper({
    required this.svgPath,
    required this.width,
    required this.height,
  });

  String svgPath;
  double width;
  double height;

  @override
  Path getClip(Size size) {
    var path = parseSvgPathData(svgPath);
    final Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(1.1, 1.1);

    // Calculate the scaling factors for width and height
    double scaleX = width / size.width;
    double scaleY = height / size.height;

    // Apply the scaling transformation
    matrix4.scale(scaleX, scaleY);

    // Calculate the translation offsets to center the clipped image
    double offsetX = (size.width - width) / 2;
    double offsetY = (size.height - height) / 2;

    // Apply the translation transformation
    matrix4.translate(offsetX, offsetY);

    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
