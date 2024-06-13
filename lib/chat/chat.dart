import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String userId;

  const ChatScreen({super.key, required this.chatId, required this.userId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _databaseReference.child('chats/${widget.chatId}/messages').orderByChild('timestamp').onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                Map<dynamic, dynamic> messages = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                List messageList = messages.values.toList();
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return _buildMessageItem(messageList[index]);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Map<dynamic, dynamic> message) {
    bool isMe = message['senderId'] == widget.userId;
    return ListTile(
      title: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            message['text'],
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: "Enter your message...",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    String messageText = _messageController.text;
    _messageController.clear();

    await _databaseReference.child('chats/${widget.chatId}/messages').push().set({
      'senderId': widget.userId,
      'text': messageText,
      'timestamp': DateTime.now().toIso8601String(),
    });

    // Scroll to the bottom after sending a message
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}