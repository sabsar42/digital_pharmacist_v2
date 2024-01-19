import 'package:flutter/material.dart';
import 'Gemini Digi-BOT/config.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  Gemini.init(apiKey: GeminiKey, enableDebugging: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase for my APP IMP**
  runApp(DigiPharmaApp());
}
