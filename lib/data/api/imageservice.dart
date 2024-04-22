// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:bloc_posts/data/api/api.dart';
import 'package:bloc_posts/data/api/apiservices.dart';
import 'package:bloc_posts/domain/entities/postimageentity.dart';
import 'package:http/http.dart' as http;

class ImageService {
  final client = http.Client();

  Future<List<PostImageModel>> fetchImages() async {
    try {
      final response = await client.get(Uri.parse('${API().baseUrl}/photos'));
      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        final List<PostImageModel> images =
            responseBody.map((json) => PostImageModel.fromJson(json)).toList();
        print("images: $images");
        return images;
      } else {
        throw ApiException(
            'Failed to fetch images. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw ApiException('Failed to fetch images: $e');
    }
  }
}
