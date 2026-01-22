import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video_category.dart';

class VideoCategoryService {
  static const String apiUrl =
      'https://www.genzcoder.dev/api-video-category';

  static Future<List<VideoCategory>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List data = body['data'];
      return data.map((e) => VideoCategory.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
