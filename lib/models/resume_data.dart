import 'dart:convert';

/// Represents a single work experience or internship entry
class ExperienceEntry {
  final String id;
  final String jobTitle;
  final String company;
  final String location;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final String description; // Multi-line or bullet achievements

  ExperienceEntry({
    required this.id,
    required this.jobTitle,
    required this.company,
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.isCurrent = false,
    this.description = '',
  });

  ExperienceEntry copyWith({
    String? id,
    String? jobTitle,
    String? company,
    String? location,
    String? startDate,
    String? endDate,
    bool? isCurrent,
    String? description,
  }) {
    return ExperienceEntry(
      id: id ?? this.id,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'jobTitle': jobTitle,
        'company': company,
        'location': location,
        'startDate': startDate,
        'endDate': endDate,
        'isCurrent': isCurrent,
        'description': description,
      };

  factory ExperienceEntry.fromJson(Map<String, dynamic> json) =>
      ExperienceEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        jobTitle: json['jobTitle'] as String? ?? '',
        company: json['company'] as String? ?? '',
        location: json['location'] as String? ?? '',
        startDate: json['startDate'] as String? ?? '',
        endDate: json['endDate'] as String? ?? '',
        isCurrent: json['isCurrent'] as bool? ?? false,
        description: json['description'] as String? ?? '',
      );
}

/// Represents an education credential
class EducationEntry {
  final String id;
  final String degree;
  final String institution;
  final String location;
  final String startDate;
  final String endDate;
  final String grade; // e.g. "3.85 GPA" or "88%"
  final String coursework;

  EducationEntry({
    required this.id,
    required this.degree,
    required this.institution,
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.grade = '',
    this.coursework = '',
  });

  EducationEntry copyWith({
    String? id,
    String? degree,
    String? institution,
    String? location,
    String? startDate,
    String? endDate,
    String? grade,
    String? coursework,
  }) {
    return EducationEntry(
      id: id ?? this.id,
      degree: degree ?? this.degree,
      institution: institution ?? this.institution,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      grade: grade ?? this.grade,
      coursework: coursework ?? this.coursework,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'degree': degree,
        'institution': institution,
        'location': location,
        'startDate': startDate,
        'endDate': endDate,
        'grade': grade,
        'coursework': coursework,
      };

  factory EducationEntry.fromJson(Map<String, dynamic> json) => EducationEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        degree: json['degree'] as String? ?? '',
        institution: json['institution'] as String? ?? '',
        location: json['location'] as String? ?? '',
        startDate: json['startDate'] as String? ?? '',
        endDate: json['endDate'] as String? ?? '',
        grade: json['grade'] as String? ?? '',
        coursework: json['coursework'] as String? ?? '',
      );
}

/// Represents a portfolio or technical project
class ProjectEntry {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String projectUrl;
  final String achievements;

  ProjectEntry({
    required this.id,
    required this.title,
    this.description = '',
    this.technologies = const [],
    this.projectUrl = '',
    this.achievements = '',
  });

  ProjectEntry copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? technologies,
    String? projectUrl,
    String? achievements,
  }) {
    return ProjectEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      projectUrl: projectUrl ?? this.projectUrl,
      achievements: achievements ?? this.achievements,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'technologies': technologies,
        'projectUrl': projectUrl,
        'achievements': achievements,
      };

  factory ProjectEntry.fromJson(Map<String, dynamic> json) => ProjectEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        technologies: (json['technologies'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        projectUrl: json['projectUrl'] as String? ?? '',
        achievements: json['achievements'] as String? ?? '',
      );
}

/// Represents a certification
class CertificationEntry {
  final String id;
  final String name;
  final String issuer;
  final String date;
  final String credentialId;
  final String url;

  CertificationEntry({
    required this.id,
    required this.name,
    required this.issuer,
    this.date = '',
    this.credentialId = '',
    this.url = '',
  });

  CertificationEntry copyWith({
    String? id,
    String? name,
    String? issuer,
    String? date,
    String? credentialId,
    String? url,
  }) {
    return CertificationEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      issuer: issuer ?? this.issuer,
      date: date ?? this.date,
      credentialId: credentialId ?? this.credentialId,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'issuer': issuer,
        'date': date,
        'credentialId': credentialId,
        'url': url,
      };

  factory CertificationEntry.fromJson(Map<String, dynamic> json) =>
      CertificationEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        name: json['name'] as String? ?? '',
        issuer: json['issuer'] as String? ?? '',
        date: json['date'] as String? ?? '',
        credentialId: json['credentialId'] as String? ?? '',
        url: json['url'] as String? ?? '',
      );
}

