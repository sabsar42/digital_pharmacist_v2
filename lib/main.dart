import 'package:flutter/material.dart';

import 'LogInScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:Color.fromRGBO(3, 74, 166, 1.0)),
        useMaterial3: true,
      ),
      home: const LogInScreen(),
    );
  }
}
