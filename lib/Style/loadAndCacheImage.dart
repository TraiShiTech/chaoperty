import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

import '../Constant/Myconstant.dart';

Future<Uint8List> loadAndCacheImage(String imageUrl) async {
  // Check if the image is already cached
  final cacheManager = DefaultCacheManager();
  final file = await cacheManager.getSingleFile(imageUrl);

  // If not cached, fetch the image from the network
  if (file == null) {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      // Cache the image file
      await cacheManager.putFile(imageUrl, bytes);

      return bytes;
    } else {
      throw Exception('Failed to load image');
    }
  } else {
    // Load the image bytes from the cache
    return file.readAsBytes();
  }
}

Future<Uint8List> loadAndCacheImage2(String imageUrl) async {
  // Check if the image is already cached
  final cacheManager = DefaultCacheManager();
  final file = await cacheManager.getSingleFile(imageUrl);

  // If not cached, fetch the image from the network
  if (file == null) {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      // Cache the image file
      await cacheManager.putFile(imageUrl, bytes);

      return bytes;
    } else {
      throw Exception('Failed to load image');
    }
  } else {
    // Load the image bytes from the cache
    return file.readAsBytes();
  }
}

/////--------------------------->
Future<Uint8List> resizeAndCompressImage(Uint8List imageBytes) async {
  img.Image image = img.decodeImage(imageBytes)!;
  img.Image resizedImage = img.copyResize(image, width: 100, height: 100);
  Uint8List resizedImageBytes =
      Uint8List.fromList(img.encodeJpg(resizedImage, quality: 100));
  return resizedImageBytes;
}

/////--------------------------->
Future<Uint8List> resizeAndCompressImage_Map(Uint8List imageBytes) async {
  img.Image image = img.decodeImage(imageBytes)!;
  img.Image resizedImage = img.copyResize(image, width: 400, height: 400);
  Uint8List resizedImageBytes =
      Uint8List.fromList(img.encodeJpg(resizedImage, quality: 100));
  return resizedImageBytes;
}

Future<Uint8List> loadImage(String url) async {
  final cacheManager = DefaultCacheManager();
  final file = await cacheManager.getSingleFile(url);
  return file.readAsBytesSync();
}

Future<void> cacheResizedImage(
    Uint8List resizedImageBytes, String cacheKey) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(cacheKey, String.fromCharCodes(resizedImageBytes));
}

Future<Uint8List?> getCachedResizedImage(String cacheKey) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? imageString = preferences.getString(cacheKey);
  return imageString != null ? Uint8List.fromList(imageString.codeUnits) : null;
}

Future<Uint8List?> getResizedLogo() async {
  try {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? logoUrl = preferences.getString('renTal_logo');

    if (logoUrl == null || logoUrl.isEmpty) {
      return null;
    }

    final String cacheKey = 'resized_$logoUrl';
    Uint8List? cachedImage = await getCachedResizedImage(cacheKey);

    if (cachedImage == null) {
      final Uint8List imageBytes = await loadImage(logoUrl);
      final Uint8List resizedImageBytes =
          await resizeAndCompressImage(imageBytes);
      await cacheResizedImage(resizedImageBytes, cacheKey);
      cachedImage = resizedImageBytes;
    }

    return cachedImage;
  } catch (e, stackTrace) {
    // Log the error and stack trace
    print('Error in getResizedLogo: $e');
    print(stackTrace);
    return null;
  }
}

Future<Uint8List?> getResizedMap(url) async {
  try {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? logoUrl = '${MyConstant().domain}/$url';

    if (logoUrl == null || logoUrl.isEmpty) {
      return null;
    }

    final String cacheKey = 'resizedMap_$logoUrl';
    Uint8List? cachedImage = await getCachedResizedImage(cacheKey);

    if (cachedImage == null) {
      final Uint8List imageBytes = await loadImage(logoUrl);
      final Uint8List resizedImageBytes =
          await resizeAndCompressImage_Map(imageBytes);
      await cacheResizedImage(resizedImageBytes, cacheKey);
      cachedImage = resizedImageBytes;
    }

    return cachedImage;
  } catch (e, stackTrace) {
    // Log the error and stack trace
    print('Error in getResizedLogo: $e');
    print(stackTrace);
    return null;
  }
}

// Future<pw.Container> generatePdfWithLogo() async {
//   Uint8List? resizedLogo = await getResizedLogo();

//   return pw.Container(
//     height: 60,
//     width: 60,
//     decoration: pw.BoxDecoration(
//       color: PdfColors.grey200,
//       border: pw.Border.all(color: PdfColors.grey300),
//     ),
//     child: resizedLogo != null
//         ? pw.Image(
//             pw.MemoryImage(resizedLogo),
//             height: 60,
//             width: 60,
//           )
//         : pw.Text('No image available'),
//   );
// }
