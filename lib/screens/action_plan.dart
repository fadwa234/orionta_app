import 'package:flutter/material.dart';
import '../services/action_plan_service.dart';
import '../services/auth_service.dart';
import '../models/action_plan_model.dart';

class ActionPlanScreen extends StatefulWidget {
  const ActionPlanScreen({super.key});

  @override
  State<ActionPlanScreen> createState() => _ActionPlanScreenState();
}

class _ActionPlanScreenState extends State<ActionPlanScreen> {
  // Services Firebase
  final ActionPlanService _actionPlanService = ActionPlanService();
  final AuthService _authService = AuthService();

  // État
  ActionPlanModel? _actionPlan;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadActionPlan();
  }

  // ============================================
  // CHARGER le plan d'action
  // ============================================
  Future<void> _loadActionPlan() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = _authService.currentUser;
      if (user == null) {
        setState(() {
          _errorMessage = 'Utilisateur non connecté';
          _isLoading = false;
        });
        return;
      }

      // Récupérer le plan existant
      final actionPlan = await _actionPlanService.getActionPlan(user.uid);

      if (actionPlan == null) {
        // Pas de plan existant → Créer un plan par défaut
        // Vous pouvez récupérer le domaine depuis Firestore (collection users)
        final newPlan = await _actionPlanService.createActionPlan(
          userId: user.uid,
          domain: 'Data Science & Analytics', // Changez selon le profil
        );

        setState(() {
          _actionPlan = newPlan;
          _isLoading = false;
        });
      } else {
        setState(() {
          _actionPlan = actionPlan;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de chargement : $e';
        _isLoading = false;
      });
    }
  }

  // ============================================
  // METTRE À JOUR une tâche
  // ============================================
  Future<void> _toggleTask(int stepNumber, String taskId, bool currentStatus) async {
    final user = _authService.currentUser;
    if (user == null) return;

    // Mise à jour optimiste de l'interface
    setState(() {
      if (_actionPlan != null) {
        final stepIndex = _actionPlan!.steps.indexWhere((s) => s.stepNumber == stepNumber);
        if (stepIndex != -1) {
          final step = _actionPlan!.steps[stepIndex];
          final taskIndex = step.tasks.indexWhere((t) => t.id == taskId);
          if (taskIndex != -1) {
            final updatedTask = step.tasks[taskIndex].copyWith(
              isCompleted: !currentStatus,
              completedAt: !currentStatus ? DateTime.now() : null,
            );
            final updatedTasks = List<TaskItem>.from(step.tasks);
            updatedTasks[taskIndex] = updatedTask;

            final updatedStep = ActionStep(
              stepNumber: step.stepNumber,
              icon: step.icon,
              title: step.title,
              deadline: step.deadline,
              description: step.description,
              tasks: updatedTasks,
            );

            final updatedSteps = List<ActionStep>.from(_actionPlan!.steps);
            updatedSteps[stepIndex] = updatedStep;

            _actionPlan = ActionPlanModel(
              userId: _actionPlan!.userId,
              domain: _actionPlan!.domain,
              createdAt: _actionPlan!.createdAt,
              updatedAt: DateTime.now(),
              steps: updatedSteps,
            );
          }
        }
      }
    });

    // Mise à jour Firebase en arrière-plan
    final success = await _actionPlanService.updateTaskStatus(
      userId: user.uid,
      stepNumber: stepNumber,
      taskId: taskId,
      isCompleted: !currentStatus,
    );

    if (!success) {
      // Si échec, recharger depuis Firebase
      _loadActionPlan();
      _showErrorSnackBar('Erreur de synchronisation');
    }
  }

  // ============================================
  // INTERFACE UTILISATEUR
  // ============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            _buildHeader(),

            // Contenu
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _errorMessage != null
                  ? _buildErrorState()
                  : _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  // En-tête
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF5B9EF6), size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    );
  }

  // État de chargement
  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF5B9EF6)),
          SizedBox(height: 16),
          Text(
            'Chargement de votre plan...',
            style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
          ),
        ],
      ),
    );
  }

  // État d'erreur
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Une erreur est survenue',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadActionPlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B9EF6),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }

  // Contenu principal
  Widget _buildContent() {
    if (_actionPlan == null) {
      return const Center(child: Text('Aucun plan d\'action disponible'));
    }

    final totalTasks = _actionPlan!.totalTasksCount;
    final completedTasks = _actionPlan!.completedTasksCount;
    final globalProgress = _actionPlan!.globalProgress;

    return SingleChildScrollView(
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
          Text(
            _actionPlan!.domain,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5B9EF6),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Avancez étape par étape avec clarté et confiance. Suivez votre progression et validez chaque action accomplie.',
            style: TextStyle(fontSize: 15, color: Color(0xFF666666), height: 1.6),
          ),
          const SizedBox(height: 28),

          // Card de progression globale
          _buildProgressCard(globalProgress, completedTasks, totalTasks),

          const SizedBox(height: 32),

          // Étapes du plan d'action
          ...List.generate(_actionPlan!.steps.length, (index) {
            final step = _actionPlan!.steps[index];
            return Padding(
              padding: EdgeInsets.only(bottom: index < _actionPlan!.steps.length - 1 ? 20.0 : 0),
              child: _buildActionStep(step),
            );
          }),

          const SizedBox(height: 28),

          // Message de motivation
          _buildMotivationCard(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Card de progression globale
  Widget _buildProgressCard(double globalProgress, int completedTasks, int totalTasks) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5B9EF6), Color(0xFF4A8EE6)],
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
    );
  }

  // Étape du plan d'action
  Widget _buildActionStep(ActionStep step) {
    final progress = step.progress;
    final completedTasks = step.tasks.where((task) => task.isCompleted).length;
    final totalTasks = step.tasks.length;
    final status = _getStepStatus(progress);
    final statusColor = _getStatusColor(progress);
    final borderColor = progress == 1
        ? const Color(0xFF4CAF50)
        : progress > 0
        ? const Color(0xFF5B9EF6)
        : const Color(0xFFE0E0E0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
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
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: borderColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${step.stepNumber}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B9EF6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _actionPlanService.getIconData(step.icon),
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
                              step.title,
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
                                Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    step.deadline,
                                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
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
                    step.description,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5),
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
                children: step.tasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final task = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < step.tasks.length - 1 ? 12.0 : 0),
                    child: _buildTaskItem(task, step.stepNumber),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Item de tâche
  Widget _buildTaskItem(TaskItem task, int stepNumber) {
    return InkWell(
      onTap: () => _toggleTask(stepNumber, task.id, task.isCompleted),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: task.isCompleted ? const Color(0xFFF5F5F5) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: task.isCompleted ? Colors.transparent : const Color(0xFFE0E0E0),
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
                color: task.isCompleted ? const Color(0xFF4CAF50) : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: task.isCompleted ? const Color(0xFF4CAF50) : const Color(0xFFCCCCCC),
                  width: 2,
                ),
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontSize: 14,
                  color: task.isCompleted ? const Color(0xFF999999) : const Color(0xFF1A1A1A),
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  height: 1.5,
                  fontWeight: task.isCompleted ? FontWeight.normal : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Message de motivation
  Widget _buildMotivationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFA726).withOpacity(0.2), width: 1),
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
            child: const Icon(Icons.lightbulb_outline, color: Color(0xFFFFA726), size: 24),
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
                  style: TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helpers
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}