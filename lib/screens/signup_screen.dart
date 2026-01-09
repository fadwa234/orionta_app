import 'package:flutter/material.dart';
import 'questionnaire_screen.dart'; // Importez le nouveau questionnaire

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4; // Changé de 5 à 4

  // Contrôleurs pour les champs de texte
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universiteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Sélection d'âge
  String? _selectedAge;

  // Niveau d'études
  String? _selectedEducationLevel;

  // Domaine d'intérêt
  String? _selectedDomain;

  @override
  void dispose() {
    _pageController.dispose();
    _prenomController.dispose();
    _nomController.dispose();
    _emailController.dispose();
    _universiteController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Dernière page - Naviguer vers le questionnaire
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const QuestionnaireScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Barre de progression
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: List.generate(
                  _totalPages,
                      (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: index <= _currentPage
                            ? const Color(0xFF5B9EF6)
                            : const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Contenu des pages
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  // Page 1: Informations de base
                  _buildBasicInfoPage(),

                  // Page 2: Âge
                  _buildAgePage(),

                  // Page 3: Niveau d'études
                  _buildEducationLevelPage(),

                  // Page 4: Domaine d'intérêt
                  _buildDomainPage(),
                ],
              ),
            ),

            // Bouton Continuer et indicateur d'étape
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B9EF6),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _currentPage == _totalPages - 1 ? "Continuer" : "Continuer",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Étape ${_currentPage + 1} sur $_totalPages",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Page 1: Informations de base
  Widget _buildBasicInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Commençons par vos informations de base',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nous garderons vos données privées et sécurisées',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 32),

          // Prénom
          _buildTextField(
            label: 'Prénom :',
            controller: _prenomController,
            hint: '',
          ),
          const SizedBox(height: 20),

          // Nom
          _buildTextField(
            label: 'Nom:',
            controller: _nomController,
            hint: '',
          ),
          const SizedBox(height: 20),

          // Email
          _buildTextField(
            label: 'Mail:',
            controller: _emailController,
            hint: '',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),

          // Université (optionnel)
          _buildTextField(
            label: 'Université (optionnel) :',
            controller: _universiteController,
            hint: '',
          ),
          const SizedBox(height: 20),

          // Mot de passe
          _buildTextField(
            label: 'Mot de passe :',
            controller: _passwordController,
            hint: '',
            obscureText: true,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Page 2: Sélection d'âge
  Widget _buildAgePage() {
    final List<String> ageRanges = [
      '18-20 ans',
      '21-22 ans',
      '23-24 ans',
      '+25 ans',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Quel âge avez-vous ?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Cela nous aide à vous proposer des programmes adaptés à votre âge',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // Options d'âge
          ...ageRanges.map((age) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildAgeOption(age),
          )),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Page 3: Niveau d'études
  Widget _buildEducationLevelPage() {
    final List<String> educationLevels = [
      'En fin de lycée',
      'En BAC+2 (DUT/DEUG...)',
      'En licence',
      'En master',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Quel est votre niveau d\'études actuel ?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Où en êtes-vous dans votre parcours académique ?',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // Options de niveau d'études
          ...educationLevels.map((level) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildSelectionOption(
              level,
              _selectedEducationLevel == level,
                  () {
                setState(() {
                  _selectedEducationLevel = level;
                });
              },
            ),
          )),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Page 4: Domaine d'intérêt
  Widget _buildDomainPage() {
    final List<String> domains = [
      'Sciences et recherche',
      'Informatique et technologies',
      'Économie et commerce',
      'Je ne suis pas encore sûr(e)',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Quel domaine vous intéresse le plus ?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Vous pouvez en explorer plusieurs, plus tard.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // Options de domaines
          ...domains.map((domain) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildSelectionOption(
              domain,
              _selectedDomain == domain,
                  () {
                setState(() {
                  _selectedDomain = domain;
                });
              },
            ),
          )),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Widget réutilisable pour les options de sélection
  Widget _buildSelectionOption(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF5B9EF6).withOpacity(0.1)
              : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF5B9EF6)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF5B9EF6) : Colors.black87,
          ),
        ),
      ),
    );
  }

  // Widget pour une option d'âge
  Widget _buildAgeOption(String age) {
    return _buildSelectionOption(
      age,
      _selectedAge == age,
          () {
        setState(() {
          _selectedAge = age;
        });
      },
    );
  }

  // Widget de champ de texte personnalisé
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFFCCCCCC),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}