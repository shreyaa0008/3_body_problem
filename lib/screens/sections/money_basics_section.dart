import 'package:flutter/material.dart';
import '../mission_split_money_screen.dart';
import '../../components/mascot_bubble.dart';
import '../../components/primary_button.dart';

class MoneyBasicsSection extends StatelessWidget {
  final int balance;

  const MoneyBasicsSection({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Mission 1",
            style: TextStyle(
              color: Color(0xFF6C63FF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Split the Money",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 16),
        MascotBubble(
          message:
              "You just received ₹2000. Let's decide how to use it wisely.",
        ),
        SizedBox(height: 24),
        PrimaryButton(
          text: "Learn Money Basics",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MissionSplitMoneyScreen(overallBalance: balance),
              ),
            );
          },
        )
      ],
    );
  }
}
