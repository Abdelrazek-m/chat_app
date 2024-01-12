import 'package:flutter/material.dart';

class FriendChatBubble extends StatelessWidget {
  const FriendChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
          right: 12,
          top: 8,
          bottom: 8,
          left: MediaQuery.of(context).size.width * .3,
        ),
        padding: const EdgeInsets.all(12),
        // width: 250,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
          ),
          color: Colors.blue,
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
