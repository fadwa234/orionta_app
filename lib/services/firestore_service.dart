import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/questionnaire_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collections Firestore
  final String _usersCollection = 'users';
  final String _questionnairesCollection = 'questionnaires';

  // ============================
  // USERS MANAGEMENT
  // ============================

  // Create a user
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection(_usersCollection).doc(user.uid).set(user.toMap());
      print('Utilisateur créé dans Firestore : ${user.uid}');
    } catch (e) {
      print('Erreur création utilisateur : $e');
      rethrow;
    }
  }

  // Get a user
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection(_usersCollection).doc(uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()! as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Erreur récupération utilisateur : $e');
      rethrow;
    }
  }

  // Update a user
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection(_usersCollection).doc(uid).update(data);
      print('Utilisateur mis à jour : $uid');
    } catch (e) {
      print('Erreur mise à jour utilisateur : $e');
      rethrow;
    }
  }

  // Delete a user
  Future<void> deleteUser(String uid) async {
    try {
      await _db.collection(_usersCollection).doc(uid).delete();
      print('Utilisateur supprimé : $uid');
    } catch (e) {
      print('Erreur suppression utilisateur : $e');
      rethrow;
    }
  }

  // ============================
  // QUESTIONNAIRES MANAGEMENT
  // ============================

  // Save a questionnaire
  Future<void> saveQuestionnaire(QuestionnaireModel questionnaire) async {
    try {
      await _db
          .collection(_questionnairesCollection)
          .doc(questionnaire.userId)
          .set(questionnaire.toMap());
      print('Questionnaire sauvegardé : ${questionnaire.userId}');
    } catch (e) {
      print('Erreur sauvegarde questionnaire : $e');
      rethrow;
    }
  }

  // Get a questionnaire
  Future<QuestionnaireModel?> getQuestionnaire(String userId) async {
    try {
      DocumentSnapshot doc =
      await _db.collection(_questionnairesCollection).doc(userId).get();

      if (doc.exists && doc.data() != null) {
        return QuestionnaireModel.fromMap(doc.data()! as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Erreur récupération questionnaire : $e');
      rethrow;
    }
  }

  // Update a questionnaire
  Future<void> updateQuestionnaire(
      String userId, Map<String, dynamic> data) async {
    try {
      await _db.collection(_questionnairesCollection).doc(userId).update(data);
      print('Questionnaire mis à jour : $userId');
    } catch (e) {
      print('Erreur mise à jour questionnaire : $e');
      rethrow;
    }
  }

  // ============================
  // ADVANCED QUERIES
  // ============================

  // Get all users (admin)
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection(_usersCollection).get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()! as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Erreur récupération utilisateurs : $e');
      rethrow;
    }
  }

  // Get users by domain
  Future<List<UserModel>> getUsersByDomain(String domain) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection(_usersCollection)
          .where('domaineInteret', isEqualTo: domain)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()! as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Erreur recherche par domaine : $e');
      rethrow;
    }
  }

  // Stream real-time user
  Stream<UserModel?> streamUser(String uid) {
    return _db.collection(_usersCollection).doc(uid).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()! as Map<String, dynamic>);
      }
      return null;
    });
  }
}
