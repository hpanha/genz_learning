import 'package:flutter/material.dart';
import '../models/contact.dart';

class ChatDetailPage extends StatefulWidget {
  final Contact contact;

  const ChatDetailPage({super.key, required this.contact});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> replies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/profile/phorn.jpg'),
            ),
            const SizedBox(width: 10),
            Text(widget.contact.name),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _receiverBubble(widget.contact.message),

                ...replies.map(
                  (e) => _senderBubble(e),
                ),
              ],
            ),
          ),

          _inputBox(),
        ],
      ),
    );
  }

  // ================= INPUT =================
  Widget _inputBox() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type message...',
                border: InputBorder.none,
              ),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.send, color: Colors.purple),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  replies.add(_controller.text);
                  _controller.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // ================= RECEIVER =================
  Widget _receiverBubble(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 16,
          backgroundImage:
              AssetImage('assets/images/profile/phorn.jpg'),
        ),

        const SizedBox(width: 8),

        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(text),
        ),
      ],
    );
  }

  // ================= SENDER =================
  Widget _senderBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
