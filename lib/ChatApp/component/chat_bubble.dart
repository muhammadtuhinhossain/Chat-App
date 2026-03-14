import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isCurrentUser ? Colors.blue : Colors.grey[300],
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: isCurrentUser ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

