import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'media_page.dart';
import 'home_page.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'សារជជែក',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      bottomNavigationBar: _bottomNav(context),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 6,
        itemBuilder: (context, index) {
          return _chatTile();
        },
      ),
    );
  }

  // ================= CHAT TILE =================
  Widget _chatTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          Stack(
            children: const [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/profile/phorn.jpg'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(radius: 6, backgroundColor: Colors.green),
              ),
            ],
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Lee Sheerlong',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('សួស្តីបង', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('18:26', style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(height: 6),
              CircleAvatar(
                radius: 9,
                backgroundColor: Colors.purple,
                child: Text(
                  '1',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ],
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
    currentIndex: 2,
    onTap: (index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
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
