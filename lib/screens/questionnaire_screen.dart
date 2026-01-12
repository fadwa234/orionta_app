import 'package:flutter/material.dart';

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
    if (!_canContinue()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une option pour continuer'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFFF6B6B),
        ),
      );
      return;
    }

    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _submitQuestionnaire();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _canContinue() {
    switch (_currentPage) {
      case 0:
        return _workPreference != null;
      case 1:
        return _learningEnvironment != null;
      case 2:
        return _motivation != null;
      case 3:
        return _futureVision != null;
      default:
        return false;
    }
  }

  void _submitQuestionnaire() {
    Navigator.pushNamed(context, '/loading');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // En-tête amélioré avec ombre subtile
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B9EF6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.quiz_outlined,
                          color: Color(0xFF5B9EF6),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Questionnaire',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Découvrez votre profil',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Barre de progression améliorée
                  Row(
                    children: List.generate(
                      _totalPages,
                          (index) => Expanded(
                        child: Container(
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            gradient: index <= _currentPage
                                ? const LinearGradient(
                              colors: [
                                Color(0xFF5B9EF6),
                                Color(0xFF4A8FE7),
                              ],
                            )
                                : null,
                            color: index <= _currentPage
                                ? null
                                : const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Indicateur d'étape
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentPage + 1} sur $_totalPages',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666),
                        ),
                      ),
                      Text(
                        '${((_currentPage + 1) / _totalPages * 100).toInt()}% complété',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5B9EF6),
                        ),
                      ),
                    ],
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
                  _buildQuestionPage(
                    questionNumber: 1,
                    icon: Icons.work_outline,
                    question: 'Comment préférez-vous travailler ?',
                    subtitle: 'Cette information nous aide à comprendre votre style de travail',
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
                  _buildQuestionPage(
                    questionNumber: 2,
                    icon: Icons.school_outlined,
                    question: 'Quel environnement d\'apprentissage vous convient le mieux ?',
                    subtitle: 'Sélectionnez l\'environnement où vous vous épanouissez',
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
                  _buildQuestionPage(
                    questionNumber: 3,
                    icon: Icons.psychology_outlined,
                    question: 'Qu\'est-ce qui vous motive le plus ?',
                    subtitle: 'Identifiez ce qui vous inspire dans vos études',
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
                  _buildQuestionPage(
                    questionNumber: 4,
                    icon: Icons.star_outline,
                    question: 'Dans 5 ans, vous vous voyez...',
                    subtitle: 'Imaginez votre futur professionnel',
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

            // Boutons en bas avec design amélioré
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Bouton Continuer/Terminer
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B9EF6),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == _totalPages - 1 ? "Terminer" : "Continuer",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == _totalPages - 1
                                ? Icons.check_circle_outline
                                : Icons.arrow_forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bouton Retour
                  if (_currentPage > 0) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: TextButton(
                        onPressed: _previousPage,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF666666),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Retour',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
    required IconData icon,
    required String question,
    required String subtitle,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge de question avec icône
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF5B9EF6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color(0xFF5B9EF6).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF5B9EF6),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Question $questionNumber/$_totalPages',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5B9EF6),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Question principale
            Text(
              question,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.3,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 12),

            // Sous-titre
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            // Options avec animations
            ...options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildOptionButton(
                  text: option,
                  index: index,
                  isSelected: selectedValue == option,
                  onTap: () => onSelect(option),
                ),
              );
            }),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String text,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF5B9EF6)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF5B9EF6)
                  : const Color(0xFFE0E0E0),
              width: isSelected ? 2 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0xFF5B9EF6).withOpacity(0.15)
                    : Colors.black.withOpacity(0.03),
                blurRadius: isSelected ? 12 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Cercle avec numéro/checkmark
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFFE0E0E0),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isSelected
                      ? const Icon(
                    Icons.check,
                    color: Color(0xFF5B9EF6),
                    size: 18,
                  )
                      : Text(
                    String.fromCharCode(65 + index), // A, B, C, D
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF999999),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Texte de l'option
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black87,
                    height: 1.4,
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