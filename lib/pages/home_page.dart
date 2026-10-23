import 'package:flutter/material.dart';
import '../models/template_info.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const HomePage({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 850;

    return Scaffold(
      appBar: AppNavbar(
        activeRoute: '/',
        onToggleTheme: onToggleTheme,
        isDark: isDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HERO SECTION
            _buildHero(context, isMobile),

            // 2. FEATURE HIGHLIGHTS (25+ Templates, ATS Analysis, etc.)
            _buildFeatures(context, isMobile),

            // 3. THREE-STEP PROCESS SECTION
            _buildThreeSteps(context, isMobile),

            // 4. SAMPLE RESUME PREVIEW SHOWCASE
            _buildSampleShowcase(context, isMobile),

            // 5. FAQ SECTION
            _buildFaq(context, isMobile),

            // 6. BOTTOM CTA
            _buildBottomCta(context, isMobile),

            // 7. FOOTER
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: isMobile ? 48 : 80,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2563EB).withOpacity(0.2)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, size: 14, color: Color(0xFF2563EB)),
                    SizedBox(width: 6),
                    Text(
                      'Free & 100% In-Browser • Zero Backend Required',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Hero Heading
              Text(
                'Build a Professional Resume\nin Minutes.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 34 : 54,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                  letterSpacing: -1.2,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 20),

              // Subheading
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  'Create a professional resume tailored to stand out to recruiters. Choose from 25+ industry-crafted templates, customize details with real-time live preview, and download professional vector PDFs instantly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 18,
                    height: 1.6,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Action Buttons
              Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.bolt, size: 18),
                    label: const Text('Create My Resume'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/builder'),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.grid_view, size: 18),
                    label: const Text('Explore Templates'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDark ? Colors.white : const Color(0xFF0F172A),
                      side: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/templates'),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Stats / Trust bar
              Wrap(
                spacing: 32,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _heroStat('25+', 'Tailored Templates'),
                  _heroStat('100%', 'ATS Parsing Safe'),
                  _heroStat('0ms', 'Server Delay (Local)'),
                  _heroStat('Vector', 'Searchable PDF Export'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _heroStat(String number, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF2563EB),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const Text(
                'WHY CV STUDIO?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2563EB),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Engineered to Outperform Generic Builders',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _featureCard(
                    context,
                    icon: Icons.grid_on_outlined,
                    title: '25+ ATS-Safe Templates',
                    description:
                        'From Software Developer to Healthcare and Executive leadership. Every template adheres strictly to single-column, machine-readable ATS guidelines.',
                  ),
                  _featureCard(
                    context,
                    icon: Icons.brush_outlined,
                    title: 'Customizable Designs',
                    description:
                        'Personalize accent colors, typography sizing, margins, and section order with real-time responsive updates.',
                  ),
                  _featureCard(
                    context,
                    icon: Icons.lightbulb_outline,
                    title: 'Actionable Improvement Tips',
                    description:
                        'Get precise suggestions with Before-and-After examples. Jump directly to weak bullet points and elevate them with strong action verbs.',
                  ),
                  _featureCard(
                    context,
                    icon: Icons.picture_as_pdf_outlined,
                    title: 'Clean Vector PDF Exports',
                    description:
                        'Generates authentic, selectable, searchable A4 PDFs directly in Dart. No rasterized screenshots, no blurry fonts, and clean multi-page flow.',
                  ),
                  _featureCard(
                    context,
                    icon: Icons.lock_outline,
                    title: '100% Client-Side Privacy',
                    description:
                        'Your personal data never leaves your browser. Stored securely in your browser cache with full support for JSON import and export backups.',
                  ),
                  _featureCard(
                    context,
                    icon: Icons.visibility_outlined,
                    title: 'Live Responsive Preview',
                    description:
                        'Instant side-by-side editing on desktop with real-time updates as you type. Customize accent colors, margins, and typography in one click.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width < 800 ? double.infinity : (width < 1150 ? (width - 160) / 2 : 330.0);

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131B2E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF2563EB), size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreeSteps(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF0B0F19) : const Color(0xFFF1F5F9),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const Text(
                'SIMPLE 3-STEP WORKFLOW',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2563EB),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'From Scratch to Interview-Ready in Minutes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: 32,
                runSpacing: 24,
                children: [
                  _stepCard(
                    step: '01',
                    title: 'Enter Your Details',
                    desc: 'Input your experience, credentials, and achievements into our guided form with live real-time preview.',
                    icon: Icons.edit_note,
                  ),
                  _stepCard(
                    step: '02',
                    title: 'Choose Your Template',
                    desc: 'Select from 25+ modern, clean templates and personalize colors, typography, and styling in real-time.',
                    icon: Icons.palette_outlined,
                  ),
                  _stepCard(
                    step: '03',
                    title: 'Download Your PDF',
                    desc: 'Export a pristine, machine-readable vector A4 PDF ready to upload directly to company portals.',
                    icon: Icons.download_for_offline_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepCard({
    required String step,
    required String title,
    required String desc,
    required IconData icon,
  }) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131B2E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                step,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2563EB),
                ),
              ),
              Icon(icon, color: const Color(0xFF64748B), size: 24),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleShowcase(BuildContext context, bool isMobile) {
    final templates = TemplateInfo.allTemplates.take(4).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const Text(
                'DESIGN SYSTEM',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2563EB),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Explore Sample Resume Formats',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Every template features distinct typography, section hierarchy, and layout structure.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: templates.map((tmpl) {
                  return Container(
                    width: 250,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF131B2E) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Template Thumbnail Mockup
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: tmpl.previewAccent,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(width: 50, height: 4, color: const Color(0xFFCBD5E1)),
                              const SizedBox(height: 12),
                              Container(width: double.infinity, height: 1, color: const Color(0xFFE2E8F0)),
                              const SizedBox(height: 8),
                              Container(width: 90, height: 4, color: const Color(0xFF94A3B8)),
                              const SizedBox(height: 4),
                              Container(width: 140, height: 3, color: const Color(0xFFE2E8F0)),
                              const SizedBox(height: 4),
                              Container(width: 120, height: 3, color: const Color(0xFFE2E8F0)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          tmpl.name,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tmpl.categoryName,
                          style: TextStyle(
                            fontSize: 11,
                            color: tmpl.previewAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(context, '/builder'),
                            child: const Text('Use Template', style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('View All 25+ Templates'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                onPressed: () => Navigator.pushReplacementNamed(context, '/templates'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaq(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const Text(
                'FREQUENTLY ASKED QUESTIONS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2563EB),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Everything You Need to Know',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 36),
              _faqItem(
                question: 'What is an ATS (Applicant Tracking System)?',
                answer:
                    'An Applicant Tracking System is recruitment software used by over 98% of Fortune 500 companies to parse, filter, and rank resumes before a human recruiter ever sees them. Unformatted tables, complex columns, or missing keywords can cause resumes to be discarded automatically.',
              ),
              _faqItem(
                question: 'Are all CV Studio templates ATS-compliant?',
                answer:
                    'Yes! Every CV Studio template follows strict ATS conventions: single-column logical hierarchies, standard section titling, zero nested tables, clean date formatting, and text-based vector PDF compilation.',
              ),
              _faqItem(
                question: 'Is CV Studio free to use?',
                answer:
                    'Yes, CV Studio runs 100% in your browser without any required paid subscriptions, paywalls, or hidden download fees. All core features work directly in client memory.',
              ),
              _faqItem(
                question: 'Where is my resume information stored?',
                answer:
                    'Your data is saved directly in your web browser’s local storage (LocalStorage / IndexedDB). We never upload your personal credentials or resume details to any remote database.',
              ),
              _faqItem(
                question: 'Can I export or backup my resumes?',
                answer:
                    'Yes! You can export your full resume profile as a lightweight JSON file anytime, and import it back seamlessly whenever you want to restore or duplicate it.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _faqItem({required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: isDark ? const Color(0xFF131B2E) : Colors.white,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
        ),
      ),
      child: ExpansionTile(
        shape: const Border(),
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(
            answer,
            style: const TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCta(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1E3A8A),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const Text(
                'Ready to Build Your Winning Resume?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Join thousands of job seekers who scored top candidate interviews with CV Studio.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFBFDBFE),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                icon: const Icon(Icons.bolt, size: 18),
                label: const Text('Start Building Free Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1E3A8A),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Navigator.pushReplacementNamed(context, '/builder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
