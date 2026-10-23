import '../models/resume_data.dart';

class SampleDataService {
  static ResumeData getSampleResume() {
    return ResumeData(
      id: 'demo_resume_01',
      resumeTitle: 'Ajil - Flutter Developer Resume',
      fullName: 'Ajil',
      jobTitle: 'Flutter Developer',
      email: 'demo@example.com',
      phone: '', // Do not provide any actual phone number. The phone number field must display only the label or placeholder text "Phone Number".
      location: 'Kerala, India',
      linkedIn: 'linkedin.com/in/demo',
      gitHub: 'github.com/demo',
      portfolioUrl: 'demo.dev',
      summary:
          'Motivated entry-level Flutter Developer with knowledge of Flutter, Dart, REST APIs, and native iOS development.',
      experience: [
        ExperienceEntry(
          id: 'exp_1',
          jobTitle: 'Flutter Developer',
          company: 'Tech Innovations',
          location: 'Kerala, India',
          startDate: 'Jan 2024',
          endDate: 'Present',
          isCurrent: true,
          description:
              '• Developed and tested responsive cross-platform mobile and web applications using Flutter and Dart.\n• Integrated REST APIs for asynchronous data synchronization and dynamic JSON parsing.\n• Utilized Git version control and collaborated effectively in agile sprint workflows.\n• Implemented Firebase Authentication and Cloud Firestore for robust real-time cloud data storage.',
        ),
      ],
      education: [
        EducationEntry(
          id: 'edu_1',
          degree: 'Bachelor of Science in Computer Science',
          institution: 'University of Kerala',
          location: 'Kerala, India',
          startDate: '2020',
          endDate: '2024',
          grade: '8.5 CGPA',
          coursework:
              'Data Structures & Algorithms, Mobile Application Development, Database Management Systems, Object-Oriented Programming',
        ),
      ],
      technicalSkills: [
        'Flutter',
        'Dart',
        'Swift',
        'REST APIs',
        'Git',
        'Firebase',
      ],
      softSkills: [
        'Problem Solving',
        'Team Collaboration',
        'Communication',
        'Quick Learner',
        'Attention to Detail',
      ],
      toolsAndTechnologies: [
        'VS Code',
        'Git',
        'Firebase',
        'Postman',
        'Figma',
      ],
      projects: [
        ProjectEntry(
          id: 'proj_1',
          title: 'Todo List App',
          description:
              'A responsive task management application built with Flutter featuring state management, local database persistence, and task filtering by completion status.',
          technologies: ['Flutter', 'Dart', 'SQLite', 'Provider'],
          projectUrl: 'https://github.com/demo/todo-list-app',
          achievements:
              'Achieved 100% offline functionality with sub-100ms task filtering and a clean, accessible user interface.',
        ),
        ProjectEntry(
          id: 'proj_2',
          title: 'CV Maker Website',
          description:
              'An online resume builder featuring 25+ professional templates, real-time live preview, and in-browser vector PDF compilation.',
          technologies: ['Flutter Web', 'Dart', 'PDF Engine'],
          projectUrl: 'https://github.com/demo/cv-maker-website',
          achievements:
              'Delivers sub-second client-side vector PDF generation with zero backend requirement.',
        ),
      ],
      internships: [
        ExperienceEntry(
          id: 'intern_1',
          jobTitle: 'Mobile App Developer Intern',
          company: 'AppStudio Labs',
          location: 'Kerala, India',
          startDate: 'Jun 2023',
          endDate: 'Dec 2023',
          description:
              'Assisted in building custom Flutter UI components and testing REST API integrations.',
        ),
      ],
      certifications: [
        CertificationEntry(
          id: 'cert_1',
          name: 'Flutter Certified Application Developer',
          issuer: 'Google Developers / Coursera',
          date: '2024',
          credentialId: 'FLUTTER-CERT-8849',
          url: 'https://coursera.org/verify',
        ),
      ],
      languages: [
        LanguageEntry(
          id: 'lang_1',
          language: 'English',
          proficiency: 'Professional Working',
        ),
        LanguageEntry(
          id: 'lang_2',
          language: 'Malayalam',
          proficiency: 'Native',
        ),
      ],
      awards: [
        AwardEntry(
          id: 'award_1',
          title: 'Best Academic Project Award',
          issuer: 'University of Kerala',
          date: '2024',
          description:
              'Recognized for outstanding mobile application development and clean architecture design.',
        ),
      ],
      volunteerWork: [
        VolunteerEntry(
          id: 'vol_1',
          role: 'Student Tech Lead',
          organization: 'Developer Student Club',
          date: '2023 - 2024',
          description:
              'Organized Flutter and Dart beginner workshops for over 150 undergraduate students.',
        ),
      ],
      publications: [],
      targetJobTitle: 'Flutter Developer',
      targetCompany: 'Tech Corp',
      targetJobDescription: '''
We are seeking a motivated Flutter Developer to join our engineering team.
Requirements:
- Hands-on knowledge of Flutter, Dart, REST APIs, and Git.
- Familiarity with native iOS development (Swift) and Firebase backend integration.
- Eagerness to build responsive, accessible mobile and web applications.
- Strong problem-solving, collaboration, and communication skills.
- Bachelor of Science in Computer Science or related degree.
''',
      templateId: 'modern_professional',
      accentColorValue: 0xFF1E3A8A,
      fontSizeScale: 1.0,
      fontFamily: 'Inter',
      spacingScale: 1.0,
    );
  }
}
