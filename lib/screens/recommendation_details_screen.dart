import 'package:flutter/material.dart';
import 'action_plan.dart';

class RecommendationDetailsScreen extends StatelessWidget {
  final String title;
  final int matchPercentage;

  const RecommendationDetailsScreen({
    Key? key,
    required this.title,
    required this.matchPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black87, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F4FD),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF5B9EF6).withOpacity(0.2)),
              ),
              child: const Text(
                'Détails de recommandation',
                style: TextStyle(
                  color: Color(0xFF2C3E50),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec titre et badge de correspondance
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4A90E2).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.analytics_rounded, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Data Science & Analytics',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3E50),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.verified, size: 14, color: Color(0xFF4CAF50)),
                                  const SizedBox(width: 4),
                                  Text(
                                    '$matchPercentage% de correspondance',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4CAF50),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE1E8ED)),
                    ),
                    child: const Text(
                      'La data science combine les Mathématiques, la programmation et l\'expertise sectorielle pour extraire des insights actionnables à partir de données. Vous apprendrez à utiliser des outils modernes, travailler avec de grands ensembles de données et prédire des tendances. Idéal pour ceux qui aiment résoudre des problèmes complexes et créer de la valeur à partir de l\'information.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF546E7A),
                        height: 1.7,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Section Universités recommandées
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.school_rounded, color: Color(0xFF4A90E2), size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Universités recommandées',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3E50),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildUniversityCard(
                    university: 'Université Mohammed V',
                    location: 'Rabat',
                    program: 'Master Data Science & Intelligence Artificielle',
                    duration: '2 ans',
                    cost: 'Gratuit',
                    language: 'Français',
                    rating: 4.5,
                  ),
                  const SizedBox(height: 12),
                  _buildUniversityCard(
                    university: 'Université Cadi Ayyad',
                    location: 'Marrakech',
                    program: 'Master Sciences des Données',
                    duration: '2 ans',
                    cost: 'CVDC',
                    language: 'Français',
                    rating: 4.3,
                  ),
                  const SizedBox(height: 12),
                  _buildUniversityCard(
                    university: 'Université Hassan II',
                    location: 'Casablanca, Mohammedia',
                    program: 'Master Data Sciences',
                    duration: '2 ans',
                    cost: 'CVDC',
                    language: 'Français',
                    rating: 4.2,
                  ),
                  const SizedBox(height: 12),
                  _buildUniversityCard(
                    university: 'Université Sidi Mohamed Ben Abdellah',
                    location: 'Fès',
                    program: 'Master Sciences de l\'information',
                    duration: '2 ans',
                    cost: 'CVDC',
                    language: 'Français',
                    rating: 4.1,
                  ),
                  const SizedBox(height: 12),
                  _buildUniversityCard(
                    university: 'Université Ibn Tofaïl',
                    location: 'Kénitra',
                    program: 'Master Big Data et Intelligence des Données',
                    duration: '2 ans',
                    cost: 'CVDC',
                    language: 'Français',
                    rating: 4.0,
                  ),

                  const SizedBox(height: 32),

                  // Conditions d'admission
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle_outline_rounded, color: Color(0xFF4A90E2), size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Conditions d\'admission',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3E50),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildAdmissionItem(
                    icon: Icons.calculate_outlined,
                    title: 'Bases en mathématiques',
                    subtitle: 'Statistiques, algèbre linéaire et calcul',
                    color: const Color(0xFFFF9800),
                  ),
                  const SizedBox(height: 12),
                  _buildAdmissionItem(
                    icon: Icons.code_rounded,
                    title: 'Connaissances en programmation',
                    subtitle: 'Python et la structure des données est un prérequis',
                    color: const Color(0xFF9C27B0),
                  ),
                  const SizedBox(height: 12),
                  _buildAdmissionItem(
                    icon: Icons.psychology_outlined,
                    title: 'Esprit analytique',
                    subtitle: 'Capacité à résoudre des problèmes complexes',
                    color: const Color(0xFF00BCD4),
                  ),
                  const SizedBox(height: 12),
                  _buildAdmissionItem(
                    icon: Icons.workspace_premium_outlined,
                    title: 'Diplôme de licence',
                    subtitle: 'Licence en informatique, mathématiques, etc.',
                    color: const Color(0xFF4CAF50),
                  ),

                  const SizedBox(height: 32),

                  // Compétences développées
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.trending_up_rounded, color: Color(0xFF4A90E2), size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Compétences que vous développerez',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3E50),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildCompetenceSection(),

                  const SizedBox(height: 32),

                  // Débouchés professionnels
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.work_outline_rounded, color: Color(0xFF4A90E2), size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Débouchés professionnels & salaires',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3E50),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildJobCard(
                    title: 'Data Analyst',
                    badge: 'Forte demande',
                    salary: '60 000 - 140 000 MAD / an',
                    location: 'Marrakech',
                    details: '15 postes publiés ce mois-ci',
                  ),
                  const SizedBox(height: 12),
                  _buildJobCard(
                    title: 'Data Engineer',
                    badge: 'Forte demande',
                    salary: '80 000 - 180 000 MAD / an',
                    location: 'Casablanca',
                    details: 'Conception et maintenance de pipelines de données',
                  ),
                  const SizedBox(height: 12),
                  _buildJobCard(
                    title: 'Business Intelligence Analyst',
                    badge: 'Forte demande',
                    salary: '75 000 - 200 000 MAD / an',
                    location: 'Rabat',
                    details: 'Analyse et visualisation des données d\'entreprise',
                  ),

                  const SizedBox(height: 32),

                  // Bouton Créer un plan d'action
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4A90E2).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ActionPlanScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.assignment_turned_in_rounded, size: 22),
                            const SizedBox(width: 12),
                            const Text(
                              "Créer un plan d'action",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUniversityCard({
    required String university,
    required String location,
    required String program,
    required String duration,
    required String cost,
    required String language,
    required double rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8ED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.account_balance, color: Color(0xFF4A90E2), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      university,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3E50),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF90A4AE)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: const TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFB300),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              program,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF546E7A),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInfoChip(Icons.schedule_rounded, duration, const Color(0xFF4A90E2)),
              _buildInfoChip(Icons.payments_outlined, cost, const Color(0xFF4CAF50)),
              _buildInfoChip(Icons.language_rounded, language, const Color(0xFF9C27B0)),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Visiter le site web',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF4A90E2)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdmissionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE1E8ED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF546E7A),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetenceSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8ED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCompetenceItem('Programmation Python : R et Python pour l\'analyse', Icons.code_rounded),
          const SizedBox(height: 16),
          _buildCompetenceItem('Visualisation des données : Créez des tableaux de bord et des graphiques', Icons.bar_chart_rounded),
          const SizedBox(height: 16),
          _buildCompetenceItem('Modélisation prédictive : Développez des modèles pour prédire les tendances', Icons.trending_up_rounded),
          const SizedBox(height: 16),
          _buildCompetenceItem('Analyse SQL : Gérez et explorez des bases de données', Icons.storage_rounded),
          const SizedBox(height: 16),
          _buildCompetenceItem('Machine Learning : Construisez des systèmes intelligents', Icons.psychology_rounded),
          const SizedBox(height: 16),
          _buildCompetenceItem('Statistiques avancées : Interprétez les données avec précision', Icons.analytics_rounded),
        ],
      ),
    );
  }

  Widget _buildCompetenceItem(String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F4FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF4A90E2)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2C3E50),
                height: 1.5,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobCard({
    required String title,
    required String badge,
    required String salary,
    required String location,
    required String details,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8ED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.work_outline_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3E50),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF90A4AE)),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF90A4AE),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.payments_outlined, size: 16, color: Color(0xFF4A90E2)),
                    const SizedBox(width: 8),
                    Text(
                      salary,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  details,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF546E7A),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}