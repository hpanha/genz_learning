import 'package:flutter/material.dart';
import '../models/video.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailPage extends StatelessWidget {
  final Video video;

  const CourseDetailPage({super.key, required this.video});

  void _openYoutube() async {
    final url = Uri.parse('https://www.youtube.com/watch?v=${video.youtubeId}');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(video.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(video.thumbnail),
            const SizedBox(height: 16),
            Text(
              video.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(video.subCategoryName),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _openYoutube,
              child: const Text('Play Video'),
            ),
          ],
        ),
      ),
    );
  }
}
