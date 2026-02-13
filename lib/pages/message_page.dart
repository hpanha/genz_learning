import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/contact_service.dart';

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
          'Feedback',
          style: TextStyle(fontWeight: FontWeight.bold,
          color: Colors.white),
          
        ),
        centerTitle: true,
      ),


      body: FutureBuilder<List<Contact>>(
        future: ContactService.fetchContacts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final contacts = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return _chatTile(context, contacts[index]);
            },
          );
        },
      ),
    );
  }

  // ================= CHAT TILE =================
  // ================= FEEDBACK TILE =================
Widget _chatTile(BuildContext context, Contact contact) {
  return GestureDetector(
    child: Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ===== USER INFO =====
          Row(
            children: [
              CircleAvatar(
              radius: 22,
              backgroundColor: _avatarColor(contact.name),
              child: Text(
                contact.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),


              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  contact.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const Text(
                '18:26',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// ===== FEEDBACK MESSAGE =====
          Text(
            contact.message,
            style: const TextStyle(
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          /// ===== RATING (UI ONLY) =====
          Row(
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star,
                size: 18,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Color _avatarColor(String name) {
  final colors = [
    Colors.purple,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.teal,
  ];

  return colors[name.hashCode % colors.length];
}


}
