import 'package:flutter/material.dart';
import '../models/video.dart';

class PlaylistDetailPage extends StatelessWidget {
  final List<Video> videos;
  final String title;

  const PlaylistDetailPage({
    super.key,
    required this.videos,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (_, i) {
          final v = videos[i];
          return ListTile(
            leading: Image.network(v.thumbnail),
            title: Text(v.title),
          );
        },
      ),
    );
  }
}
