// course_detail_page.dart
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video.dart';

class CourseDetailPage extends StatefulWidget {
  final List<Video> videos;
  final int startIndex;

  const CourseDetailPage({
    super.key,
    required this.videos,
    this.startIndex = 0,
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late YoutubePlayerController _controller;
  late int currentIndex;

  Video get currentVideo => widget.videos[currentIndex];

  @override
  void initState() {
    super.initState();

    if (widget.videos.isEmpty) {
      throw Exception("No videos to play!");
    }

    currentIndex = widget.startIndex;

    _controller = YoutubePlayerController(
      initialVideoId: currentVideo.youtubeId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    )..addListener(_listener);
  }

  void _listener() {
    if (_controller.value.playerState == PlayerState.ended) {
      _playNext();
    }
  }

  void _playNext() {
    if (currentIndex < widget.videos.length - 1) {
      setState(() {
        currentIndex++;
        _controller.load(widget.videos[currentIndex].youtubeId);
      });
    }
  }

  void _playAt(int index) {
    setState(() {
      currentIndex = index;
      _controller.load(widget.videos[index].youtubeId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          currentVideo.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  currentVideo.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '${currentVideo.categoryName} • ${currentVideo.subCategoryName}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),

              if (widget.videos.length > 1) ...[
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Up next',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.videos.length,
                  itemBuilder: (context, index) {
                    final v = widget.videos[index];
                    return ListTile(
                      leading: Image.network(
                        v.thumbnail,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        v.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(v.subCategoryName),
                      selected: index == currentIndex,
                      onTap: () => _playAt(index),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
