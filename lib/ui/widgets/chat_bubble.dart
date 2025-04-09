import 'package:flutter/material.dart';
import 'package:chat_app/core/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final bool isCurrentUser;
  final MessageModel message;

  const ChatBubble({
    Key? key,
    required this.isCurrentUser,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isCurrentUser ? const Radius.circular(16) : Radius.zero,
            bottomRight:
                isCurrentUser ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(
          message.content ?? "",
          style: TextStyle(
            color: isCurrentUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
