import 'package:flutter/material.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final String title;
  final int matchPercentage;

  const ProgramDetailsScreen({
    super.key,
    required this.title,
    required this.matchPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Color(0xFF5B9EF6)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            // Contenu avec scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge et titre
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5B9EF6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.analytics,
                            color: Color(0xFF5B9EF6),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF5B9EF6),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            '$matchPercentage% Niveau de compatibilité',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5B9EF6),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Titre
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Sous-titre
                    const Text(
                      'Programme de Master • 2 ans • Accréditation complète',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF666666),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Section: Présentation du programme
                    _buildSection(
                      icon: Icons.book,
                      title: 'Présentation du programme',
                      content:
                      'La data science combine les statistiques, la programmation et la compréhension des enjeux métier afin d\'extraire des informations pertinentes à partir des données et d\'orienter la prise de décision. Ce domaine pluridisciplinaire prépare les diplômés à des métiers très demandés dans les secteurs de la technologie, de la finance, de la santé et de la recherche.',
                    ),

                    const SizedBox(height: 32),

                    // Section: Universités recommandées
                    _buildUniversitiesSection(),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF5B9EF6),
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUniversitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(
              Icons.school,
              color: Color(0xFF5B9EF6),
              size: 28,
            ),
            SizedBox(width: 12),
            Text(
              'Universités recommandées',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Carte université
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Université Mohammed V à Rabat',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF5B9EF6)),
                    ),
                    child: const Text(
                      'TOP 2 au maroc',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5B9EF6),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Master Data Science & Intelligence Artificielle.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF5B9EF6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: Color(0xFF666666),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Rabat , Maroc',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildUniversityDetail('Durée', '2 ans'),
                  ),
                  Expanded(
                    child: _buildUniversityDetail('Frais', '0 MAD'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildUniversityDetail('Langue', 'Français'),
                  ),
                  Expanded(
                    child: _buildUniversityDetail(
                      'Admission',
                      'sélective\n(≈ 15 %)',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {},
                icon: const Text(
                  'Visiter le site de l\'université',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5B9EF6),
                  ),
                ),
                label: const Icon(
                  Icons.open_in_new,
                  size: 20,
                  color: Color(0xFF5B9EF6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUniversityDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF999999),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}