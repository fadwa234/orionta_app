import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Logo Orionta
              _buildLogo(),

              const SizedBox(height: 60),

              // Titre principal
              const Text(
                'Trouvez votre parcours académique en toute confiance',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 24),

              // Sous-titre
              const Text(
                'Nous savons que choisir votre avenir peut sembler difficile. Rendons-le plus clair, ensemble.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 60),

              // Bouton S'inscrire → Navigation vers Onboarding
              CustomButton(
                text: "S'inscrire",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen(),
                    ),
                  );
                },
                isPrimary: true,
              ),

              const SizedBox(height: 16),

              // Bouton Se connecter
              CustomButton(
                text: 'Se connecter',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                isPrimary: false,
              ),


              const Spacer(flex: 2),

              // Texte en bas
              const Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Text(
                  'Adoptée par des milliers d\'étudiants en\nquête de leur voie',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'lib/assets/images/logo3.png',
      width: 350,
      height: 200,
      fit: BoxFit.contain,
    );
  }
}