import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'Qu\'est-ce qu\'Orionta ?',
      'answer':
      'Orionta est une plateforme d\'orientation académique qui vous aide à découvrir les formations et les parcours qui correspondent le mieux à vos intérêts, compétences et objectifs professionnels.',
    },
    {
      'question': 'Comment fonctionne le questionnaire d\'orientation ?',
      'answer':
      'Notre questionnaire analyse vos préférences, votre environnement d\'apprentissage idéal, vos motivations et votre vision du futur pour vous proposer des recommandations personnalisées de formations et de parcours académiques.',
    },
    {
      'question': 'Puis-je refaire le questionnaire ?',
      'answer':
      'Oui, vous pouvez refaire le questionnaire à tout moment depuis la page Paramètres. Vos nouvelles réponses remplaceront les anciennes et vous recevrez de nouvelles recommandations adaptées.',
    },
    {
      'question': 'Comment sont générées les recommandations ?',
      'answer':
      'Nos recommandations sont générées en analysant vos réponses au questionnaire et en les comparant avec des milliers de profils académiques et professionnels. L\'algorithme prend en compte vos intérêts, compétences et objectifs pour vous suggérer les parcours les plus pertinents.',
    },
    {
      'question': 'Mes données personnelles sont-elles protégées ?',
      'answer':
      'Oui, nous prenons la protection de vos données très au sérieux. Toutes vos informations sont stockées de manière sécurisée et ne sont jamais partagées avec des tiers sans votre consentement. Consultez notre Politique de confidentialité pour plus de détails.',
    },
    {
      'question': 'L\'application est-elle gratuite ?',
      'answer':
      'Oui, Orionta est entièrement gratuite. Notre mission est de rendre l\'orientation académique accessible à tous les étudiants.',
    },
    {
      'question': 'Puis-je modifier mes informations personnelles ?',
      'answer':
      'Oui, vous pouvez modifier vos informations personnelles à tout moment depuis votre page Profil en cliquant sur le bouton "Modifier".',
    },
    {
      'question': 'Comment puis-je contacter le support ?',
      'answer':
      'Vous pouvez nous contacter via la page "Contacter l\'assistance" disponible dans Paramètres > Aide et Support. Notre équipe vous répondra dans les 24-48 heures.',
    },
    {
      'question': 'Les recommandations sont-elles garanties ?',
      'answer':
      'Les recommandations fournies par Orionta sont basées sur des algorithmes d\'analyse et doivent être utilisées comme guide d\'orientation. Nous vous encourageons à faire vos propres recherches et à consulter des conseillers d\'orientation pour prendre vos décisions finales.',
    },
    {
      'question': 'Comment puis-je supprimer mon compte ?',
      'answer':
      'Pour supprimer votre compte, veuillez contacter notre support via la page "Contacter l\'assistance". Nous traiterons votre demande dans les plus brefs délais.',
    },
  ];

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
                    'FAQ',
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
                          colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4CAF50).withOpacity(0.3),
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
                              Icons.quiz_rounded,
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
                                  'Questions fréquentes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Trouvez rapidement des réponses',
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

                    // Liste des FAQ
                    ...List.generate(_faqs.length, (index) {
                      final faq = _faqs[index];
                      final isExpanded = _expandedIndex == index;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isExpanded
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFE1E8ED),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _expandedIndex = isExpanded ? null : index;
                              });
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8F5E9),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.help_outline_rounded,
                                          color: Color(0xFF4CAF50),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          faq['question']!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: isExpanded
                                                ? const Color(0xFF4CAF50)
                                                : const Color(0xFF2C3E50),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons.keyboard_arrow_down_rounded,
                                        color: const Color(0xFF4CAF50),
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                  if (isExpanded) ...[
                                    const SizedBox(height: 12),
                                    Container(
                                      height: 1,
                                      color: const Color(0xFFF0F0F0),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      faq['answer']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF546E7A),
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 16),

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
                            Icons.support_agent_rounded,
                            color: Color(0xFF5B9EF6),
                            size: 40,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Vous n\'avez pas trouvé de réponse ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C3E50),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Notre équipe d\'assistance est là pour vous aider',
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
                            label: const Text('Contacter l\'assistance'),
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
}