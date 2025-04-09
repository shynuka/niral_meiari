import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/models/message_model.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BottomField extends StatelessWidget {
  const BottomField({
    super.key,
    this.onTap,
    this.onChanged,
    this.controller,
  });

  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightPrimary, // Updated background color
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 25.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              // Add action here (e.g., image picker, file attach, etc.)
            },
            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: white,
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: CustomTextfield(
              controller: controller,
              isChatText: true,
              hintText: "Write message...",
              onChanged: onChanged,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    this.isCurrentUser = true,
  });

  final MessageModel message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final borderRadius = isCurrentUser
        ? BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          );

    final alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: 1.sw * 0.75, minWidth: 50.w),
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isCurrentUser ? primary : lightPrimary, // Updated bubble color
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.content ?? "",
              style: body.copyWith(
                color: isCurrentUser ? white : Colors.black, // Text color fix
              ),
            ),
            5.verticalSpace,
            if (message.timestamp != null)
              Text(
                DateFormat('hh:mm a').format(message.timestamp!),
                style: small.copyWith(
                  color: isCurrentUser
                      ? white.withOpacity(0.8)
                      : Colors.black54, // Timestamp color fix
                ),
              ),
          ],
        ),
      ),
    );
  }
}
