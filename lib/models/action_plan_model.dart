import 'package:cloud_firestore/cloud_firestore.dart';

class ActionPlanModel {
  final String userId;
  final String domain;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ActionStep> steps;

  ActionPlanModel({
    required this.userId,
    required this.domain,
    required this.createdAt,
    required this.updatedAt,
    required this.steps,
  });

  // Convertir en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'domain': domain,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'steps': steps.map((step) => step.toMap()).toList(),
    };
  }

  // Créer depuis Map Firestore
  factory ActionPlanModel.fromMap(Map<String, dynamic> map) {
    return ActionPlanModel(
      userId: map['userId'] as String? ?? '',
      domain: map['domain'] as String? ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      steps: (map['steps'] as List<dynamic>?)
          ?.map((stepMap) => ActionStep.fromMap(stepMap as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  // Calculer la progression globale
  double get globalProgress {
    if (steps.isEmpty) return 0.0;
    int totalTasks = 0;
    int completedTasks = 0;

    for (var step in steps) {
      totalTasks += step.tasks.length;
      completedTasks += step.tasks.where((task) => task.isCompleted).length;
    }

    return totalTasks > 0 ? completedTasks / totalTasks : 0.0;
  }

  // Nombre total de tâches
  int get totalTasksCount {
    return steps.fold(0, (sum, step) => sum + step.tasks.length);
  }

  // Nombre de tâches complétées
  int get completedTasksCount {
    return steps.fold(
      0,
          (sum, step) => sum + step.tasks.where((task) => task.isCompleted).length,
    );
  }
}

class ActionStep {
  final int stepNumber;
  final String icon;
  final String title;
  final String deadline;
  final String description;
  final List<TaskItem> tasks;

  ActionStep({
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.deadline,
    required this.description,
    required this.tasks,
  });

  Map<String, dynamic> toMap() {
    return {
      'stepNumber': stepNumber,
      'icon': icon,
      'title': title,
      'deadline': deadline,
      'description': description,
      'tasks': tasks.map((task) => task.toMap()).toList(),
    };
  }

  factory ActionStep.fromMap(Map<String, dynamic> map) {
    return ActionStep(
      stepNumber: map['stepNumber'] as int? ?? 0,
      icon: map['icon'] as String? ?? '',
      title: map['title'] as String? ?? '',
      deadline: map['deadline'] as String? ?? '',
      description: map['description'] as String? ?? '',
      tasks: (map['tasks'] as List<dynamic>?)
          ?.map((taskMap) => TaskItem.fromMap(taskMap as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  // Calculer la progression de l'étape
  double get progress {
    if (tasks.isEmpty) return 0.0;
    int completed = tasks.where((task) => task.isCompleted).length;
    return completed / tasks.length;
  }
}

class TaskItem {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime? completedAt;

  TaskItem({
    required this.id,
    required this.title,
    required this.isCompleted,
    this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
    };
  }

  factory TaskItem.fromMap(Map<String, dynamic> map) {
    return TaskItem(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      isCompleted: map['isCompleted'] as bool? ?? false,
      completedAt: (map['completedAt'] as Timestamp?)?.toDate(),
    );
  }

  // Copier avec modifications
  TaskItem copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}