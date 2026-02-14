import 'package:flutter/material.dart';

class VirtualCardWidget extends StatelessWidget {
  final double balance;

  const VirtualCardWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 195.05,
      padding: EdgeInsets.fromLTRB(29, 29, 29, 29),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Color(0xFFE0EAFC), // Light Base
            Color(0xFFFFFFFF), // Highlight (Shine)
            Color(0xFFCFDEF3), // Mid-tone
            Color(0xFFB0C4DE), // Darker edge for depth
          ],
          stops: [0.0, 0.4, 0.6, 1.0], // Position the shine
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: Offset(4, 8), // Enhanced shadow for 3D feel
          ),
          BoxShadow(
             color: Colors.white.withValues(alpha: 0.6),
             blurRadius: 10,
             offset: Offset(-4, -4), // Edge light source
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.account_circle, color: Colors.black54, size: 32);
                },
              ),
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
