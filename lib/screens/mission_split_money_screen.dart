import 'package:flutter/material.dart';
import '../components/game_header.dart';
import '../components/mascot_bubble.dart';
import '../components/primary_button.dart';
import 'mission_change_runner_screen.dart';

class MissionSplitMoneyScreen extends StatefulWidget {
  final int overallBalance; // User's total balance passed from dashboard

  const MissionSplitMoneyScreen({super.key, this.overallBalance = 3250});

  @override
  State<MissionSplitMoneyScreen> createState() =>
      _MissionSplitMoneyScreenState();
}

class _MissionSplitMoneyScreenState extends State<MissionSplitMoneyScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  String? _feedbackMessage;

  // Placeholder Question Data
  final List<Map<String, dynamic>> _questions = [
    {
      "situation": "Ravi's bicycle tire is burst. He needs to get to the market to sell his vegetables. He has enough money for either a New Tire or a Fancy Sunglasses.",
      "isNeed": true,
      "correctOption": "New Tire",
      "wrongOption": "Fancy Sunglasses"
    },
    {
      "situation": "You are thirsty after playing. You can buy a Bottle of Water or a Sugary Soda.",
      "isNeed": true,
       "correctOption": "Water",
      "wrongOption": "Soda"
    },
    {
      "situation": "You have an exam tomorrow. You can buy a Textbook you need or a Video Game.",
      "isNeed": true,
       "correctOption": "Textbook",
      "wrongOption": "Video Game"
    },
  ];

  void _handleAnswer(bool choosedNeed) {
    if (_currentQuestionIndex >= _questions.length) return;

    // For now assuming NEED is always correct in these scenarios
    
    if (choosedNeed) {
        _score += 10;
        _feedbackMessage = "Correct! That is a smart choice.";
    } else {
        _feedbackMessage = "Not quite! Remember to prioritize Needs over Wants.";
    }

    setState(() {});

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
            _currentQuestionIndex++;
              if (_currentQuestionIndex >= _questions.length) {
                _feedbackMessage = "Mission Completed! You scored $_score";
              } else {
                 _feedbackMessage = null;
              }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _currentQuestionIndex < _questions.length 
        ? _questions[_currentQuestionIndex] 
        : _questions.last;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Use the GameHeader with the overall balance + current score
          GameHeader(
            title: "Money Basics",
            coinBalance: widget.overallBalance + _score, 
            currentStep: 0, // This is Mission 1: Split the Money, so step 0
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Mission 1",
                    style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Split the Money",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Goal: Differentiate between Needs (Survival) and Wants (Luxury).",
                    style: TextStyle(fontSize: 14, color: Color(0xFF6C63FF)),
                  ),
                  SizedBox(height: 40),
                  
                  if (_currentQuestionIndex < _questions.length) ...[
                    Text(
                      "Situation: \"${question['situation']}\"",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87, height: 1.5),
                    ),
                    SizedBox(height: 60),
                    Row(
                      children: [
                        Expanded(child: _buildOptionButton("WANTS", false)),
                        SizedBox(width: 20),
                        Expanded(child: _buildOptionButton("NEEDS", true)),
                      ],
                    ),
                  ] else ...[
                     Container(
                       padding: EdgeInsets.all(20),
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         color: Color(0xFFE0EAFC),
                         borderRadius: BorderRadius.circular(16)
                       ),
                       child: Column(
                         children: [
                           Icon(Icons.emoji_events, size: 48, color: Color(0xFF6C63FF)),
                           SizedBox(height: 12),
                           Text("Great Job!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                           Text("You finished the quiz.", style: TextStyle(color: Colors.black54)),
                         ],
                        ),
                     ),
                     SizedBox(height: 20),
                     PrimaryButton(
                        text: "Go to Mission 2",
                        onPressed: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (_) => MissionChangeRunnerScreen(overallBalance: widget.overallBalance + _score),
                             ),
                           );
                        },
                      ),

                  ],

                  SizedBox(height: 60),
                  MascotBubble(
                    message: _feedbackMessage ?? "Select the correct category to help Ravi!",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String label, bool isNeed) {
    return OutlinedButton(
      onPressed: () => _handleAnswer(isNeed),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: Color(0xFF6C63FF)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
