import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  // Controllers pour les champs
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universiteController = TextEditingController();

  // Données utilisateur
  UserModel? _currentUser;
  bool _isLoading = true;
  bool _isSaving = false;

  // Sélections
  String? _selectedAge;
  String? _selectedNiveauEtudes;
  String? _selectedDomaine;

  // Options d'âge - ALIGNÉES avec SignUpScreen
  final List<String> _ageOptions = [
    '16-18 ans',
    '18-20 ans',
    '19-21 ans',
    '21-22 ans',
    '22-24 ans',
    '23-24 ans',
    '25-27 ans',
    '+25 ans',
    '28+ ans',
  ];

  final List<String> _niveauEtudesOptions = [
    'En fin de lycée',
    'En BAC+2 (DUT/DEUG...)',
    'En licence',
    'En master',
    'Baccalauréat',
    'Licence (L1-L3)',
    'Master (M1-M2)',
    'Doctorat',
    'Autre',
  ];

  final List<String> _domaineOptions = [
    'Sciences et recherche',
    'Informatique et technologies',
    'Économie et commerce',
    'Je ne suis pas encore sûr(e)',
    'Sciences & Technologies',
    'Économie & Gestion',
    'Santé & Médecine',
    'Droit & Sciences Politiques',
    'Arts & Lettres',
    'Ingénierie',
    'Sciences Sociales',
    'Autre',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final userData = await _firestoreService.getUser(user.uid);
        if (userData != null && mounted) {
          setState(() {
            _currentUser = userData;
            _prenomController.text = userData.prenom;
            _nomController.text = userData.nom;
            _emailController.text = userData.email;
            _universiteController.text = userData.universite ?? '';

            //  Vérification pour éviter les erreurs de dropdown
            _selectedAge = _ageOptions.contains(userData.age)
                ? userData.age
                : null;

            _selectedNiveauEtudes = _niveauEtudesOptions.contains(userData.niveauEtudes)
                ? userData.niveauEtudes
                : null;

            _selectedDomaine = _domaineOptions.contains(userData.domaineInteret)
                ? userData.domaineInteret
                : null;

            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Erreur chargement : $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_currentUser == null) return;

    // Validation
    if (_prenomController.text.trim().isEmpty ||
        _nomController.text.trim().isEmpty) {
      _showErrorSnackBar('Le prénom et le nom sont obligatoires');
      return;
    }

    setState(() => _isSaving = true);

    try {
      // Mise à jour dans Firestore
      await _firestoreService.updateUser(
        _currentUser!.uid,
        {
          'prenom': _prenomController.text.trim(),
          'nom': _nomController.text.trim(),
          'universite': _universiteController.text.trim(),
          'age': _selectedAge,
          'niveauEtudes': _selectedNiveauEtudes,
          'domaineInteret': _selectedDomaine,
        },
      );

      if (mounted) {
        _showSuccessSnackBar('Profil mis à jour avec succès !');
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pop(context, true); // Retour avec succès
      }
    } catch (e) {
      _showErrorSnackBar('Erreur lors de la mise à jour : ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFE53935),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    _prenomController.dispose();
    _nomController.dispose();
    _emailController.dispose();
    _universiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF2C3E50),
                        size: 22,
                      ),
                      onPressed: _isSaving ? null : () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Modifier le profil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3E50),
                      letterSpacing: -0.5,
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
                  : SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Informations personnelles
                    _buildSectionTitle('Informations personnelles'),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _prenomController,
                      label: 'Prénom',
                      icon: Icons.person_outline,
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _nomController,
                      label: 'Nom',
                      icon: Icons.person_outline,
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email_outlined,
                      enabled: false,
                      hint: 'L\'email ne peut pas être modifié',
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _universiteController,
                      label: 'Université',
                      icon: Icons.school_outlined,
                      enabled: !_isSaving,
                    ),

                    const SizedBox(height: 32),

                    // Section Informations académiques
                    _buildSectionTitle('Informations académiques'),
                    const SizedBox(height: 16),

                    _buildDropdown(
                      label: 'Tranche d\'âge',
                      icon: Icons.cake_outlined,
                      value: _selectedAge,
                      items: _ageOptions,
                      onChanged: _isSaving
                          ? null
                          : (value) => setState(() => _selectedAge = value),
                    ),
                    const SizedBox(height: 16),

                    _buildDropdown(
                      label: 'Niveau d\'études',
                      icon: Icons.school_outlined,
                      value: _selectedNiveauEtudes,
                      items: _niveauEtudesOptions,
                      onChanged: _isSaving
                          ? null
                          : (value) =>
                          setState(() => _selectedNiveauEtudes = value),
                    ),
                    const SizedBox(height: 16),

                    _buildDropdown(
                      label: 'Domaine d\'intérêt',
                      icon: Icons.interests_outlined,
                      value: _selectedDomaine,
                      items: _domaineOptions,
                      onChanged: _isSaving
                          ? null
                          : (value) =>
                          setState(() => _selectedDomaine = value),
                    ),

                    const SizedBox(height: 40),

                    // Bouton Enregistrer
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B9EF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                          disabledBackgroundColor:
                          const Color(0xFF5B9EF6).withOpacity(0.5),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                            : const Text(
                          'Enregistrer les modifications',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2C3E50),
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    String? hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: enabled
              ? const Color(0xFFE1E8ED)
              : const Color(0xFFE1E8ED).withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: enabled ? const Color(0xFF2C3E50) : const Color(0xFF90A4AE),
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 13,
            color: Color(0xFF90A4AE),
          ),
          prefixIcon: Icon(
            icon,
            color: enabled ? const Color(0xFF5B9EF6) : const Color(0xFF90A4AE),
            size: 22,
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            color: enabled ? const Color(0xFF546E7A) : const Color(0xFF90A4AE),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: onChanged != null
              ? const Color(0xFFE1E8ED)
              : const Color(0xFFE1E8ED).withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: onChanged != null
                ? const Color(0xFF5B9EF6)
                : const Color(0xFF90A4AE),
            size: 22,
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            color: onChanged != null
                ? const Color(0xFF546E7A)
                : const Color(0xFF90A4AE),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: onChanged != null
              ? const Color(0xFF2C3E50)
              : const Color(0xFF90A4AE),
        ),
        dropdownColor: Colors.white,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: onChanged != null
              ? const Color(0xFF5B9EF6)
              : const Color(0xFF90A4AE),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}