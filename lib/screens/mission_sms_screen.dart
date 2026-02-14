import 'package:flutter/material.dart';
import '../components/gradient_header.dart';
import '../components/mascot_bubble.dart';

class MissionSmsScreen extends StatefulWidget {
  const MissionSmsScreen({super.key});

  @override
  State<MissionSmsScreen> createState() =>
      _MissionSmsScreenState();
}

class _MissionSmsScreenState
    extends State<MissionSmsScreen> {
  String? result;

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
                    // Top Progress/Header Card (reused style)
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
                             child: Text("Let's learn how money works in real life.", style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.w600, fontSize: 12)),
                           ),
                           SizedBox(height: 8),
                           Align(
                             alignment: Alignment.centerLeft,
                             child: Text("Mission 2", style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.bold)),
                           ),
                           Align(
                             alignment: Alignment.centerLeft,
                             child: Text("SMS ??", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                           ),
                         ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "URGENT: ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                TextSpan(text: "Your ₹5,000 instant loan is approved.\n\nTo activate, share the OTP sent to your phone within 2 minutes.\n\nDo NOT delay or the offer will expire."),
                              ],
                            ),
                            style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    if (result == null)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                result = "Oh looks like you got a message"; // Should probably be fail state
                              });
                            },
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Color(0xFF6C63FF),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                               padding: EdgeInsets.symmetric(vertical: 14),
                             ),
                             child: Text("Send OTP", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                           child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                result = "Good job! You ignored the scam.";
                              });
                            },
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Color(0xFF6C63FF).withValues(alpha: 0.8),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                               padding: EdgeInsets.symmetric(vertical: 14),
                             ),
                             child: Text("Don't Send OTP", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    if (result != null)
                      MascotBubble(message: result!),
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
}