/// Course entry
class CourseEntry {
  final String id;
  final String name;
  final String provider;
  final String date;

  CourseEntry({
    required this.id,
    required this.name,
    this.provider = '',
    this.date = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'provider': provider,
        'date': date,
      };

  factory CourseEntry.fromJson(Map<String, dynamic> json) => CourseEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        name: json['name'] as String? ?? '',
        provider: json['provider'] as String? ?? '',
        date: json['date'] as String? ?? '',
      );
}

/// Language proficiency
class LanguageEntry {
  final String id;
  final String language;
  final String proficiency; // Native, Fluent, Professional, Intermediate, Basic

  LanguageEntry({
    required this.id,
    required this.language,
    this.proficiency = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'language': language,
        'proficiency': proficiency,
      };

  factory LanguageEntry.fromJson(Map<String, dynamic> json) => LanguageEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        language: json['language'] as String? ?? '',
        proficiency: json['proficiency'] as String? ?? '',
      );
}

/// Award entry
class AwardEntry {
  final String id;
  final String title;
  final String issuer;
  final String date;
  final String description;

  AwardEntry({
    required this.id,
    required this.title,
    this.issuer = '',
    this.date = '',
    this.description = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'issuer': issuer,
        'date': date,
        'description': description,
      };

  factory AwardEntry.fromJson(Map<String, dynamic> json) => AwardEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        title: json['title'] as String? ?? '',
        issuer: json['issuer'] as String? ?? '',
        date: json['date'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );
}

/// Volunteer experience entry
class VolunteerEntry {
  final String id;
  final String role;
  final String organization;
  final String date;
  final String description;

  VolunteerEntry({
    required this.id,
    required this.role,
    this.organization = '',
    this.date = '',
    this.description = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'organization': organization,
        'date': date,
        'description': description,
      };

  factory VolunteerEntry.fromJson(Map<String, dynamic> json) => VolunteerEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        role: json['role'] as String? ?? '',
        organization: json['organization'] as String? ?? '',
        date: json['date'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );
}

/// Publication entry
class PublicationEntry {
  final String id;
  final String title;
  final String publisher;
  final String date;
  final String url;
  final String description;

