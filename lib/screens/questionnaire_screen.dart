import 'package:flutter/material.dart';

import 'login_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  // Réponses sélectionnées
  String? _workPreference;
  String? _learningEnvironment;
  String? _motivation;
  String? _futureVision;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Dernière page - Terminer le questionnaire
      _submitQuestionnaire();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitQuestionnaire() {
    // Navigation vers la page de chargement
    Navigator.pushNamed(context, '/loading');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // En-tête avec titre et barre de progression
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Questionnaire',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Barre de progression
                  Row(
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
                ],
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
                  // Question 1
                  _buildQuestionPage(
                    questionNumber: 1,
                    question: 'Comment préférez-vous travailler ?',
                    subtitle: 'Choisissez l\'option qui vous correspond le plus',
                    options: [
                      'De manière indépendante, à mon propre rythme',
                      'En collaboration avec d\'autres',
                      'Un mélange des deux',
                    ],
                    selectedValue: _workPreference,
                    onSelect: (value) {
                      setState(() {
                        _workPreference = value;
                      });
                    },
                  ),

                  // Question 2
                  _buildQuestionPage(
                    questionNumber: 2,
                    question: 'Quel environnement d\'apprentissage vous convient le mieux ?',
                    subtitle: 'Choisissez l\'option qui vous correspond le plus',
                    options: [
                      'Structuré, avec des règles et des objectifs clairs',
                      'Flexible, favorisant l\'autonomie',
                      'Rythmé et dynamique',
                    ],
                    selectedValue: _learningEnvironment,
                    onSelect: (value) {
                      setState(() {
                        _learningEnvironment = value;
                      });
                    },
                  ),

                  // Question 3
                  _buildQuestionPage(
                    questionNumber: 3,
                    question: 'Qu\'est-ce qui vous motive le plus ?',
                    subtitle: 'Choisissez l\'option qui vous correspond le plus',
                    options: [
                      'Comprendre les théories et les concepts',
                      'La pratique et les projets concrets',
                      'Travailler avec des personnes',
                      'Résoudre des problèmes complexes',
                    ],
                    selectedValue: _motivation,
                    onSelect: (value) {
                      setState(() {
                        _motivation = value;
                      });
                    },
                  ),

                  // Question 4
                  _buildQuestionPage(
                    questionNumber: 4,
                    question: 'Dans 5 ans, vous vous voyez...',
                    subtitle: 'Choisissez l\'option qui vous correspond le plus',
                    options: [
                      'En tant que spécialiste dans votre domaine',
                      'À la tête de projets ou d\'équipes',
                      'En train de lancer votre propre projet',
                      'Toujours en train d\'explorer et d\'apprendre',
                    ],
                    selectedValue: _futureVision,
                    onSelect: (value) {
                      setState(() {
                        _futureVision = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Boutons en bas
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Bouton Continuer
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
                        _currentPage == _totalPages - 1 ? "Terminer" : "Continuer",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Bouton Retour (sauf sur la première page)
                  if (_currentPage > 0) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: TextButton(
                        onPressed: _previousPage,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                        ),
                        child: const Text(
                          'Retour',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Indicateur d'étape
                  Text(
                    'Étape ${_currentPage + 1} sur $_totalPages',
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

  Widget _buildQuestionPage({
    required int questionNumber,
    required String question,
    required String subtitle,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Numéro de question en cercle
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$questionNumber',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Question principale
            Text(
              question,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 16),

            // Sous-titre
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 48),

            // Options
            ...options.map((option) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildOptionButton(
                text: option,
                isSelected: selectedValue == option,
                onTap: () => onSelect(option),
              ),
            )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
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
}