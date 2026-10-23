import 'package:flutter/material.dart';
import '../../models/resume_data.dart';

/// Form section header helper
Widget buildSectionCard({
  required BuildContext context,
  required String title,
  required IconData icon,
  required String subtitle,
  required Widget child,
  Widget? trailingAction,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Card(
    margin: const EdgeInsets.only(bottom: 20),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF2563EB), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              if (trailingAction != null) trailingAction,
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    ),
  );
}

/// Standard text form field with two-way controller sync and clean placeholder hints
class AppFormField extends StatefulWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final String? hint;
  final bool isOptional;
  final int maxLines;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;

  const AppFormField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
    this.isOptional = false,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixIcon,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(AppFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text && widget.value != oldWidget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
            ),
            if (widget.isOptional)
              const Text(
                ' (Optional)',
                style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
              ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _controller,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon,
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

/// Helper for standard text form fields
Widget buildTextField({
  required String label,
  required String value,
  required ValueChanged<String> onChanged,
  String? hint,
  bool isOptional = false,
  int maxLines = 1,
  TextInputType? keyboardType,
  Widget? prefixIcon,
}) {
  return AppFormField(
    label: label,
    value: value,
    onChanged: onChanged,
    hint: hint,
    isOptional: isOptional,
    maxLines: maxLines,
    keyboardType: keyboardType,
    prefixIcon: prefixIcon,
  );
}

// -------------------------------------------------------------
// 1. PERSONAL DETAILS FORM
// -------------------------------------------------------------
class PersonalDetailsForm extends StatelessWidget {
  final ResumeData resume;
  final ValueChanged<ResumeData> onResumeChanged;

  const PersonalDetailsForm({
    super.key,
    required this.resume,
    required this.onResumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return buildSectionCard(
      context: context,
      title: 'Personal & Contact Information',
      subtitle: 'Enter your contact details for recruiters and hiring managers.',
      icon: Icons.person_outline,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  label: 'Full Name',
                  value: resume.fullName,
                  hint: 'e.g. Alex Morgan',
                  onChanged: (val) => onResumeChanged(resume.copyWith(fullName: val)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: buildTextField(
                  label: 'Professional Title',
                  value: resume.jobTitle,
                  hint: 'e.g. Software Engineer',
                  onChanged: (val) => onResumeChanged(resume.copyWith(jobTitle: val)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  label: 'Email Address',
                  value: resume.email,
                  hint: 'e.g. alex@example.com',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) => onResumeChanged(resume.copyWith(email: val)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: buildTextField(
                  label: 'Phone Number',
                  value: resume.phone,
                  hint: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  onChanged: (val) => onResumeChanged(resume.copyWith(phone: val)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  label: 'City & Country',
                  value: resume.location,
                  hint: 'e.g. San Francisco, CA',
                  onChanged: (val) => onResumeChanged(resume.copyWith(location: val)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: buildTextField(
                  label: 'LinkedIn Profile',
                  value: resume.linkedIn,
                  hint: 'linkedin.com/in/username',
                  isOptional: true,
                  onChanged: (val) => onResumeChanged(resume.copyWith(linkedIn: val)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  label: 'GitHub URL',
                  value: resume.gitHub,
                  hint: 'github.com/username',
                  isOptional: true,
                  onChanged: (val) => onResumeChanged(resume.copyWith(gitHub: val)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: buildTextField(
                  label: 'Portfolio Website',
                  value: resume.portfolioUrl,
                  hint: 'portfolio.dev',
                  isOptional: true,
                  onChanged: (val) => onResumeChanged(resume.copyWith(portfolioUrl: val)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 2. PROFESSIONAL SUMMARY FORM
// -------------------------------------------------------------
class SummaryForm extends StatelessWidget {
  final ResumeData resume;
  final ValueChanged<ResumeData> onResumeChanged;

  const SummaryForm({
    super.key,
    required this.resume,
    required this.onResumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final wordCount = resume.summary.trim().isEmpty
        ? 0
        : resume.summary.trim().split(RegExp(r'\s+')).length;

    return buildSectionCard(
      context: context,
      title: 'Professional Summary',
      subtitle: '3-4 sentences outlining your core value proposition, key tech, and quantifiable milestones.',
      icon: Icons.notes_outlined,
      trailingAction: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: (wordCount >= 30 && wordCount <= 120)
              ? const Color(0xFF10B981).withOpacity(0.12)
              : const Color(0xFFF59E0B).withOpacity(0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '$wordCount words (Optimal: 40-100)',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: (wordCount >= 30 && wordCount <= 120)
                ? const Color(0xFF10B981)
                : const Color(0xFFD97706),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextField(
            label: 'Summary Statement',
            value: resume.summary,
            hint: 'Write a compelling 2-4 sentence summary highlighting your core strengths, technical skills, and career achievements...',
            maxLines: 5,
            onChanged: (val) => onResumeChanged(resume.copyWith(summary: val)),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, size: 16, color: Color(0xFF2563EB)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tip: Start with your title & years of experience, mention 2-3 core specialties (e.g. Flutter, scalable APIs), and end with a measurable win (e.g. "boosted performance by 40%").',
                    style: TextStyle(fontSize: 12, color: Color(0xFF1E3A8A), height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. WORK EXPERIENCE FORM
// -------------------------------------------------------------
class ExperienceForm extends StatelessWidget {
  final ResumeData resume;
  final ValueChanged<ResumeData> onResumeChanged;

  const ExperienceForm({
    super.key,
    required this.resume,
    required this.onResumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return buildSectionCard(
      context: context,
      title: 'Work Experience',
      subtitle: 'List your career positions in reverse chronological order with action-driven achievements.',
      icon: Icons.work_outline,
      trailingAction: TextButton.icon(
        icon: const Icon(Icons.add, size: 16),
        label: const Text('Add Position'),
        onPressed: _addNewExperience,
      ),
      child: Column(
        children: [
          if (resume.experience.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'No experience entries yet. Click "Add Position" above.',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                ),
              ),
            ),
          ...resume.experience.asMap().entries.map((entry) {
            final index = entry.key;
            final exp = entry.value;
            return _buildExperienceCard(context, exp, index);
          }),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, ExperienceEntry exp, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Position #${index + 1}: ${exp.jobTitle.isNotEmpty ? exp.jobTitle : "Untitled"}',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              Row(
                children: [
                  if (index > 0)
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, size: 16),
                      tooltip: 'Move Up',
                      onPressed: () => _moveExperience(index, -1),
                    ),
                  if (index < resume.experience.length - 1)
                    IconButton(
                      icon: const Icon(Icons.arrow_downward, size: 16),
                      tooltip: 'Move Down',
                      onPressed: () => _moveExperience(index, 1),
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                    tooltip: 'Delete Position',
                    onPressed: () => _deleteExperience(exp.id),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  label: 'Job Title',
                  value: exp.jobTitle,
                  hint: 'e.g. Senior Software Engineer',
                  onChanged: (val) => _updateExperience(exp.copyWith(jobTitle: val)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildTextField(
                  label: 'Company Name',
                  value: exp.company,
                  hint: 'e.g. Acme Corp',
                  onChanged: (val) => _updateExperience(exp.copyWith(company: val)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  label: 'Location',
                  value: exp.location,
                  hint: 'e.g. New York, NY',
                  isOptional: true,
                  onChanged: (val) => _updateExperience(exp.copyWith(location: val)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildTextField(
                  label: 'Start Date',
                  value: exp.startDate,
                  hint: 'e.g. Jan 2022',
                  onChanged: (val) => _updateExperience(exp.copyWith(startDate: val)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildTextField(
                  label: 'End Date',
                  value: exp.isCurrent ? 'Present' : exp.endDate,
                  hint: 'Present',
                  onChanged: (val) => _updateExperience(exp.copyWith(endDate: val)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: exp.isCurrent,
                onChanged: (val) {
                  _updateExperience(exp.copyWith(isCurrent: val ?? false));
                },
              ),
              const Text('I currently work here', style: TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          buildTextField(
            label: 'Responsibilities & Measurable Achievements',
            value: exp.description,
            hint: '• Architected core design system, reducing codebase duplication by 35%.\n• Optimized rendering pipeline, cutting latency from 2.8s to 900ms.',
            maxLines: 4,
            onChanged: (val) => _updateExperience(exp.copyWith(description: val)),
          ),
        ],
      ),
    );
  }

  void _addNewExperience() {
    final newExp = ExperienceEntry(
      id: UniqueId.generate(),
      jobTitle: '',
      company: '',
      location: '',
      startDate: '',
      endDate: '',
      isCurrent: false,
      description: '',
    );
    onResumeChanged(resume.copyWith(
      experience: [newExp, ...resume.experience],
    ));
  }

  void _updateExperience(ExperienceEntry updated) {
    final updatedList = resume.experience.map((e) => e.id == updated.id ? updated : e).toList();
    onResumeChanged(resume.copyWith(experience: updatedList));
  }

  void _deleteExperience(String id) {
    final updatedList = resume.experience.where((e) => e.id != id).toList();
    onResumeChanged(resume.copyWith(experience: updatedList));
  }

  void _moveExperience(int index, int delta) {
    final target = index + delta;
    if (target < 0 || target >= resume.experience.length) return;
    final list = List<ExperienceEntry>.from(resume.experience);
    final item = list.removeAt(index);
    list.insert(target, item);
    onResumeChanged(resume.copyWith(experience: list));
  }
}

// -------------------------------------------------------------
// 4. EDUCATION FORM
// -------------------------------------------------------------
class EducationForm extends StatelessWidget {
  final ResumeData resume;
  final ValueChanged<ResumeData> onResumeChanged;

  const EducationForm({
    super.key,
    required this.resume,
    required this.onResumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return buildSectionCard(
      context: context,
      title: 'Education & Credentials',
      subtitle: 'Degrees, academic institutions, graduation dates, and relevant coursework.',
      icon: Icons.school_outlined,
      trailingAction: TextButton.icon(
        icon: const Icon(Icons.add, size: 16),
        label: const Text('Add Education'),
        onPressed: _addNewEducation,
      ),
      child: Column(
        children: [
          ...resume.education.map((edu) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          edu.degree.isNotEmpty ? edu.degree : 'Degree Title',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                        onPressed: () => _deleteEducation(edu.id),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          label: 'Degree',
                          value: edu.degree,
                          hint: 'e.g. B.S. in Computer Science',
                          onChanged: (val) => _updateEducation(edu.copyWith(degree: val)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: buildTextField(
                          label: 'Institution / University',
                          value: edu.institution,
                          hint: 'e.g. Stanford University',
                          onChanged: (val) => _updateEducation(edu.copyWith(institution: val)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          label: 'Graduation Year / Dates',
                          value: edu.endDate,
                          hint: '2024 or 2020 - 2024',
                          onChanged: (val) => _updateEducation(edu.copyWith(endDate: val)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: buildTextField(
                          label: 'Grade / GPA',
                          value: edu.grade,
                          hint: 'e.g. 3.8 GPA',
                          isOptional: true,
                          onChanged: (val) => _updateEducation(edu.copyWith(grade: val)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    label: 'Relevant Coursework',
                    value: edu.coursework,
                    hint: 'Data Structures, Distributed Systems, Software Architecture',
                    isOptional: true,
                    onChanged: (val) => _updateEducation(edu.copyWith(coursework: val)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _addNewEducation() {
    final newEdu = EducationEntry(
      id: UniqueId.generate(),
      degree: '',
      institution: '',
      endDate: '',
    );
    onResumeChanged(resume.copyWith(education: [...resume.education, newEdu]));
  }

  void _updateEducation(EducationEntry updated) {
    final list = resume.education.map((e) => e.id == updated.id ? updated : e).toList();
    onResumeChanged(resume.copyWith(education: list));
  }

  void _deleteEducation(String id) {
    final list = resume.education.where((e) => e.id != id).toList();
    onResumeChanged(resume.copyWith(education: list));
  }
}

// -------------------------------------------------------------
// 5. SKILLS FORM
// -------------------------------------------------------------
class SkillsForm extends StatefulWidget {
  final ResumeData resume;
  final ValueChanged<ResumeData> onResumeChanged;

  const SkillsForm({
    super.key,
    required this.resume,
    required this.onResumeChanged,
  });

  @override
  State<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  final TextEditingController _techController = TextEditingController();
  final TextEditingController _toolController = TextEditingController();
  final TextEditingController _softController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildSectionCard(
      context: context,
      title: 'Skills & Competencies',
      subtitle: 'Add categorized tags for Technical Skills, Tools & Cloud, and Core Soft Skills.',
      icon: Icons.code,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Technical Skills
          _buildSkillCategory(
            title: 'Technical Skills (Languages, Frameworks, Databases)',
            controller: _techController,
            tags: widget.resume.technicalSkills,
            onAdd: (tag) {
              if (tag.isNotEmpty && !widget.resume.technicalSkills.contains(tag)) {
                widget.onResumeChanged(widget.resume.copyWith(
                  technicalSkills: [...widget.resume.technicalSkills, tag],
                ));
              }
            },
            onRemove: (tag) {
              widget.onResumeChanged(widget.resume.copyWith(
                technicalSkills: widget.resume.technicalSkills.where((t) => t != tag).toList(),
              ));
            },
          ),
          const SizedBox(height: 18),

          // Tools & Technologies
          _buildSkillCategory(
            title: 'Tools, Cloud & Infrastructure',
            controller: _toolController,
            tags: widget.resume.toolsAndTechnologies,
            onAdd: (tag) {
              if (tag.isNotEmpty && !widget.resume.toolsAndTechnologies.contains(tag)) {
                widget.onResumeChanged(widget.resume.copyWith(
                  toolsAndTechnologies: [...widget.resume.toolsAndTechnologies, tag],
                ));
              }
            },
            onRemove: (tag) {
              widget.onResumeChanged(widget.resume.copyWith(
                toolsAndTechnologies: widget.resume.toolsAndTechnologies.where((t) => t != tag).toList(),
              ));
            },
          ),
          const SizedBox(height: 18),

          // Soft Skills
          _buildSkillCategory(
            title: 'Soft Skills & Leadership',
            controller: _softController,
            tags: widget.resume.softSkills,
            onAdd: (tag) {
              if (tag.isNotEmpty && !widget.resume.softSkills.contains(tag)) {
                widget.onResumeChanged(widget.resume.copyWith(
                  softSkills: [...widget.resume.softSkills, tag],
                ));
              }
            },
            onRemove: (tag) {
              widget.onResumeChanged(widget.resume.copyWith(
                softSkills: widget.resume.softSkills.where((t) => t != tag).toList(),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory({
    required String title,
    required TextEditingController controller,
    required List<String> tags,
    required ValueChanged<String> onAdd,
    required ValueChanged<String> onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Type skill name and press Enter or Add',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                onSubmitted: (val) {
                  onAdd(val.trim());
                  controller.clear();
                },
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () {
                onAdd(controller.text.trim());
                controller.clear();
              },
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: tags.map((t) {
            return Chip(
              label: Text(t, style: const TextStyle(fontSize: 12)),
              deleteIcon: const Icon(Icons.close, size: 14),
              onDeleted: () => onRemove(t),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// -------------------------------------------------------------
// 6. PROJECTS FORM
// -------------------------------------------------------------
class ProjectsForm extends StatelessWidget {
  final ResumeData resume;
  final ValueChanged<ResumeData> onResumeChanged;

  const ProjectsForm({
    super.key,
    required this.resume,
    required this.onResumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return buildSectionCard(
      context: context,
      title: 'Featured Projects',
      subtitle: 'Technical projects demonstrating hands-on proficiency and problem-solving capability.',
      icon: Icons.rocket_launch_outlined,
      trailingAction: TextButton.icon(
        icon: const Icon(Icons.add, size: 16),
        label: const Text('Add Project'),
        onPressed: _addNewProject,
      ),
      child: Column(
        children: [
          ...resume.projects.map((proj) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          proj.title.isNotEmpty ? proj.title : 'Project Title',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                        onPressed: () => _deleteProject(proj.id),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          label: 'Project Title',
                          value: proj.title,
                          hint: 'e.g. Portfolio Website',
                          onChanged: (val) => _updateProject(proj.copyWith(title: val)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: buildTextField(
                          label: 'Project URL / Demo',
                          value: proj.projectUrl,
                          hint: 'https://github.com/username/project',
                          isOptional: true,
                          onChanged: (val) => _updateProject(proj.copyWith(projectUrl: val)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    label: 'Description',
                    value: proj.description,
                    hint: 'Brief overview of problem solved and architecture...',
                    maxLines: 2,
                    onChanged: (val) => _updateProject(proj.copyWith(description: val)),
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    label: 'Technologies Used (Comma separated)',
                    value: proj.technologies.join(', '),
                    hint: 'Flutter, Dart, Node.js, SQLite',
                    isOptional: true,
                    onChanged: (val) {
                      final techList = val.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
                      _updateProject(proj.copyWith(technologies: techList));
                    },
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    label: 'Measurable Achievement / Metric',
                    value: proj.achievements,
                    hint: 'e.g. Processed 50,000+ resumes with sub-second generation.',
                    isOptional: true,
                    onChanged: (val) => _updateProject(proj.copyWith(achievements: val)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _addNewProject() {
    final newProj = ProjectEntry(
      id: UniqueId.generate(),
      title: '',
      description: '',
      technologies: [],
    );
    onResumeChanged(resume.copyWith(projects: [...resume.projects, newProj]));
  }

  void _updateProject(ProjectEntry updated) {
    final list = resume.projects.map((p) => p.id == updated.id ? updated : p).toList();
    onResumeChanged(resume.copyWith(projects: list));
  }

  void _deleteProject(String id) {
    final list = resume.projects.where((p) => p.id != id).toList();
    onResumeChanged(resume.copyWith(projects: list));
  }
}


