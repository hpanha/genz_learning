import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'message_page.dart';
import 'media_page.dart';
import 'notification_page.dart';
import 'register_page.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: _bottomNav(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context),
              _searchBar(),
              _banner(),
              _sectionLabel('សូមស្វាគមន៍មកកាន់ការសិក្សាផ្នែកទំនាក់ទំនង'),
              _instructorSection(),
              _techIcons(),
              _courseGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _header(BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(30, 15, 30, 50),
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
              MaterialPageRoute(
                builder: (_) => RegisterPage(),
              ),
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
          icon: const Icon(Icons.notifications, color: Colors.white),
        ),
      ],
    ),
  );
}



  // SEARCH BAR
  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Transform.translate(
        offset: const Offset(0, -45),
        child: Container(
          width: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

            // ✅ BORDER
            border: Border.all(color: Colors.purple.shade300, width: 1.5),

            // ✅ SHADOW
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none, // remove TextField border
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
    );
  }

  // BANNER
  Widget _banner() {
    return Transform.translate(
      offset: const Offset(0, -30), // ⬆ move up
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: 370,
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage('assets/images/courseContainer.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // PURPLE LABEL BEFORE INSTRUCTOR
  Widget _sectionLabel(String text) {
    return Container(
      width: double.infinity, // full width
      color: Colors.purple, // Purple background
      padding: const EdgeInsets.symmetric(vertical: 12), // vertical padding only
      child: Text(
        text,
        textAlign: TextAlign.center, // optional: center the text
        style: const TextStyle(
          color: Colors.white, // White text
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  final List<String> instructorImages = [
  'assets/images/profile/panha.jpg',
  'assets/images/profile/phorn.jpg',
  'assets/images/profile/sreypich.jpg',
  'assets/images/profile/long.jpg',
  'assets/images/profile/makara.jpg',
];

  // INSTRUCTORS
  Widget _instructorSection() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Instructor',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: instructorImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(3), // border thickness
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(instructorImages[index]),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'What on your mind?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}


Widget _techIcons() {
  final List<String> techImages = [
    'assets/images/courseLogo/cpp.png',
    'assets/images/courseLogo/css.png',
    'assets/images/courseLogo/html.png',
    'assets/images/courseLogo/js.png',
    'assets/images/courseLogo/flutter.png',
    'assets/images/courseLogo/laravel.png',
    'assets/images/courseLogo/mysql.png',
    'assets/images/courseLogo/react.png',
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scroll
      child: Row(
        children: techImages.map((image) {
          return Container(
            margin: const EdgeInsets.only(right: 12), // space between logos
            width: 40, // circle size
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6), // inner padding
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}


  // COURSES GRID
  Widget _courseGrid() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _courseCard('C# Programming', 'assets/images/coursesImg/cppCourse.png'),
        _courseCard('Web Design', 'assets/images/coursesImg/html&cssCourse.png'),
      ],
    ),
  );
}


  Widget _courseCard(String title, String imagePath) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blueAccent, // Card background color
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath, // Example: 'assets/images/csharp.png'
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(108, 0, 0, 0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}


  // BOTTOM NAV
  Widget _bottomNav(BuildContext context) {
  return BottomNavigationBar(
    selectedItemColor: Colors.purple,
    unselectedItemColor: Colors.grey,
    currentIndex: 0,
    onTap: (index) {
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
