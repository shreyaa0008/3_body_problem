import 'package:flutter/material.dart';
import '../../components/mascot_bubble.dart';

class StocksSection extends StatelessWidget {
  const StocksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Mission 4",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Stocks & Investing",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 16),
        MascotBubble(
          message:
              "This module is currently locked. Complete previous missions to unlock!",
        ),
        SizedBox(height: 24),
        Opacity(
          opacity: 0.5,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              "Locked",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
