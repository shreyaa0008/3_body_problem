import 'package:flutter/material.dart';
import '../components/game_header.dart';
import '../components/mascot_bubble.dart';
import '../components/primary_button.dart';
import 'mission_change_runner_screen.dart';

class MissionSplitMoneyScreen extends StatefulWidget {
  final int overallBalance;

  const MissionSplitMoneyScreen({super.key, this.overallBalance = 3250});

  @override
  State<MissionSplitMoneyScreen> createState() => _MissionSplitMoneyScreenState();
}

class _MissionSplitMoneyScreenState extends State<MissionSplitMoneyScreen> {
  int _currentScenarioIndex = 0;
  int _score = 0;
  String? _feedbackMessage;
  
  // Track dropped items: "itemId" -> "targetType" (Need/Want)
  final Map<String, String> _droppedItems = {};

  final List<Map<String, dynamic>> _scenarios = [
    {
      "title": "Scenario 1: Daily Life",
      "items": [
        {"id": "s1_1", "text": "Repair Tire", "type": "Need"},
        {"id": "s1_2", "text": "Buy Sunglasses", "type": "Want"},
      ]
    },
    {
      "title": "Scenario 2: Thirst Quencher",
      "items": [
        {"id": "s2_1", "text": "Water Bottle", "type": "Need"},
        {"id": "s2_2", "text": "Sugary Soda", "type": "Want"},
      ]
    },
    {
      "title": "Scenario 3: Exam Prep",
      "items": [
        {"id": "s3_1", "text": "Textbook", "type": "Need"},
        {"id": "s3_2", "text": "Video Game", "type": "Want"},
      ]
    },
  ];

  void _onItemDropped(Map<String, String> item, String targetType) {
    if (_feedbackMessage != null) return; // Wait for current feedback to clear

    final isCorrect = item['type'] == targetType;

    setState(() {
      if (isCorrect) {
        _droppedItems[item['id']!] = targetType;
        _score += 10;
        _feedbackMessage = "Correct! That's a $targetType.";
        
        // Clear success message after delay or keep until next action
         Future.delayed(Duration(seconds: 1), () {
           if (mounted && _feedbackMessage != null && !_isScenarioComplete()) {
             setState(() => _feedbackMessage = null);
           }
         });

      } else {
        _feedbackMessage = "Oops! ${item['text']} is actually a ${item['type']}.";
        // Clear error message automatically
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) setState(() => _feedbackMessage = null);
        });
      }
    });

    if (_isScenarioComplete()) {
       Future.delayed(Duration(seconds: 1), _nextScenario);
    }
  }

  bool _isScenarioComplete() {
     if (_currentScenarioIndex >= _scenarios.length) return true;
     final items = _scenarios[_currentScenarioIndex]['items'] as List;
     // Check if all items for this scenario are in droppedItems
     return items.every((item) => _droppedItems.containsKey(item['id']));
  }

  void _nextScenario() {
    if (mounted) {
      setState(() {
        if (_currentScenarioIndex < _scenarios.length) {
          _currentScenarioIndex++;
          // Keep droppedItems history? Or clear for new level? 
          // Since IDs are unique across scenarios, we don't strictly *need* to clear, 
          // but clearing keeps map small.
          // However, to animate out, we might want to keep them for a moment.
          // For simplicity, we just move index.
        }
        _feedbackMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isGameFinished = _currentScenarioIndex >= _scenarios.length;
    final currentScenario = !isGameFinished ? _scenarios[_currentScenarioIndex] : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GameHeader(
            title: "Money Basics",
            coinBalance: widget.overallBalance + _score,
            currentStep: 0,
          ),
          Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                            "Mission 1",
                            style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Split the Money",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                         ],
                       ),
                    ],
                   ),
                  
                  SizedBox(height: 20),

                  if (!isGameFinished) ...[
                     Text(
                        currentScenario!['title'],
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      SizedBox(height: 30),
                      
                      // Draggable Items Area
                      Center(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: (currentScenario['items'] as List).map<Widget>((dynamic itemDyn) {
                             final item = itemDyn as Map<String, dynamic>;
                             final id = item['id'] as String;
                             final text = item['text'] as String;

                             final isDropped = _droppedItems.containsKey(id);
                             if (isDropped) return SizedBox.shrink(); // Hide if dropped

                             return Draggable<Map<String, String>>(
                               data: Map<String, String>.from(item),
                               feedback: _buildDraggableCard(text, true),
                               childWhenDragging: Opacity(opacity: 0.3, child: _buildDraggableCard(text, false)),
                               child: _buildDraggableCard(text, false),
                             );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: 40), // Increased spacing for comfort
                      
                      // Drop Targets
                      Row(
                        children: [
                          Expanded(child: _buildDragTarget("Want", Colors.purple.shade50)),
                          SizedBox(width: 16),
                          Expanded(child: _buildDragTarget("Need", Colors.blue.shade50)),
                        ],
                      ),
                      
                  ] else ...[
                     SizedBox(height: 40),
                      Container(
                       padding: EdgeInsets.all(24),
                       decoration: BoxDecoration(
                         color: Color(0xFFE0EAFC),
                         borderRadius: BorderRadius.circular(16)
                       ),
                       child: Column(
                         children: [
                           Icon(Icons.check_circle, size: 64, color: Color(0xFF6C63FF)),
                           SizedBox(height: 16),
                           Text("Mission Complete!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                           SizedBox(height: 8),
                           Text("You know how to split your money wisely.", textAlign: TextAlign.center),
                         ],
                       ),
                     ),
                     SizedBox(height: 40),
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
                      SizedBox(height: 20),
                  ],
                  
                  SizedBox(height: 16),
                  MascotBubble(
                    message: _feedbackMessage ?? "Drag items to 'Wants' or 'Needs'!",
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableCard(String text, bool isDragging) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF6C63FF), width: 1.5),
          boxShadow: [
             BoxShadow(
              color: Colors.black.withValues(alpha: isDragging ? 0.2 : 0.05),
              blurRadius: isDragging ? 12 : 4,
              offset: Offset(0, 4),
            )
          ]
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold, 
            color: Colors.black87
          ),
        ),
      ),
    );
  }

  Widget _buildDragTarget(String type, Color bgColor) {
    return DragTarget<Map<String, String>>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) => _onItemDropped(details.data, type),
      builder: (context, candidateData, rejectedData) {
        bool isHovered = candidateData.isNotEmpty;
        return Container(
          height: 120, // Fixed height for targets
          decoration: BoxDecoration(
            color: isHovered ? bgColor.withValues(alpha: 0.8) : bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered ? Color(0xFF6C63FF) : Colors.transparent,
              width: 2
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                type == "Want" ? Icons.favorite_border : Icons.shield_outlined,
                size: 32,
                color: Color(0xFF6C63FF),
              ),
              SizedBox(height: 8),
              Text(
                "${type}s",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF)
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
