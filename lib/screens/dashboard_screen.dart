import 'package:flutter/material.dart';
import '../components/gradient_header.dart';
import '../components/virtual_card_widget.dart';
import '../components/module_selector.dart';
import '../models/module_model.dart';
import 'sections/money_basics_section.dart';
import 'sections/banking_section.dart';
import 'sections/commerce_section.dart';
import 'sections/stocks_section.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<ModuleModel> _modules = [
    ModuleModel(title: "Money Basics", isUnlocked: true),
    ModuleModel(title: "Banking", isUnlocked: false),
    ModuleModel(title: "E-Commerce", isUnlocked: false),
    ModuleModel(title: "Stocks", isUnlocked: false),
  ];

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
                    VirtualCardWidget(balance: 3250),
                    SizedBox(height: 24),
                    ModuleSelector(
                      modules: _modules,
                      selectedIndex: _selectedIndex,
                      onModuleSelected: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    _buildSectionContent(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContent() {
    switch (_selectedIndex) {
      case 0:
        return MoneyBasicsSection(balance: 3250);
      case 1:
        return BankingSection();
      case 2:
        return CommerceSection();
      case 3:
        return StocksSection();
      default:
        return MoneyBasicsSection(balance: 3250);
    }
  }
}
