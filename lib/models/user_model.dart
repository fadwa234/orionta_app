class UserModel {
  final String uid;
  final String email;
  final String prenom;
  final String nom;
  final String? universite;
  final String? age;
  final String? niveauEtudes;
  final String? domaineInteret;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.prenom,
    required this.nom,
    this.universite,
    this.age,
    this.niveauEtudes,
    this.domaineInteret,
    required this.createdAt,
  });

  // Convertir vers Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'prenom': prenom,
      'nom': nom,
      'universite': universite,
      'age': age,
      'niveauEtudes': niveauEtudes,
      'domaineInteret': domaineInteret,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // 🔥 CORRECTION : Créer depuis Map Firestore avec type explicite
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String? ?? '',
      email: map['email'] as String? ?? '',
      prenom: map['prenom'] as String? ?? '',
      nom: map['nom'] as String? ?? '',
      universite: map['universite'] as String?,
      age: map['age'] as String?,
      niveauEtudes: map['niveauEtudes'] as String?,
      domaineInteret: map['domaineInteret'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}