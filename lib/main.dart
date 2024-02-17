import 'package:flutter/material.dart';
import 'Gemini Digi-BOT/config.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  Gemini.init(apiKey: GeminiKey, enableDebugging: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase for my APP IMP**
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle incoming FCM message
    print("FCM Message Received: ${message.notification?.body}");
  });
  runApp(DigiPharmaApp());
}
