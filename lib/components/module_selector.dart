import 'package:flutter/material.dart';
import '../models/module_model.dart';

class ModuleSelector extends StatelessWidget {
  final List<ModuleModel> modules;
  final int selectedIndex;
  final Function(int) onModuleSelected;

  const ModuleSelector({
    super.key,
    required this.modules,
    required this.selectedIndex,
    required this.onModuleSelected,
  });

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
        children: modules.asMap().entries.map((entry) {
          int idx = entry.key;
          ModuleModel module = entry.value;
          bool isSelected = idx == selectedIndex;

          return GestureDetector(
            onTap: () => onModuleSelected(idx),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Color(0xFFE0EAFC)
                        : Colors.transparent,
                    border: isSelected
                        ? Border.all(color: Color(0xFF6C63FF).withValues(alpha: 0.3), width: 1)
                        : Border.all(color: Colors.transparent),
                  ),
                   child: Icon(
                    _getIconForModule(module.title),
                    color: isSelected
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
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.black87 : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                // Only show Unlocked/Locked if we want, or maybe just highlight selection.
                // Keeping it for now as per design.
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
            ),
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
