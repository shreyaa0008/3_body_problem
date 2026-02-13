import 'package:flutter/material.dart';
import '../models/module_model.dart';

class ModuleSelector extends StatelessWidget {
  final List<ModuleModel> modules;

  const ModuleSelector({super.key, required this.modules});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: modules.map((module) {
          return Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: module.isUnlocked
                      ? Color(0xFFE0EAFC)
                      : Colors.grey.shade100,
                ),
                 child: Icon(
                  _getIconForModule(module.title),
                  color: module.isUnlocked
                      ? Color(0xFF6C63FF)
                      : Colors.grey.shade400,
                  size: 28,
                ),
              ),
              SizedBox(height: 8),
              Text(
                module.title,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                module.isUnlocked ? "Unlocked" : "Locked",
                style: TextStyle(
                  fontSize: 9,
                  color: module.isUnlocked
                      ? Colors.green
                      : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  IconData _getIconForModule(String title) {
    switch (title) {
      case "Money Basics":
        return Icons.savings_outlined;
      case "Banking":
        return Icons.account_balance_outlined;
      case "E-Commerce":
        return Icons.shopping_bag_outlined;
      case "Stocks":
        return Icons.trending_up;
      default:
        return Icons.help_outline;
    }
  }
}
