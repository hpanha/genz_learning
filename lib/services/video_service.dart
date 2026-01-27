import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video.dart';

class VideoService {
  static Future<List<Video>> fetch() async {
    final res = await http.get(
        Uri.parse('https://www.genzcoder.dev/api-video-play-list'));

    final body = json.decode(res.body)['data'];

    return body.map<Video>((e) => Video.fromJson(e)).toList();
  }
}
