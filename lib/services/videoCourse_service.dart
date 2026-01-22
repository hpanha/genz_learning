import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video_course.dart';

class VideoCourseService {
  static const String apiUrl =
      'https://www.genzcoder.dev/api-video-course';

  static Future<List<VideoCourse>> fetchVideos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List list = body['data'];

      return list.map((e) => VideoCourse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load video courses');
    }
  }
}

