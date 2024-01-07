
import 'package:flutter/material.dart';

class CalenderScreen extends StatefulWidget {
  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Add 25 days to the current date
    DateTime futureDate = currentDate.add(Duration(days: 25));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Date Calculation Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Date:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '${currentDate.toLocal()}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Date after 25 days:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '${futureDate.toLocal()}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
