import 'package:flutter/material.dart';
import 'dart:ui';

class MascotBubble extends StatelessWidget {
  final String message;

  const MascotBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(4),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                margin: EdgeInsets.only(bottom: 40), // Lifted slightly higher
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7), // Glassy-ish (needs bg to show)
                  // borderRadius: moved to ClipRRect
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5), // Glassy border
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
          ),
        ),
        SizedBox(width: 16),
        // Local mascot asset
        Container(
          width: 140,
          height: 140,
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
