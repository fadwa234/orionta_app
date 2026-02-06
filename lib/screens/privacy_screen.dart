import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

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
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Politique de confidentialité',
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
                    // Carte d'introduction
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3F51B5), Color(0xFF303F9F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3F51B5).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.shield_rounded,
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
                                  'Votre vie privée compte',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Dernière mise à jour : Janvier 2026',
                                  style: TextStyle(
                                    fontSize: 14,
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

                    _buildSection(
                      title: '1. Introduction',
                      content:
                      'Chez Orionta, nous prenons très au sérieux la protection de vos données personnelles. Cette politique de confidentialité explique comment nous collectons, utilisons, partageons et protégeons vos informations lorsque vous utilisez notre application.',
                    ),

                    _buildSection(
                      title: '2. Informations que nous collectons',
                      content:
                      'Nous collectons les types d\'informations suivants :\n\n'
                          '• Informations de compte : nom, prénom, adresse e-mail, université, niveau d\'études\n'
                          '• Informations académiques : domaine d\'intérêt, âge, préférences d\'apprentissage\n'
                          '• Réponses au questionnaire : vos réponses aux questions d\'orientation\n'
                          '• Données d\'utilisation : comment vous interagissez avec l\'application\n'
                          '• Informations techniques : adresse IP, type d\'appareil, système d\'exploitation',
                    ),

                    _buildSection(
                      title: '3. Comment nous utilisons vos informations',
                      content:
                      'Nous utilisons vos informations pour :\n\n'
                          '• Fournir et personnaliser nos services d\'orientation\n'
                          '• Générer des recommandations académiques adaptées\n'
                          '• Améliorer notre application et nos algorithmes\n'
                          '• Communiquer avec vous concernant votre compte\n'
                          '• Analyser les tendances et statistiques d\'utilisation\n'
                          '• Assurer la sécurité et prévenir la fraude',
                    ),

                    _buildSection(
                      title: '4. Partage de vos informations',
                      content:
                      'Nous ne vendons jamais vos données personnelles. Nous pouvons partager vos informations uniquement dans les cas suivants :\n\n'
                          '• Avec votre consentement explicite\n'
                          '• Avec des prestataires de services qui nous aident à fournir notre service (hébergement, analyse)\n'
                          '• Pour nous conformer à des obligations légales\n'
                          '• Pour protéger nos droits et notre sécurité',
                    ),

                    _buildSection(
                      title: '5. Sécurité des données',
                      content:
                      'Nous mettons en œuvre des mesures de sécurité techniques et organisationnelles appropriées pour protéger vos données :\n\n'
                          '• Chiffrement des données en transit et au repos\n'
                          '• Authentification sécurisée\n'
                          '• Contrôles d\'accès stricts\n'
                          '• Surveillance continue de la sécurité\n'
                          '• Sauvegardes régulières',
                    ),

                    _buildSection(
                      title: '6. Conservation des données',
                      content:
                      'Nous conservons vos données personnelles aussi longtemps que nécessaire pour fournir nos services et nous conformer à nos obligations légales. Vous pouvez demander la suppression de votre compte à tout moment.',
                    ),

                    _buildSection(
                      title: '7. Vos droits',
                      content:
                      'Conformément aux lois sur la protection des données, vous disposez des droits suivants :\n\n'
                          '• Droit d\'accès à vos données personnelles\n'
                          '• Droit de rectification de données inexactes\n'
                          '• Droit de suppression de vos données\n'
                          '• Droit de limitation du traitement\n'
                          '• Droit à la portabilité des données\n'
                          '• Droit d\'opposition au traitement',
                    ),

                    _buildSection(
                      title: '8. Cookies et technologies similaires',
                      content:
                      'Nous utilisons des cookies et des technologies similaires pour améliorer votre expérience, analyser l\'utilisation de l\'application et personnaliser le contenu. Vous pouvez gérer vos préférences en matière de cookies dans les paramètres de votre appareil.',
                    ),

                    _buildSection(
                      title: '9. Protection des mineurs',
                      content:
                      'Notre service est destiné aux utilisateurs de 16 ans et plus. Nous ne collectons pas sciemment d\'informations personnelles auprès d\'enfants de moins de 16 ans sans le consentement parental.',
                    ),

                    _buildSection(
                      title: '10. Transferts internationaux',
                      content:
                      'Vos données peuvent être transférées et stockées dans des pays autres que votre pays de résidence. Nous veillons à ce que ces transferts soient effectués conformément aux lois applicables sur la protection des données.',
                    ),

                    _buildSection(
                      title: '11. Modifications de cette politique',
                      content:
                      'Nous pouvons mettre à jour cette politique de confidentialité de temps en temps. Nous vous informerons de tout changement important en publiant la nouvelle politique sur l\'application et en mettant à jour la date de "dernière mise à jour".',
                    ),

                    _buildSection(
                      title: '12. Contact',
                      content:
                      'Pour toute question concernant cette politique de confidentialité ou pour exercer vos droits, veuillez nous contacter à :\n\n'
                          'Email : privacy@orionta.com\n'
                          'Adresse : [Votre adresse]\n'
                          'Téléphone : +212 5XX-XXXXXX',
                    ),

                    const SizedBox(height: 24),

                    // Garanties de sécurité
                    Container(
                      padding: const EdgeInsets.all(20),
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
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.verified_user_rounded,
                                color: Color(0xFF4CAF50),
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Nos engagements de sécurité',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildSecurityItem(
                            icon: Icons.lock_rounded,
                            text: 'Chiffrement de bout en bout',
                          ),
                          _buildSecurityItem(
                            icon: Icons.security_rounded,
                            text: 'Conformité RGPD',
                          ),
                          _buildSecurityItem(
                            icon: Icons.no_accounts_rounded,
                            text: 'Aucune vente de données',
                          ),
                          _buildSecurityItem(
                            icon: Icons.policy_rounded,
                            text: 'Transparence totale',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Message de contact
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F9FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF5B9EF6).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.help_outline_rounded,
                            color: Color(0xFF5B9EF6),
                            size: 40,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Questions sur vos données ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C3E50),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Nous sommes là pour vous aider',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF546E7A),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/contact');
                            },
                            icon: const Icon(Icons.email_rounded, size: 20),
                            label: const Text('Nous contacter'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5B9EF6),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF546E7A),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF4CAF50),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF546E7A),
              ),
            ),
          ),
          const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF4CAF50),
            size: 18,
          ),
        ],
      ),
    );
  }
}