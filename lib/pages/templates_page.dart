import 'package:flutter/material.dart';
import '../models/template_info.dart';
import '../services/storage_service.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';

class TemplatesPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const TemplatesPage({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  TemplateCategory _selectedCategory = TemplateCategory.all;
  String _searchQuery = '';
  bool _atsSafeOnly = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    // Filter templates
    final filteredTemplates = TemplateInfo.allTemplates.where((t) {
      if (_atsSafeOnly && !t.isAtsSafe) return false;
      if (_selectedCategory != TemplateCategory.all && t.category != _selectedCategory) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesName = t.name.toLowerCase().contains(q);
        final matchesDesc = t.description.toLowerCase().contains(q);
        final matchesRec = t.recommendedFor.toLowerCase().contains(q);
        final matchesTags = t.tags.any((tag) => tag.toLowerCase().contains(q));
        if (!matchesName && !matchesDesc && !matchesRec && !matchesTags) {
          return false;
        }
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppNavbar(
        activeRoute: '/templates',
        onToggleTheme: widget.onToggleTheme,
        isDark: widget.isDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 64,
                vertical: 48,
              ),
              color: widget.isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          '25+ ATS-FRIENDLY RESUME TEMPLATES',
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
                        'Templates Crafted to Beat Applicant Tracking Systems',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.w900,
                          color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Each template has its own unique typography, hierarchy, and styling while preserving 100% machine parseability.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Color(0xFF64748B)),
                      ),
                      const SizedBox(height: 28),

                      // Search Bar & ATS Filter
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: isMobile ? double.infinity : 400,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search templates by role (e.g. Flutter, Sales, Finance)...',
                                prefixIcon: const Icon(Icons.search, size: 20),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 18),
                                        onPressed: () => setState(() => _searchQuery = ''),
                                      )
                                    : null,
                              ),
                              onChanged: (val) => setState(() => _searchQuery = val.trim()),
                            ),
                          ),
                          FilterChip(
                            label: const Text('ATS-Safe Only'),
                            selected: _atsSafeOnly,
                            avatar: const Icon(Icons.verified_outlined, size: 16),
                            onSelected: (val) => setState(() => _atsSafeOnly = val),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Category Filter Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: widget.isDark ? const Color(0xFF131B2E) : Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _categoryTab('All Templates (25)', TemplateCategory.all),
                      _categoryTab('Professional', TemplateCategory.professional),
                      _categoryTab('Tech & Engineering', TemplateCategory.tech),
                      _categoryTab('Executive & Leadership', TemplateCategory.executive),
                      _categoryTab('Design & Creative', TemplateCategory.creative),
                      _categoryTab('Academic & Healthcare', TemplateCategory.academicHealthcare),
                      _categoryTab('Entry-Level & Students', TemplateCategory.entryLevel),
                    ],
                  ),
                ),
              ),
            ),

            // Templates Grid
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 48,
                vertical: 40,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: filteredTemplates.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(48),
                          child: Text(
                            'No templates found matching your search criteria.',
                            style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
                          ),
                        )
                      : Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          alignment: WrapAlignment.center,
                          children: filteredTemplates.map((tmpl) {
                            return _buildTemplateCard(tmpl, isMobile);
                          }).toList(),
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

  Widget _categoryTab(String title, TemplateCategory category) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(title),
        selected: isSelected,
        selectedColor: const Color(0xFF2563EB),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : (widget.isDark ? Colors.white70 : const Color(0xFF334155)),
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          fontSize: 13,
        ),
        onSelected: (val) {
          if (val) setState(() => _selectedCategory = category);
        },
      ),
    );
  }

  Widget _buildTemplateCard(TemplateInfo tmpl, bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : 360,
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF131B2E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visual Mockup of Template
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(
                bottom: BorderSide(
                  color: widget.isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
                ),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110,
                      height: 10,
                      decoration: BoxDecoration(
                        color: tmpl.previewAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    if (tmpl.isAtsSafe)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check, size: 10, color: Color(0xFF10B981)),
                            SizedBox(width: 2),
                            Text(
                              'ATS Safe',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(width: 70, height: 5, color: const Color(0xFF94A3B8)),
                const SizedBox(height: 14),
                Container(width: double.infinity, height: 1.5, color: tmpl.previewAccent.withOpacity(0.4)),
                const SizedBox(height: 12),
                Container(width: 90, height: 6, color: const Color(0xFF64748B)),
                const SizedBox(height: 6),
                Container(width: double.infinity, height: 4, color: const Color(0xFFE2E8F0)),
                const SizedBox(height: 4),
                Container(width: 220, height: 4, color: const Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Container(width: 100, height: 6, color: const Color(0xFF64748B)),
                const SizedBox(height: 6),
                Container(width: 180, height: 4, color: const Color(0xFFE2E8F0)),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        tmpl.name,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: tmpl.previewAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tmpl.categoryName,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: tmpl.previewAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  tmpl.description,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Recommended for: ${tmpl.recommendedFor}',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                    color: widget.isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: tmpl.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(tag, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),

                // Button: Use Template
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _useTemplate(tmpl.id),
                    child: const Text('Use Template in Builder', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _useTemplate(String templateId) async {
    final resume = await StorageService.loadActiveResume();
    final updated = resume.copyWith(templateId: templateId);
    await StorageService.saveActiveResume(updated);
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/builder');
    }
  }
}
