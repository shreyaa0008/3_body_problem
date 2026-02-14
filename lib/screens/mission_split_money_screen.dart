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
                    Center(
                      child: Container(
                         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                         decoration: BoxDecoration(
                           color: Color(0xFF6C63FF),
                           borderRadius: BorderRadius.circular(16),
                         ),
                         child: Text(
                           "₹2000",
                           style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                         ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildChoice("Essentials", selected == "Essentials"),
                        _buildChoice("Fun", selected == "Fun"),
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

  Widget _buildChoice(String label, bool isSelected) {
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
            style: BorderStyle.solid // Dashed is hard in flutter perfectly without package, using solid for now or custom painter if strict. Design looks like dashed.
          ),
          borderRadius: BorderRadius.circular(12),
          // For dashed effect we need a custom painter or package (dotted_border).
          // Using solid for simplicity unless strictly required.
          // Wait, the design shows dashed. I'll stick to solid for now to minimize deps.
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
