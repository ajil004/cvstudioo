import 'package:flutter/material.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';

class PrivacyPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const PrivacyPage({
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
        activeRoute: '/privacy',
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
                          color: const Color(0xFF10B981).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'TRANSPARENT PRIVACY POLICY',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF059669),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Last Updated: 2026 • Your Data Privacy Matters to Us',
                        style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Policy Content
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
                      _privacySection(
                        '1. Overview and Core Privacy Commitment',
                        'CV Studio ("we", "our", or "the platform") is dedicated to providing an accessible, private, and secure resume-building experience. We believe candidate career information should remain strictly under your control. Unlike many online resume builders, CV Studio is architected so that your resume content is processed locally within your web browser.',
                      ),
                      _privacySection(
                        '2. Information We Collect and How It Is Handled',
                        '• Information You Provide: When you use the Resume Builder, you enter professional information such as your name, contact details, work experience, education, skills, and projects. This information is saved solely in your browser’s local storage (LocalStorage and IndexedDB). It is never sent to, collected by, or stored on external application servers.\n\n'
                        '• Contact Inquiries: If you contact us via email or our contact form, we collect the details you provide (such as your name, email address, and message) strictly to respond to your inquiry. We never share or sell contact information.',
                      ),
                      _privacySection(
                        '3. Browser-Based Local Storage & Device Persistence',
                        'Because your resume information is stored directly on your own device and browser:\n'
                        '• Your data does not automatically sync across different devices or browsers.\n'
                        '• You can use the "Export JSON" feature in the builder to create an offline, encrypted backup file that you can transfer securely to another device.\n'
                        '• Clearing your browser cache or site data will remove saved resume drafts from your device.',
                      ),
                      _privacySection(
                        '4. Client-Side PDF Compilation',
                        'All resume PDF documents are generated in-memory using an embedded vector PDF engine running directly inside your browser tab. Your resume text, structure, and formatting are never uploaded to any remote server or external rendering API for PDF conversion.',
                      ),
                      _privacySection(
                        '5. Third-Party Services and Content Delivery',
                        'To deliver a high-quality web experience, CV Studio integrates the following third-party services:\n\n'
                        '• Google Fonts: We use Google Fonts to render typography cleanly and consistently across devices. When your browser loads fonts, standard HTTP requests may be made to Google servers (fonts.googleapis.com and fonts.gstatic.com).\n\n'
                        '• Static Web Hosting: CV Studio is hosted on modern secure static web infrastructure (such as GitHub Pages). Static hosting providers may log standard web request information (such as IP addresses and browser user-agent strings) for server maintenance, security, and uptime monitoring.',
                      ),
                      _privacySection(
                        '6. Advertising, Google AdSense & Cookies Policy',
                        'To maintain CV Studio as a free tool for job seekers, we support the display of advertisements served by Google AdSense and third-party advertising partners.\n\n'
                        '• Google AdSense Disclosures: Third-party vendors, including Google, use cookies and web beacons to serve ads based on a user’s prior visits to this website or other websites on the Internet.\n\n'
                        '• Personalized Advertising: Google’s use of advertising cookies enables it and its partners to serve ads to users based on their visits to our site and/or other sites across the web.\n\n'
                        '• Opting Out: Users may opt out of personalized advertising at any time by visiting Google Ads Settings (https://adssettings.google.com). Alternatively, you can opt out of third-party vendor use of cookies for personalized advertising by visiting https://www.aboutads.info or https://youradchoices.com.\n\n'
                        '• Cookie Management: You can configure your browser to reject all cookies or notify you when a cookie is placed. Note that core resume building functionality in CV Studio works entirely without advertising cookies.',
                      ),
                      _privacySection(
                        '7. Data Deletion and User Control',
                        'You retain complete control over your data at all times. Since CV Studio stores your resume locally on your machine, you can delete your data at any time by clearing your browser’s site storage or cookies for this website. You can also edit or clear any resume form fields directly in the Resume Builder.',
                      ),
                      _privacySection(
                        '8. Children’s Online Privacy Protection',
                        'CV Studio is intended for individuals seeking employment and career development opportunities. We do not knowingly collect personal information from children under the age of 13. If you believe a child has provided us with personal information, please contact us immediately.',
                      ),
                      _privacySection(
                        '9. Updates to This Privacy Policy',
                        'We may update this Privacy Policy from time to time to reflect changes in our practices or applicable legal and regulatory requirements. Any updates will be posted on this page with an updated "Last Updated" date.',
                      ),
                      _privacySection(
                        '10. Contact Us Regarding Privacy',
                        'If you have any questions, concerns, or requests regarding this Privacy Policy or how your data is handled, please contact us directly:\n\n'
                        '• Email: ajilarun004@gmail.com\n'
                        '• Platform: CV Studio Online Resume Platform\n'
                        '• Operating Hours: Monday – Friday, 9:00 AM – 6:00 PM IST',
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

  Widget _privacySection(String title, String body) {
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
