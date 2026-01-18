import 'package:flutter/material.dart';
import 'message_page.dart';
import 'media_page.dart';
import 'select_photo_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  ImageProvider profileImage =
      const AssetImage('assets/images/profile/phorn.jpg');

  final emailCtrl = TextEditingController(text: 'sophron168@gmail.com');
  final phoneCtrl = TextEditingController(text: '078638383');
  final addressCtrl = TextEditingController(text: 'Phnom Penh, Cambodia');
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: _bottomNav(context),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _header(context),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: _profileCard(),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _header(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= PROFILE CARD =================
  Widget _profileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 110, 16, 20),
            child: Column(
              children: [
                const Text(
                  'Mr. HORM SOPHORN',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text('@sophorn168',
                    style: TextStyle(color: Colors.grey)),

                const SizedBox(height: 16),

                _sectionTitle('Private Information'),
                isEditing ? _editForm() : _viewInfo(),

                if (!isEditing) ...[
                  _sectionTitle('Connect Account'),
                  _socialButton(Icons.mail, 'Continue with Email'),
                  _socialButton(Icons.g_mobiledata, 'Continue with Google'),
                  _socialButton(Icons.apple, 'Continue with Apple'),
                  _socialButton(Icons.facebook, 'Continue with Facebook'),
                ],
              ],
            ),
          ),

          // PROFILE IMAGE + EDIT ICON
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                children: [
                  // PROFILE IMAGE
                  GestureDetector(
                    onTap: isEditing
                        ? () async {
                            final selected =
                                await Navigator.push<ImageProvider>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SelectPhotoPage(),
                              ),
                            );

                            if (selected != null) {
                              setState(() => profileImage = selected);
                            }
                          }
                        : null,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // ✏️ EDIT BUTTON (VIEW MODE ONLY)
                  if (!isEditing)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => setState(() => isEditing = true),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= VIEW MODE =================
  Widget _viewInfo() {
    return Column(
      children: [
        _infoRow('Email', emailCtrl.text),
        _divider(),
        _infoRow('Password', '********'),
        _divider(),
        _infoRow('Phone Number', phoneCtrl.text),
        _divider(),
        _infoRow('Address', addressCtrl.text),
      ],
    );
  }

  // ================= EDIT MODE =================
  Widget _editForm() {
    return Column(
      children: [
        _textField('Email', emailCtrl),
        _textField('Password', passwordCtrl, obscure: true),
        _textField('Phone Number', phoneCtrl),
        _textField('Address', addressCtrl),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () => setState(() => isEditing = false),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              onPressed: () => setState(() => isEditing = false),
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }

  // ================= HELPERS =================
  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
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

  Widget _divider() => Divider(color: Colors.grey[300]);

  Widget _socialButton(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _textField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  // ================= BOTTOM NAV =================
  Widget _bottomNav(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      currentIndex: 3,
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
            icon: Icon(Icons.play_circle), label: 'Courses'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
