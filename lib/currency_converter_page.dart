import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});
  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  TextEditingController textEditingController = new TextEditingController();
  double cal = 0.0;
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(40));
    void convert() {
      setState(() {
        cal = double.parse(textEditingController.text) * 81;
      });
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(141, 248, 243, 243),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 119, 119),
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 100,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'INR: ${cal != 0 ? cal.toStringAsFixed(2) : 0}',
                style: TextStyle(fontSize: 54, color: Colors.white),
              ),

              TextField(
                controller: textEditingController,
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in USD',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.monetization_on),
                  filled: true,
                  fillColor: Colors.white60,
                  focusedBorder: border,
                  enabledBorder: border,
                  contentPadding: const EdgeInsets.all(10),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              Container(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    convert();
                  },
                  icon: const Icon(Icons.sync, color: Colors.white),
                  label: const Text(
                    'Convert',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(141, 5, 5, 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
