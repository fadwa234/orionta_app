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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Détails de recommandation',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec titre et barre de progression
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade400, Colors.blue.shade700],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.analytics, color: Colors.white, size: 26),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Data Science & Analytics',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'La data science combine les Mathématiques, la programmation et l\'expertise sectorielle pour extraire des insights actionnables à partir de données. Vous apprendrez à utiliser des outils modernes, travailler avec de grands ensembles de données et prédire des tendances. Idéal pour ceux qui aiment résoudre des problèmes complexes et créer de la valeur à partir de l\'information.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Section Universités recommandées
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.school, color: Color(0xFF5B9EF6), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Universités recommandées',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildUniversityCard(
                    university: 'Université Mohammed V à Rabat',
                    program: 'Master Data Science & Intelligence Artificielle',
                    location: 'Rabat',
                    duration: '2 ans',
                    cost: 'Gratuit',
                    language: 'Français',
                    rating: 4.5,
                  ),
                  const SizedBox(height: 12),
                  _buildUniversityCard(
                    university: 'Université Cadi Ayyad à Marrakech',
                    program: 'Master Sciences des Données',
                    location: 'Marrakech',
                    duration: '2 ans',
                    cost: 'CVDC',
                    language: 'Français',
                    rating: 4.3,
                  ),
                  const SizedBox(height: 12),
                  _buildUniversityCard(
                    university: 'Université Hassan II à Mohammedia/Casablanca',
                    program: 'Master Data Sciences',
                    location: 'Casablanca, Mohammedia',
                    duration: '2 ans',
                    cost: 'CVDC',
                    language: 'Français',
                    rating: 4.2,
                  ),
                  const SizedBox(height: 12),
                  _buildUniversityCard(
                    university: 'Université Sidi Mohamed Ben Abdellah à Fès',
                    program: 'Master Sciences de l\'information',
                    location: 'Fès',
                    duration: '2 ans',
                    cost: 'CVDC',
                    language: 'Français',
                    rating: 4.1,
                  ),
                  const SizedBox(height: 12),
                  _buildUniversityCard(
                    university: 'Université Ibn Tofaïl à Kénitra',
                    program: 'Master Big Data et Intelligence des Données',
                    location: 'Kénitra',
                    duration: '2 ans',
                    cost: 'CVDC',
                    language: 'Français',
                    rating: 4.0,
                  ),

                  const SizedBox(height: 32),

                  // Conditions d'admission
                  const Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Color(0xFF5B9EF6), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Conditions d\'admission',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildAdmissionItem(
                    icon: Icons.calculate_outlined,
                    title: 'Bases en mathématiques',
                    subtitle: 'Statistiques, algèbre linéaire et calcul',
                  ),
                  const SizedBox(height: 12),
                  _buildAdmissionItem(
                    icon: Icons.code,
                    title: 'Connaissances en programmation',
                    subtitle: 'Python et la structure des données est un prérequis',
                  ),
                  const SizedBox(height: 12),
                  _buildAdmissionItem(
                    icon: Icons.psychology_outlined,
                    title: 'Esprit analytique',
                    subtitle: 'Capacité à résoudre des problèmes complexes',
                  ),
                  const SizedBox(height: 12),
                  _buildAdmissionItem(
                    icon: Icons.workspace_premium_outlined,
                    title: 'Diplôme de licence',
                    subtitle: 'Licence en informatique, mathématiques, etc.',
                  ),

                  const SizedBox(height: 32),

                  // Compétences développées
                  const Row(
                    children: [
                      Icon(Icons.trending_up, color: Color(0xFF5B9EF6), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Compétences que vous développerez',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildCompetenceSection(),

                  const SizedBox(height: 32),

                  // Débouchés professionnels
                  const Row(
                    children: [
                      Icon(Icons.business_center_outlined, color: Color(0xFF5B9EF6), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Débouchés professionnels & salaires',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildJobCard(
                    title: 'Data analyst',
                    badge: 'Forte demande',
                    salary: '60 000 - 140 000 MAD / 12 Mois (Marrakech)',
                    details: '15 postes publiés ce mois-ci',
                  ),
                  const SizedBox(height: 12),
                  _buildJobCard(
                    title: 'Numéro carrière Enseigné',
                    badge: 'Forte demande',
                    salary: '80 000 - 180 000 MAD / 12 Mois (Casablanca)',
                    details: 'UX/UI designer de product design',
                  ),
                  const SizedBox(height: 12),
                  _buildJobCard(
                    title: 'Business Intelligence Analyst',
                    badge: 'Forte demande',
                    salary: '75 000 - 200 000 MAD / 12 Mois (Rabat)',
                    details: 'Analysez les données',
                  ),

                  const SizedBox(height: 32),

                  // Bouton Créer un plan d'action
                  SizedBox(
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
                        backgroundColor: const Color(0xFF5B9EF6),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Créer un plan d'action",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
    required String program,
    required String location,
    required String duration,
    required String cost,
    required String language,
    required double rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      university,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      program,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(fontSize: 13, color: Color(0xFF999999)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInfoChip('Durée', duration),
              _buildInfoChip('Prix', cost),
              _buildInfoChip('Langue', language),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF5B9EF6),
                padding: EdgeInsets.zero,
              ),
              icon: const Text(
                'Visiter le site web de l\'université',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              label: const Icon(Icons.open_in_new, size: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF999999),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
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
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF666666), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF666666),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCompetenceItem('Programmation Python : R et Python pour l\'analyse'),
          const Divider(height: 24),
          _buildCompetenceItem('Visualisation des données : Créez des tableaux de bord et des graphiques'),
          const Divider(height: 24),
          _buildCompetenceItem('Modélisation prédictive : Développez des modèles pour prédire les tendances'),
          const Divider(height: 24),
          _buildCompetenceItem('Analyse SQL : Gérez et explorez des bases de données'),
          const Divider(height: 24),
          _buildCompetenceItem('Machine Learning : Construisez des systèmes intelligents'),
          const Divider(height: 24),
          _buildCompetenceItem('Statistiques avancées : Interprétez les données avec précision'),
        ],
      ),
    );
  }

  Widget _buildCompetenceItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFF5B9EF6),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
              height: 1.5,
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
    required String details,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5B9EF6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            salary,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            details,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}