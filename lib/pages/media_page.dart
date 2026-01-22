import 'package:flutter/material.dart';
import '../models/video_course.dart';
import '../models/video_category.dart';
import '../services/video_course_service.dart';
import '../services/video_category_service.dart';
import 'course_detail_page.dart';
import 'register_page.dart';
import 'notification_page.dart';
import 'message_page.dart';
import 'profile_page.dart';
import 'home_page.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _header(context),
          _categoryList(),
          Expanded(child: _videoList()),
        ],
      ),
      bottomNavigationBar: _bottomNav(context),
    );
  }

  // ================= HEADER =================
  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
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
              radius: 22,
              backgroundImage:
                  AssetImage('assets/images/profile/phorn.jpg'),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Horm Sophorn',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Good morning!',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationPage(),
                ),
              );
            },
            icon: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= CATEGORY =================
  Widget _categoryList() {
    return FutureBuilder<List<VideoCategory>>(
      future: VideoCategoryService.fetchCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }

        final categories = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _categoryChip('All', null),
              ...categories.map(
                (c) => _categoryChip(c.name, c.id),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _categoryChip(String name, int? id) {
    final bool selected = selectedCategoryId == id;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(name),
        selected: selected,
        onSelected: (_) {
          setState(() {
            selectedCategoryId = id;
          });
        },
        selectedColor: Colors.purple,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // ================= VIDEO LIST =================
  Widget _videoList() {
    return FutureBuilder<List<VideoCourse>>(
      future: VideoCourseService.fetchVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No videos found'));
        }

        final videos = snapshot.data!;
        final filtered = selectedCategoryId == null
            ? videos
            : videos
                .where((v) => v.categoryId == selectedCategoryId)
                .toList();

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final video = filtered[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailPage(video: video),
                  ),
                );
              },
              child: _VideoCard(video: video),
            );
          },
        );
      },
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MediaPage()),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MessagePage()),
        );
      }
      if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(Icons.play_circle),
        label: 'Courses',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

// ================= VIDEO CARD =================
class _VideoCard extends StatelessWidget {
  final VideoCourse video;

  const _VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Image.network(video.thumbnail, width: 80),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              video.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
