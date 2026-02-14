import 'package:flutter/material.dart';

class GameHeader extends StatelessWidget {
  final String title;
  final int coinBalance;
  final int currentStep; // 0, 1, 2, 3 corresponding to the levels

  const GameHeader({
    super.key,
    required this.title,
    required this.coinBalance,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
         gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF8F94FB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.currency_rupee, size: 18, color: Color(0xFF6C63FF)),
                        SizedBox(width: 4),
                        Text(
                          "$coinBalance",
                          style: TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Progress Stepper Container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStep(0, "0", "Split the money"),
                  _buildConnector(),
                  _buildStep(1, "50", "The change runner"),
                  _buildConnector(),
                  _buildStep(2, "60", "The Value Matcher"),
                   _buildConnector(),
                  _buildStep(3, "70", "Mastered"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int stepIndex, String label, String description) {
    bool isActive = stepIndex == currentStep;
    bool isCompleted = stepIndex < currentStep;

    return Column( // Removed Expanded, using natural width
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Color(0xFF6C63FF) : (isCompleted ? Color(0xFF6C63FF).withValues(alpha: 0.5) : Color(0xFFE0EAFC)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isActive || isCompleted ? Colors.white : Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          width: 60, // Limit text width to prevent layout shifts
          child: Text(
            isActive ? description : "", 
             textAlign: TextAlign.center,
             maxLines: 2,
             overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9, 
              fontWeight: FontWeight.bold,
              color: Colors.black87
            ),
          ),
        )
      ],
    );
  }

  Widget _buildConnector() {
    return Expanded( // Expanded connector to fill space
      child: Container(
        height: 2,
        margin: EdgeInsets.only(top: 14), // Center vertically relative to 30px circle
        color: Color(0xFFE0EAFC),
      ),
    );
  }
}
