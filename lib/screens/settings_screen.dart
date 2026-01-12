import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // En-tête moderne
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
                      icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF2C3E50), size: 22),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Paramètres',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Carte de profil
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4A90E2).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Utilisateur',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Gérez votre compte et vos préférences',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Section Compte
                    _buildSectionHeader(
                      icon: Icons.account_circle_rounded,
                      title: 'Compte',
                    ),
                    const SizedBox(height: 12),

                    _buildSettingsCard(
                      children: [
                        _buildSettingItem(
                          icon: Icons.refresh_rounded,
                          iconColor: const Color(0xFF4A90E2),
                          iconBgColor: const Color(0xFFE8F4FD),
                          title: 'Reprendre le questionnaire',
                          subtitle: 'Mettre à jour vos préférences académiques',
                          onTap: () {
                            Navigator.pushNamed(context, '/questionnaire');
                          },
                        ),
                        _buildDivider(),
                        _buildSettingItem(
                          icon: Icons.edit_rounded,
                          iconColor: const Color(0xFF9C27B0),
                          iconBgColor: const Color(0xFFF3E5F5),
                          title: 'Modifier le profil',
                          subtitle: 'Changez vos informations personnelles',
                          onTap: () {
                            // Navigation vers modification profil
                          },
                        ),
                        _buildDivider(),
                        _buildSettingItem(
                          icon: Icons.logout_rounded,
                          iconColor: const Color(0xFFE53935),
                          iconBgColor: const Color(0xFFFFEBEE),
                          title: 'Se déconnecter',
                          subtitle: 'Se déconnecter de votre compte',
                          onTap: () {
                            _showLogoutDialog(context);
                          },
                          titleColor: const Color(0xFFE53935),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Section Notifications
                    _buildSectionHeader(
                      icon: Icons.notifications_rounded,
                      title: 'Notifications',
                    ),
                    const SizedBox(height: 12),

                    _buildSettingsCard(
                      children: [
                        _buildSwitchItem(
                          icon: Icons.email_rounded,
                          iconColor: const Color(0xFFFF9800),
                          iconBgColor: const Color(0xFFFFF3E0),
                          title: 'Notifications par e-mail',
                          subtitle: 'Recevoir des mises à jour par e-mail',
                          value: _emailNotifications,
                          onChanged: (value) {
                            setState(() {
                              _emailNotifications = value;
                            });
                          },
                        ),
                        _buildDivider(),
                        _buildSwitchItem(
                          icon: Icons.notifications_active_rounded,
                          iconColor: const Color(0xFF00BCD4),
                          iconBgColor: const Color(0xFFE0F7FA),
                          title: 'Notifications push',
                          subtitle: 'Recevoir des rappels et des mises à jour',
                          value: _pushNotifications,
                          onChanged: (value) {
                            setState(() {
                              _pushNotifications = value;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Section Aide et Support
                    _buildSectionHeader(
                      icon: Icons.help_rounded,
                      title: 'Aide et Support',
                    ),
                    const SizedBox(height: 12),

                    _buildSettingsCard(
                      children: [
                        _buildSettingItem(
                          icon: Icons.quiz_rounded,
                          iconColor: const Color(0xFF4CAF50),
                          iconBgColor: const Color(0xFFE8F5E9),
                          title: 'FAQ',
                          subtitle: 'Questions et réponses courantes',
                          onTap: () {
                            // Navigation vers FAQ
                          },
                        ),
                        _buildDivider(),
                        _buildSettingItem(
                          icon: Icons.support_agent_rounded,
                          iconColor: const Color(0xFFFF5722),
                          iconBgColor: const Color(0xFFFBE9E7),
                          title: 'Contacter l\'assistance',
                          subtitle: 'Bénéficier de l\'aide de notre équipe',
                          onTap: () {
                            // Navigation vers contact
                          },
                        ),
                        _buildDivider(),
                        _buildSettingItem(
                          icon: Icons.description_rounded,
                          iconColor: const Color(0xFF607D8B),
                          iconBgColor: const Color(0xFFECEFF1),
                          title: 'Conditions d\'utilisation',
                          subtitle: 'Lisez nos termes et conditions',
                          onTap: () {
                            // Navigation vers conditions
                          },
                        ),
                        _buildDivider(),
                        _buildSettingItem(
                          icon: Icons.shield_rounded,
                          iconColor: const Color(0xFF3F51B5),
                          iconBgColor: const Color(0xFFE8EAF6),
                          title: 'Politique de confidentialité',
                          subtitle: 'Comment nous protégeons vos données',
                          onTap: () {
                            // Navigation vers politique
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Section À propos
                    _buildSectionHeader(
                      icon: Icons.info_rounded,
                      title: 'À propos',
                    ),
                    const SizedBox(height: 12),

                    _buildSettingsCard(
                      children: [
                        _buildSettingItem(
                          icon: Icons.info_outline_rounded,
                          iconColor: const Color(0xFF4A90E2),
                          iconBgColor: const Color(0xFFE8F4FD),
                          title: 'Version de l\'application',
                          subtitle: 'Version 1.0.0',
                          onTap: () {},
                          showArrow: false,
                        ),
                      ],
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

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4A90E2).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF4A90E2), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3E50),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8ED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: const Color(0xFFF0F0F0),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? titleColor,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? const Color(0xFF2C3E50),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF546E7A),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: const Color(0xFF90A4AE),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF546E7A),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF4A90E2),
              activeTrackColor: const Color(0xFF4A90E2).withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.all(24),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFE53935),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Se déconnecter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          content: const Text(
            'Êtes-vous sûr de vouloir vous déconnecter de votre compte ?',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF546E7A),
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Annuler',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF546E7A),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigation vers WelcomeScreen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Déconnexion',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}