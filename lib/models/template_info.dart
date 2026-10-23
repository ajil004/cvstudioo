import 'package:flutter/material.dart';

enum TemplateCategory {
  all,
  professional,
  tech,
  executive,
  creative,
  academicHealthcare,
  entryLevel,
}

class TemplateInfo {
  final String id;
  final String name;
  final TemplateCategory category;
  final String categoryName;
  final String description;
  final bool isAtsSafe;
  final String recommendedFor;
  final Color previewAccent;
  final List<String> tags;
  final String fontFamily;
  final bool hasSidebar;

  const TemplateInfo({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryName,
    required this.description,
    required this.isAtsSafe,
    required this.recommendedFor,
    required this.previewAccent,
    required this.tags,
    this.fontFamily = 'Inter',
    this.hasSidebar = false,
  });

  static const List<TemplateInfo> allTemplates = [
    // 1
    TemplateInfo(
      id: 'classic_professional',
      name: 'Classic Professional',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Timeless, traditional serif aesthetic with centered header and clean divider rules. Highest ATS compliance.',
      isAtsSafe: true,
      recommendedFor: 'Lawyers, Accountants, Senior Managers, Traditional Industries',
      previewAccent: Color(0xFF1E293B),
      tags: ['ATS Safe', 'Serif', 'Clean', 'Conservative'],
      fontFamily: 'Merriweather',
    ),
    // 2
    TemplateInfo(
      id: 'modern_professional',
      name: 'Modern Professional',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Crisp sans-serif typography, clean left accent bars on headings, and structured metadata. Our flagship design.',
      isAtsSafe: true,
      recommendedFor: 'Consultants, Operations, Tech & Corporate Professionals',
      previewAccent: Color(0xFF1E3A8A),
      tags: ['ATS Safe', 'Popular', 'Modern', 'Sleek'],
      fontFamily: 'Inter',
    ),
    // 3
    TemplateInfo(
      id: 'minimalist',
      name: 'Minimalist',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Generous whitespace, refined lightweight headings, and zero distraction. Focuses 100% on achievements.',
      isAtsSafe: true,
      recommendedFor: 'All Industries, C-Suite, Writers, Developers',
      previewAccent: Color(0xFF475569),
      tags: ['ATS Safe', 'Lightweight', 'Minimal', 'Whitespace'],
      fontFamily: 'Lato',
    ),
    // 4
    TemplateInfo(
      id: 'corporate',
      name: 'Corporate',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Structured header banner in navy, clear corporate borders, and formal section demarcations.',
      isAtsSafe: true,
      recommendedFor: 'Banking, Enterprise IT, Fortune 500 Applicants',
      previewAccent: Color(0xFF0F172A),
      tags: ['ATS Safe', 'Corporate', 'Structured', 'Formal'],
      fontFamily: 'Roboto',
    ),
    // 5
    TemplateInfo(
      id: 'executive',
      name: 'Executive',
      category: TemplateCategory.executive,
      categoryName: 'Executive & Leadership',
      description:
          'Polished leadership format featuring a prominent executive summary quote, core competencies grid, and board-level styling.',
      isAtsSafe: true,
      recommendedFor: 'Directors, VPs, CTOs, CEOs, Board Members',
      previewAccent: Color(0xFF0F2B48),
      tags: ['ATS Safe', 'Leadership', 'Grid', 'Senior'],
      fontFamily: 'Merriweather',
    ),
    // 6
    TemplateInfo(
      id: 'student',
      name: 'Student',
      category: TemplateCategory.entryLevel,
      categoryName: 'Entry-Level & Students',
      description:
          'Prioritizes university education, GPA, relevant coursework, campus leadership, and academic projects.',
      isAtsSafe: true,
      recommendedFor: 'College Undergrads, Recent Graduates, High School Seniors',
      previewAccent: Color(0xFF2563EB),
      tags: ['ATS Safe', 'Education First', 'Coursework', 'GPA'],
      fontFamily: 'Inter',
    ),
    // 7
    TemplateInfo(
      id: 'fresher',
      name: 'Fresher',
      category: TemplateCategory.entryLevel,
      categoryName: 'Entry-Level & Students',
      description:
          'Designed to compensate for limited work experience by putting core technical skills, projects, and certifications upfront.',
      isAtsSafe: true,
      recommendedFor: 'First-time Job Seekers, Career Changers, Fresh Graduates',
      previewAccent: Color(0xFF0284C7),
      tags: ['ATS Safe', 'Skills Matrix', 'Projects First'],
      fontFamily: 'Roboto',
    ),
    // 8
    TemplateInfo(
      id: 'software_developer',
      name: 'Software Developer',
      category: TemplateCategory.tech,
      categoryName: 'Tech & Engineering',
      description:
          'Structured tech stack categorization (Languages, Frameworks, Cloud, Databases), GitHub links, and high-impact metric bullets.',
      isAtsSafe: true,
      recommendedFor: 'Backend, Frontend, Full Stack & Systems Engineers',
      previewAccent: Color(0xFF1D4ED8),
      tags: ['ATS Safe', 'Code Badges', 'GitHub Link', 'Tech Stack'],
      fontFamily: 'Inter',
    ),
    // 9
    TemplateInfo(
      id: 'flutter_developer',
      name: 'Flutter Developer',
      category: TemplateCategory.tech,
      categoryName: 'Tech & Engineering',
      description:
          'Optimized for cross-platform mobile engineers. Showcases published App Store & Play Store apps, state management, and Dart mastery.',
      isAtsSafe: true,
      recommendedFor: 'Flutter, Dart, Mobile Cross-Platform Developers',
      previewAccent: Color(0xFF02569B),
      tags: ['ATS Safe', 'Flutter Blue', 'App Showcase', 'Dart'],
      fontFamily: 'Inter',
    ),
    // 10
    TemplateInfo(
      id: 'ios_developer',
      name: 'iOS Developer',
      category: TemplateCategory.tech,
      categoryName: 'Tech & Engineering',
      description:
          'Apple Human Interface Guidelines inspired minimalism. Swift, SwiftUI, Combine, and App Store metrics focus.',
      isAtsSafe: true,
      recommendedFor: 'iOS, macOS, watchOS, Swift Developers',
      previewAccent: Color(0xFF0071E3),
      tags: ['ATS Safe', 'Apple Style', 'Swift', 'App Store'],
      fontFamily: 'Inter',
    ),
    // 11
    TemplateInfo(
      id: 'web_developer',
      name: 'Web Developer',
      category: TemplateCategory.tech,
      categoryName: 'Tech & Engineering',
      description:
          'Frontend and backend breakdown, live deployment URLs, web performance metrics, and responsive design accolades.',
      isAtsSafe: true,
      recommendedFor: 'React, Angular, Vue, Next.js, Node.js Engineers',
      previewAccent: Color(0xFF0891B2),
      tags: ['ATS Safe', 'Web Tech', 'Live Links', 'Full Stack'],
      fontFamily: 'Inter',
    ),
    // 12
    TemplateInfo(
      id: 'data_analyst',
      name: 'Data Analyst',
      category: TemplateCategory.tech,
      categoryName: 'Tech & Engineering',
      description:
          'Emphasizes SQL, Python, Tableau/PowerBI, data modeling, ETL pipelines, and business impact metric callouts.',
      isAtsSafe: true,
      recommendedFor: 'Data Analysts, BI Developers, Data Scientists',
      previewAccent: Color(0xFF059669),
      tags: ['ATS Safe', 'Metrics Driven', 'SQL & BI', 'Data Impact'],
      fontFamily: 'Inter',
    ),
    // 13
    TemplateInfo(
      id: 'ui_ux_designer',
      name: 'UI/UX Designer',
      category: TemplateCategory.creative,
      categoryName: 'Design & Creative',
      description:
          'Subtle creative accent typography, design system proficiency, user research case-study links, and Figma prowess.',
      isAtsSafe: true,
      recommendedFor: 'Product Designers, UX Researchers, Visual Designers',
      previewAccent: Color(0xFF7C3AED),
      tags: ['ATS Safe', 'Design Flair', 'Portfolio First', 'Case Studies'],
      fontFamily: 'Poppins',
    ),
    // 14
    TemplateInfo(
      id: 'product_manager',
      name: 'Product Manager',
      category: TemplateCategory.executive,
      categoryName: 'Executive & Leadership',
      description:
          'Centers on product lifecycle, roadmap execution, OKRs, KPI growth, and cross-functional leadership milestones.',
      isAtsSafe: true,
      recommendedFor: 'APMs, Product Managers, Group PMs, CPOs',
      previewAccent: Color(0xFF4338CA),
      tags: ['ATS Safe', 'OKRs & KPIs', 'Strategy', 'Growth'],
      fontFamily: 'Inter',
    ),
    // 15
    TemplateInfo(
      id: 'marketing',
      name: 'Marketing Specialist',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Tailored for campaign impact: CAC reduction, ROAS, MQL generation, SEO/SEM performance, and brand growth metrics.',
      isAtsSafe: true,
      recommendedFor: 'Growth Marketers, Digital Strategists, Content Leads',
      previewAccent: Color(0xFFD97706),
      tags: ['ATS Safe', 'Campaign Metrics', 'Growth', 'ROI Focus'],
      fontFamily: 'Lato',
    ),
    // 16
    TemplateInfo(
      id: 'sales',
      name: 'Sales Executive',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Puts quota attainment percentages, closed deal revenue, enterprise client acquisition, and CRM mastery front-and-center.',
      isAtsSafe: true,
      recommendedFor: 'Account Executives, SDRs, VP of Sales, Business Development',
      previewAccent: Color(0xFF15803D),
      tags: ['ATS Safe', 'Quota %', 'Revenue Numbers', 'Accounts'],
      fontFamily: 'Roboto',
    ),
    // 17
    TemplateInfo(
      id: 'finance',
      name: 'Finance & Banking',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Strict Wall Street / Big Four format. Formal, conservative, high-density financial modeling & auditing layout.',
      isAtsSafe: true,
      recommendedFor: 'Investment Bankers, Financial Analysts, Auditors, CPAs',
      previewAccent: Color(0xFF1E293B),
      tags: ['ATS Safe', 'Strict Formal', 'Wall St Standard', 'Dense'],
      fontFamily: 'Merriweather',
    ),
    // 18
    TemplateInfo(
      id: 'project_manager',
      name: 'Project Manager',
      category: TemplateCategory.executive,
      categoryName: 'Executive & Leadership',
      description:
          'Agile/Scrum/PMP methodology highlights, budget governance, risk mitigation, and milestone delivery stats.',
      isAtsSafe: true,
      recommendedFor: 'Scrum Masters, Agile Coaches, Technical Project Managers',
      previewAccent: Color(0xFF0369A1),
      tags: ['ATS Safe', 'PMP / Agile', 'Budget On-Time', 'Governance'],
      fontFamily: 'Inter',
    ),
    // 19
    TemplateInfo(
      id: 'engineering',
      name: 'Engineering',
      category: TemplateCategory.tech,
      categoryName: 'Tech & Engineering',
      description:
          'Designed for mechanical, electrical, and systems engineers. Emphasizes CAD/CAM tools, compliance standards, and patents.',
      isAtsSafe: true,
      recommendedFor: 'Mechanical, Electrical, Civil, Systems Engineers',
      previewAccent: Color(0xFF334155),
      tags: ['ATS Safe', 'CAD & Standards', 'Patents', 'Hardware'],
      fontFamily: 'Roboto',
    ),
    // 20
    TemplateInfo(
      id: 'academic',
      name: 'Academic CV',
      category: TemplateCategory.academicHealthcare,
      categoryName: 'Academic & Healthcare',
      description:
          'Formal curriculum vitae formatting with teaching experience, course development, faculty committees, and pedagogy.',
      isAtsSafe: true,
      recommendedFor: 'Professors, Lecturers, Postdocs, Academic Applicants',
      previewAccent: Color(0xFF374151),
      tags: ['ATS Safe', 'Curriculum Vitae', 'Teaching', 'Faculty'],
      fontFamily: 'Merriweather',
    ),
    // 21
    TemplateInfo(
      id: 'research',
      name: 'Research Scientist',
      category: TemplateCategory.academicHealthcare,
      categoryName: 'Academic & Healthcare',
      description:
          'Highlights peer-reviewed publications, DOI links, lab affiliations, grant awards, and experimental methodology.',
      isAtsSafe: true,
      recommendedFor: 'Research Scientists, PhD Candidates, R&D Specialists',
      previewAccent: Color(0xFF1E40AF),
      tags: ['ATS Safe', 'Publications', 'Grants', 'Peer-Reviewed'],
      fontFamily: 'Merriweather',
    ),
    // 22
    TemplateInfo(
      id: 'healthcare',
      name: 'Healthcare & Clinical',
      category: TemplateCategory.academicHealthcare,
      categoryName: 'Academic & Healthcare',
      description:
          'Clinical rotations, state medical licensing, patient outcomes, HIPAA compliance, and hospital department experience.',
      isAtsSafe: true,
      recommendedFor: 'Nurses, Physicians, Clinical Specialists, Pharmacists',
      previewAccent: Color(0xFF0E7490),
      tags: ['ATS Safe', 'Licenses', 'Clinical Care', 'Hospital'],
      fontFamily: 'Inter',
    ),
    // 23
    TemplateInfo(
      id: 'customer_support',
      name: 'Customer Support',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Highlights CSAT and NPS metrics, SLA resolution rates, ticketing systems (Zendesk, Salesforce), and empathy skills.',
      isAtsSafe: true,
      recommendedFor: 'Support Specialists, Customer Success Managers, Helpdesk Leads',
      previewAccent: Color(0xFF059669),
      tags: ['ATS Safe', 'CSAT & NPS', 'Zendesk', 'Client Success'],
      fontFamily: 'Inter',
    ),
    // 24
    TemplateInfo(
      id: 'human_resources',
      name: 'Human Resources',
      category: TemplateCategory.professional,
      categoryName: 'Professional',
      description:
          'Talent acquisition metrics, employee retention programs, HRIS platforms (Workday, BambooHR), and compliance stewardship.',
      isAtsSafe: true,
      recommendedFor: 'HR Generalists, Recruiters, People Ops Managers',
      previewAccent: Color(0xFF6B21A8),
      tags: ['ATS Safe', 'Talent Ops', 'HRIS Systems', 'People Ops'],
      fontFamily: 'Inter',
    ),
    // 25
    TemplateInfo(
      id: 'internship',
      name: 'Internship Applicant',
      category: TemplateCategory.entryLevel,
      categoryName: 'Entry-Level & Students',
      description:
          'Concise single-page format emphasizing university coursework, passion projects, student clubs, and quick adaptability.',
      isAtsSafe: true,
      recommendedFor: 'Summer Internships, Co-op Programs, Traineeships',
      previewAccent: Color(0xFF2563EB),
      tags: ['ATS Safe', 'Single Page', 'Campus Leader', 'High Impact'],
      fontFamily: 'Inter',
    ),
  ];

  static TemplateInfo getById(String id) {
    return allTemplates.firstWhere(
      (t) => t.id == id,
      orElse: () => allTemplates[1], // default modern_professional
    );
  }
}
