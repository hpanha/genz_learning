import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'message_page.dart';
import 'course_detail_page.dart';
import 'home_page.dart';
import 'notification_page.dart';

/// ================= COURSE MODEL =================
class Courses {
  final String image;
  final String title;
  final String lessons;
  final double progress;
  final String category;

  Courses({
    required this.image,
    required this.title,
    required this.lessons,
    required this.progress,
    required this.category,
  });
}

/// ================= MEDIA PAGE =================
class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  String selectedCategory = 'All';

  final List<Courses> allCourses = [
    Courses(
      image: 'assets/images/coursesImg/cppCourse.png',
      title: 'វគ្គសិក្សាកម្មវិធីកុំព្យូទ័រ C++',
      lessons: '៤៨ មេរៀន',
      progress: 0.75,
      category: 'Desktop',
    ),
    Courses(
      image: 'assets/images/coursesImg/flutter.png',
      title: 'វគ្គសិក្សាកម្មវិធី Flutter',
      lessons: '៦៨ មេរៀន',
      progress: 0.30,
      category: 'Mobile',
    ),
    Courses(
      image: 'assets/images/coursesImg/javaCourse.png',
      title: 'វគ្គសិក្សា Web Fullstack',
      lessons: '៥០ មេរៀន',
      progress: 0.20,
      category: 'Web',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCourses = selectedCategory == 'All'
        ? allCourses
        : allCourses
            .where((c) => c.category == selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: _bottomNav(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _categoryList(),
            _courseList(filteredCourses),
            const SizedBox(height: 20),
          ],
        ),
      ),
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
      children: [
        // Profile avatar + info
        const CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('assets/images/profile/phorn.jpg'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Horm Sophorn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Good morning!',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        const Spacer(),
        // Notification button
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}


  // ================= CATEGORY LIST =================
  Widget _categoryList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: ExpansionTile(
          iconColor: Colors.purple,
          title: Row(
            children: const [
              Icon(Icons.video_library, color: Colors.purple),
              SizedBox(width: 10),
              Text('វីដេអូ',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          children: [
            _categoryItem('All', 'All'),
            _categoryItem('វីដេអូ UI & UX', 'UI'),
            _categoryItem('វីដេអូ កម្មវិធីទូរស័ព្ទ', 'Mobile'),
            _categoryItem('វីដេអូ កម្មវិធីគេហទំព័រ', 'Web'),
            _categoryItem('វីដេអូ កម្មវិធីកុំព្យូទ័រ', 'Desktop'),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(String title, String category) {
    return ListTile(
      leading: const Icon(Icons.play_circle, color: Colors.purple),
      title: Text(title),
      trailing: selectedCategory == category
          ? const Icon(Icons.check, color: Colors.purple)
          : null,
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
        Navigator.pop(context);
      },
    );
  }

  // ================= COURSE LIST =================
  Widget _courseList(List<Courses> courses) {
    if (courses.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(30),
        child: Text(
          'មិនមានវគ្គសិក្សានៅក្នុងប្រភេទនេះទេ',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children:
courses
    .map(
      (course) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailPage(course: course),
            ),
          );
        },
        child: _CourseCard(course: course),
      ),
    )
    .toList(),
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

/// ================= COURSE CARD =================
class _CourseCard extends StatelessWidget {
  final Courses course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Image.asset(course.image, width: 55),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(course.lessons,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: course.progress,
                  backgroundColor: Colors.grey[300],
                  color: Colors.purple,
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'PRO',
              style: TextStyle(
                  color: Colors.purple, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
