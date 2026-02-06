import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

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
                    'Conditions d\'utilisation',
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
                          colors: [Color(0xFF607D8B), Color(0xFF546E7A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF607D8B).withOpacity(0.3),
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
                              Icons.description_rounded,
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
                                  'Conditions d\'utilisation',
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
                      title: '1. Acceptation des conditions',
                      content:
                      'En utilisant Orionta, vous acceptez d\'être lié par ces conditions d\'utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser notre application.',
                    ),

                    _buildSection(
                      title: '2. Description du service',
                      content:
                      'Orionta est une plateforme d\'orientation académique qui fournit des recommandations personnalisées basées sur vos réponses à un questionnaire. Le service comprend l\'analyse de vos préférences, la génération de recommandations de formations et l\'accès à des ressources d\'orientation.',
                    ),

                    _buildSection(
                      title: '3. Utilisation du service',
                      content:
                      'Vous vous engagez à utiliser Orionta uniquement à des fins légales et conformément à ces conditions. Vous ne devez pas :\n\n'
                          '• Utiliser le service de manière frauduleuse ou malveillante\n'
                          '• Tenter d\'accéder à des comptes autres que le vôtre\n'
                          '• Perturber ou interférer avec le fonctionnement du service\n'
                          '• Utiliser le service pour distribuer du contenu illégal',
                    ),

                    _buildSection(
                      title: '4. Compte utilisateur',
                      content:
                      'Vous êtes responsable de maintenir la confidentialité de vos identifiants de connexion. Vous acceptez de nous informer immédiatement de toute utilisation non autorisée de votre compte.',
                    ),

                    _buildSection(
                      title: '5. Propriété intellectuelle',
                      content:
                      'Tout le contenu disponible sur Orionta, y compris les textes, graphiques, logos, et logiciels, est la propriété d\'Orionta ou de ses concédants de licence et est protégé par les lois sur la propriété intellectuelle.',
                    ),

                    _buildSection(
                      title: '6. Recommandations',
                      content:
                      'Les recommandations fournies par Orionta sont générées algorithmiquement et doivent être utilisées comme guide d\'orientation. Nous ne garantissons pas l\'exactitude, l\'exhaustivité ou l\'adéquation des recommandations pour vos besoins spécifiques. Vous devriez toujours consulter des conseillers d\'orientation professionnels pour prendre des décisions importantes concernant votre parcours académique.',
                    ),

                    _buildSection(
                      title: '7. Limitation de responsabilité',
                      content:
                      'Orionta est fourni "tel quel" sans garantie d\'aucune sorte. Nous ne serons pas responsables des dommages directs, indirects, accessoires ou consécutifs résultant de l\'utilisation ou de l\'impossibilité d\'utiliser notre service.',
                    ),

                    _buildSection(
                      title: '8. Modifications du service',
                      content:
                      'Nous nous réservons le droit de modifier, suspendre ou interrompre le service à tout moment, avec ou sans préavis. Nous ne serons pas responsables envers vous ou envers des tiers de toute modification, suspension ou interruption du service.',
                    ),

                    _buildSection(
                      title: '9. Résiliation',
                      content:
                      'Nous pouvons résilier ou suspendre votre accès au service immédiatement, sans préavis ni responsabilité, pour quelque raison que ce soit, y compris en cas de violation de ces conditions.',
                    ),

                    _buildSection(
                      title: '10. Modifications des conditions',
                      content:
                      'Nous nous réservons le droit de modifier ces conditions à tout moment. Les modifications entreront en vigueur dès leur publication sur l\'application. Votre utilisation continue du service après de telles modifications constitue votre acceptation des nouvelles conditions.',
                    ),

                    _buildSection(
                      title: '11. Loi applicable',
                      content:
                      'Ces conditions sont régies par les lois du Maroc. Tout litige découlant de ces conditions sera soumis à la juridiction exclusive des tribunaux marocains.',
                    ),

                    _buildSection(
                      title: '12. Contact',
                      content:
                      'Pour toute question concernant ces conditions d\'utilisation, veuillez nous contacter à :\n\n'
                          'Email : legal@orionta.com\n'
                          'Adresse : [Votre adresse]\n'
                          'Téléphone : +212 5XX-XXXXXX',
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
                            'Des questions sur nos conditions ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C3E50),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Notre équipe est disponible pour vous aider',
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
}