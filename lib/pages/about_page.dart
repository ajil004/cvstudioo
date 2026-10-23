import 'package:flutter/material.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';

class AboutPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const AboutPage({
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
        activeRoute: '/about',
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
                          'ABOUT CV STUDIO',
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
                        'Professional, Private, and High-Impact Resumes for Every Career Path',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 26 : 38,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Build Your Resume • Customize Real-Time • Download Free Vector PDFs',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main Content Area
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
                      _sectionTitle('Our Mission & Purpose'),
                      _sectionParagraph(
                        'CV Studio was created with a straightforward goal: provide job seekers, students, career switchers, and seasoned professionals with a modern, free, and privacy-respecting resume builder. In an era where traditional resume builders lock downloads behind recurring subscriptions or sell personal candidate data to recruiters, CV Studio puts users first by executing directly in your browser without paywalls or tracking.',
                      ),
                      const SizedBox(height: 32),

                      _sectionTitle('Who We Serve'),
                      _sectionParagraph(
                        'CV Studio is built for anyone preparing for their next career milestone, including:\n\n'
                        '• Recent Graduates & Students: Create your first professional resume with clear, structured sections for coursework, academic projects, and internships.\n'
                        '• Software Engineers & Tech Professionals: Highlight technical stacks, GitHub projects, system architectures, and engineering impact with clean typography.\n'
                        '• Experienced Executives & Managers: Showcase leadership milestones, measurable revenue growth, and team management accomplishments.\n'
                        '• Career Changers: Emphasize transferable skills, relevant certifications, and achievements tailored to new industries.',
                      ),
                      const SizedBox(height: 32),

                      _sectionTitle('Key Platform Features'),
                      _featureBullet(
                        icon: Icons.edit_note,
                        title: 'Interactive Real-Time Builder',
                        description:
                            'Fill in personal contact details, summaries, work experience, education, skills, certifications, languages, and projects with immediate live visual feedback.',
                      ),
                      const SizedBox(height: 16),
                      _featureBullet(
                        icon: Icons.grid_view,
                        title: '25+ Industry-Tailored Templates',
                        description:
                            'Choose from over 25 professionally crafted resume templates designed according to single-column, machine-readable conventions that recruiters and applicant tracking systems can easily digest.',
                      ),
                      const SizedBox(height: 16),
                      _featureBullet(
                        icon: Icons.palette_outlined,
                        title: 'Deep Customization Options',
                        description:
                            'Personalize accent colors, typography sizes, layout spacing, and margins on the fly to match your personal brand or industry aesthetic.',
                      ),
                      const SizedBox(height: 16),
                      _featureBullet(
                        icon: Icons.picture_as_pdf_outlined,
                        title: 'Crisp Vector PDF Downloads',
                        description:
                            'Export authentic, selectable, searchable A4 vector PDFs generated entirely client-side using an embedded Dart PDF compilation engine. No rasterized text or blurry graphics.',
                      ),
                      const SizedBox(height: 16),
                      _featureBullet(
                        icon: Icons.security,
                        title: '100% In-Browser Privacy',
                        description:
                            'Your resume text, contact details, and career history never leave your computer. Stored securely in your browser local storage with zero server databases collecting your data.',
                      ),
                      const SizedBox(height: 16),
                      _featureBullet(
                        icon: Icons.backup_outlined,
                        title: 'Portable JSON Backup & Restore',
                        description:
                            'Save your resume progress to a lightweight JSON string to backup your data locally or migrate it seamlessly across computers without requiring an account.',
                      ),
                      const SizedBox(height: 36),

                      _sectionTitle('Why Single-Column Machine Readability Matters'),
                      _sectionParagraph(
                        'Modern recruitment workflows rely heavily on enterprise applicant screening software (such as Workday, Greenhouse, Taleo, and Lever) to ingest candidate profiles. Complex multi-column graphic resumes with infographic skill bars, nested tables, or image headers often parse incorrectly, scrambling candidate contact info and work chronologies. Every CV Studio template is engineered with semantic hierarchy, clean headings, standard bullet lists, and standard font encoding to maximize readability by both human recruiters and automated parsers.',
                      ),
                      const SizedBox(height: 36),

                      // CTA Actions
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.bolt, size: 18),
                            label: const Text('Start Building Your Resume'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(context, '/builder'),
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.grid_view, size: 18),
                            label: const Text('Browse 25+ Templates'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(context, '/templates'),
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.mail_outline, size: 18),
                            label: const Text('Contact Our Team'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(context, '/contact'),
                          ),
                        ],
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

  static Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
      ),
    );
  }

  static Widget _sectionParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, height: 1.65, color: Color(0xFF64748B)),
    );
  }

  static Widget _featureBullet({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2563EB).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF2563EB), size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
