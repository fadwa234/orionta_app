class QuestionnaireModel {
  final String userId;
  final String? workPreference;
  final String? learningEnvironment;
  final String? motivation;
  final String? futureVision;
  final DateTime completedAt;

  QuestionnaireModel({
    required this.userId,
    this.workPreference,
    this.learningEnvironment,
    this.motivation,
    this.futureVision,
    required this.completedAt,
  });

  // Convertir vers Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'workPreference': workPreference,
      'learningEnvironment': learningEnvironment,
      'motivation': motivation,
      'futureVision': futureVision,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  // 🔥 CORRECTION : Créer depuis Map Firestore avec type explicite
  factory QuestionnaireModel.fromMap(Map<String, dynamic> map) {
    return QuestionnaireModel(
      userId: map['userId'] as String? ?? '',
      workPreference: map['workPreference'] as String?,
      learningEnvironment: map['learningEnvironment'] as String?,
      motivation: map['motivation'] as String?,
      futureVision: map['futureVision'] as String?,
      completedAt: DateTime.parse(map['completedAt'] as String),
    );
  }
}