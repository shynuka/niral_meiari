import 'dart:convert';
import 'dart:developer';

class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? imageUrl;
  final String? profilePicUrl;
  final bool isOnline;
  final Map<String, dynamic>? lastMessage;
  final int? unreadCounter;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.imageUrl,
    this.profilePicUrl,
    this.lastMessage,
    this.unreadCounter,
    this.isOnline = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'profilePicUrl': profilePicUrl,
      'isOnline': isOnline,
      'lastMessage': lastMessage,
      'unreadCounter': unreadCounter,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return UserModel(
      uid: map['uid'] as String?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      imageUrl: map['imageUrl'] as String?,
      profilePicUrl: map['profilePicUrl'] as String?,
      isOnline: map['isOnline'] ?? false,
      lastMessage: map['lastMessage'] != null
          ? Map<String, dynamic>.from(map['lastMessage'])
          : null,
      unreadCounter: map['unreadCounter'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, imageUrl: $imageUrl, profilePicUrl: $profilePicUrl, isOnline: $isOnline, lastMessage: $lastMessage, unreadCounter: $unreadCounter)';
  }
}
