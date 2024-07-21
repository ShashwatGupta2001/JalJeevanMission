import 'package:flutter/material.dart';

class ComplaintProgress extends StatelessWidget {
  final int currentStage;

  ComplaintProgress({required this.currentStage});

  final List<String> stages = [
    'Complaint Placed',
    'Complaint Acknowledged',
    'Team Has Arrived',
    'Complaint Resolved'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(stages.length, (index) {
            return Expanded(
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index <= currentStage ? Colors.blue : Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    stages[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: index <= currentStage ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 16),
        Row(
          children: List.generate(stages.length - 1, (index) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      color: index < currentStage ? Colors.blue : Colors.grey,
                    ),
                  ),
                  Container(
                    width: 5, // This ensures consistent spacing
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
