import 'package:flutter/material.dart';

class VirtualCardWidget extends StatelessWidget {
  final double balance;

  const VirtualCardWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.nfc, color: Colors.black54),
              Icon(Icons.circle, color: Colors.black26), // Placeholder for Mastercard logo
            ],
          ),
          Spacer(),
          Text(
            "**** **** **** 2858",
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          Text("Balance",
              style: TextStyle(color: Colors.black45, fontSize: 12)),
          SizedBox(height: 4),
          Text("₹ ${balance.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF))),
        ],
      ),
    );
  }
}
