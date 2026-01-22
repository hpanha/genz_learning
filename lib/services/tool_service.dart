import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tool.dart';

class ToolService {
  static const String apiUrl = 'https://www.genzcoder.dev/api-tool';

  static Future<List<Tool>> fetchSliders() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List list = body['data'];

      return list.map((e) => Tool.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load slider data');
    }
  }
}
