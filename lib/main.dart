import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orionta_app/firebase_options.dart';
import 'screens/welcome_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/questionnaire_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/login_screen.dart';
import 'screens/recommendations_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, );
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
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/questionnaire': (context) => const QuestionnaireScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/login': (context) => const LoginScreen(),
        '/recommendations': (context) => const RecommendationsScreen(),
      },
    );
  }
}