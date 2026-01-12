import 'package:flutter/material.dart';
import 'dart:math' as math;

class ActionPlanScreen extends StatefulWidget {
  const ActionPlanScreen({super.key});

  @override
  State<ActionPlanScreen> createState() => _ActionPlanScreenState();
}

class _ActionPlanScreenState extends State<ActionPlanScreen> with TickerProviderStateMixin {
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
    int totalTasks = _taskStatus.length;
    int completedTasks = _taskStatus.values.where((status) => status).length;
    double globalProgress = completedTasks / totalTasks;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF5B9EF6), size: 20),
                    onPressed: () {
                      Navigator.pop(context);
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
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenu
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre principal
                    const Text(
                      'Votre parcours personnalisé',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Data Science & Analytics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF5B9EF6),
                        letterSpacing: 0.2,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Avancez étape par étape avec clarté et confiance. Suivez votre progression et validez chaque action accomplie.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF666666),
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Card de progression globale
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF5B9EF6),
                            Color(0xFF4A8EE6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5B9EF6).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Progression circulaire
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    value: globalProgress,
                                    strokeWidth: 6,
                                    backgroundColor: Colors.white.withOpacity(0.3),
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${(globalProgress * 100).toInt()}%',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Progression globale',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '$completedTasks sur $totalTasks tâches complétées',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${totalTasks - completedTasks} tâches restantes',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Étapes du plan d'action
                    _buildActionStep(
                      stepNumber: 1,
                      icon: Icons.search_outlined,
                      title: 'Rechercher les programmes',
                      deadline: 'Dans les 2 prochaines semaines',
                      description: 'Comparez les universités et leurs critères d\'admission',
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

                    const SizedBox(height: 20),

                    _buildActionStep(
                      stepNumber: 2,
                      icon: Icons.trending_up_outlined,
                      title: 'Compléter les prérequis',
                      deadline: 'Au cours des 3 prochains mois',
                      description: 'Comblez les éventuelles lacunes avant de déposer votre candidature',
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

                    const SizedBox(height: 20),

                    _buildActionStep(
                      stepNumber: 3,
                      icon: Icons.description_outlined,
                      title: 'Préparer la candidature',
                      deadline: 'Au cours des 4 prochains mois',
                      description: 'Rassemblez les documents requis et préparez votre dossier de candidature',
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
                          title: 'Demander 2 lettres de recommandation ou plus',
                          isCompleted: _taskStatus['task3_3']!,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildActionStep(
                      stepNumber: 4,
                      icon: Icons.people_outline,
                      title: 'Échanger avec des étudiants',
                      deadline: 'En continu',
                      description: 'Discutez avec des étudiants actuels et des diplômés pour mieux comprendre le programme',
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

                    const SizedBox(height: 28),

                    // Message de motivation
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFFA726).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFA726).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.lightbulb_outline,
                              color: Color(0xFFFFA726),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Conseil',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFFA726),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Vous êtes sur la bonne voie. Rappelez-vous : c\'est un parcours. Avancez pas à pas et célébrez chaque victoire.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    height: 1.5,
                                  ),
                                ),
                              ],
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

  String _getStepStatus(double progress) {
    if (progress == 0) return 'À faire';
    if (progress < 1) return 'En cours';
    return 'Terminé';
  }

  Color _getStatusColor(double progress) {
    if (progress == 0) return const Color(0xFFE0E0E0);
    if (progress < 1) return const Color(0xFFFFA726);
    return const Color(0xFF4CAF50);
  }

  Widget _buildActionStep({
    required int stepNumber,
    required IconData icon,
    required String title,
    required String deadline,
    required String description,
    required double progress,
    required List<TaskItem> tasks,
  }) {
    int completedTasks = tasks.where((task) => task.isCompleted).length;
    int totalTasks = tasks.length;
    String status = _getStepStatus(progress);
    Color statusColor = _getStatusColor(progress);
    Color borderColor = progress == 1 ? const Color(0xFF4CAF50) :
    progress > 0 ? const Color(0xFF5B9EF6) :
    const Color(0xFFE0E0E0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(
            color: borderColor,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de la card
            Container(
              padding: const EdgeInsets.all(20),
              color: borderColor.withOpacity(0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Numéro d'étape
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: borderColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '$stepNumber',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Icône
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B9EF6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          icon,
                          color: const Color(0xFF5B9EF6),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    deadline,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Badge de statut
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: statusColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor == const Color(0xFFE0E0E0)
                                ? Colors.grey[700]
                                : statusColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Barre de progression
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progression',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF666666),
                        ),
                      ),
                      Text(
                        '$completedTasks/$totalTasks tâches',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5B9EF6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: const Color(0xFFE8F1FF),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress == 1 ? const Color(0xFF4CAF50) : const Color(0xFF5B9EF6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Liste des tâches
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: tasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final task = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < tasks.length - 1 ? 12.0 : 0,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _taskStatus[task.id] = !task.isCompleted;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: task.isCompleted
                              ? const Color(0xFFF5F5F5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: task.isCompleted
                                ? Colors.transparent
                                : const Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: task.isCompleted
                                    ? const Color(0xFF4CAF50)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: task.isCompleted
                                      ? const Color(0xFF4CAF50)
                                      : const Color(0xFFCCCCCC),
                                  width: 2,
                                ),
                              ),
                              child: task.isCompleted
                                  ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: task.isCompleted
                                      ? const Color(0xFF999999)
                                      : const Color(0xFF1A1A1A),
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  height: 1.5,
                                  fontWeight: task.isCompleted
                                      ? FontWeight.normal
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
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