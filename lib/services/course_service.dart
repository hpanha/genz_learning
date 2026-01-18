import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class CourseService {
  static const String apiUrl =
      'https://www.genzcoder.dev/api-course';

  static Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

   
      final List list = decoded['data'];

      return list.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
