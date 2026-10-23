import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/resume_data.dart';
import '../models/template_info.dart';

class ResumeDocumentRenderer extends StatelessWidget {
  final ResumeData resume;
  final double scale;

  const ResumeDocumentRenderer({
    super.key,
    required this.resume,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final template = TemplateInfo.getById(resume.templateId);
    final accentColor = Color(resume.accentColorValue);
    final fontScale = resume.fontSizeScale.clamp(0.85, 1.25);

    // Font styling according to template and user preference
    TextStyle baseStyle;
    final selectedFont = resume.fontFamily.isNotEmpty ? resume.fontFamily : template.fontFamily;
    switch (selectedFont.toLowerCase()) {
      case 'merriweather':
        baseStyle = GoogleFonts.merriweather();
        break;
      case 'lato':
        baseStyle = GoogleFonts.lato();
        break;
      case 'roboto':
        baseStyle = GoogleFonts.roboto();
        break;
      case 'poppins':
        baseStyle = GoogleFonts.poppins();
        break;
      default:
        baseStyle = GoogleFonts.inter();
    }

    return Container(
      width: 794 * scale, // Standard A4 width in pixels at 96 DPI
      constraints: BoxConstraints(
        minHeight: 1123 * scale, // A4 height
      ),
      padding: EdgeInsets.symmetric(
        horizontal: (36 * resume.spacingScale).clamp(20.0, 50.0) * scale,
        vertical: (36 * resume.spacingScale).clamp(20.0, 50.0) * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: baseStyle.copyWith(
          color: const Color(0xFF1E293B),
          fontSize: 13 * fontScale * scale,
          height: 1.45,
        ),
        child: _buildTemplateLayout(context, template, accentColor, baseStyle, fontScale * scale),
      ),
    );
  }

  Widget _buildTemplateLayout(
    BuildContext context,
    TemplateInfo template,
    Color accentColor,
    TextStyle font,
    double fontScale,
  ) {
    // Determine template-specific section hierarchy
    final isCompletelyEmpty = resume.fullName.trim().isEmpty &&
        resume.jobTitle.trim().isEmpty &&
        resume.summary.trim().isEmpty &&
        resume.experience.isEmpty &&
        resume.education.isEmpty &&
        resume.technicalSkills.isEmpty &&
        resume.projects.isEmpty;

    if (isCompletelyEmpty) {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 80 * fontScale),
          padding: EdgeInsets.all(32 * fontScale),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFCBD5E1),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_note_outlined, size: 48 * fontScale, color: accentColor),
              SizedBox(height: 12 * fontScale),
              Text(
                'Live Resume Preview',
                style: font.copyWith(
                  fontSize: 18 * fontScale,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 6 * fontScale),
              Text(
                'Start entering your information in the builder form to see your resume formatted live in the ${template.name} template.',
                textAlign: TextAlign.center,
                style: font.copyWith(
                  fontSize: 12 * fontScale,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<String> effectiveSectionOrder = List<String>.from(resume.sectionOrder);

    // Section prioritization according to domain archetype
    if (template.id == 'student' || template.id == 'internship') {
      // Education first
      effectiveSectionOrder.remove('education');
      effectiveSectionOrder.insert(0, 'education');
    } else if (template.id == 'fresher') {
      // Skills & Projects first
      effectiveSectionOrder.remove('skills');
      effectiveSectionOrder.remove('projects');
      effectiveSectionOrder.insert(0, 'projects');
      effectiveSectionOrder.insert(0, 'skills');
    } else if (template.id == 'academic' || template.id == 'research') {
      // Education & Publications first
      effectiveSectionOrder.remove('publications');
      effectiveSectionOrder.remove('education');
      effectiveSectionOrder.insert(0, 'education');
      final expIdx = effectiveSectionOrder.indexOf('experience');
      if (expIdx >= 0) {
        effectiveSectionOrder.insert(expIdx + 1, 'publications');
      }
    } else if (template.id == 'software_developer' ||
        template.id == 'flutter_developer' ||
        template.id == 'ios_developer' ||
        template.id == 'web_developer') {
      // Skills & Projects prominent
      effectiveSectionOrder.remove('skills');
      final summaryIdx = effectiveSectionOrder.indexOf('summary');
      effectiveSectionOrder.insert(summaryIdx >= 0 ? summaryIdx + 1 : 0, 'skills');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. TEMPLATE SPECIFIC HEADER
        _buildHeader(template, accentColor, font, fontScale),

        SizedBox(height: 14 * fontScale),

        // 2. TEMPLATE SPECIFIC CALLOUT BANNERS (Executive Competencies, Mobile Badges, etc.)
        _buildSpecializedBanner(template, accentColor, font, fontScale),

        // 3. SECTIONS ACCORDING TO REORDERING & VISIBILITY
        ...effectiveSectionOrder.map((sectionKey) {
          if (resume.enabledSections[sectionKey] == false) {
            return const SizedBox.shrink();
          }
          return _buildSectionByKey(sectionKey, template, accentColor, font, fontScale);
        }),
      ],
    );
  }

  Widget _buildHeader(
    TemplateInfo template,
    Color accentColor,
    TextStyle font,
    double fontScale,
  ) {
    final name = resume.fullName.trim();
    final title = resume.jobTitle.trim();

    final contactParts = <String>[];
    if (resume.email.isNotEmpty) contactParts.add(resume.email);
    if (resume.phone.isNotEmpty) contactParts.add(resume.phone);
    if (resume.location.isNotEmpty) contactParts.add(resume.location);

    final linkParts = <String>[];
    if (resume.linkedIn.isNotEmpty) linkParts.add(resume.linkedIn);
    if (resume.gitHub.isNotEmpty) linkParts.add(resume.gitHub);
    if (resume.portfolioUrl.isNotEmpty) linkParts.add(resume.portfolioUrl);

    // Template-specific header styling
    switch (template.id) {
      // 1. Classic Professional (Centered, Serif, Classic Rule)
      case 'classic_professional':
      case 'finance':
        return Column(
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: font.copyWith(
                fontSize: 26 * fontScale,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
                letterSpacing: 0.5,
              ),
            ),
            if (title.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4 * fontScale),
                child: Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: font.copyWith(
                    fontSize: 12 * fontScale,
                    letterSpacing: 1.5,
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Text(
              [...contactParts, ...linkParts].join('  •  '),
              textAlign: TextAlign.center,
              style: font.copyWith(
                fontSize: 10 * fontScale,
                color: const Color(0xFF475569),
              ),
            ),
            SizedBox(height: 8 * fontScale),
            Divider(color: const Color(0xFF0F172A), thickness: 1.5 * scale),
          ],
        );

      // 3. Minimalist
      case 'minimalist':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: font.copyWith(
                fontSize: 28 * fontScale,
                fontWeight: FontWeight.w300,
                color: const Color(0xFF0F172A),
                letterSpacing: 0.8,
              ),
            ),
            Text(
              title,
              style: font.copyWith(
                fontSize: 12.5 * fontScale,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 6 * fontScale),
            Text(
              [...contactParts, ...linkParts].join('  |  '),
              style: font.copyWith(
                fontSize: 9.5 * fontScale,
                color: const Color(0xFF94A3B8),
              ),
            ),
            SizedBox(height: 8 * fontScale),
            Divider(color: const Color(0xFFE2E8F0), thickness: 1 * scale),
          ],
        );

