import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF090D16) : const Color(0xFF0F172A),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : (width > 1200 ? 64 : 32),
        vertical: 48,
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 48,
            runSpacing: 32,
            alignment: WrapAlignment.spaceBetween,
            children: [
              // Column 1: Brand & Tagline
              SizedBox(
                width: isMobile ? double.infinity : 340,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Text(
                              'CV',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'CV Studio',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Build Your Resume. Improve Your Score. Get Career-Ready.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF93C5FD),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Modern, ATS-friendly browser-based resume builder engineered to pass enterprise recruitment screening systems. 100% private and in-browser.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF94A3B8),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Column 2: Navigation Links
              _footerColumn(
                context,
                title: 'Product',
                links: [
                  _FooterItem('Resume Builder', '/builder'),
                  _FooterItem('25+ Templates Gallery', '/templates'),
                ],
              ),

              // Column 3: Legal & Privacy
              _footerColumn(
                context,
                title: 'Company & Legal',
                links: [
                  _FooterItem('About CV Studio', '/about'),
                  _FooterItem('Contact Us', '/contact'),
                  _FooterItem('Privacy Policy', '/privacy'),
                  _FooterItem('Terms of Use', '/terms'),
                ],
              ),

              // Column 4: Privacy & Security Badge
              SizedBox(
                width: isMobile ? double.infinity : 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Zero Data Tracking',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF334155)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.shield_outlined, color: Color(0xFF10B981), size: 18),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'All resumes stay in your browser. We never upload your personal details or sell candidate data.',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFFCBD5E1),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 36),
          const Divider(color: Color(0xFF1E293B), thickness: 1),
          const SizedBox(height: 24),

          // Bottom Bar
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  '© 2026 CV Studio. Engineered with Flutter & Dart.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _bottomTextLink(context, 'Privacy', '/privacy'),
                    const SizedBox(width: 16),
                    _bottomTextLink(context, 'Terms', '/terms'),
                    const SizedBox(width: 16),
                    _bottomTextLink(context, 'Contact', '/contact'),
                    const SizedBox(width: 16),
                    _bottomTextLink(context, 'Templates', '/templates'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _footerColumn(
    BuildContext context, {
    required String title,
    required List<_FooterItem> links,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ...links.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () {
                if (item.route == 'contact_dialog') {
                  _showContactDialog(context);
                } else {
                  Navigator.pushReplacementNamed(context, item.route);
                }
              },
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF94A3B8),
                  height: 1.4,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  static void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.mail_outline, color: Color(0xFF2563EB)),
            SizedBox(width: 10),
            Text('Contact CV Studio Team'),
          ],
        ),
        content: const SizedBox(
          width: 440,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Have questions, template suggestions, or feedback?',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              SizedBox(height: 12),
              Text(
                'Email: ajilarun004@gmail.com\n'
                'Hours: Monday – Friday, 9:00 AM – 6:00 PM IST',
                style: TextStyle(fontSize: 13, height: 1.6, color: Color(0xFF64748B)),
              ),
              SizedBox(height: 14),
              Text(
                'CV Studio is an open, client-side web application. All core features work locally inside your browser without backend dependencies.',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static Widget _bottomTextLink(BuildContext context, String title, String route) {
    return InkWell(
      onTap: () {
        if (route == 'contact_dialog') {
          _showContactDialog(context);
        } else {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }
}

class _FooterItem {
  final String title;
  final String route;
  _FooterItem(this.title, this.route);
}
