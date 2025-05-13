import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final IconData icon;
  final String label1,label2;
  const HourlyForecastItem({super.key, required this.icon,required this.label1,required this.label2});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(
              label1,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(label2, style: TextStyle()),
          ],
        ),
      ),
    );
  }
}