      // 4. Corporate (Solid dark accent banner)
      case 'corporate':
        return Container(
          padding: EdgeInsets.all(16 * fontScale),
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: font.copyWith(
                  fontSize: 26 * fontScale,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2 * fontScale),
              Text(
                title.toUpperCase(),
                style: font.copyWith(
                  fontSize: 12 * fontScale,
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 8 * fontScale),
              Text(
                [...contactParts, ...linkParts].join('  |  '),
                style: font.copyWith(
                  fontSize: 9.5 * fontScale,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        );

      // 5. Executive (Board level, authoritative)
      case 'executive':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: font.copyWith(
                          fontSize: 28 * fontScale,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F2B48),
                        ),
                      ),
                      Text(
                        title.toUpperCase(),
                        style: font.copyWith(
                          fontSize: 13 * fontScale,
                          fontWeight: FontWeight.w700,
                          color: accentColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (contactParts.isNotEmpty)
                      Text(
                        contactParts.join('  •  '),
                        style: font.copyWith(
                          fontSize: 9.5 * fontScale,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    if (linkParts.isNotEmpty)
                      Text(
                        linkParts.join('  •  '),
                        style: font.copyWith(
                          fontSize: 9.5 * fontScale,
                          color: const Color(0xFF475569),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8 * fontScale),
            Container(height: 3 * scale, color: const Color(0xFF0F2B48)),
          ],
        );

      // 8, 9, 10, 11 (Tech Developer templates)
      case 'software_developer':
      case 'flutter_developer':
      case 'ios_developer':
      case 'web_developer':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: font.copyWith(
                          fontSize: 26 * fontScale,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 2 * fontScale),
                      Text(
                        title,
                        style: font.copyWith(
                          fontSize: 13 * fontScale,
                          fontWeight: FontWeight.w600,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10 * fontScale,
                    vertical: 4 * fontScale,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    template.name.toUpperCase(),
                    style: font.copyWith(
                      fontSize: 9 * fontScale,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8 * fontScale),
            Wrap(
              spacing: 12 * fontScale,
              runSpacing: 4 * fontScale,
              children: [...contactParts, ...linkParts].map((item) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_right, size: 14 * fontScale, color: accentColor),
                    Text(
                      item,
                      style: font.copyWith(
                        fontSize: 9.5 * fontScale,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 8 * fontScale),
            Divider(color: accentColor.withValues(alpha: 0.3), thickness: 1 * scale),
          ],
        );

      // 13. UI/UX Designer
      case 'ui_ux_designer':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 27 * fontScale,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 13 * fontScale,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF7C3AED),
                      ),
                    ),
                  ],
                ),
                if (resume.portfolioUrl.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Portfolio: ${resume.portfolioUrl}',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF7C3AED)),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8 * fontScale),
            Text(
              contactParts.join('  •  '),
              style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF64748B)),
            ),
            SizedBox(height: 8 * fontScale),
            Container(height: 2.5 * scale, color: const Color(0xFF7C3AED)),
          ],
        );

      // 20, 21. Academic & Research
      case 'academic':
      case 'research':
        return Column(
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: font.copyWith(
                fontSize: 26 * fontScale,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: font.copyWith(
                fontSize: 12 * fontScale,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF475569),
              ),
            ),
            SizedBox(height: 4 * fontScale),
            Text(
              [...contactParts, ...linkParts].join('  •  '),
              textAlign: TextAlign.center,
              style: font.copyWith(
                fontSize: 9.5 * fontScale,
                color: const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 8 * fontScale),
            Divider(color: const Color(0xFF334155), thickness: 1 * scale),
          ],
        );

      // Default (Modern Professional and remaining templates)
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: font.copyWith(
                fontSize: 26 * fontScale,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 2 * fontScale),
            Text(
              title,
              style: font.copyWith(
                fontSize: 13 * fontScale,
                fontWeight: FontWeight.w600,
                color: accentColor,
              ),
            ),
            SizedBox(height: 6 * fontScale),
            Wrap(
              spacing: 14 * fontScale,
              runSpacing: 4 * fontScale,
              children: [...contactParts, ...linkParts].map((item) {
                return Text(
                  item,
                  style: font.copyWith(
                    fontSize: 9.5 * fontScale,
                    color: const Color(0xFF475569),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10 * fontScale),
            Container(height: 2 * scale, color: accentColor),
          ],
        );
    }
  }

  Widget _buildSpecializedBanner(
    TemplateInfo template,
    Color accentColor,
    TextStyle font,
    double fontScale,
  ) {
    if (template.id == 'executive') {
      return Container(
        margin: EdgeInsets.only(bottom: 12 * fontScale),
        padding: EdgeInsets.all(10 * fontScale),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            const Icon(Icons.stars, color: Color(0xFF0F2B48), size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'CORE LEADERSHIP COMPETENCIES: Visionary Roadmapping • P&L Management • Enterprise Architecture • Executive Stakeholder Alignment',
                style: font.copyWith(
                  fontSize: 8.5 * fontScale,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F2B48),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (template.id == 'flutter_developer') {
      return Container(
        margin: EdgeInsets.only(bottom: 10 * fontScale),
        padding: EdgeInsets.symmetric(horizontal: 10 * fontScale, vertical: 6 * fontScale),
        decoration: BoxDecoration(
          color: const Color(0xFF02569B).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(Icons.phone_iphone, size: 14, color: Color(0xFF02569B)),
            const SizedBox(width: 6),
            Text(
              'SPECIALTY: Cross-Platform Mobile & Web Apps • MVVM / BLoC • High-FPS Rendering • Native Channel Integration',
              style: font.copyWith(fontSize: 8.5 * fontScale, fontWeight: FontWeight.bold, color: const Color(0xFF02569B)),
            ),
          ],
        ),
      );
    } else if (template.id == 'data_analyst') {
      return Container(
        margin: EdgeInsets.only(bottom: 10 * fontScale),
        padding: EdgeInsets.symmetric(horizontal: 10 * fontScale, vertical: 6 * fontScale),
        decoration: BoxDecoration(
          color: const Color(0xFF059669).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(Icons.bar_chart, size: 14, color: Color(0xFF059669)),
            const SizedBox(width: 6),
            Text(
              'ANALYTICS STACK: SQL • Python • ETL Pipelines • Business Intelligence • Statistical Modeling • Data Visualization',
              style: font.copyWith(fontSize: 8.5 * fontScale, fontWeight: FontWeight.bold, color: const Color(0xFF059669)),
            ),
          ],
        ),
      );
    } else if (template.id == 'healthcare') {
      return Container(
        margin: EdgeInsets.only(bottom: 10 * fontScale),
        padding: EdgeInsets.symmetric(horizontal: 10 * fontScale, vertical: 6 * fontScale),
        decoration: BoxDecoration(
          color: const Color(0xFF0E7490).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(Icons.medical_services_outlined, size: 14, color: Color(0xFF0E7490)),
            const SizedBox(width: 6),
            Text(
              'CLINICAL CREDENTIALS: State Board Licensed • HIPAA Compliant • Patient Care Excellence • EHR Systems',
              style: font.copyWith(fontSize: 8.5 * fontScale, fontWeight: FontWeight.bold, color: const Color(0xFF0E7490)),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSectionHeading(
    String title,
    TemplateInfo template,
    Color accentColor,
    TextStyle font,
    double fontScale,
  ) {
    switch (template.id) {
      case 'classic_professional':
      case 'finance':
      case 'academic':
      case 'research':
        return Padding(
          padding: EdgeInsets.only(top: 14 * fontScale, bottom: 4 * fontScale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: font.copyWith(
                  fontSize: 11.5 * fontScale,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 2 * fontScale),
              Divider(color: const Color(0xFF94A3B8), thickness: 1 * scale),
            ],
          ),
        );

      case 'minimalist':
        return Padding(
          padding: EdgeInsets.only(top: 14 * fontScale, bottom: 4 * fontScale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: font.copyWith(
                  fontSize: 11 * fontScale,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 2 * fontScale),
              Divider(color: const Color(0xFFE2E8F0), thickness: 0.8 * scale),
            ],
          ),
        );

      case 'corporate':
        return Container(
          margin: EdgeInsets.only(top: 14 * fontScale, bottom: 6 * fontScale),
          padding: EdgeInsets.symmetric(horizontal: 8 * fontScale, vertical: 3 * fontScale),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            border: Border(left: BorderSide(color: accentColor, width: 4 * scale)),
          ),
          child: Text(
            title.toUpperCase(),
            style: font.copyWith(
              fontSize: 11 * fontScale,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
              color: const Color(0xFF0F172A),
            ),
          ),
        );

      case 'executive':
        return Padding(
          padding: EdgeInsets.only(top: 14 * fontScale, bottom: 6 * fontScale),
          child: Row(
            children: [
              Text(
                title.toUpperCase(),
                style: font.copyWith(
                  fontSize: 12 * fontScale,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: const Color(0xFF0F2B48),
                ),
              ),
              SizedBox(width: 8 * fontScale),
              Expanded(
                child: Container(height: 1 * scale, color: const Color(0xFFCBD5E1)),
              ),
            ],
          ),
        );

      default:
        return Padding(
          padding: EdgeInsets.only(top: 14 * fontScale, bottom: 6 * fontScale),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 3 * scale,
                height: 14 * fontScale,
                color: accentColor,
              ),
              SizedBox(width: 6 * fontScale),
              Text(
                title.toUpperCase(),
                style: font.copyWith(
                  fontSize: 11.5 * fontScale,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: accentColor,
                ),
              ),
              SizedBox(width: 8 * fontScale),
              Expanded(
                child: Container(
                  height: 1 * scale,
                  color: accentColor.withValues(alpha: 0.18),
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildSectionByKey(
    String key,
    TemplateInfo template,
    Color accentColor,
    TextStyle font,
    double fontScale,
  ) {
    switch (key) {
      case 'summary':
        if (resume.summary.trim().isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Professional Summary', template, accentColor, font, fontScale),
            Padding(
              padding: EdgeInsets.only(top: 2 * fontScale),
              child: Text(
                resume.summary,
                style: font.copyWith(
                  fontSize: 10 * fontScale,
                  color: const Color(0xFF334155),
                  height: 1.5,
                ),
              ),
            ),
          ],
        );

      case 'experience':
        if (resume.experience.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Work Experience', template, accentColor, font, fontScale),
            ...resume.experience.map((exp) {
              final dateRange = [
                if (exp.startDate.isNotEmpty) exp.startDate,
                if (exp.isCurrent) 'Present' else if (exp.endDate.isNotEmpty) exp.endDate,
              ].join(' – ');

              return Padding(
                padding: EdgeInsets.only(bottom: 10 * fontScale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            exp.jobTitle,
                            style: font.copyWith(
                              fontSize: 11 * fontScale,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (dateRange.isNotEmpty)
                          Text(
                            dateRange,
                            style: font.copyWith(
                              fontSize: 9.5 * fontScale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          exp.company,
                          style: font.copyWith(
                            fontSize: 10 * fontScale,
                            fontWeight: FontWeight.w500,
                            color: accentColor,
                          ),
                        ),
                        if (exp.location.isNotEmpty)
                          Text(
                            exp.location,
                            style: font.copyWith(
                              fontSize: 9 * fontScale,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                      ],
                    ),
                    if (exp.description.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 3 * fontScale),
                        child: _buildBulletList(exp.description, font, 9.5 * fontScale),
                      ),
                  ],
                ),
              );
            }),
          ],
        );

      case 'education':
        if (resume.education.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Education', template, accentColor, font, fontScale),
            ...resume.education.map((edu) {
              final dateRange = [
                if (edu.startDate.isNotEmpty) edu.startDate,
                if (edu.endDate.isNotEmpty) edu.endDate,
              ].join(' – ');

              return Padding(
                padding: EdgeInsets.only(bottom: 8 * fontScale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            edu.degree,
                            style: font.copyWith(
                              fontSize: 10.5 * fontScale,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (dateRange.isNotEmpty)
                          Text(
                            dateRange,
                            style: font.copyWith(
                              fontSize: 9 * fontScale,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          edu.institution + (edu.location.isNotEmpty ? ', ${edu.location}' : ''),
                          style: font.copyWith(
                            fontSize: 9.5 * fontScale,
                            color: const Color(0xFF475569),
                          ),
                        ),
                        if (edu.grade.isNotEmpty)
                          Text(
                            edu.grade,
                            style: font.copyWith(
                              fontSize: 9 * fontScale,
                              fontWeight: FontWeight.w600,
                              color: accentColor,
                            ),
                          ),
                      ],
                    ),
                    if (edu.coursework.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 1 * fontScale),
                        child: Text(
                          'Relevant Coursework: ${edu.coursework}',
                          style: font.copyWith(
                            fontSize: 8.5 * fontScale,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        );

      case 'skills':
        final hasSkills = resume.technicalSkills.isNotEmpty ||
            resume.softSkills.isNotEmpty ||
            resume.toolsAndTechnologies.isNotEmpty;
        if (!hasSkills) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Skills & Competencies', template, accentColor, font, fontScale),
            if (resume.technicalSkills.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 4 * fontScale),
                child: RichText(
                  text: TextSpan(
                    style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF334155)),
                    children: [
                      TextSpan(
                        text: 'Technical Skills: ',
                        style: font.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      TextSpan(text: resume.technicalSkills.join(' • ')),
                    ],
                  ),
                ),
              ),
            if (resume.toolsAndTechnologies.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 4 * fontScale),
                child: RichText(
                  text: TextSpan(
                    style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF334155)),
                    children: [
                      TextSpan(
                        text: 'Tools & Cloud: ',
                        style: font.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      TextSpan(text: resume.toolsAndTechnologies.join(' • ')),
                    ],
                  ),
                ),
              ),
            if (resume.softSkills.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 4 * fontScale),
                child: RichText(
                  text: TextSpan(
                    style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF334155)),
                    children: [
                      TextSpan(
                        text: 'Core Competencies: ',
                        style: font.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      TextSpan(text: resume.softSkills.join(' • ')),
                    ],
                  ),
                ),
              ),
          ],
        );

      case 'projects':
        if (resume.projects.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Featured Projects', template, accentColor, font, fontScale),
            ...resume.projects.map((proj) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8 * fontScale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            proj.title,
                            style: font.copyWith(
                              fontSize: 10.5 * fontScale,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (proj.projectUrl.isNotEmpty)
                          Text(
                            proj.projectUrl,
                            style: font.copyWith(
                              fontSize: 9 * fontScale,
                              color: accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                    if (proj.technologies.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1 * fontScale),
                        child: Text(
                          proj.technologies.join(' | '),
                          style: font.copyWith(
                            fontSize: 8.5 * fontScale,
                            color: const Color(0xFF64748B),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    if (proj.description.isNotEmpty)
                      Text(
                        proj.description,
                        style: font.copyWith(
                          fontSize: 9.5 * fontScale,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    if (proj.achievements.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 2 * fontScale),
                        child: Text(
                          '• ${proj.achievements}',
                          style: font.copyWith(
                            fontSize: 9 * fontScale,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        );

      case 'certifications':
        if (resume.certifications.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Certifications', template, accentColor, font, fontScale),
            ...resume.certifications.map((cert) {
              return Padding(
                padding: EdgeInsets.only(bottom: 4 * fontScale),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF0F172A)),
                          children: [
                            TextSpan(text: cert.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            if (cert.issuer.isNotEmpty)
                              TextSpan(
                                text: ' — ${cert.issuer}',
                                style: const TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF475569)),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (cert.date.isNotEmpty)
                      Text(
                        cert.date,
                        style: font.copyWith(fontSize: 8.5 * fontScale, color: const Color(0xFF64748B)),
                      ),
                  ],
                ),
              );
            }),
          ],
        );

      case 'languages':
        if (resume.languages.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Languages', template, accentColor, font, fontScale),
            Text(
              resume.languages.map((l) => '${l.language} (${l.proficiency})').join('  •  '),
              style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF334155)),
            ),
          ],
        );

      case 'awards':
        if (resume.awards.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Honors & Awards', template, accentColor, font, fontScale),
            ...resume.awards.map((award) {
              return Padding(
                padding: EdgeInsets.only(bottom: 4 * fontScale),
                child: Text(
                  '• ${award.title}${award.issuer.isNotEmpty ? ' (${award.issuer})' : ''}: ${award.description}',
                  style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF334155)),
                ),
              );
            }),
          ],
        );

      case 'volunteer':
        if (resume.volunteerWork.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Volunteer Work', template, accentColor, font, fontScale),
            ...resume.volunteerWork.map((vol) {
              return Padding(
                padding: EdgeInsets.only(bottom: 4 * fontScale),
                child: Text(
                  '• ${vol.role} at ${vol.organization}: ${vol.description}',
                  style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF334155)),
                ),
              );
            }),
          ],
        );

      case 'publications':
        if (resume.publications.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading('Publications', template, accentColor, font, fontScale),
            ...resume.publications.map((pub) {
              return Padding(
                padding: EdgeInsets.only(bottom: 4 * fontScale),
                child: Text(
                  '• "${pub.title}", ${pub.publisher} (${pub.date}). ${pub.description}',
                  style: font.copyWith(fontSize: 9.5 * fontScale, color: const Color(0xFF334155)),
                ),
              );
            }),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBulletList(String rawText, TextStyle font, double fontSize) {
    final lines = rawText.split('\n').where((l) => l.trim().isNotEmpty).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        final cleanLine = line.trim().startsWith('•') || line.trim().startsWith('-')
            ? line.trim().substring(1).trim()
            : line.trim();
        return Padding(
          padding: const EdgeInsets.only(bottom: 2.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 12,
                child: Text(
                  '•',
                  style: font.copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  cleanLine,
                  style: font.copyWith(
                    fontSize: fontSize,
                    color: const Color(0xFF334155),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
