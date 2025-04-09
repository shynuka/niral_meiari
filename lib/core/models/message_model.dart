import 'dart:convert';

class MessageModel {
  final String? id;
  final String? content;
  final String? senderId;
  final String? receiverId;
  final DateTime? timestamp;

  MessageModel({
    this.id,
    this.content,
    this.senderId,
    this.receiverId,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String?,
      content: map['content'] as String?,
      senderId: map['senderId'] as String?,
      receiverId: map['receiverId'] as String?,
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, content: $content, senderId: $senderId, receiverId: $receiverId, timestamp: $timestamp)';
  }
}
