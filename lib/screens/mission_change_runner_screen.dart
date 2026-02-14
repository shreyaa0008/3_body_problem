import 'dart:async';
import 'package:flutter/material.dart';
import '../components/game_header.dart';
import '../components/mascot_bubble.dart';
import '../components/primary_button.dart';
import 'mission_value_matcher_screen.dart';

class MissionChangeRunnerScreen extends StatefulWidget {
  final int overallBalance;

  const MissionChangeRunnerScreen({super.key, required this.overallBalance});

  @override
  State<MissionChangeRunnerScreen> createState() => _MissionChangeRunnerScreenState();
}

class _MissionChangeRunnerScreenState extends State<MissionChangeRunnerScreen> {
  int _currentScenarioIndex = 0;
  int _score = 0;
  int _timeLeft = 15; // 15 seconds per scenario
  Timer? _timer;
  String? _feedbackMessage;
  
  // Track selected indices from the available options
  final Set<int> _selectedIndices = {};

  final List<Map<String, dynamic>> _scenarios = [
    {
      "title": "Scenario 1: The Quick Snack",
      "difficulty": "Low",
      "color": Colors.green,
      "request": "I'll take one roasted corn cob for 15 Rupees",
      "targetAmount": 15,
      "options": [5, 5, 5, 10, 10, 20] 
    },
    {
      "title": "Scenario 2: The Tool Repair",
      "difficulty": "Medium",
      "color": Colors.orange,
      "request": "I need to pay for a shovel sharpening. That's 35 Rupees",
      "targetAmount": 35,
      "options": [5, 5, 5, 10, 10, 20]
    },
    {
      "title": "Scenario 3: The Bulk Harvest",
      "difficulty": "High",
      "color": Colors.red,
      "request": "I'm buying three bags of fertilizer. The total is 85 Rupees",
      "targetAmount": 85,
      "options": [5, 5, 10, 10, 20, 50, 50] // Adjusted options to make 85 reachable
    }
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = 15;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _handleTimeout();
      }
    });
  }

  void _handleTimeout() {
    _timer?.cancel();
    setState(() {
      _feedbackMessage = "Time's up! Try faster next time.";
    });
    Future.delayed(Duration(seconds: 2), _nextScenario);
  }

  void _nextScenario() {
    if (_currentScenarioIndex < _scenarios.length - 1) {
      setState(() {
        _currentScenarioIndex++;
        _selectedIndices.clear();
        _feedbackMessage = null;
      });
      _startTimer();
    } else {
      // Game Over
      _timer?.cancel();
      setState(() {
        _currentScenarioIndex++;
      });
    }
  }

  void _toggleSelection(int index) {
    if (_feedbackMessage != null) return; // Block input during feedback

    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });

    _checkAnswer();
  }

  void _checkAnswer() {
    final scenario = _scenarios[_currentScenarioIndex];
    final options = scenario['options'] as List<int>;
    final target = scenario['targetAmount'] as int;

    int currentSum = 0;
    for (int idx in _selectedIndices) {
      currentSum += options[idx];
    }

    if (currentSum == target) {
      _timer?.cancel();
      setState(() {
        _score += 10 + _timeLeft; // Bonus for speed
        _feedbackMessage = "Perfect! Payment exact.";
      });
      Future.delayed(Duration(seconds: 2), _nextScenario);
    } else if (currentSum > target) {
       // Optional: Immediate fail on overpayment? Or just let them deselect?
       // Let's warn them but not fail immediately unless time runs out.
    }
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scenario = _currentScenarioIndex < _scenarios.length 
        ? _scenarios[_currentScenarioIndex] 
        : _scenarios.last;
        
    final options = scenario['options'] as List<int>;
    final totalSelected = _selectedIndices.fold<int>(0, (sum, idx) => sum + options[idx]);

    // Format timer
    final minutes = (_timeLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timeLeft % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GameHeader(
            title: "Money Basics",
            coinBalance: widget.overallBalance + _score,
            currentStep: 1, // Mission 2
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mission 2",
                    style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "The Change Runner",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Goal: Identifying the correct currency notes/coins to pay for an item quickly.",
                    style: TextStyle(fontSize: 12, color: Color(0xFF6C63FF)),
                  ),
                  SizedBox(height: 30),
                  
                  // Timer
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFF8F94FB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "$minutes:$seconds",
                        style: TextStyle(
                          fontSize: 32, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,
                          fontFamily: 'Courier', // Monospace for timer look
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("Time is ticking, be quick!", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 30),

                  if (_currentScenarioIndex < _scenarios.length || _feedbackMessage != null && _currentScenarioIndex == _scenarios.length -1) ...[
                      Row(
                        children: [
                          Text(
                            scenario['title'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: scenario['color'],
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Text(
                              scenario['difficulty'],
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        scenario['request'],
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      SizedBox(height: 30),
                      
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: List.generate(options.length, (index) {
                          bool isSelected = _selectedIndices.contains(index);
                          int amount = options[index];
                          return GestureDetector(
                            onTap: () => _toggleSelection(index),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: isSelected ? Color(0xFF6C63FF) : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? Color(0xFF6C63FF) : Colors.grey.shade300,
                                  width: 2
                                ),
                                boxShadow: [
                                  if (!isSelected)
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: Offset(0, 2)
                                    )
                                ]
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "$amount",
                                style: TextStyle(
                                  fontSize: 18, 
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : Colors.black87
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      
                      SizedBox(height: 20),
                      Text("Total Selected: ₹$totalSelected / ₹${scenario['targetAmount']}", 
                        style: TextStyle(fontWeight: FontWeight.w600, 
                        color: totalSelected == scenario['targetAmount'] ? Colors.green : (totalSelected > scenario['targetAmount'] ? Colors.red : Colors.grey)
                        )
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
                           Text("You finished Section 2.", style: TextStyle(color: Colors.black54)),
                         ],
                       ),

                     ), // Ends Container
                     SizedBox(height: 20),
                     PrimaryButton(
                       text: "Go to Mission 3",
                       onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (_) => MissionValueMatcherScreen(overallBalance: widget.overallBalance + _score),
                           ),
                         );
                       },
                     )
                  ],

                  SizedBox(height: 40),
                  MascotBubble(
                    message: _feedbackMessage ?? "Select the exact change!",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