  PublicationEntry({
    required this.id,
    required this.title,
    this.publisher = '',
    this.date = '',
    this.url = '',
    this.description = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'publisher': publisher,
        'date': date,
        'url': url,
        'description': description,
      };

  factory PublicationEntry.fromJson(Map<String, dynamic> json) =>
      PublicationEntry(
        id: json['id'] as String? ?? UniqueId.generate(),
        title: json['title'] as String? ?? '',
        publisher: json['publisher'] as String? ?? '',
        date: json['date'] as String? ?? '',
        url: json['url'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );
}

/// Helper to generate unique IDs
class UniqueId {
  static int _counter = 0;
  static String generate() {
    _counter++;
    return '${DateTime.now().millisecondsSinceEpoch}_$_counter';
  }
}

/// Root data model representing the entire resume
class ResumeData {
  // Identity & Meta
  final String id;
  final String resumeTitle; // e.g. "Senior Software Engineer Resume"
  final DateTime lastModified;

  // Personal Details
  final String fullName;
  final String jobTitle;
  final String email;
  final String phone;
  final String location; // City, Country
  final String linkedIn;
  final String gitHub;
  final String portfolioUrl;

  // Professional Summary
  final String summary;

  // Experience & Education
  final List<ExperienceEntry> experience;
  final List<EducationEntry> education;

  // Skills
  final List<String> technicalSkills;
  final List<String> softSkills;
  final List<String> toolsAndTechnologies;

  // Projects
  final List<ProjectEntry> projects;

  // Additional sections
  final List<ExperienceEntry> internships;
  final List<CertificationEntry> certifications;
  final List<CourseEntry> courses;
  final List<LanguageEntry> languages;
  final List<AwardEntry> awards;
  final List<VolunteerEntry> volunteerWork;
  final List<PublicationEntry> publications;

  // Target Job (for ATS scoring)
  final String targetJobTitle;
  final String targetJobDescription;
  final String targetCompany;

  // Design Customizations
  final String templateId;
  final int accentColorValue;
  final double fontSizeScale; // 0.9 = compact, 1.0 = standard, 1.15 = large
  final String fontFamily; // 'Inter', 'Merriweather', 'Roboto', 'Lato'
  final double spacingScale; // 0.8 = compact, 1.0 = normal, 1.2 = relaxed
  final List<String> sectionOrder;
  final Map<String, bool> enabledSections;

  ResumeData({
    required this.id,
    this.resumeTitle = 'My Resume',
    DateTime? lastModified,
    this.fullName = '',
    this.jobTitle = '',
    this.email = '',
    this.phone = '',
    this.location = '',
    this.linkedIn = '',
    this.gitHub = '',
    this.portfolioUrl = '',
    this.summary = '',
    this.experience = const [],
    this.education = const [],
    this.technicalSkills = const [],
    this.softSkills = const [],
    this.toolsAndTechnologies = const [],
    this.projects = const [],
    this.internships = const [],
    this.certifications = const [],
    this.courses = const [],
    this.languages = const [],
    this.awards = const [],
    this.volunteerWork = const [],
    this.publications = const [],
    this.targetJobTitle = '',
    this.targetJobDescription = '',
    this.targetCompany = '',
    this.templateId = 'modern_professional',
    this.accentColorValue = 0xFF1E3A8A, // Navy accent
    this.fontSizeScale = 1.0,
    this.fontFamily = 'Inter',
    this.spacingScale = 1.0,
    List<String>? sectionOrder,
    Map<String, bool>? enabledSections,
  })  : lastModified = lastModified ?? DateTime.now(),
        sectionOrder = sectionOrder ?? defaultSectionOrder,
        enabledSections = enabledSections ?? defaultEnabledSections;

  static const List<String> defaultSectionOrder = [
    'summary',
    'experience',
    'projects',
    'skills',
    'education',
    'internships',
    'certifications',
    'courses',
    'languages',
    'awards',
    'volunteer',
    'publications',
  ];

  static const Map<String, bool> defaultEnabledSections = {
    'summary': true,
    'experience': true,
    'projects': true,
    'skills': true,
    'education': true,
    'internships': true,
    'certifications': true,
    'courses': false,
    'languages': true,
    'awards': false,
    'volunteer': false,
    'publications': false,
  };

  ResumeData copyWith({
    String? id,
    String? resumeTitle,
    DateTime? lastModified,
    String? fullName,
    String? jobTitle,
    String? email,
    String? phone,
    String? location,
    String? linkedIn,
    String? gitHub,
    String? portfolioUrl,
    String? summary,
    List<ExperienceEntry>? experience,
    List<EducationEntry>? education,
    List<String>? technicalSkills,
    List<String>? softSkills,
    List<String>? toolsAndTechnologies,
    List<ProjectEntry>? projects,
    List<ExperienceEntry>? internships,
    List<CertificationEntry>? certifications,
    List<CourseEntry>? courses,
    List<LanguageEntry>? languages,
    List<AwardEntry>? awards,
    List<VolunteerEntry>? volunteerWork,
    List<PublicationEntry>? publications,
    String? targetJobTitle,
    String? targetJobDescription,
    String? targetCompany,
    String? templateId,
    int? accentColorValue,
    double? fontSizeScale,
    String? fontFamily,
    double? spacingScale,
    List<String>? sectionOrder,
    Map<String, bool>? enabledSections,
  }) {
    return ResumeData(
      id: id ?? this.id,
      resumeTitle: resumeTitle ?? this.resumeTitle,
      lastModified: lastModified ?? DateTime.now(),
      fullName: fullName ?? this.fullName,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      linkedIn: linkedIn ?? this.linkedIn,
      gitHub: gitHub ?? this.gitHub,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      summary: summary ?? this.summary,
      experience: experience ?? this.experience,
      education: education ?? this.education,
      technicalSkills: technicalSkills ?? this.technicalSkills,
      softSkills: softSkills ?? this.softSkills,
      toolsAndTechnologies: toolsAndTechnologies ?? this.toolsAndTechnologies,
      projects: projects ?? this.projects,
      internships: internships ?? this.internships,
      certifications: certifications ?? this.certifications,
      courses: courses ?? this.courses,
      languages: languages ?? this.languages,
      awards: awards ?? this.awards,
      volunteerWork: volunteerWork ?? this.volunteerWork,
      publications: publications ?? this.publications,
      targetJobTitle: targetJobTitle ?? this.targetJobTitle,
      targetJobDescription: targetJobDescription ?? this.targetJobDescription,
      targetCompany: targetCompany ?? this.targetCompany,
      templateId: templateId ?? this.templateId,
      accentColorValue: accentColorValue ?? this.accentColorValue,
      fontSizeScale: fontSizeScale ?? this.fontSizeScale,
      fontFamily: fontFamily ?? this.fontFamily,
      spacingScale: spacingScale ?? this.spacingScale,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      enabledSections: enabledSections ?? this.enabledSections,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'resumeTitle': resumeTitle,
        'lastModified': lastModified.toIso8601String(),
        'fullName': fullName,
        'jobTitle': jobTitle,
        'email': email,
        'phone': phone,
        'location': location,
        'linkedIn': linkedIn,
        'gitHub': gitHub,
        'portfolioUrl': portfolioUrl,
        'summary': summary,
        'experience': experience.map((e) => e.toJson()).toList(),
        'education': education.map((e) => e.toJson()).toList(),
        'technicalSkills': technicalSkills,
        'softSkills': softSkills,
        'toolsAndTechnologies': toolsAndTechnologies,
        'projects': projects.map((e) => e.toJson()).toList(),
        'internships': internships.map((e) => e.toJson()).toList(),
        'certifications': certifications.map((e) => e.toJson()).toList(),
        'courses': courses.map((e) => e.toJson()).toList(),
        'languages': languages.map((e) => e.toJson()).toList(),
        'awards': awards.map((e) => e.toJson()).toList(),
        'volunteerWork': volunteerWork.map((e) => e.toJson()).toList(),
        'publications': publications.map((e) => e.toJson()).toList(),
        'targetJobTitle': targetJobTitle,
        'targetJobDescription': targetJobDescription,
        'targetCompany': targetCompany,
        'templateId': templateId,
        'accentColorValue': accentColorValue,
        'fontSizeScale': fontSizeScale,
        'fontFamily': fontFamily,
        'spacingScale': spacingScale,
        'sectionOrder': sectionOrder,
        'enabledSections': enabledSections,
      };

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      id: json['id'] as String? ?? UniqueId.generate(),
      resumeTitle: json['resumeTitle'] as String? ?? 'My Resume',
      lastModified: json['lastModified'] != null
          ? DateTime.tryParse(json['lastModified'] as String) ?? DateTime.now()
          : DateTime.now(),
      fullName: json['fullName'] as String? ?? '',
      jobTitle: json['jobTitle'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      location: json['location'] as String? ?? '',
      linkedIn: json['linkedIn'] as String? ?? '',
      gitHub: json['gitHub'] as String? ?? '',
      portfolioUrl: json['portfolioUrl'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      experience: (json['experience'] as List<dynamic>?)
              ?.map((e) => ExperienceEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      education: (json['education'] as List<dynamic>?)
              ?.map((e) => EducationEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      technicalSkills: (json['technicalSkills'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      softSkills: (json['softSkills'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      toolsAndTechnologies: (json['toolsAndTechnologies'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      projects: (json['projects'] as List<dynamic>?)
              ?.map((e) => ProjectEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      internships: (json['internships'] as List<dynamic>?)
              ?.map((e) => ExperienceEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      certifications: (json['certifications'] as List<dynamic>?)
              ?.map((e) =>
                  CertificationEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      courses: (json['courses'] as List<dynamic>?)
              ?.map((e) => CourseEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => LanguageEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      awards: (json['awards'] as List<dynamic>?)
              ?.map((e) => AwardEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      volunteerWork: (json['volunteerWork'] as List<dynamic>?)
              ?.map((e) => VolunteerEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      publications: (json['publications'] as List<dynamic>?)
              ?.map((e) =>
                  PublicationEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      targetJobTitle: json['targetJobTitle'] as String? ?? '',
      targetJobDescription: json['targetJobDescription'] as String? ?? '',
      targetCompany: json['targetCompany'] as String? ?? '',
      templateId: json['templateId'] as String? ?? 'modern_professional',
      accentColorValue: json['accentColorValue'] as int? ?? 0xFF1E3A8A,
      fontSizeScale: (json['fontSizeScale'] as num?)?.toDouble() ?? 1.0,
      fontFamily: json['fontFamily'] as String? ?? 'Inter',
      spacingScale: (json['spacingScale'] as num?)?.toDouble() ?? 1.0,
      sectionOrder: (json['sectionOrder'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          defaultSectionOrder,
      enabledSections: (json['enabledSections'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, v as bool),
          ) ??
          defaultEnabledSections,
    );
  }

  factory ResumeData.empty() => ResumeData(id: UniqueId.generate());

  String toJsonString() => jsonEncode(toJson());

  factory ResumeData.fromJsonString(String source) =>
      ResumeData.fromJson(jsonDecode(source) as Map<String, dynamic>);
}
