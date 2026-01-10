import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class ActionPlanScreen extends StatefulWidget {
  const ActionPlanScreen({super.key});

  @override
  State<ActionPlanScreen> createState() => _ActionPlanScreenState();
}

class _ActionPlanScreenState extends State<ActionPlanScreen> {
  // État des tâches
  final Map<String, bool> _taskStatus = {
    'task1_1': false,
    'task1_2': false,
    'task1_3': false,
    'task2_1': false,
    'task2_2': false,
    'task3_1': false,
    'task3_2': false,
    'task3_3': false,
    'task4_1': false,
    'task4_2': false,
    'task4_3': false,
  };

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
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const DashboardScreen()),
                            (route) => false,
                      );
                    },
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8E6B8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Plan d\'action',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
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
                      'Votre parcours personnalisé vers Data Science & Analytics',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Avancez étape par étape avec clarté et confiance. Suivez votre progression et validez chaque action accomplie.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Étape 1: Rechercher les programmes
                    _buildActionStep(
                      icon: Icons.book_outlined,
                      title: 'Rechercher les programmes',
                      deadline: 'Dans les 2 prochaines semaines',
                      description:
                      'Comparez les universités et leurs critères d\'admission',
                      progress: _calculateProgress(['task1_1', 'task1_2', 'task1_3']),
                      tasks: [
                        TaskItem(
                          id: 'task1_1',
                          title: 'Identifier 3 à 5 universités proposant ce programme',
                          isCompleted: _taskStatus['task1_1']!,
                        ),
                        TaskItem(
                          id: 'task1_2',
                          title: 'Vérifier les dates limites de candidature',
                          isCompleted: _taskStatus['task1_2']!,
                        ),
                        TaskItem(
                          id: 'task1_3',
                          title: 'Analyser les conditions d\'admission',
                          isCompleted: _taskStatus['task1_3']!,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Étape 2: Compléter les prérequis
                    _buildActionStep(
                      icon: Icons.trending_up,
                      title: 'Compléter les prérequis',
                      deadline: 'Au cours des 3 prochains mois',
                      description:
                      'Comblez les éventuelles lacunes avant de déposer votre candidature.',
                      progress: _calculateProgress(['task2_1', 'task2_2']),
                      tasks: [
                        TaskItem(
                          id: 'task2_1',
                          title: 'Suivre un cours en ligne de Python',
                          isCompleted: _taskStatus['task2_1']!,
                        ),
                        TaskItem(
                          id: 'task2_2',
                          title: 'Revoir les bases des statistiques',
                          isCompleted: _taskStatus['task2_2']!,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Étape 3: Préparer la candidature
                    _buildActionStep(
                      icon: Icons.description_outlined,
                      title: 'Préparer la candidature',
                      deadline: 'Au cours des 4 prochains mois',
                      description:
                      'Rassemblez les documents requis et préparez votre dossier de candidature.',
                      progress: _calculateProgress(['task3_1', 'task3_2', 'task3_3']),
                      tasks: [
                        TaskItem(
                          id: 'task3_1',
                          title: 'Demander vos relevés de notes académiques',
                          isCompleted: _taskStatus['task3_1']!,
                        ),
                        TaskItem(
                          id: 'task3_2',
                          title: 'Rédiger la lettre de motivation',
                          isCompleted: _taskStatus['task3_2']!,
                        ),
                        TaskItem(
                          id: 'task3_3',
                          title: 'Demander 2 lettre de recommandations ou plus',
                          isCompleted: _taskStatus['task3_3']!,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Étape 4: Échanger avec des étudiants
                    _buildActionStep(
                      icon: Icons.people_outline,
                      title: 'Échanger avec des étudiants',
                      deadline: 'En continu',
                      description:
                      'Discutez avec des étudiants actuels et des diplômés pour mieux comprendre le programme.',
                      progress: _calculateProgress(['task4_1', 'task4_2', 'task4_3']),
                      tasks: [
                        TaskItem(
                          id: 'task4_1',
                          title: 'Rejoindre les groupes du programme',
                          isCompleted: _taskStatus['task4_1']!,
                        ),
                        TaskItem(
                          id: 'task4_2',
                          title: 'Participer aux journées portes ouvertes virtuelles',
                          isCompleted: _taskStatus['task4_2']!,
                        ),
                        TaskItem(
                          id: 'task4_3',
                          title: 'Entrer en contact avec des alumni sur LinkedIn',
                          isCompleted: _taskStatus['task4_3']!,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Message de motivation
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFFA726).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.lightbulb_outline,
                            color: Color(0xFFFFA726),
                            size: 28,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Vous êtes sur la bonne voie. Rappelez-vous : c\'est un parcours. Avancez pas à pas.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  double _calculateProgress(List<String> taskIds) {
    int completed = taskIds.where((id) => _taskStatus[id] == true).length;
    return completed / taskIds.length;
  }

  Widget _buildActionStep({
    required IconData icon,
    required String title,
    required String deadline,
    required String description,
    required double progress,
    required List<TaskItem> tasks,
  }) {
    int completedTasks = tasks.where((task) => task.isCompleted).length;
    int totalTasks = tasks.length;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF5B9EF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF5B9EF6),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deadline,
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

          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          // Barre de progression
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE0E0E0),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF5B9EF6),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$completedTasks/$totalTasks',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5B9EF6),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Liste des tâches
          ...tasks.map((task) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      setState(() {
                        _taskStatus[task.id] = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFF5B9EF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 15,
                          color: task.isCompleted
                              ? const Color(0xFF999999)
                              : Colors.black87,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class TaskItem {
  final String id;
  final String title;
  final bool isCompleted;

  TaskItem({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
}