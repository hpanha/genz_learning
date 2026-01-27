import 'package:flutter/material.dart';
import '../models/video.dart';
import 'course_detail_page.dart';

class PlaylistDetailPage extends StatelessWidget {
  final String title;
  final List<Video> videos;

  const PlaylistDetailPage({
    super.key,
    required this.title,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return GestureDetector(
            onTap: () {
              // Navigate to course_detail_page to play video
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CourseDetailPage(video: video),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ],
              ),
              child: Row(
                children: [
                  Image.network(video.thumbnail, width: 100, height: 60, fit: BoxFit.cover),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          video.subCategoryName,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.play_circle_fill, color: Colors.purple, size: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
