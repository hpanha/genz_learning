import 'package:flutter/material.dart';
import '../models/video.dart';
import '../models/category.dart';
import '../services/video_service.dart';
import '../services/category_service.dart';
import 'playlist_detail_page.dart';
import 'register_page.dart';
import 'notification_page.dart';
import 'message_page.dart';
import 'profile_page.dart';
import 'home_page.dart';
import 'course_detail_page.dart';


class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  String selectedCategory = 'All';
  late Future<List<Category>> _categoryFuture;
  List<Video> _allVideos = [];
  bool _loadingVideos = true;

  @override
  void initState() {
    super.initState();
    _categoryFuture = CategoryService.fetch();
    _fetchVideos();
  }

  void _fetchVideos() async {
    _allVideos = await VideoService.fetch();
    setState(() {
      _loadingVideos = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Video> filteredVideos = selectedCategory == 'All'
        ? _allVideos
        : _allVideos.where((v) => v.categoryName == selectedCategory).toList();

    final Map<String, List<Video>> grouped = {};
    for (var v in filteredVideos) {
      grouped.putIfAbsent(v.subCategoryName, () => []);
      grouped[v.subCategoryName]!.add(v);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _header(context),
          _categoryList(),
          Expanded(
            child: _loadingVideos
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: grouped.entries.map((e) {
                      final list = e.value;
                      if (list.length == 1) return _VideoCard(video: list.first);
                      return PlaylistCard(title: e.key, videos: list);
                    }).toList(),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNav(context),
    );
  }

  // ================= HEADER =================
  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 28),
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RegisterPage()),
              );
            },
            child: const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/profile/phorn.jpg'),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Horm Sophorn',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Text('Good morning!', style: TextStyle(color: Colors.white70)),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
            icon: Container(
              width: 42,
              height: 42,
              decoration:
                  const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.notifications, color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }

  // ================= CATEGORY LIST =================
  Widget _categoryList() {
    return FutureBuilder<List<Category>>(
      future: _categoryFuture,
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _categoryChip('All'),
              ...snap.data!.map((c) => _categoryChip(c.name)),
            ],
          ),
        );
      },
    );
  }

  Widget _categoryChip(String name) {
    final bool selected = selectedCategory == name;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = name;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.purple : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Text(
            name,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // ================= BOTTOM NAV =================
  Widget _bottomNav(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      currentIndex: 1,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const HomePage()));
        } else if (index == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const MediaPage()));
        } else if (index == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const MessagePage()));
        } else if (index == 3) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ProfilePage()));
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: 'Courses'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class _VideoCard extends StatelessWidget {
  final Video video;

  const _VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailPage(
              videos: [video],
              startIndex: 0,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  video.thumbnail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                video.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 6),

            // Sub category
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                video.subCategoryName,
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}



class PlaylistCard extends StatelessWidget {
  final String title;
  final List<Video> videos;

  const PlaylistCard({
    super.key,
    required this.title,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaylistDetailPage(title: title, videos: videos),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    Image.network(
                      videos.first.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    // Playlist overlay
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.playlist_play,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              videos.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Playlist title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 6),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '${videos.length} episodes',
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
