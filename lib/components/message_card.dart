import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(message),
    );
  }
}
