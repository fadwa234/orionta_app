import 'package:flutter/material.dart';

class TemoignagesScreen extends StatelessWidget {
  const TemoignagesScreen({super.key});

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

            // Contenu
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Histoires d\'étudiants',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Témoignages authentiques d\'étudiants qui ont trouvé leur voie',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Témoignage 1
                    _buildTestimonialCard(
                      quote:
                      'J\'hésitais entre l\'informatique et les statistiques. Le questionnaire m\'a aidée à réaliser que la data science était le mélange parfait. Aujourd\'hui, je suis en deuxième année et j\'adore !',
                      name: 'Fatima ASSALHI',
                      program: 'Data Science . ENSAO',
                      avatarColor: const Color(0xFF5B9EF6),
                      initials: 'FA',
                    ),

                    const SizedBox(height: 24),

                    // Témoignage 2
                    _buildTestimonialCard(
                      quote:
                      'Issue d\’un parcours classique en informatique, je me sentais perdue. Cette application m\’a donné la confiance nécessaire pour me réorienter vers le design. La meilleure décision de ma vie académique.',
                      name: 'Fadwa JABBAR',
                      program: 'Master SIM . FPT',
                      avatarColor: const Color(0xFF800080),
                      initials: 'FJ',
                    ),

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

  Widget _buildTestimonialCard({
    required String quote,
    required String name,
    required String program,
    required Color avatarColor,
    required String initials,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône de citation
          Icon(
            Icons.format_quote,
            size: 40,
            color: avatarColor.withOpacity(0.3),
          ),

          const SizedBox(height: 16),

          // Citation
          Text(
            quote,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 24),

          // Profil de l'étudiant
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: avatarColor,
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      program,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}