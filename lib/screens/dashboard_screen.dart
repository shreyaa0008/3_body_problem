import 'package:flutter/material.dart';
import '../components/gradient_header.dart';
import '../components/virtual_card_widget.dart';
import '../components/module_selector.dart';
import '../components/mascot_bubble.dart';
import '../components/primary_button.dart';
import '../models/module_model.dart';
import 'mission_split_money_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ModuleModel> modules = [
      ModuleModel(title: "Money Basics", isUnlocked: true),
      ModuleModel(title: "Banking", isUnlocked: false),
      ModuleModel(title: "E-Commerce", isUnlocked: false),
      ModuleModel(title: "Stocks", isUnlocked: false),
    ];

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
                    VirtualCardWidget(balance: 3250),
                    SizedBox(height: 24),
                    ModuleSelector(modules: modules),
                    SizedBox(height: 24),
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
                            builder: (_) =>
                                MissionSplitMoneyScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
