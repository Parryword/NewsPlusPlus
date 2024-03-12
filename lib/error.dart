import 'dart:collection';

import 'package:flutter/material.dart';

class WarningWidget extends StatelessWidget {
  final String title;
  final String description;
  final Severity severity;

  const WarningWidget({super.key,
    required this.title,
    required this.description,
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: _getColor(),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
            Text(description),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    if (severity == Severity.moderate) {
      return Colors.orangeAccent.shade100;
    }
    else {
      return Colors.red.shade100;
    }
  }
}

enum Severity {
  moderate, critical
}