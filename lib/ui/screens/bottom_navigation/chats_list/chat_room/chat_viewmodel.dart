import 'dart:async';
import 'dart:developer';

import 'package:chat_app/core/models/message_model.dart';
import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/other/base_viewmodel.dart';
import 'package:chat_app/core/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatViewmodel extends BaseViewmodel {
  final ChatService _chatService;
  final UserModel _currentUser;
  final UserModel _receiver;

  String chatRoomId = "";
  final TextEditingController _messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<MessageModel> _messages = [];
  StreamSubscription? _subscription;
  bool _isLoading = true;

  ChatViewmodel(this._chatService, this._currentUser, this._receiver) {
    _setChatRoomId();
    _listenToMessages();
  }

  TextEditingController get controller => _messageController;
  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;

  void _setChatRoomId() {
    if (_currentUser.uid.hashCode > _receiver.uid.hashCode) {
      chatRoomId = "${_currentUser.uid}_${_receiver.uid}";
    } else {
      chatRoomId = "${_receiver.uid}_${_currentUser.uid}";
    }
  }

  void _listenToMessages() {
    _isLoading = true;
    notifyListeners();

    _subscription = _chatService.getMessages(chatRoomId).listen((messages) {
      _messages =
          messages.docs.map((e) => MessageModel.fromMap(e.data())).toList();
      _isLoading = false;
      notifyListeners();

      // Auto-scroll to bottom after a short delay
      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  Future<void> saveMessage() async {
    try {
      final text = _messageController.text.trim();
      if (text.isEmpty) throw Exception("Please enter some text");

      final now = DateTime.now();

      final message = MessageModel(
        id: now.millisecondsSinceEpoch.toString(),
        content: text,
        senderId: _currentUser.uid,
        receiverId: _receiver.uid,
        timestamp: now,
      );

      await _chatService.saveMessage(message.toMap(), chatRoomId);
      await _chatService.updateLastMessage(
        _currentUser.uid!,
        _receiver.uid!,
        message.content!,
        now.millisecondsSinceEpoch,
      );

      _messageController.clear();
    } catch (e) {
      log("Message send error: $e");
      rethrow;
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    scrollController.dispose();
    _subscription?.cancel();
    super.dispose();
  }
}
