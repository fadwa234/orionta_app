import 'package:flutter/material.dart';
//  AJOUT : Imports Firebase
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';
//  AJOUT : Import de la page d'édition
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // AJOUT : Services Firebase
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  //  AJOUT : Données utilisateur
  UserModel? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  //  NOUVELLE FONCTION : Charger les données utilisateur
  Future<void> _loadUserData() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final userData = await _firestoreService.getUser(user.uid);
        if (mounted) {
          setState(() {
            _currentUser = userData;
            _isLoading = false;
          });
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Erreur chargement utilisateur : $e');
      setState(() => _isLoading = false);
    }
  }

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
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  //  MODIFICATION : Navigation vers EditProfileScreen
                  TextButton.icon(
                    onPressed: () async {
                      // Navigation vers la page de modification
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );

                      // Si la modification a réussi, recharger les données
                      if (result == true) {
                        _loadUserData();
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFF4DD4AC),
                      size: 20,
                    ),
                    label: const Text(
                      'Modifier',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4DD4AC),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenu
            Expanded(
              child: _isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF5B9EF6),
                ),
              )
                  : _currentUser == null
                  ? const Center(
                child: Text(
                  'Aucune donnée utilisateur',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
              )
                  : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mon profil',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Vos informations académiques',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),

                    const SizedBox(height: 32),

                    //  MODIFICATION : Carte Informations personnelles avec données réelles
                    _buildInfoCard(
                      title: 'Informations personnelles',
                      items: {
                        'Prénom': _currentUser!.prenom,
                        'Nom': _currentUser!.nom,
                        'Email': _currentUser!.email,
                        'Université':
                        _currentUser!.universite ?? 'Non spécifiée',
                      },
                    ),

                    const SizedBox(height: 24),

                    //  MODIFICATION : Carte Informations académiques avec données réelles
                    _buildInfoCard(
                      title: 'Informations académiques',
                      items: {
                        'Tranche d\'âge':
                        _currentUser!.age ?? 'Non spécifiée',
                        'Niveau d\'études':
                        _currentUser!.niveauEtudes ?? 'Non spécifié',
                        'Domaine d\'intérêt':
                        _currentUser!.domaineInteret ?? 'Non spécifié',
                        'Date d\'inscription':
                        _formatDate(_currentUser!.createdAt),
                      },
                    ),

                    const SizedBox(height: 32),

                    // Message informatif
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F9FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF5B9EF6).withOpacity(0.3),
                        ),
                      ),
                      child: const Text(
                        'Pour mettre à jour vos préférences académiques, veuillez remplir à nouveau le questionnaire depuis la page des paramètres',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
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

  //  NOUVELLE FONCTION : Formater la date
  String _formatDate(DateTime date) {
    final months = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Widget _buildInfoCard({
    required String title,
    required Map<String, String> items,
  }) {
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ...items.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    entry.value,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF666666),
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