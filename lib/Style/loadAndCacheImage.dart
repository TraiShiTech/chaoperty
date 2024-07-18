import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

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
