// playlist_detail_page.dart
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
        backgroundColor: Colors.purple,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];

          return ListTile(
            leading: Image.network(video.thumbnail, width: 90),
            title: Text(video.title),
            subtitle: Text(video.subCategoryName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CourseDetailPage(
                    videos: videos,
                    startIndex: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
