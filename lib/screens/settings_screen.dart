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
                ],
              ),
            ),

            // Contenu
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Paramètres et aide',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Gérez votre compte et vos préférences',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Section Compte
                    const Text(
                      'Compte',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildSettingsCard(
                      children: [
                        _buildSettingItem(
                          icon: Icons.refresh,
                          iconColor: const Color(0xFF5B9EF6),
                          title: 'Reprendre le questionnaire',
                          subtitle: 'Mettre à jour vos préférences académiques',
                          onTap: () {
                            Navigator.pushNamed(context, '/questionnaire');
                          },
                        ),
                        const Divider(height: 1),
                        _buildSettingItem(
                          icon: Icons.logout,
                          iconColor: Colors.red,
                          title: 'Se déconnecter',
                          subtitle: 'Se déconnecter de votre compte',
                          onTap: () {
                            _showLogoutDialog(context);
                          },
                          titleColor: Colors.red,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Section Notifications
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildSettingsCard(
                      children: [
                        _buildSwitchItem(
                          icon: Icons.notifications_outlined,
                          iconColor: const Color(0xFF5B9EF6),
                          title: 'Notifications par e-mail',
                          subtitle: 'Recevoir des mises à jour par e-mail',
                          value: _emailNotifications,
                          onChanged: (value) {
                            setState(() {
                              _emailNotifications = value;
                            });
                          },
                        ),
                        const Divider(height: 1),
                        _buildSwitchItem(
                          icon: Icons.notifications_active_outlined,
                          iconColor: const Color(0xFF5B9EF6),
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

                    const SizedBox(height: 32),

                    // Section Aide et Support
                    const Text(
                      'Aide et Support',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildSettingsCard(
                      children: [
                        _buildSettingItem(
                          icon: Icons.help_outline,
                          iconColor: const Color(0xFF5B9EF6),
                          title: 'FAQ',
                          subtitle: 'Questions et réponses courantes',
                          onTap: () {
                            // Navigation vers FAQ
                          },
                        ),
                        const Divider(height: 1),
                        _buildSettingItem(
                          icon: Icons.email_outlined,
                          iconColor: const Color(0xFF5B9EF6),
                          title: 'Contacter l\'assistance',
                          subtitle: 'Bénéficier de l\'aide de notre équipe',
                          onTap: () {
                            // Navigation vers contact
                          },
                        ),
                        const Divider(height: 1),
                        _buildSettingItem(
                          icon: Icons.description_outlined,
                          iconColor: const Color(0xFF5B9EF6),
                          title: 'Conditions d\'utilisation',
                          subtitle: 'Lisez nos termes et conditions',
                          onTap: () {
                            // Navigation vers conditions
                          },
                        ),
                        const Divider(height: 1),
                        _buildSettingItem(
                          icon: Icons.shield_outlined,
                          iconColor: const Color(0xFF5B9EF6),
                          title: 'Politique et confidentialité',
                          subtitle: 'Comment nous protégeons vos données',
                          onTap: () {
                            // Navigation vers politique
                          },
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

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF5B9EF6),
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
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Se déconnecter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Êtes-vous sûr de vouloir vous déconnecter ?',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Annuler',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
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
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Déconnexion',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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