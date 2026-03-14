import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../component/chat_bubble.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      String message = _messageController.text;
      _messageController.clear();
      await _chatService.sendMessage(widget.receiverUserID, message);
      scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessage(
          _firebaseAuth.currentUser!.uid, widget.receiverUserID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading.....');
        }

        scrollToBottom();

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map<Widget>((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(
              data['senderEmail'],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            ChatBubble(
              message: data['message'],
              isCurrentUser: data['senderId'] == _firebaseAuth.currentUser!.uid,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: 'Enter message',
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward, size: 40),
          ),
        ],
      ),
    );
  }
}

