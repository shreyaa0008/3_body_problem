import 'dart:async';
import 'package:flutter/material.dart';
import '../components/game_header.dart';
import '../components/mascot_bubble.dart';
import '../components/primary_button.dart';

class MissionValueMatcherScreen extends StatefulWidget {
  final int overallBalance;

  const MissionValueMatcherScreen({super.key, required this.overallBalance});

  @override
  State<MissionValueMatcherScreen> createState() => _MissionValueMatcherScreenState();
}

class _MissionValueMatcherScreenState extends State<MissionValueMatcherScreen> {
  int _currentScenarioIndex = 0;
  int _score = 0;
  
  // Game State
  String? _selectedId;
  Set<String> _matchedIds = {};
  Set<String> _errorIds = {}; // Items to flash red
  bool _isProcessing = false; // Prevent double taps during animation

  final List<Map<String, dynamic>> _scenarios = [
    {
      "title": "Scenario 1: Basics & Survival",
      "instruction": "Match the financial terms to their meanings.",
      "pairs": [
        {"id": "s1_1a", "text": "Needs", "matchId": "s1_1b"},
        {"id": "s1_1b", "text": "Essential for survival", "matchId": "s1_1a"},
        {"id": "s1_2a", "text": "Wants", "matchId": "s1_2b"},
        {"id": "s1_2b", "text": "Nice to have, not essential", "matchId": "s1_2a"},
        {"id": "s1_3a", "text": "Income", "matchId": "s1_3b"},
        {"id": "s1_3b", "text": "Money you earn", "matchId": "s1_3a"},
      ]
    },
    {
      "title": "Scenario 2: Tools of the Trade",
      "instruction": "Categorize these spending decisions.",
      "pairs": [
        {"id": "s2_1a", "text": "Investment", "matchId": "s2_1b"},
        {"id": "s2_1b", "text": "Buying a new plow", "matchId": "s2_1a"},
        {"id": "s2_2a", "text": "Expense", "matchId": "s2_2b"},
        {"id": "s2_2b", "text": "Buying a movie ticket", "matchId": "s2_2a"},
        {"id": "s2_3a", "text": "Emergency", "matchId": "s2_3b"},
        {"id": "s2_3b", "text": "Fixing a broken pipe", "matchId": "s2_3a"},
      ]
    },
    {
      "title": "Scenario 3: The Hidden Costs",
      "instruction": "Match value concepts.",
      "pairs": [
        {"id": "s3_1a", "text": "High Value", "matchId": "s3_1b"},
        {"id": "s3_1b", "text": "Good quality, lasts long", "matchId": "s3_1a"},
        {"id": "s3_2a", "text": "Low Value", "matchId": "s3_2b"},
        {"id": "s3_2b", "text": "Cheap, breaks matched", "matchId": "s3_2a"},
        {"id": "s3_3a", "text": "Waste", "matchId": "s3_3b"},
        {"id": "s3_3b", "text": "Lottery tickets", "matchId": "s3_3a"},
      ]
    }
  ];

  late List<Map<String, String>> _leftItems;
  late List<Map<String, String>> _rightItems;

  @override
  void initState() {
    super.initState();
    _loadScenario();
  }

  void _loadScenario() {
    if (_currentScenarioIndex >= _scenarios.length) return;
    
    final pairs = _scenarios[_currentScenarioIndex]['pairs'] as List<Map<String, String>>;
    _leftItems = [];
    _rightItems = [];
    
    for (int i = 0; i < pairs.length; i++) {
      if (i % 2 == 0) {
        _leftItems.add(pairs[i]);
      } else {
        _rightItems.add(pairs[i]);
      }
    }
    
    // Shuffle only the right side (definitions) to ensure mismatch
    _rightItems.shuffle();
    
    _matchedIds.clear();
    _selectedId = null;
    _errorIds.clear();
  }

  void _onItemTapped(String id, String matchId) {
    if (_isProcessing || _matchedIds.contains(id)) return;

    setState(() {
      _errorIds.clear(); // Clear previous errors on new tap
    });

    if (_selectedId == null) {
      // First selection
      setState(() {
        _selectedId = id;
      });
    } else if (_selectedId == id) {
      // Deselect if tapping same item
      setState(() {
        _selectedId = null;
      });
    } else {
      // Second selection - Check match
      _checkMatch(id, matchId);
    }
  }

