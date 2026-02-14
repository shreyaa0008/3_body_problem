import 'package:flutter/material.dart';
import '../components/gradient_header.dart';
import '../components/mascot_bubble.dart';
import '../components/primary_button.dart';

class MissionSplitMoneyScreen extends StatefulWidget {
  const MissionSplitMoneyScreen({super.key});

  @override
  State<MissionSplitMoneyScreen> createState() =>
      MissionSplitMoneyScreenState();
}

class MissionSplitMoneyScreenState
    extends State<MissionSplitMoneyScreen> {
  String? selected;
  bool showSplitSlider = false;
  double splitPercentage = 0.5; // 50% to each category
  final double totalAmount = 2000;
  
  double get essentialsAmount => totalAmount * splitPercentage;
  double get funAmount => totalAmount * (1 - splitPercentage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientHeader(
              title: "Parth",
              subtitle: "Welcome to Gamified Mode",
            ),
             Transform.translate(
              offset: Offset(0, -40),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                         boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                        border: Border.all(color: Color(0xFF6C63FF), width: 2),
                      ),
                      child: Column(
                         children: [
                           // Using Module Icon row style for top part
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               _buildStepIcon(Icons.savings_outlined, "Money\nBasics", true),
                               _buildStepIcon(Icons.account_balance_outlined, "Banking", false),
                               _buildStepIcon(Icons.shopping_bag_outlined, "E commerce", false),
                               _buildStepIcon(Icons.trending_up, "Stocks", false),
                             ],
                           ),
                           SizedBox(height: 20),
                           Align(
                             alignment: Alignment.centerLeft,
                             child: Text("Mission 1", style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.bold)),
                           ),
                           Align(
                             alignment: Alignment.centerLeft,
                             child: Text("Split the Money", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                           ),
                         ],
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onLongPress: () {
                        setState(() {
                          showSplitSlider = true;
                        });
                      },
                      child: Center(
                        child: Container(
                           padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                           decoration: BoxDecoration(
                             color: Color(0xFF6C63FF),
                             borderRadius: BorderRadius.circular(16),
                           ),
                           child: Text(
                             "₹${totalAmount.toStringAsFixed(0)}",
                             style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                           ),
                        ),
                      ),
                    ),
                    if (showSplitSlider) ...[
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Color(0xFF6C63FF), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Drag to split your money",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6C63FF),
                              ),
                            ),
                            SizedBox(height: 16),
                            GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                setState(() {
                                  splitPercentage += details.delta.dx / 200;
                                  splitPercentage = splitPercentage.clamp(0.0, 1.0);
                                });
                              },
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey.shade200,
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 8,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    Container(
                                      height: 8,
                                      width: (splitPercentage * 100).clamp(0, 100).toDouble() + 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Color(0xFF6C63FF),
                                      ),
                                    ),
                                    Positioned(
                                      left: (splitPercentage * 200) - 12,
                                      top: -6,
                                      child: GestureDetector(
                                        onHorizontalDragUpdate: (details) {
                                          setState(() {
                                            splitPercentage += details.delta.dx / 200;
                                            splitPercentage = splitPercentage.clamp(0.0, 1.0);
                                          });
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF6C63FF),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.2),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Essentials",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "₹${essentialsAmount.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Fun",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "₹${funAmount.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showSplitSlider = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF6C63FF),
                              ),
                              child: Text("Done Splitting", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildChoice("Essentials", selected == "Essentials", essentialsAmount),
                        _buildChoice("Fun", selected == "Fun", funAmount),
                      ],
                    ),
                    SizedBox(height: 30),
                    if (selected != null) ...[
                       MascotBubble(
                        message: selected == "Essentials"
                            ? "Good Job !! Needs come first."
                            : "Fun is fine, but balance is important!",
                      ),
                      SizedBox(height: 20),
                      PrimaryButton(
                        text: "Go to Mission 2",
                        onPressed: () {
                           // Navigate to next mission? or just show completion
                        },
                      )
                    ],
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStepIcon(IconData icon, String label, bool isActive) {
     return Column(
       children: [
         Container(
           padding: EdgeInsets.all(12),
           decoration: BoxDecoration(
             shape: BoxShape.circle,
             color: isActive ? Color(0xFFE0EAFC) : Colors.transparent,
           ),
           child: Icon(icon, color: isActive ? Color(0xFF6C63FF) : Colors.grey.shade400),
         ),
         SizedBox(height: 4),
         Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? Colors.black87 : Colors.grey)),
         Text(isActive ? "Unlocked" : "Locked", style: TextStyle(fontSize: 8, color: isActive ? Colors.black54 : Colors.grey)),
       ],
     );
  }

  Widget _buildChoice(String label, bool isSelected, double amount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.black87 : Colors.black45,
            width: 1.5,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "₹${amount.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6C63FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
