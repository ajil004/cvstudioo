import 'package:flutter/material.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String activeRoute;
  final VoidCallback onToggleTheme;
  final bool isDark;

  const AppNavbar({
    super.key,
    required this.activeRoute,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 850;

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (width > 1200 ? 64 : 24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand Logo
          InkWell(
            onTap: () => _navigate(context, '/'),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'CV',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'CV Studio',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'PRO',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2563EB),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Online Resume Platform',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Desktop Navigation Links
          if (!isMobile)
            Row(
              children: [
                _navLink(context, 'Home', '/'),
                _navLink(context, 'Resume Builder', '/builder'),
                _navLink(context, 'Templates', '/templates'),
                _navLink(context, 'About', '/about'),
                _navLink(context, 'Contact', '/contact'),
              ],
            ),

          // Actions: Theme toggle & CTA button
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  size: 20,
                  color: isDark ? Colors.white70 : const Color(0xFF475569),
                ),
                tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                onPressed: onToggleTheme,
              ),
              const SizedBox(width: 8),
              if (!isMobile)
                ElevatedButton.icon(
                  icon: const Icon(Icons.bolt, size: 16),
                  label: const Text('Create My Resume'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _navigate(context, '/builder'),
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _openMobileMenu(context),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navLink(BuildContext context, String title, String route) {
    final isActive = activeRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: () => _navigate(context, route),
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive
                  ? const Color(0xFF2563EB)
                  : (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155)),
            ),
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, String route) {
    if (activeRoute != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _mobileItem(ctx, 'Home', '/', Icons.home_outlined),
                _mobileItem(ctx, 'Resume Builder', '/builder', Icons.edit_document),
                _mobileItem(ctx, 'Templates (25+)', '/templates', Icons.grid_view),
                _mobileItem(ctx, 'About CV Studio', '/about', Icons.info_outline),
                _mobileItem(ctx, 'Contact Us', '/contact', Icons.mail_outline),
                _mobileItem(ctx, 'Privacy Policy', '/privacy', Icons.security),
                _mobileItem(ctx, 'Terms of Use', '/terms', Icons.description_outlined),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _navigate(context, '/builder');
                  },
                  child: const Text('Create My Resume Now'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mobileItem(BuildContext context, String title, String route, IconData icon) {
    final isActive = activeRoute == route;
    return ListTile(
      leading: Icon(icon, color: isActive ? const Color(0xFF2563EB) : null),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color: isActive ? const Color(0xFF2563EB) : null,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _navigate(context, route);
      },
    );
  }
}
