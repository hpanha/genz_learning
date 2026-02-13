import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
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
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
        enableCaption: false,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    // Auto play next video
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

  // Reset orientation & system UI
  Future<void> _resetOrientation() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _resetOrientation();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Reset orientation when user presses back
        await _resetOrientation();
        return true;
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.purple,
          onEnded: (_) => _playNext(),
        ),
        builder: (context, player) {
          bool isFullScreen = _controller.value.isFullScreen;

          // Fullscreen system UI
          if (isFullScreen) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
              DeviceOrientation.portraitUp,
            ]);
          } else {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
          }

          return Scaffold(
            appBar: isFullScreen
                ? null
                : AppBar(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
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
                    // Player
                    player,
                    const SizedBox(height: 12),
                    // Video title
                    if (!isFullScreen)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          currentVideo.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (!isFullScreen) const SizedBox(height: 6),
                    // Category info
                    if (!isFullScreen)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${currentVideo.categoryName} • ${currentVideo.subCategoryName}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    if (!isFullScreen) const SizedBox(height: 12),

                    // Up Next
                    if (!isFullScreen && widget.videos.length > 1) ...[
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
                          return GestureDetector(
                            onTap: () => _playAt(index),
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      v.thumbnail,
                                      width: 120,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          v.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: index == currentIndex
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        ),
                                        Text(
                                          v.subCategoryName,
                                          style:
                                              const TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
