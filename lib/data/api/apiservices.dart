// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:bloc_posts/data/api/api.dart';
import 'package:bloc_posts/domain/entities/postentities.dart';
import 'package:http/http.dart' as http;

class PostServices {
  final client = http.Client();
  Future<List<PostModel>> fetchAllPosts() async {
    try {
      final response = await client.get(Uri.parse(
          "${API().baseUrl}${API().endPoint}")); // getting response when hitting the converted url to URI
      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
        final List<PostModel> posts = responseBody
            .map((json) => PostModel.fromJson(json))
            .toList(); // converting everything in the response body to POSTMODEL =>> .fromJson == >> each map  converted using method in POSTMODEL ==> fromJson
        return posts;
      } else {
        throw ApiException(
            "Failed to fetch posts. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw ApiException("Failed to fetch Posts : $e");
    }
  }
}

class ApiException implements Exception {
  final String? message;
  ApiException(String errormessage, {this.message});

  @override
  String toString() {
    return 'ApiException : $message';
  }
}
