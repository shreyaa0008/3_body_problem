import 'package:flutter/material.dart';
import '../mission_sms_screen.dart';
import '../../components/mascot_bubble.dart';
import '../../components/primary_button.dart';

class BankingSection extends StatelessWidget {
  const BankingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Mission 2",
            style: TextStyle(
              color: Color(0xFF6C63FF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "SMS Scam",
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
              "Scammers are everywhere! Can you spot the fake SMS?",
        ),
        SizedBox(height: 24),
        PrimaryButton(
          text: "Start Banking Mission",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MissionSmsScreen(),
              ),
            );
          },
        )
      ],
    );
  }
}
