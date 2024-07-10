// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_string_interpolations, prefer_collection_literals, sort_child_properties_last, avoid_unnecessary_containers, prefer_is_empty, prefer_final_fields, camel_case_types, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, deprecated_member_use
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
import '../Constant/Myconstant.dart';

dynamic captureAndConvertToBase64(chartKey, Name) async {
  final boundary =
      chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image =
      await boundary.toImage(pixelRatio: 3.0); // Adjust pixelRatio as needed

  // Convert the captured image to bytes
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();

  // Encode the bytes to base64
  final base64String = base64Encode(buffer);
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  // print(base64String);
  String fileName = '${Name}_$timestamp.png';
  await Future.delayed(Duration(milliseconds: 100));
  String Foder_ = '';
  try {
    final url =
        '${MyConstant().domain}/File_downloadImg.php?name=$fileName&Foder=$Foder_';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'image': base64String,
        'Foder': Foder_,
        'name': fileName
      }, // Send the image as a form field named 'image'
    );

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      downloadImage(fileName);
      // downloadImage('${MyConstant().domain}/files/$foder/contract/$Form_Img_',
      //         '${Form_Img_}')
      //     .deleteFile(fileName_Slip);
    } else {
      downloadImage(fileName);
      print('Image upload failed $Foder_ // $fileName');
    }
  } catch (e) {
    print('Error during image processing: $e');
  }

  // return base64String;
}

dynamic downloadImage(fileName) async {
  try {
    // first we make a request to the url like you did
    // in the android and ios version
    final http.Response r = await http.get(
      Uri.parse('${MyConstant().domain}/Awaitdownload/$fileName'),
    );

    // we get the bytes from the body
    final data = r.bodyBytes;
    // and encode them to base64
    final base64data = base64Encode(data);

    // then we create and AnchorElement with the html package
    final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');

    // set the name of the file we want the image to get
    // downloaded to
    a.download = 'Load_$fileName.png';

    // and we click the AnchorElement which downloads the image
    a.click();
    // finally we remove the AnchorElement
    a.remove();
    await Future.delayed(Duration(seconds: 5));
    deleteFile(fileName);
  } catch (e) {
    print(e);
    deleteFile(fileName);
  }
}

dynamic deleteFile(fileName) async {
  String url =
      '${MyConstant().domain}/File_Deleted_downloadImg.php?name=$fileName';

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
