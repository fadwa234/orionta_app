import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  //  Obtenir l'utilisateur actuel
  User? get currentUser => _auth.currentUser;

  //  Stream de l'état d'authentification
  Stream get authStateChanges => _auth.authStateChanges();

  //  INSCRIPTION avec email et mot de passe
  Future signUpWithEmail({
    required String email,
    required String password,
    required String prenom,
    required String nom,
    String? universite,
    String? age,
    String? niveauEtudes,
    String? domaineInteret,
  }) async {
    try {
      // 1. Créer le compte Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Créer le modèle utilisateur
      UserModel newUser = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        prenom: prenom,
        nom: nom,
        universite: universite,
        age: age,
        niveauEtudes: niveauEtudes,
        domaineInteret: domaineInteret,
        createdAt: DateTime.now(),
      );

      // 3. Sauvegarder dans Firestore
      await _firestoreService.createUser(newUser);

      print(' Inscription réussie : ${newUser.email}');
      return newUser;
    } on FirebaseAuthException catch (e) {
      print(' Erreur inscription : ${e.code}');
      throw _handleAuthException(e);
    } catch (e) {
      print(' Erreur inattendue : $e');
      rethrow;
    }
  }

  //  CONNEXION avec email et mot de passe
  Future signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Connexion Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Récupérer les données Firestore
      UserModel? user = await _firestoreService.getUser(userCredential.user!.uid);

      print(' Connexion réussie : ${user?.email}');
      return user;
    } on FirebaseAuthException catch (e) {
      print(' Erreur connexion : ${e.code}');
      throw _handleAuthException(e);
    } catch (e) {
      print(' Erreur inattendue : $e');
      rethrow;
    }
  }

  // 🚪 DÉCONNEXION
  Future signOut() async {
    try {
      await _auth.signOut();
      print(' Déconnexion réussie');
    } catch (e) {
      print(' Erreur déconnexion : $e');
      rethrow;
    }
  }

  //  RÉINITIALISATION du mot de passe
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print(' Email de réinitialisation envoyé à : $email');
    } on FirebaseAuthException catch (e) {
      print(' Erreur réinitialisation : ${e.code}');
      throw _handleAuthException(e);
    }
  }

  //  Gestion des erreurs Firebase Auth
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Le mot de passe est trop faible (min. 6 caractères)';
      case 'email-already-in-use':
        return 'Cette adresse e-mail est déjà utilisée';
      case 'invalid-email':
        return 'Adresse e-mail invalide';
      case 'user-not-found':
        return 'Aucun compte ne correspond à cette adresse e-mail';
      case 'wrong-password':
        return 'Mot de passe incorrect';
      case 'user-disabled':
        return 'Ce compte a été désactivé';
      case 'too-many-requests':
        return 'Trop de tentatives. Réessayez plus tard';
      case 'operation-not-allowed':
        return 'Opération non autorisée';
      default:
        return 'Une erreur est survenue : ${e.message}';
    }
  }
}