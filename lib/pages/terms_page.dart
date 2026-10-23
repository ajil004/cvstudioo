import 'package:flutter/material.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';

class TermsPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const TermsPage({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Scaffold(
      appBar: AppNavbar(
        activeRoute: '/terms',
        onToggleTheme: onToggleTheme,
        isDark: isDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Page Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 64,
                vertical: 48,
              ),
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'LEGAL AGREEMENT',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2563EB),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Terms of Service',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Last Updated: 2026 • Please Read These Terms Carefully',
                        style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Terms Content
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 64,
                vertical: 48,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _termsSection(
                        '1. Acceptance of Terms',
                        'By accessing or using CV Studio ("the platform", "we", "our"), you agree to be bound by these Terms of Service ("Terms") and our Privacy Policy. If you do not agree with any part of these terms, you should immediately discontinue using the website.',
                      ),
                      _termsSection(
                        '2. Description of the Service',
                        'CV Studio provides a free, client-side online resume builder that enables users to draft, format, customize, and export professional resumes in vector PDF and JSON formats. All core editing and document generation operations take place locally within your web browser.',
                      ),
                      _termsSection(
                        '3. User Responsibility & Content Accuracy',
                        'You are solely responsible for the authenticity, truthfulness, and accuracy of all career information, work histories, employment dates, academic credentials, and skills you input into CV Studio. CV Studio is a document formatting tool and does not independently verify, endorse, or validate any user-provided content.',
                      ),
                      _termsSection(
                        '4. Permitted and Acceptable Use',
                        'You agree to use CV Studio strictly for lawful personal or professional career advancement purposes. You must not:\n\n'
                        '• Use the platform to generate fraudulent, deceptive, or misleading resumes, diplomas, or credentials.\n'
                        '• Attempt to disrupt, compromise, or circumvent the integrity, security, or availability of the website.\n'
                        '• Use automated bots, scrapers, or scripts to overburden our static infrastructure.',
                      ),
                      _termsSection(
                        '5. Intellectual Property Rights',
                        '• Your Content: You retain 100% full ownership, rights, and copyright to the resume content, text, and personal information you create and export through CV Studio.\n\n'
                        '• Platform IP: The design system, software source code, branding, logos, layout templates, typography arrangements, and graphical assets of CV Studio are the exclusive intellectual property of CV Studio and are protected under applicable intellectual property laws.',
                      ),
                      _termsSection(
                        '6. Disclaimer of Employment & Screening Outcomes',
                        'While CV Studio designs its templates to comply with single-column, machine-readable ATS guidelines, hiring practices and applicant tracking algorithms differ significantly between employers. CV Studio makes no representation or warranty that using our templates will result in job interviews, job offers, or successful automated parsing by any specific employer or recruiting portal.',
                      ),
                      _termsSection(
                        '7. Disclaimer of Warranties ("AS IS")',
                        'CV Studio is provided on an "AS IS" and "AS AVAILABLE" basis without warranties of any kind, whether express, implied, or statutory, including but not limited to warranties of merchantability, fitness for a particular purpose, and non-infringement. We do not warrant that the website will operate uninterrupted or error-free.',
                      ),
                      _termsSection(
                        '8. Limitation of Liability',
                        'To the maximum extent permitted by applicable law, in no event shall CV Studio, its developers, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including loss of profits, career opportunities, data, or goodwill, arising out of or related to your use of or inability to use the platform.',
                      ),
                      _termsSection(
                        '9. Third-Party Services and Advertisements',
                        'CV Studio may integrate third-party services (such as Google Fonts) and display third-party advertisements (such as Google AdSense). We do not control or endorse external third-party websites or services linked to or advertised through the platform. Your interactions with third-party services are subject to the terms and policies of those respective third parties.',
                      ),
                      _termsSection(
                        '10. Changes to These Terms',
                        'We reserve the right to revise or update these Terms of Service at any time. Any changes will become effective immediately upon posting to this page, with the updated "Last Updated" date reflecting the change. Continued use of CV Studio constitutes acceptance of the modified Terms.',
                      ),
                      _termsSection(
                        '11. Contact Information',
                        'If you have questions, comments, or legal notices concerning these Terms of Service, please reach out to us:\n\n'
                        '• Email: ajilarun004@gmail.com\n'
                        '• Platform: CV Studio Online Resume Platform\n'
                        '• Support Hours: Monday – Friday, 9:00 AM – 6:00 PM IST',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _termsSection(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(fontSize: 14.5, height: 1.65, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