  void _checkMatch(String id, String matchId) {
    // Find the previously selected item's matchId
    // It could be in left or right list
    final allItems = [..._leftItems, ..._rightItems];
    final selectedItem = allItems.firstWhere((item) => item['id'] == _selectedId);
    final selectedMatchId = selectedItem['matchId'];

    if (selectedMatchId == id) {
      // Correct Match
      setState(() {
        _matchedIds.add(id);
        _matchedIds.add(_selectedId!);
        _selectedId = null;
        _score += 10;
      });
      _checkCompletion();
    } else {
      // Incorrect Match
      setState(() {
        _errorIds = {id, _selectedId!};
        _isProcessing = true;
      });
      
      // Delay before resetting error state
      Future.delayed(Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _errorIds.clear();
            _selectedId = null;
            _isProcessing = false;
          });
        }
      });
    }
  }

  void _checkCompletion() {
    if (_matchedIds.length == (_leftItems.length + _rightItems.length)) {
      // Scenario Completed
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
           setState(() {
             if (_currentScenarioIndex < _scenarios.length - 1) {
               _currentScenarioIndex++;
               _loadScenario();
             } else {
               _currentScenarioIndex++; // To show game over screen
             }
           });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isGameOver = _currentScenarioIndex >= _scenarios.length;
    final scenario = !isGameOver ? _scenarios[_currentScenarioIndex] : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GameHeader(
            title: "Money Basics",
            coinBalance: widget.overallBalance + _score,
            currentStep: isGameOver ? 3 : 2, // Mission 3 or Completed
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Mission 3",
                    style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "The Value Matcher",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Goal: Connect financial terms to their practical meanings.",
                    style: TextStyle(fontSize: 12, color: Color(0xFF6C63FF)),
                  ),
                  SizedBox(height: 30),

                  if (!isGameOver) ...[
                    Text(
                      scenario!['title'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    SizedBox(height: 8),
                    Text(
                      scenario['instruction'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 30),

                    // Two Column Layout
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column (Terms)
                        Expanded(
                          child: Column(
                            children: _leftItems.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: _buildOption(item),
                            )).toList(),
                          ),
                        ),
                        SizedBox(width: 24),
                        // Right Column (Definitions)
                        Expanded(
                          child: Column(
                             children: _rightItems.map((item) => Padding(
                               padding: const EdgeInsets.only(bottom: 16.0),
                               child: _buildOption(item),
                             )).toList(),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                     Container(
                       padding: EdgeInsets.all(24),
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         color: Color(0xFFE0EAFC),
                         borderRadius: BorderRadius.circular(16)
                       ),
                       child: Column(
                         children: [
                           Icon(Icons.stars, size: 64, color: Color(0xFF6C63FF)),
                           SizedBox(height: 16),
                           Text("All Missions Completed!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                           SizedBox(height: 8),
                           Text("You've mastered the Money Basics.", style: TextStyle(color: Colors.black54)),
                         ],
                       ),
                     ),
                     SizedBox(height: 30),
                     PrimaryButton(
                       text: "Back to Dashboard",
                       onPressed: () {
                         Navigator.popUntil(context, (route) => route.isFirst);
                       },
                     )
                  ],

                  if (!isGameOver) ...[
                    SizedBox(height: 40),
                    MascotBubble(
                      message: _errorIds.isNotEmpty 
                        ? "Oops! Those don't match." 
                        : "Tap a term, then tap its meaning!",
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(Map<String, String> item) {
    final id = item['id']!;
    final text = item['text']!;
    final matchId = item['matchId']!;
    
    bool isMatched = _matchedIds.contains(id);
    bool isSelected = _selectedId == id;
    bool isError = _errorIds.contains(id);

    Color bgColor = Colors.white;
    Color borderColor = Colors.grey.shade300;
    Color textColor = Colors.black87;

    if (isMatched) {
      bgColor = Colors.green.shade100;
      borderColor = Colors.green;
      textColor = Colors.green.shade900;
    } else if (isError) {
      bgColor = Colors.red.shade100;
      borderColor = Colors.red;
      textColor = Colors.red.shade900;
    } else if (isSelected) {
      bgColor = Color(0xFFE0EAFC);
      borderColor = Color(0xFF6C63FF);
      textColor = Color(0xFF6C63FF);
    }

    return GestureDetector(
      onTap: () => _onItemTapped(id, matchId),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            if (!isMatched && !isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              )
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
