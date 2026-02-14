import 'package:flutter/material.dart';
import '../components/game_header.dart';
import '../components/primary_button.dart';

class LevelCompletionScreen extends StatelessWidget {
  final int score;
  final int totalBalance;
  final VoidCallback onUnlockNext;

  const LevelCompletionScreen({
    super.key,
    required this.score,
    required this.totalBalance,
    required this.onUnlockNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Reuse GameHeader but maybe static or final state
          GameHeader(
            title: "Money Basics",
            coinBalance: totalBalance,
            currentStep: 3, // Mastered
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Well done, Parth. You’ve mastered the basics of money.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2D2D), // Dark grey for text
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 32),
                  
                  // Mascot with effects
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Placeholder for confetti/particles if needed
                      Image.asset(
                        'assets/images/mascot.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),

                  Text(
                    "You have been awarded $score Rs for this completion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your current balance is $totalBalance Rs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  Spacer(),
                  
                  PrimaryButton(
                    text: "Unlock Banking Level for 160 Rs",
                    onPressed: onUnlockNext,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
