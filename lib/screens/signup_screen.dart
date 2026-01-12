import 'package:flutter/material.dart';
import 'questionnaire_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  // Contrôleurs pour les champs de texte
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universiteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Sélections
  String? _selectedAge;
  String? _selectedEducationLevel;
  String? _selectedDomain;

  // Visibilité mot de passe
  bool _obscurePassword = true;

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const QuestionnaireScreen(),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // En-tête avec bouton retour et barre de progression
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: Column(
                children: [
                  // Bouton retour
                  Row(
                    children: [
                      if (_currentPage > 0)
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF5B9EF6)),
                          onPressed: _previousPage,
                        )
                      else
                        IconButton(
                          icon: const Icon(Icons.close, color: Color(0xFF5B9EF6)),
                          onPressed: () => Navigator.pop(context),
                        ),
                      const Spacer(),
                      Text(
                        'Étape ${_currentPage + 1} sur $_totalPages',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Barre de progression améliorée
                  Row(
                    children: List.generate(
                      _totalPages,
                          (index) => Expanded(
                        child: Container(
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: index <= _currentPage
                                ? const Color(0xFF5B9EF6)
                                : const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(3),
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
                  _buildBasicInfoPage(),
                  _buildAgePage(),
                  _buildEducationLevelPage(),
                  _buildDomainPage(),
                ],
              ),
            ),

            // Bouton Continuer
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
              child: SizedBox(
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
                        _currentPage == _totalPages - 1 ? "Continuer" : "Continuer",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Page 1: Informations de base (AMÉLIORÉE)
  Widget _buildBasicInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Icône académique
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5B9EF6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.school,
              size: 40,
              color: Color(0xFF5B9EF6),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Commençons par vos informations de base',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nous garderons vos données privées et sécurisées',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Prénom & Nom (en ligne)
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'Prénom',
                  controller: _prenomController,
                  hint: 'Ex: Ahmed',
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  label: 'Nom',
                  controller: _nomController,
                  hint: 'Ex: Alami',
                  icon: Icons.person_outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Email
          _buildTextField(
            label: 'Adresse e-mail',
            controller: _emailController,
            hint: 'exemple@email.com',
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 20),

          // Université (optionnel)
          _buildTextField(
            label: 'Université (optionnel)',
            controller: _universiteController,
            hint: 'Ex: Université Mohammed V',
            icon: Icons.location_city_outlined,
          ),
          const SizedBox(height: 20),

          // Mot de passe
          _buildPasswordField(),

          const SizedBox(height: 16),

          // Info sécurité
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF5B9EF6).withOpacity(0.2),
              ),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.lock_outline,
                  size: 18,
                  color: Color(0xFF5B9EF6),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Vos informations sont sécurisées et cryptées',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5B9EF6),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Page 2: Âge (AMÉLIORÉE)
  Widget _buildAgePage() {
    final List<Map<String, dynamic>> ageRanges = [
      {'range': '18-20 ans', 'icon': Icons.school_outlined},
      {'range': '21-22 ans', 'icon': Icons.menu_book_outlined},
      {'range': '23-24 ans', 'icon': Icons.workspace_premium_outlined},
      {'range': '+25 ans', 'icon': Icons.work_outline},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Icône
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5B9EF6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.calendar_today,
              size: 40,
              color: Color(0xFF5B9EF6),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Quel âge avez-vous ?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Cela nous aide à vous proposer des programmes adaptés à votre parcours',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Options d'âge avec icônes
          ...ageRanges.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildEnhancedOption(
              text: item['range'],
              icon: item['icon'],
              isSelected: _selectedAge == item['range'],
              onTap: () {
                setState(() {
                  _selectedAge = item['range'];
                });
              },
            ),
          )),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Page 3: Niveau d'études (AMÉLIORÉE)
  Widget _buildEducationLevelPage() {
    final List<Map<String, dynamic>> educationLevels = [
      {'level': 'En fin de lycée', 'icon': Icons.school_outlined, 'subtitle': 'BAC ou équivalent'},
      {'level': 'En BAC+2 (DUT/DEUG...)', 'icon': Icons.menu_book_outlined, 'subtitle': 'Formation courte'},
      {'level': 'En licence', 'icon': Icons.workspace_premium_outlined, 'subtitle': 'BAC+3'},
      {'level': 'En master', 'icon': Icons.military_tech_outlined, 'subtitle': 'BAC+5'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5B9EF6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.auto_stories,
              size: 40,
              color: Color(0xFF5B9EF6),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Quel est votre niveau d\'études actuel ?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Cela nous permet de vous orienter vers les formations appropriées',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          ...educationLevels.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildEducationOption(
              text: item['level'],
              subtitle: item['subtitle'],
              icon: item['icon'],
              isSelected: _selectedEducationLevel == item['level'],
              onTap: () {
                setState(() {
                  _selectedEducationLevel = item['level'];
                });
              },
            ),
          )),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Page 4: Domaine d'intérêt (AMÉLIORÉE)
  Widget _buildDomainPage() {
    final List<Map<String, dynamic>> domains = [
      {'domain': 'Sciences et recherche', 'icon': Icons.science_outlined, 'color': Color(0xFF5B9EF6)},
      {'domain': 'Informatique et technologies', 'icon': Icons.computer_outlined, 'color': Color(0xFF5B9EF6)},
      {'domain': 'Économie et commerce', 'icon': Icons.business_center_outlined, 'color': Color(0xFF5B9EF6)},
      {'domain': 'Je ne suis pas encore sûr(e)', 'icon': Icons.help_outline, 'color': Color(0xFF999999)},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5B9EF6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.explore_outlined,
              size: 40,
              color: Color(0xFF5B9EF6),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Quel domaine vous intéresse le plus ?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Vous pourrez explorer plusieurs domaines par la suite',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          ...domains.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildDomainOption(
              text: item['domain'],
              icon: item['icon'],
              iconColor: item['color'],
              isSelected: _selectedDomain == item['domain'],
              onTap: () {
                setState(() {
                  _selectedDomain = item['domain'];
                });
              },
            ),
          )),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Widget champ de texte amélioré
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFFBBBBBB),
                fontSize: 15,
              ),
              prefixIcon: icon != null
                  ? Icon(icon, color: const Color(0xFF5B9EF6), size: 20)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: icon != null ? 16 : 20,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget mot de passe avec visibilité
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mot de passe',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: 'Minimum 8 caractères',
              hintStyle: const TextStyle(
                color: Color(0xFFBBBBBB),
                fontSize: 15,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF5B9EF6),
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: const Color(0xFF999999),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Option améliorée avec icône
  Widget _buildEnhancedOption({
    required String text,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B9EF6).withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF5B9EF6) : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF5B9EF6)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF666666),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? const Color(0xFF5B9EF6) : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF5B9EF6),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  // Option éducation avec sous-titre
  Widget _buildEducationOption({
    required String text,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B9EF6).withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF5B9EF6) : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF5B9EF6)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF666666),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF5B9EF6) : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? const Color(0xFF5B9EF6).withOpacity(0.7) : const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF5B9EF6),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  // Option domaine
  Widget _buildDomainOption({
    required String text,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B9EF6).withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF5B9EF6) : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF5B9EF6)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? const Color(0xFF5B9EF6) : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF5B9EF6),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}