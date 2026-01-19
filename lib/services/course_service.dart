import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';
import '../models/course_detail_model.dart';

class CourseService {
  static const String courseListUrl =
      'https://www.genzcoder.dev/api-course';

  static const String courseDetailUrl =
      'https://www.genzcoder.dev/api-course-detail';

  static Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(courseListUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List list = jsonData['data'];

      return list.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  static Future<CourseDetail> fetchCourseBySlug(String slug) async {
    final url = '$courseDetailUrl/$slug';
    print('FETCH DETAIL => $url');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return CourseDetail.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load course detail');
    }
  }
}
