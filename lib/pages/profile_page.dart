import 'package:flutter/material.dart';
import 'message_page.dart';
import 'media_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        automaticallyImplyLeading: false, // no back arrow
        title: const Text('My Profile'),
        centerTitle: true,
      ),

      // 🔹 USE THE BOTTOM NAV HERE
      bottomNavigationBar: _bottomNav(context),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 45,
              backgroundImage:
                  AssetImage('assets/images/profile/phorn.jpg'),
            ),

            const SizedBox(height: 12),

            const Text(
              'Mr. LEE SHEERLONG',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            const Text(
              '@sealong168',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            _infoCard(),
          ],
        ),
      ),
    );
  }

  // ================= INFO CARD =================
  Widget _infoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: const [
          _InfoRow(title: 'Email', value: 'sealong168@gmail.com'),
          Divider(),
          _InfoRow(title: 'Password', value: '********'),
          Divider(),
          _InfoRow(title: 'Phone', value: '078638383'),
          Divider(),
          _InfoRow(title: 'Address', value: 'Phnom Penh, Cambodia'),
        ],
      ),
    );
  }

  // ================= BOTTOM NAV =================
  Widget _bottomNav(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      currentIndex: 3, // Profile selected
      onTap: (index) {
        if (index == 0) {
          Navigator.pop(context); // back to Home
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

// ================= INFO ROW =================
class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
