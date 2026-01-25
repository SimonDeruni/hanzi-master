import 'package:flutter/material.dart';

class SessionSummaryScreen extends StatelessWidget {
  final int totalReviewed;
  final int correctCount;

  const SessionSummaryScreen({
    super.key,
    required this.totalReviewed,
    required this.correctCount,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate percentage
    final double percentage = totalReviewed == 0 ? 0 : (correctCount / totalReviewed);
    final int percentageInt = (percentage * 100).round();

    return Scaffold(
      backgroundColor: Colors.indigo.shade50, // Light blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. TROPHY ICON
              const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
              const SizedBox(height: 16),
              
              const Text(
                "Session Complete!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 32),

              // 2. STATS CARD
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      const Text("Accuracy", style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text(
                        "$percentageInt%",
                        style: TextStyle(
                          fontSize: 60, 
                          fontWeight: FontWeight.bold,
                          color: percentage >= 0.8 ? Colors.green : Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem("Reviewed", "$totalReviewed", Colors.blue),
                          _buildStatItem("Correct", "$correctCount", Colors.green),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),

              // 3. HOME BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    // Go back to the very first screen (The Library)
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text(
                    "Back to Library",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
}