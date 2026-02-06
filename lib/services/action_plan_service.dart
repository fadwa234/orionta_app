import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/action_plan_model.dart';
import 'package:flutter/material.dart';

class ActionPlanService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection Firestore
  CollectionReference get _actionPlansCollection =>
      _firestore.collection('action_plans');

  // ============================================
  // 1. CRÉER un plan d'action personnalisé
  // ============================================
  Future<ActionPlanModel?> createActionPlan({
    required String userId,
    required String domain,
  }) async {
    try {
      // Générer le plan d'action basé sur le domaine
      final actionPlan = _generatePlanForDomain(userId, domain);

      // Sauvegarder dans Firestore
      await _actionPlansCollection.doc(userId).set(actionPlan.toMap());

      print(' Plan d\'action créé pour $domain');
      return actionPlan;
    } catch (e) {
      print(' Erreur création plan d\'action : $e');
      return null;
    }
  }

  // ============================================
  // 2. RÉCUPÉRER le plan d'action
  // ============================================
  Future<ActionPlanModel?> getActionPlan(String userId) async {
    try {
      final doc = await _actionPlansCollection.doc(userId).get();

      if (!doc.exists) {
        print(' Aucun plan d\'action trouvé pour $userId');
        return null;
      }

      return ActionPlanModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print(' Erreur récupération plan : $e');
      return null;
    }
  }

  // ============================================
  // 3. METTRE À JOUR une tâche (cocher/décocher)
  // ============================================
  Future<bool> updateTaskStatus({
    required String userId,
    required int stepNumber,
    required String taskId,
    required bool isCompleted,
  }) async {
    try {
      final actionPlan = await getActionPlan(userId);
      if (actionPlan == null) return false;

      // Trouver l'étape et la tâche
      final stepIndex = actionPlan.steps.indexWhere((s) => s.stepNumber == stepNumber);
      if (stepIndex == -1) return false;

      final step = actionPlan.steps[stepIndex];
      final taskIndex = step.tasks.indexWhere((t) => t.id == taskId);
      if (taskIndex == -1) return false;

      // Mettre à jour la tâche
      final updatedTask = step.tasks[taskIndex].copyWith(
        isCompleted: isCompleted,
        completedAt: isCompleted ? DateTime.now() : null,
      );

      // Créer la nouvelle liste de tâches
      final updatedTasks = List<TaskItem>.from(step.tasks);
      updatedTasks[taskIndex] = updatedTask;

      // Créer la nouvelle étape
      final updatedStep = ActionStep(
        stepNumber: step.stepNumber,
        icon: step.icon,
        title: step.title,
        deadline: step.deadline,
        description: step.description,
        tasks: updatedTasks,
      );

      // Créer la nouvelle liste d'étapes
      final updatedSteps = List<ActionStep>.from(actionPlan.steps);
      updatedSteps[stepIndex] = updatedStep;

      // Créer le plan mis à jour
      final updatedPlan = ActionPlanModel(
        userId: actionPlan.userId,
        domain: actionPlan.domain,
        createdAt: actionPlan.createdAt,
        updatedAt: DateTime.now(),
        steps: updatedSteps,
      );

      // Sauvegarder dans Firestore
      await _actionPlansCollection.doc(userId).update(updatedPlan.toMap());

      print(' Tâche $taskId mise à jour : $isCompleted');
      return true;
    } catch (e) {
      print(' Erreur mise à jour tâche : $e');
      return false;
    }
  }

  // ============================================
  // 4. SUPPRIMER le plan d'action
  // ============================================
  Future<bool> deleteActionPlan(String userId) async {
    try {
      await _actionPlansCollection.doc(userId).delete();
      print(' Plan d\'action supprimé');
      return true;
    } catch (e) {
      print(' Erreur suppression plan : $e');
      return false;
    }
  }

  // ============================================
  // 5. STREAM en temps réel du plan
  // ============================================
  Stream<ActionPlanModel?> streamActionPlan(String userId) {
    return _actionPlansCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return ActionPlanModel.fromMap(doc.data() as Map<String, dynamic>);
    });
  }

  // ============================================
  //  GÉNÉRATION DE PLAN PERSONNALISÉ
  // ============================================
  ActionPlanModel _generatePlanForDomain(String userId, String domain) {
    // Plans spécifiques par domaine
    final plans = {
      'Data Science & Analytics': _getDataSciencePlan(userId),
      'Ingénierie': _getEngineeringPlan(userId),
      'Médecine': _getMedicinePlan(userId),
      'Commerce & Gestion': _getBusinessPlan(userId),
      'Sciences Humaines': _getHumanitiesPlan(userId),
      'Arts & Design': _getArtsPlan(userId),
    };

    // Retourner le plan correspondant ou plan par défaut
    return plans[domain] ?? _getDefaultPlan(userId, domain);
  }

  // Plan Data Science
  ActionPlanModel _getDataSciencePlan(String userId) {
    return ActionPlanModel(
      userId: userId,
      domain: 'Data Science & Analytics',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      steps: [
        ActionStep(
          stepNumber: 1,
          icon: 'search_outlined',
          title: 'Rechercher les programmes',
          deadline: 'Dans les 2 prochaines semaines',
          description: 'Comparez les universités et leurs critères d\'admission',
          tasks: [
            TaskItem(
              id: 'task1_1',
              title: 'Identifier 3 à 5 universités proposant ce programme',
              isCompleted: false,
            ),
            TaskItem(
              id: 'task1_2',
              title: 'Vérifier les dates limites de candidature',
              isCompleted: false,
            ),
            TaskItem(
              id: 'task1_3',
              title: 'Analyser les conditions d\'admission',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 2,
          icon: 'trending_up_outlined',
          title: 'Compléter les prérequis',
          deadline: 'Au cours des 3 prochains mois',
          description: 'Comblez les éventuelles lacunes avant de déposer votre candidature',
          tasks: [
            TaskItem(
              id: 'task2_1',
              title: 'Suivre un cours en ligne de Python',
              isCompleted: false,
            ),
            TaskItem(
              id: 'task2_2',
              title: 'Revoir les bases des statistiques',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 3,
          icon: 'description_outlined',
          title: 'Préparer la candidature',
          deadline: 'Au cours des 4 prochains mois',
          description: 'Rassemblez les documents requis et préparez votre dossier de candidature',
          tasks: [
            TaskItem(
              id: 'task3_1',
              title: 'Demander vos relevés de notes académiques',
              isCompleted: false,
            ),
            TaskItem(
              id: 'task3_2',
              title: 'Rédiger la lettre de motivation',
              isCompleted: false,
            ),
            TaskItem(
              id: 'task3_3',
              title: 'Demander 2 lettres de recommandation ou plus',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 4,
          icon: 'people_outline',
          title: 'Échanger avec des étudiants',
          deadline: 'En continu',
          description: 'Discutez avec des étudiants actuels et des diplômés pour mieux comprendre le programme',
          tasks: [
            TaskItem(
              id: 'task4_1',
              title: 'Rejoindre les groupes du programme',
              isCompleted: false,
            ),
            TaskItem(
              id: 'task4_2',
              title: 'Participer aux journées portes ouvertes virtuelles',
              isCompleted: false,
            ),
            TaskItem(
              id: 'task4_3',
              title: 'Entrer en contact avec des alumni sur LinkedIn',
              isCompleted: false,
            ),
          ],
        ),
      ],
    );
  }

  // Plan Ingénierie
  ActionPlanModel _getEngineeringPlan(String userId) {
    return ActionPlanModel(
      userId: userId,
      domain: 'Ingénierie',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      steps: [
        ActionStep(
          stepNumber: 1,
          icon: 'school_outlined',
          title: 'Identifier les écoles d\'ingénieurs',
          deadline: 'Dans les 2 prochaines semaines',
          description: 'Recherchez les meilleures écoles selon votre spécialité',
          tasks: [
            TaskItem(
              id: 'eng_task1_1',
              title: 'Lister 5 écoles d\'ingénieurs de votre choix',
              isCompleted: false,
            ),
            TaskItem(
              id: 'eng_task1_2',
              title: 'Comparer les spécialisations proposées',
              isCompleted: false,
            ),
            TaskItem(
              id: 'eng_task1_3',
              title: 'Vérifier les taux d\'insertion professionnelle',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 2,
          icon: 'calculate_outlined',
          title: 'Renforcer les mathématiques et physique',
          deadline: 'Au cours des 3 prochains mois',
          description: 'Préparez-vous aux examens d\'admission',
          tasks: [
            TaskItem(
              id: 'eng_task2_1',
              title: 'Réviser les mathématiques avancées',
              isCompleted: false,
            ),
            TaskItem(
              id: 'eng_task2_2',
              title: 'Pratiquer les exercices de physique',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 3,
          icon: 'engineering_outlined',
          title: 'Réaliser un projet technique',
          deadline: 'Au cours des 4 prochains mois',
          description: 'Montrez vos compétences pratiques',
          tasks: [
            TaskItem(
              id: 'eng_task3_1',
              title: 'Développer un projet Arduino ou Raspberry Pi',
              isCompleted: false,
            ),
            TaskItem(
              id: 'eng_task3_2',
              title: 'Documenter votre projet sur GitHub',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 4,
          icon: 'groups_outlined',
          title: 'Participer à des concours',
          deadline: 'En continu',
          description: 'Développez votre expérience pratique',
          tasks: [
            TaskItem(
              id: 'eng_task4_1',
              title: 'S\'inscrire à des hackathons',
              isCompleted: false,
            ),
            TaskItem(
              id: 'eng_task4_2',
              title: 'Rejoindre des clubs de robotique',
              isCompleted: false,
            ),
          ],
        ),
      ],
    );
  }

  // Plan Médecine
  ActionPlanModel _getMedicinePlan(String userId) {
    return ActionPlanModel(
      userId: userId,
      domain: 'Médecine',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      steps: [
        ActionStep(
          stepNumber: 1,
          icon: 'local_hospital_outlined',
          title: 'Rechercher les facultés de médecine',
          deadline: 'Dans les 2 prochaines semaines',
          description: 'Identifiez les meilleures facultés et leurs critères',
          tasks: [
            TaskItem(
              id: 'med_task1_1',
              title: 'Lister les facultés de médecine accréditées',
              isCompleted: false,
            ),
            TaskItem(
              id: 'med_task1_2',
              title: 'Vérifier les taux de réussite au concours',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 2,
          icon: 'science_outlined',
          title: 'Renforcer les sciences',
          deadline: 'Au cours des 4 prochains mois',
          description: 'Préparez-vous intensivement aux matières scientifiques',
          tasks: [
            TaskItem(
              id: 'med_task2_1',
              title: 'Réviser la biologie et chimie',
              isCompleted: false,
            ),
            TaskItem(
              id: 'med_task2_2',
              title: 'S\'inscrire à une prépa médecine',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 3,
          icon: 'volunteer_activism_outlined',
          title: 'Acquérir de l\'expérience',
          deadline: 'Au cours des 6 prochains mois',
          description: 'Familiarisez-vous avec le milieu médical',
          tasks: [
            TaskItem(
              id: 'med_task3_1',
              title: 'Faire du bénévolat dans un hôpital',
              isCompleted: false,
            ),
            TaskItem(
              id: 'med_task3_2',
              title: 'Observer des professionnels de santé',
              isCompleted: false,
            ),
          ],
        ),
      ],
    );
  }

  // Plan Commerce & Gestion
  ActionPlanModel _getBusinessPlan(String userId) {
    return ActionPlanModel(
      userId: userId,
      domain: 'Commerce & Gestion',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      steps: [
        ActionStep(
          stepNumber: 1,
          icon: 'business_outlined',
          title: 'Explorer les écoles de commerce',
          deadline: 'Dans les 3 prochaines semaines',
          description: 'Identifiez les meilleures business schools',
          tasks: [
            TaskItem(
              id: 'bus_task1_1',
              title: 'Comparer les classements des écoles',
              isCompleted: false,
            ),
            TaskItem(
              id: 'bus_task1_2',
              title: 'Analyser les spécialisations (finance, marketing, etc.)',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 2,
          icon: 'account_balance_outlined',
          title: 'Développer vos compétences entrepreneuriales',
          deadline: 'Au cours des 4 prochains mois',
          description: 'Construisez votre profil business',
          tasks: [
            TaskItem(
              id: 'bus_task2_1',
              title: 'Lancer un petit projet entrepreneurial',
              isCompleted: false,
            ),
            TaskItem(
              id: 'bus_task2_2',
              title: 'Suivre un MOOC en gestion de projet',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 3,
          icon: 'work_outline',
          title: 'Acquérir de l\'expérience professionnelle',
          deadline: 'Au cours des 6 prochains mois',
          description: 'Stages et expériences pratiques',
          tasks: [
            TaskItem(
              id: 'bus_task3_1',
              title: 'Trouver un stage en entreprise',
              isCompleted: false,
            ),
            TaskItem(
              id: 'bus_task3_2',
              title: 'Participer à des concours de business plan',
              isCompleted: false,
            ),
          ],
        ),
      ],
    );
  }

  // Plan Sciences Humaines
  ActionPlanModel _getHumanitiesPlan(String userId) {
    return ActionPlanModel(
      userId: userId,
      domain: 'Sciences Humaines',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      steps: [
        ActionStep(
          stepNumber: 1,
          icon: 'psychology_outlined',
          title: 'Explorer les programmes en sciences humaines',
          deadline: 'Dans les 2 prochaines semaines',
          description: 'Psychologie, sociologie, anthropologie...',
          tasks: [
            TaskItem(
              id: 'hum_task1_1',
              title: 'Identifier les universités spécialisées',
              isCompleted: false,
            ),
            TaskItem(
              id: 'hum_task1_2',
              title: 'Comparer les programmes de recherche',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 2,
          icon: 'menu_book_outlined',
          title: 'Approfondir vos connaissances',
          deadline: 'Au cours des 4 prochains mois',
          description: 'Lectures et recherches théoriques',
          tasks: [
            TaskItem(
              id: 'hum_task2_1',
              title: 'Lire les auteurs classiques de votre domaine',
              isCompleted: false,
            ),
            TaskItem(
              id: 'hum_task2_2',
              title: 'Participer à des conférences académiques',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 3,
          icon: 'edit_note_outlined',
          title: 'Développer vos compétences de recherche',
          deadline: 'Au cours des 5 prochains mois',
          description: 'Méthodes de recherche et rédaction',
          tasks: [
            TaskItem(
              id: 'hum_task3_1',
              title: 'Rédiger un mémoire de recherche',
              isCompleted: false,
            ),
            TaskItem(
              id: 'hum_task3_2',
              title: 'Assister un chercheur en tant que bénévole',
              isCompleted: false,
            ),
          ],
        ),
      ],
    );
  }

  // Plan Arts & Design
  ActionPlanModel _getArtsPlan(String userId) {
    return ActionPlanModel(
      userId: userId,
      domain: 'Arts & Design',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      steps: [
        ActionStep(
          stepNumber: 1,
          icon: 'palette_outlined',
          title: 'Explorer les écoles d\'art',
          deadline: 'Dans les 3 prochaines semaines',
          description: 'Design graphique, beaux-arts, design industriel...',
          tasks: [
            TaskItem(
              id: 'art_task1_1',
              title: 'Visiter les portfolios d\'anciens élèves',
              isCompleted: false,
            ),
            TaskItem(
              id: 'art_task1_2',
              title: 'Comparer les programmes et spécialisations',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 2,
          icon: 'brush_outlined',
          title: 'Construire votre portfolio',
          deadline: 'Au cours des 4 prochains mois',
          description: 'Créez un portfolio professionnel',
          tasks: [
            TaskItem(
              id: 'art_task2_1',
              title: 'Réaliser 10 projets créatifs variés',
              isCompleted: false,
            ),
            TaskItem(
              id: 'art_task2_2',
              title: 'Créer un site web pour votre portfolio',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 3,
          icon: 'color_lens_outlined',
          title: 'Développer vos compétences techniques',
          deadline: 'En continu',
          description: 'Maîtrisez les outils du design',
          tasks: [
            TaskItem(
              id: 'art_task3_1',
              title: 'Maîtriser Adobe Creative Suite',
              isCompleted: false,
            ),
            TaskItem(
              id: 'art_task3_2',
              title: 'Participer à des concours de design',
              isCompleted: false,
            ),
          ],
        ),
      ],
    );
  }

  // Plan par défaut
  ActionPlanModel _getDefaultPlan(String userId, String domain) {
    return ActionPlanModel(
      userId: userId,
      domain: domain,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      steps: [
        ActionStep(
          stepNumber: 1,
          icon: 'search_outlined',
          title: 'Rechercher les programmes',
          deadline: 'Dans les 2 prochaines semaines',
          description: 'Identifiez les meilleures opportunités',
          tasks: [
            TaskItem(
              id: 'default_task1_1',
              title: 'Lister 5 universités ou écoles',
              isCompleted: false,
            ),
            TaskItem(
              id: 'default_task1_2',
              title: 'Vérifier les dates limites',
              isCompleted: false,
            ),
          ],
        ),
        ActionStep(
          stepNumber: 2,
          icon: 'school_outlined',
          title: 'Préparer votre candidature',
          deadline: 'Au cours des 3 prochains mois',
          description: 'Rassemblez tous les documents nécessaires',
          tasks: [
            TaskItem(
              id: 'default_task2_1',
              title: 'Demander vos relevés de notes',
              isCompleted: false,
            ),
            TaskItem(
              id: 'default_task2_2',
              title: 'Rédiger votre lettre de motivation',
              isCompleted: false,
            ),
          ],
        ),
      ],
    );
  }

  // ============================================
  //  HELPERS - Conversion icônes
  // ============================================
  IconData getIconData(String iconName) {
    final icons = {
      'search_outlined': Icons.search_outlined,
      'trending_up_outlined': Icons.trending_up_outlined,
      'description_outlined': Icons.description_outlined,
      'people_outline': Icons.people_outline,
      'school_outlined': Icons.school_outlined,
      'calculate_outlined': Icons.calculate_outlined,
      'engineering_outlined': Icons.engineering_outlined,
      'groups_outlined': Icons.groups_outlined,
      'local_hospital_outlined': Icons.local_hospital_outlined,
      'science_outlined': Icons.science_outlined,
      'volunteer_activism_outlined': Icons.volunteer_activism_outlined,
      'business_outlined': Icons.business_outlined,
      'account_balance_outlined': Icons.account_balance_outlined,
      'work_outline': Icons.work_outline,
      'psychology_outlined': Icons.psychology_outlined,
      'menu_book_outlined': Icons.menu_book_outlined,
      'edit_note_outlined': Icons.edit_note_outlined,
      'palette_outlined': Icons.palette_outlined,
      'brush_outlined': Icons.brush_outlined,
      'color_lens_outlined': Icons.color_lens_outlined,
    };
    return icons[iconName] ?? Icons.help_outline;
  }
}