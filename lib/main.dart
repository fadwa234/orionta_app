import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const OriontaApp());
}

class OriontaApp extends StatelessWidget {
  const OriontaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orionta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const WelcomeScreen(),
    );
  }
}