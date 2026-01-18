import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/about.dart';

class AboutService {
  static const String apiUrl = 'https://www.genzcoder.dev/api-about';

  static Future<List<About>> fetchAbout() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List list = body['data'];

      return list.map((e) => About.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load about');
    }
  }
}
