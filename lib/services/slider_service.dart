import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/slider_item.dart';

class SliderService {
  static const String apiUrl = 'https://www.genzcoder.dev/api-slider';

  static Future<List<SliderItem>> fetchSliders() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List list = body['data'];

      return list.map((e) => SliderItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load slider data');
    }
  }
}
