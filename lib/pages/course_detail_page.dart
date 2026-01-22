import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';
import '../models/video_course.dart';

class CourseDetailPage extends StatelessWidget {
  final VideoCourse video;

  const CourseDetailPage({super.key, required this.video});

  Future<void> _playVideo() async {
    final uri = Uri.parse(video.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text(video.categoryName)),
      body: Column(
        children: [
          GestureDetector(
            onTap: _playVideo,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(video.thumbnail),
                const Icon(Icons.play_circle, size: 64, color: Colors.white),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              video.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
