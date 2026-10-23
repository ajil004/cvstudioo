import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/resume_data.dart';

class PdfService {
  /// Generate text-based, searchable, multi-page vector PDF
  static Future<Uint8List> generateResumePdf(ResumeData resume) async {
    final pdf = pw.Document(
      title: '${resume.fullName} - Resume',
      author: resume.fullName,
      creator: 'CV Studio — https://cvstudio.dev',
    );

    // Accent color from resume settings
    final accentColor = PdfColor.fromInt(resume.accentColorValue);
    final textDark = PdfColor.fromInt(0xFF0F172A);
    final textMuted = PdfColor.fromInt(0xFF475569);
    final dividerColor = PdfColor.fromInt(0xFFE2E8F0);

    // Base font scale
    final scale = resume.fontSizeScale.clamp(0.85, 1.25);
    final nameSize = 22.0 * scale;
    final titleSize = 12.0 * scale;
    final headingSize = 11.5 * scale;
    final bodySize = 9.5 * scale;
    final smallSize = 8.0 * scale;

    // Load standard fonts
    final regularFont = await PdfGoogleFonts.interRegular();
    final boldFont = await PdfGoogleFonts.interBold();
    final semiBoldFont = await PdfGoogleFonts.interSemiBold();
    final italicFont = await PdfGoogleFonts.interItalic();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          final List<pw.Widget> widgets = [];

          // 1. HEADER
          widgets.add(_buildHeader(
            resume: resume,
            accentColor: accentColor,
            textDark: textDark,
            textMuted: textMuted,
            regularFont: regularFont,
            boldFont: boldFont,
            semiBoldFont: semiBoldFont,
            nameSize: nameSize,
            titleSize: titleSize,
            smallSize: smallSize,
          ));

          widgets.add(pw.SizedBox(height: 14));

          // 2. SECTIONS ACCORDING TO USER'S SECTION ORDER & TEMPLATE ARCHETYPE
          final effectiveSectionOrder = List<String>.from(resume.sectionOrder);
          if (resume.templateId == 'student' || resume.templateId == 'internship') {
            effectiveSectionOrder.remove('education');
            effectiveSectionOrder.insert(0, 'education');
          } else if (resume.templateId == 'fresher') {
            effectiveSectionOrder.remove('skills');
            effectiveSectionOrder.remove('projects');
            effectiveSectionOrder.insert(0, 'projects');
            effectiveSectionOrder.insert(0, 'skills');
          } else if (resume.templateId == 'software_developer' ||
              resume.templateId == 'flutter_developer' ||
              resume.templateId == 'ios_developer' ||
              resume.templateId == 'web_developer') {
            effectiveSectionOrder.remove('skills');
            final summaryIdx = effectiveSectionOrder.indexOf('summary');
            effectiveSectionOrder.insert(summaryIdx >= 0 ? summaryIdx + 1 : 0, 'skills');
          }

          for (final sectionKey in effectiveSectionOrder) {
            if (resume.enabledSections[sectionKey] == false) continue;

            switch (sectionKey) {
              case 'summary':
                if (resume.summary.trim().isNotEmpty) {
                  widgets.add(_buildSectionHeading(
                    'PROFESSIONAL SUMMARY',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  widgets.add(pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 4, bottom: 12),
                    child: pw.Text(
                      resume.summary,
                      style: pw.TextStyle(
                        font: regularFont,
                        fontSize: bodySize,
                        color: textDark,
                        lineSpacing: 1.3,
                      ),
                    ),
                  ));
                }
                break;

              case 'experience':
                if (resume.experience.isNotEmpty) {
                  widgets.add(_buildSectionHeading(
                    'WORK EXPERIENCE',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  for (final exp in resume.experience) {
                    widgets.add(_buildExperienceItem(
                      exp: exp,
                      textDark: textDark,
                      textMuted: textMuted,
                      regularFont: regularFont,
                      boldFont: boldFont,
                      semiBoldFont: semiBoldFont,
                      italicFont: italicFont,
                      bodySize: bodySize,
                      smallSize: smallSize,
                    ));
                  }
                  widgets.add(pw.SizedBox(height: 6));
                }
                break;

              case 'projects':
                if (resume.projects.isNotEmpty) {
                  widgets.add(_buildSectionHeading(
                    'PROJECTS',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  for (final proj in resume.projects) {
                    widgets.add(_buildProjectItem(
                      proj: proj,
                      accentColor: accentColor,
                      textDark: textDark,
                      textMuted: textMuted,
                      regularFont: regularFont,
                      boldFont: boldFont,
                      italicFont: italicFont,
                      bodySize: bodySize,
                      smallSize: smallSize,
                    ));
                  }
                  widgets.add(pw.SizedBox(height: 6));
                }
                break;

              case 'skills':
                final hasSkills = resume.technicalSkills.isNotEmpty ||
                    resume.softSkills.isNotEmpty ||
                    resume.toolsAndTechnologies.isNotEmpty;
                if (hasSkills) {
                  widgets.add(_buildSectionHeading(
                    'SKILLS & COMPETENCIES',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  widgets.add(pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 4, bottom: 12),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (resume.technicalSkills.isNotEmpty)
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 3),
                            child: pw.RichText(
                              text: pw.TextSpan(
                                children: [
                                  pw.TextSpan(
                                    text: 'Technical Skills: ',
                                    style: pw.TextStyle(
                                      font: boldFont,
                                      fontSize: bodySize,
                                      color: textDark,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: resume.technicalSkills.join(' • '),
                                    style: pw.TextStyle(
                                      font: regularFont,
                                      fontSize: bodySize,
                                      color: textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (resume.toolsAndTechnologies.isNotEmpty)
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 3),
                            child: pw.RichText(
                              text: pw.TextSpan(
                                children: [
                                  pw.TextSpan(
                                    text: 'Tools & Cloud: ',
                                    style: pw.TextStyle(
                                      font: boldFont,
                                      fontSize: bodySize,
                                      color: textDark,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: resume.toolsAndTechnologies.join(' • '),
                                    style: pw.TextStyle(
                                      font: regularFont,
                                      fontSize: bodySize,
                                      color: textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (resume.softSkills.isNotEmpty)
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 3),
                            child: pw.RichText(
                              text: pw.TextSpan(
                                children: [
                                  pw.TextSpan(
                                    text: 'Soft Skills: ',
                                    style: pw.TextStyle(
                                      font: boldFont,
                                      fontSize: bodySize,
                                      color: textDark,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: resume.softSkills.join(' • '),
                                    style: pw.TextStyle(
                                      font: regularFont,
                                      fontSize: bodySize,
                                      color: textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ));
                }
                break;

              case 'education':
                if (resume.education.isNotEmpty) {
                  widgets.add(_buildSectionHeading(
                    'EDUCATION',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  for (final edu in resume.education) {
                    widgets.add(_buildEducationItem(
                      edu: edu,
                      textDark: textDark,
                      textMuted: textMuted,
                      regularFont: regularFont,
                      boldFont: boldFont,
                      italicFont: italicFont,
                      bodySize: bodySize,
                      smallSize: smallSize,
                    ));
                  }
                  widgets.add(pw.SizedBox(height: 6));
                }
                break;

              case 'certifications':
                if (resume.certifications.isNotEmpty) {
                  widgets.add(_buildSectionHeading(
                    'CERTIFICATIONS',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  for (final cert in resume.certifications) {
                    widgets.add(pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: pw.RichText(
                              text: pw.TextSpan(
                                children: [
                                  pw.TextSpan(
                                    text: cert.name,
                                    style: pw.TextStyle(
                                      font: boldFont,
                                      fontSize: bodySize,
                                      color: textDark,
                                    ),
                                  ),
                                  if (cert.issuer.isNotEmpty)
                                    pw.TextSpan(
                                      text: ' — ${cert.issuer}',
                                      style: pw.TextStyle(
                                        font: regularFont,
                                        fontSize: bodySize,
                                        color: textDark,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (cert.date.isNotEmpty)
                            pw.Text(
                              cert.date,
                              style: pw.TextStyle(
                                font: regularFont,
                                fontSize: smallSize,
                                color: textMuted,
                              ),
                            ),
                        ],
                      ),
                    ));
                  }
                  widgets.add(pw.SizedBox(height: 6));
                }
                break;

              case 'languages':
                if (resume.languages.isNotEmpty) {
                  widgets.add(_buildSectionHeading(
                    'LANGUAGES',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  final langStr = resume.languages
                      .map((l) => '${l.language} (${l.proficiency})')
                      .join('  •  ');
                  widgets.add(pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 2, bottom: 8),
                    child: pw.Text(
                      langStr,
                      style: pw.TextStyle(
                        font: regularFont,
                        fontSize: bodySize,
                        color: textDark,
                      ),
                    ),
                  ));
                }
                break;

              case 'awards':
                if (resume.awards.isNotEmpty) {
                  widgets.add(_buildSectionHeading(
                    'HONORS & AWARDS',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  for (final award in resume.awards) {
                    widgets.add(pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              '${award.title}${award.issuer.isNotEmpty ? ' (${award.issuer})' : ''}: ${award.description}',
                              style: pw.TextStyle(
                                font: regularFont,
                                fontSize: bodySize,
                                color: textDark,
                              ),
                            ),
                          ),
                          if (award.date.isNotEmpty)
                            pw.Text(
                              award.date,
                              style: pw.TextStyle(
                                font: regularFont,
                                fontSize: smallSize,
                                color: textMuted,
                              ),
                            ),
                        ],
                      ),
                    ));
                  }
                  widgets.add(pw.SizedBox(height: 6));
                }
                break;

              case 'publications':
                if (resume.publications.isNotEmpty) {
                  widgets.add(_buildSectionHeading(
                    'PUBLICATIONS',
                    accentColor,
                    boldFont,
                    headingSize,
                    dividerColor,
                  ));
                  for (final pub in resume.publications) {
                    widgets.add(pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Text(
                        '• "${pub.title}", ${pub.publisher} (${pub.date}). ${pub.description}',
                        style: pw.TextStyle(
                          font: regularFont,
                          fontSize: bodySize,
                          color: textDark,
                        ),
                      ),
                    ));
                  }
                  widgets.add(pw.SizedBox(height: 6));
                }
                break;
            }
          }

          return widgets;
        },
      ),
    );

    return pdf.save();
  }

  /// Download or Print PDF directly in browser
  static Future<void> downloadResumePdf(ResumeData resume) async {
    final bytes = await generateResumePdf(resume);
    final sanitizedName = resume.fullName.trim().isEmpty
        ? 'Resume'
        : resume.fullName.trim().replaceAll(RegExp(r'\s+'), '_');
    final filename = '${sanitizedName}_Resume.pdf';

    await Printing.sharePdf(
      bytes: bytes,
      filename: filename,
    );
  }

  // --- Sub-widget builders for clean modular PDF layout ---

  static pw.Widget _buildHeader({
    required ResumeData resume,
    required PdfColor accentColor,
    required PdfColor textDark,
    required PdfColor textMuted,
    required pw.Font regularFont,
    required pw.Font boldFont,
    required pw.Font semiBoldFont,
    required double nameSize,
    required double titleSize,
    required double smallSize,
  }) {
    final contactParts = <String>[];
    if (resume.email.isNotEmpty) contactParts.add(resume.email);
    if (resume.phone.isNotEmpty) contactParts.add(resume.phone);
    if (resume.location.isNotEmpty) contactParts.add(resume.location);

    final linkParts = <String>[];
    if (resume.linkedIn.isNotEmpty) contactParts.add(resume.linkedIn);
    if (resume.gitHub.isNotEmpty) linkParts.add(resume.gitHub);
    if (resume.portfolioUrl.isNotEmpty) linkParts.add(resume.portfolioUrl);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (resume.fullName.trim().isNotEmpty)
          pw.Text(
            resume.fullName.trim(),
            style: pw.TextStyle(
              font: boldFont,
              fontSize: nameSize,
              color: accentColor,
            ),
          ),
        if (resume.jobTitle.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 2, bottom: 6),
            child: pw.Text(
              resume.jobTitle.toUpperCase(),
              style: pw.TextStyle(
                font: semiBoldFont,
                fontSize: titleSize,
                color: textDark,
                letterSpacing: 1.2,
              ),
            ),
          ),
        if (contactParts.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 2),
            child: pw.Text(
              contactParts.join('  |  '),
              style: pw.TextStyle(
                font: regularFont,
                fontSize: smallSize,
                color: textMuted,
              ),
            ),
          ),
        if (linkParts.isNotEmpty)
          pw.Text(
            linkParts.join('  |  '),
            style: pw.TextStyle(
              font: regularFont,
              fontSize: smallSize,
              color: textMuted,
            ),
          ),
      ],
    );
  }

  static pw.Widget _buildSectionHeading(
    String title,
    PdfColor accentColor,
    pw.Font boldFont,
    double headingSize,
    PdfColor dividerColor,
  ) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 8, bottom: 4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              font: boldFont,
              fontSize: headingSize,
              color: accentColor,
              letterSpacing: 1.1,
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Container(
            height: 1.2,
            color: accentColor,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildExperienceItem({
    required ExperienceEntry exp,
    required PdfColor textDark,
    required PdfColor textMuted,
    required pw.Font regularFont,
    required pw.Font boldFont,
    required pw.Font semiBoldFont,
    required pw.Font italicFont,
    required double bodySize,
    required double smallSize,
  }) {
    final dateRange = [
      if (exp.startDate.isNotEmpty) exp.startDate,
      if (exp.isCurrent) 'Present' else if (exp.endDate.isNotEmpty) exp.endDate,
    ].join(' – ');

    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 5, bottom: 4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(
                  exp.jobTitle,
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: bodySize + 0.5,
                    color: textDark,
                  ),
                ),
              ),
              if (dateRange.isNotEmpty)
                pw.Text(
                  dateRange,
                  style: pw.TextStyle(
                    font: semiBoldFont,
                    fontSize: smallSize,
                    color: textMuted,
                  ),
                ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                exp.company,
                style: pw.TextStyle(
                  font: italicFont,
                  fontSize: bodySize,
                  color: textMuted,
                ),
              ),
              if (exp.location.isNotEmpty)
                pw.Text(
                  exp.location,
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: smallSize,
                    color: textMuted,
                  ),
                ),
            ],
          ),
          if (exp.description.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 3),
              child: _buildBulletList(exp.description, regularFont, bodySize, textDark),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildEducationItem({
    required EducationEntry edu,
    required PdfColor textDark,
    required PdfColor textMuted,
    required pw.Font regularFont,
    required pw.Font boldFont,
    required pw.Font italicFont,
    required double bodySize,
    required double smallSize,
  }) {
    final dateRange = [
      if (edu.startDate.isNotEmpty) edu.startDate,
      if (edu.endDate.isNotEmpty) edu.endDate,
    ].join(' – ');

    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 4, bottom: 3),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(
                  edu.degree,
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: bodySize,
                    color: textDark,
                  ),
                ),
              ),
              if (dateRange.isNotEmpty)
                pw.Text(
                  dateRange,
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: smallSize,
                    color: textMuted,
                  ),
                ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                edu.institution + (edu.location.isNotEmpty ? ', ${edu.location}' : ''),
                style: pw.TextStyle(
                  font: italicFont,
                  fontSize: bodySize - 0.5,
                  color: textMuted,
                ),
              ),
              if (edu.grade.isNotEmpty)
                pw.Text(
                  edu.grade,
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: smallSize,
                    color: textDark,
                  ),
                ),
            ],
          ),
          if (edu.coursework.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 2),
              child: pw.Text(
                'Coursework: ${edu.coursework}',
                style: pw.TextStyle(
                  font: regularFont,
                  fontSize: smallSize,
                  color: textMuted,
                ),
              ),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildProjectItem({
    required ProjectEntry proj,
    required PdfColor accentColor,
    required PdfColor textDark,
    required PdfColor textMuted,
    required pw.Font regularFont,
    required pw.Font boldFont,
    required pw.Font italicFont,
    required double bodySize,
    required double smallSize,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 4, bottom: 4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(
                  proj.title,
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: bodySize,
                    color: textDark,
                  ),
                ),
              ),
              if (proj.projectUrl.isNotEmpty)
                pw.Text(
                  proj.projectUrl,
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: smallSize,
                    color: accentColor,
                  ),
                ),
            ],
          ),
          if (proj.technologies.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 1, bottom: 2),
              child: pw.Text(
                'Technologies: ${proj.technologies.join(', ')}',
                style: pw.TextStyle(
                  font: italicFont,
                  fontSize: smallSize,
                  color: textMuted,
                ),
              ),
            ),
          if (proj.description.isNotEmpty)
            pw.Text(
              proj.description,
              style: pw.TextStyle(
                font: regularFont,
                fontSize: bodySize - 0.5,
                color: textDark,
              ),
            ),
          if (proj.achievements.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 1),
              child: pw.Text(
                '• ${proj.achievements}',
                style: pw.TextStyle(
                  font: regularFont,
                  fontSize: bodySize - 0.5,
                  color: textDark,
                ),
              ),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildBulletList(
    String rawText,
    pw.Font font,
    double fontSize,
    PdfColor color,
  ) {
    final lines = rawText.split('\n').where((l) => l.trim().isNotEmpty).toList();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: lines.map((line) {
        final cleanLine = line.trim().startsWith('•') || line.trim().startsWith('-')
            ? line.trim().substring(1).trim()
            : line.trim();
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 2),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 10,
                child: pw.Text(
                  '•',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: fontSize,
                    color: color,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  cleanLine,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: fontSize,
                    color: color,
                    lineSpacing: 1.25,
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
