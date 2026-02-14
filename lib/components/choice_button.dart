import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceButton({super.key, 
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Colors.deepPurple
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label),
      ),
    );
  }
}
