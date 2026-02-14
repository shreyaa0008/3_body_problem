import 'package:flutter/material.dart';

class MascotBubble extends StatelessWidget {
  final String message;

  const MascotBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(color: Color(0xFFE0EAFC), width: 1),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        // Local mascot asset
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: Color(0xFFE0EAFC), // Removed background color to look cleaner if transparent
            image: DecorationImage(
                image: AssetImage('assets/images/mascot.png'),
                fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }
}
