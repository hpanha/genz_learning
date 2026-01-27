import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoryService {
  static Future<List<Category>> fetch() async {
    final res = await http.get(
        Uri.parse('https://www.genzcoder.dev/api-video-category'));

    final body = json.decode(res.body)['data'];

    return body.map<Category>((e) => Category.fromJson(e)).toList();
  }
}
