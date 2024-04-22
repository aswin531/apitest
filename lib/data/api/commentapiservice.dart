// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:bloc_posts/data/api/api.dart';
import 'package:bloc_posts/data/api/apiservices.dart';
import 'package:bloc_posts/domain/entities/postcommententities.dart';
import 'package:http/http.dart' as http;

class CommentService {
  final client = http.Client();

  Future<List<PostCommentModel>> fetchComments() async {
    try {
      final response = await client.get(Uri.parse('${API().baseUrl}/comments'));
      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        final List<PostCommentModel> comments =
            responseBody.map((json) => PostCommentModel.fromJson(json)).toList();
        print("comments: $comments"); 
        return comments;
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
