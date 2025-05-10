import 'package:flutter/material.dart';
import 'package:learning_flutter1/currency_converter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrencyConverterPage(),
    );
  }
}
