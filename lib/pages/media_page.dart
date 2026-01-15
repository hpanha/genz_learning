import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'message_page.dart';


class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'All video_course',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      bottomNavigationBar: _bottomNav(context),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _searchBar(),
            _categoryList(),
            _courseList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundImage:
                AssetImage('assets/images/profile/phorn.jpg'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Horm Sophorn',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Good morning!',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const Spacer(),
          const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.orange,
            child: Icon(Icons.star, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ================= SEARCH =================
  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'ស្វែងរក',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.tune),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ================= CATEGORY =================
  Widget _categoryList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: const [
          _CategoryItem(title: 'វីដេអូ UI & UX'),
          Divider(),
          _CategoryItem(title: 'វីដេអូ កម្មវិធីទូរស័ព្ទ'),
          Divider(),
          _CategoryItem(title: 'វីដេអូ កម្មវិធីគេហទំព័រ'),
          Divider(),
          _CategoryItem(title: 'វីដេអូ កម្មវិធីកុំព្យូទ័រ'),
        ],
      ),
    );
  }

  // ================= COURSE LIST =================
  Widget _courseList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          _CourseCard(
            image: 'assets/images/course/cpp.png',
            title: 'វគ្គសិក្សាកម្មវិធីកុំព្យូទ័រ C++',
            lessons: '៤៨ មេរៀន',
            progress: 0.75,
          ),
          _CourseCard(
            image: 'assets/images/course/flutter.png',
            title: 'វគ្គសិក្សាកម្មវិធី Flutter',
            lessons: '៦៨ មេរៀន',
            progress: 0.30,
          ),
          _CourseCard(
            image: 'assets/images/course/web.png',
            title: 'វគ្គសិក្សា Web Fullstack',
            lessons: '៥០ មេរៀន',
            progress: 0.20,
          ),
        ],
      ),
    );
  }

  // ================= BOTTOM NAV =================
  Widget _bottomNav(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      currentIndex: 1, // Courses selected
      onTap: (index) {
        Navigator.pop(context);
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
            icon: Icon(Icons.play_circle), label: 'Courses'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

// ================= CATEGORY ITEM =================
class _CategoryItem extends StatelessWidget {
  final String title;

  const _CategoryItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.play_circle, color: Colors.purple),
        const SizedBox(width: 10),
        Expanded(child: Text(title)),
        const Icon(Icons.chevron_right),
      ],
    );
  }
}

// ================= COURSE CARD =================
class _CourseCard extends StatelessWidget {
  final String image;
  final String title;
  final String lessons;
  final double progress;

  const _CourseCard({
    required this.image,
    required this.title,
    required this.lessons,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Image.asset(image, width: 48),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(lessons,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  color: Colors.purple,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'PRO',
            style: TextStyle(
              fontSize: 12,
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
