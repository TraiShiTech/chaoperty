// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_string_interpolations, prefer_collection_literals, sort_child_properties_last, avoid_unnecessary_containers, prefer_is_empty, prefer_final_fields, camel_case_types, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, deprecated_member_use, depend_on_referenced_packages
import 'dart:html';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart' as xml;

import '../Model/GetArea_Model.dart';
import '../Model/GetOverdue_floorplans_Model.dart';

Future<List<Overdue_floorplansModel>> loadSvgImageOverdue(
    {required String svgImage, areaModelsOverdue, areaModelsAll}) async {
  List<Overdue_floorplansModel> maps = [];

  // Make a network request to fetch the SVG data
  var response = await http.get(Uri.parse(svgImage));
  if (response.statusCode == 200) {
    String svgString = response.body;

    xml.XmlDocument document = xml.XmlDocument.parse(svgString);
    final paths = document.findAllElements('path');
    // int index = 0;
    for (int index = 0; index < areaModelsAll.length; index++) {
      for (var element in paths) {
        String partId = element.getAttribute('id').toString().trim();
        String partPath = element.getAttribute('d').toString().trim();
        String name = element.getAttribute('name').toString().trim();
        String color = element.getAttribute('color')?.toString() ?? 'D7D3D2';

        if (areaModelsAll[index].ln.toString().trim() ==
            name.toString().trim()) {
          maps.add(Overdue_floorplansModel(
              ser: areaModelsAll[index].ser.toString(),
              custno: areaModelsAll[index].custno.toString(),
              dtype: areaModelsAll[index].dtype.toString(),
              date: areaModelsAll[index].date.toString(),
              total: areaModelsAll[index].total.toString(),
              refno: areaModelsAll[index].refno.toString(),
              lncode: areaModelsAll[index].lncode.toString(),
              ln: areaModelsAll[index].ln.toString(),
              no: areaModelsAll[index].no.toString(),
              sname: areaModelsAll[index].sname.toString(),
              zn: areaModelsAll[index].zn.toString(),
              zser: areaModelsAll[index].zser.toString(),
              ln_c: areaModelsAll[index].ln_c.toString(),
              in_docno: areaModelsAll[index].in_docno.toString(),
              docno: areaModelsAll[index].docno.toString(),
              quantity: areaModelsAll[index].quantity.toString(),
              id: partId,
              path: partPath,
              color: color,
              name: name,
              ser_area: ''));
        }

        // index++;
      }
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
class ClipperOverdue extends CustomClipper<Path> {
  ClipperOverdue({
    required this.svgPath,
  });

  String svgPath;

  @override
  Path getClip(Size size) {
    var path = parseSvgPathData(svgPath);
    final Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(1.0, 1.0, 1.0);

    return path.transform(matrix4.storage).shift(const Offset(0, -15));
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}


// SELECT
//     c_trans.ser,
//     c_trans.custno ,
//     c_trans.dtype AS dtype,
//     c_trans.date,
//     SUM(c_trans.amt) AS total,
//     c_trans.refno,
//     c_area.lncode,
//     c_area.ln,
//     c_trans.no,
//     c_contract.sname,
//     c_contract.zn,
//     c_contract.zser,
//     c_contract.ln AS ln_c,
//     c_invoice.docno AS  in_docno,
//  GROUP_CONCAT(CONVERT(c_trans.docno USING utf8) SEPARATOR ',') AS docno,

// CASE WHEN (c_area.ser IN (SELECT DISTINCT(aser) FROM c_areax WHERE type = 'A' )) THEN '1'
// WHEN (c_area.ser IN (SELECT DISTINCT(aser) FROM c_areax WHERE type = 'B'  )) THEN '2'
// WHEN (c_area.ser IN (SELECT DISTINCT(aser) FROM c_areax WHERE type = 'C'  )) THEN '3'
// ELSE null  END AS quantity

// FROM c_area   
// LEFT JOIN c_invoice ON c_invoice.refno = c_area.cid     
// LEFT JOIN c_trans ON c_trans.refno = c_area.cid    
// LEFT JOIN c_contractx ON c_contractx.cid = c_area.cid  
// LEFT JOIN c_contract ON c_contract.cid = c_area.cid  


// -- FROM c_trans   
// -- LEFT JOIN c_invoice ON c_invoice.refno = c_trans.docno     
// -- LEFT JOIN c_area ON c_area.cid = c_trans.refno    
// -- LEFT JOIN c_contractx ON c_contractx.ser = c_trans.no
// -- LEFT JOIN c_contract ON c_contract.cid = c_trans.refno
   
// WHERE
//     (
//         c_trans.dtype IN ('KR', 'KD', 'KO', 'DP' )
//       AND c_trans.refno = 'LE000023'
//         AND c_trans.date = '2023-01-01' 
//         AND (
//             NOT (
//                 c_trans.docno IN (
//                     SELECT refno
//                     FROM c_trans
//                     WHERE dtype IN ('KP')
//                 )
//                 AND c_trans.term = '0'
//             )
//         )
//     )
// AND 
//     c_contractx.etype != 'F'
//     OR (
//         c_trans.dtype IN ('KU')
//         AND (
//             NOT (
//                 c_trans.docno IN (
//                     SELECT refno
//                     FROM c_trans
//                     WHERE dtype IN ('KP')
//                 )
//             )
//         )
//     )


//  AND c_trans.refno =  'LE000023'   AND c_trans.date = '2023-01-01'  AND c_contractx.etype != 'F'   
// GROUP BY c_area.ser
// HAVING   total != 0.00
// ORDER BY c_area.lncode ASC ;