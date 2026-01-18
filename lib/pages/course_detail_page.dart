import 'package:flutter/material.dart';
import 'media_page.dart';
import 'profile_page.dart';
import 'message_page.dart';
import 'home_page.dart';

class CourseDetailPage extends StatelessWidget {
  final Courses course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.grey[100],
  body: SingleChildScrollView(
  child: Column(
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          _header(),
          Positioned(
            left: 16,
            right: 16,
            top: 105,
            child: _videoCard(),
          ),
        ],
      ),
      const SizedBox(height: 265),
      _courseInfo(),
      const SizedBox(height: 16),
      _tabBar(),
      _lessonList(),
    ],
  ),
),

  bottomNavigationBar: _bottomNav(context),
);

  }

  // ================= HEADER =================
   Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 45, 20, 35),
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CircleAvatar(
                radius: 22,
                backgroundImage:
                    AssetImage('assets/images/profile/phorn.jpg'),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Horm Sophorn',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Good morning!',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.notifications, color: Colors.white),
        ],
      ),
    );
  }


  Widget _videoCard() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 45, 20, 35),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video Preview
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                course.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 180,
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.35),
              ),
              const Icon(
                Icons.play_circle_fill,
                size: 64,
                color: Colors.white,
              ),
            ],
          ),
        ),

        // Progress bar
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: 0.3,
                backgroundColor: Colors.grey[300],
                color: Colors.purple,
              ),
              const SizedBox(height: 6),
              const Text(
                "20:32 / 1:20:00",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  // ================= COURSE INFO =================
  Widget _courseInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.star, size: 16, color: Colors.orange),
              SizedBox(width: 4),
              Text("4.5"),
              SizedBox(width: 12),
              Text("Free", style: TextStyle(color: Colors.purple)),
            ],
          ),
        ],
      ),
    );
  }

  // ================= TAB BAR =================
  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Lessons",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                  child: Text(
                    "Reviews",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= LESSON LIST =================
  Widget _lessonList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(
          4,
          (index) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.play_circle_fill, color: Colors.purple),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Lesson ${index + 1}: Product list render from API",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
