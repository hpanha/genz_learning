import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: _bottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
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
  Widget _header() {
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
          const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Horm Sophorn',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text('Good morning!', style: TextStyle(color: Colors.white70)),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
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
                color: Colors.black.withOpacity(0.1),
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
              itemCount: 5,
              itemBuilder: (_, _) {
                return const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/instructor.jpg'),
                  ),
                );
              },
            ),
          ),
                  const Text(
            'What on you mind?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // TECH ICONS
  Widget _techIcons() {
    final icons = [
      Icons.code,
      Icons.html,
      Icons.css,
      Icons.javascript,
      Icons.flutter_dash,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: icons
            .map(
              (icon) => CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(icon, color: Colors.purple),
              ),
            )
            .toList(),
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
          _courseCard('C# Programming', Icons.code),
          _courseCard('Web Design', Icons.web),
        ],
      ),
    );
  }

  Widget _courseCard(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.purple),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // BOTTOM NAV
  Widget _bottomNav() {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
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
