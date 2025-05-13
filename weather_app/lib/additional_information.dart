import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  final IconData icon;
  String label1, label2;
  AdditionalInformation({super.key,required this.icon,required this.label1,required this.label2});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32),
              SizedBox(height: 16),
              Text(label1, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                label2,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
