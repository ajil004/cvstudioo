import 'package:flutter/material.dart';
import '../../models/resume_data.dart';
import 'form_sections.dart';

class AdditionalSectionsForm extends StatelessWidget {
  final ResumeData resume;
  final ValueChanged<ResumeData> onResumeChanged;

  const AdditionalSectionsForm({
    super.key,
    required this.resume,
    required this.onResumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return buildSectionCard(
      context: context,
      title: 'Additional Resume Sections',
      subtitle: 'Add Certifications, Languages, Awards, Volunteer Work, and Publications.',
      icon: Icons.add_circle_outline,
      trailingAction: OutlinedButton.icon(
        icon: const Icon(Icons.tune, size: 16),
        label: const Text('Manage Sections'),
        onPressed: () => _openSectionManager(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Certifications
          _buildCertificationsSub(context),
          const Divider(height: 32),

          // Languages
          _buildLanguagesSub(context),
          const Divider(height: 32),

          // Awards
          _buildAwardsSub(context),
          const Divider(height: 32),

          // Volunteer Work
          _buildVolunteerSub(context),
          const Divider(height: 32),

          // Publications
          _buildPublicationsSub(context),
        ],
      ),
    );
  }

  Widget _buildCertificationsSub(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Certifications', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Certification'),
              onPressed: () {
                final newCert = CertificationEntry(
                  id: UniqueId.generate(),
                  name: '',
                  issuer: '',
                );
                onResumeChanged(resume.copyWith(certifications: [...resume.certifications, newCert]));
              },
            ),
          ],
        ),
        ...resume.certifications.map((cert) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: buildTextField(
                    label: 'Certification Name',
                    value: cert.name,
                    hint: 'AWS Solutions Architect',
                    onChanged: (val) {
                      final list = resume.certifications
                          .map((c) => c.id == cert.id ? cert.copyWith(name: val) : c)
                          .toList();
                      onResumeChanged(resume.copyWith(certifications: list));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: buildTextField(
                    label: 'Issuer',
                    value: cert.issuer,
                    hint: 'Amazon Web Services',
                    onChanged: (val) {
                      final list = resume.certifications
                          .map((c) => c.id == cert.id ? cert.copyWith(issuer: val) : c)
                          .toList();
                      onResumeChanged(resume.copyWith(certifications: list));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: buildTextField(
                    label: 'Year',
                    value: cert.date,
                    hint: '2023',
                    isOptional: true,
                    onChanged: (val) {
                      final list = resume.certifications
                          .map((c) => c.id == cert.id ? cert.copyWith(date: val) : c)
                          .toList();
                      onResumeChanged(resume.copyWith(certifications: list));
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                  onPressed: () {
                    final list = resume.certifications.where((c) => c.id != cert.id).toList();
                    onResumeChanged(resume.copyWith(certifications: list));
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLanguagesSub(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Languages', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Language'),
              onPressed: () {
                final newLang = LanguageEntry(id: UniqueId.generate(), language: '');
                onResumeChanged(resume.copyWith(languages: [...resume.languages, newLang]));
              },
            ),
          ],
        ),
        ...resume.languages.map((lang) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: buildTextField(
                    label: 'Language',
                    value: lang.language,
                    hint: 'English / German / Japanese',
                    onChanged: (val) {
                      final list = resume.languages
                          .map((l) => l.id == lang.id ? LanguageEntry(id: l.id, language: val, proficiency: l.proficiency) : l)
                          .toList();
                      onResumeChanged(resume.copyWith(languages: list));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: buildTextField(
                    label: 'Proficiency',
                    value: lang.proficiency,
                    hint: 'Fluent / Native / Professional',
                    onChanged: (val) {
                      final list = resume.languages
                          .map((l) => l.id == lang.id ? LanguageEntry(id: l.id, language: l.language, proficiency: val) : l)
                          .toList();
                      onResumeChanged(resume.copyWith(languages: list));
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                  onPressed: () {
                    final list = resume.languages.where((l) => l.id != lang.id).toList();
                    onResumeChanged(resume.copyWith(languages: list));
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAwardsSub(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Honors & Awards', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Award'),
              onPressed: () {
                final newAward = AwardEntry(id: UniqueId.generate(), title: '');
                onResumeChanged(resume.copyWith(awards: [...resume.awards, newAward]));
              },
            ),
          ],
        ),
        ...resume.awards.map((award) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: buildTextField(
                    label: 'Award Title',
                    value: award.title,
                    hint: 'Innovation Excellence Award',
                    onChanged: (val) {
                      final list = resume.awards
                          .map((a) => a.id == award.id ? AwardEntry(id: a.id, title: val, issuer: a.issuer, date: a.date, description: a.description) : a)
                          .toList();
                      onResumeChanged(resume.copyWith(awards: list));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: buildTextField(
                    label: 'Description / Issuer',
                    value: award.description,
                    hint: 'Recognized for exceptional engineering...',
                    onChanged: (val) {
                      final list = resume.awards
                          .map((a) => a.id == award.id ? AwardEntry(id: a.id, title: a.title, issuer: a.issuer, date: a.date, description: val) : a)
                          .toList();
                      onResumeChanged(resume.copyWith(awards: list));
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                  onPressed: () {
                    final list = resume.awards.where((a) => a.id != award.id).toList();
                    onResumeChanged(resume.copyWith(awards: list));
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildVolunteerSub(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Volunteer Work', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Volunteer Role'),
              onPressed: () {
                final newVol = VolunteerEntry(id: UniqueId.generate(), role: '');
                onResumeChanged(resume.copyWith(volunteerWork: [...resume.volunteerWork, newVol]));
              },
            ),
          ],
        ),
        ...resume.volunteerWork.map((vol) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: buildTextField(
                    label: 'Role & Organization',
                    value: vol.role,
                    hint: 'Tech Mentor at Flutter India Community',
                    onChanged: (val) {
                      final list = resume.volunteerWork
                          .map((v) => v.id == vol.id ? VolunteerEntry(id: v.id, role: val, organization: v.organization, date: v.date, description: v.description) : v)
                          .toList();
                      onResumeChanged(resume.copyWith(volunteerWork: list));
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                  onPressed: () {
                    final list = resume.volunteerWork.where((v) => v.id != vol.id).toList();
                    onResumeChanged(resume.copyWith(volunteerWork: list));
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPublicationsSub(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Publications', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Publication'),
              onPressed: () {
                final newPub = PublicationEntry(id: UniqueId.generate(), title: '');
                onResumeChanged(resume.copyWith(publications: [...resume.publications, newPub]));
              },
            ),
          ],
        ),
        ...resume.publications.map((pub) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: buildTextField(
                    label: 'Publication Title & Publisher',
                    value: pub.title,
                    hint: 'Optimizing Client-Side Memory, Tech Innovators Quarterly',
                    onChanged: (val) {
                      final list = resume.publications
                          .map((p) => p.id == pub.id ? PublicationEntry(id: p.id, title: val, publisher: p.publisher, date: p.date, url: p.url, description: p.description) : p)
                          .toList();
                      onResumeChanged(resume.copyWith(publications: list));
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                  onPressed: () {
                    final list = resume.publications.where((p) => p.id != pub.id).toList();
                    onResumeChanged(resume.copyWith(publications: list));
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _openSectionManager(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return AlertDialog(
              title: const Text('Manage & Reorder Resume Sections'),
              content: SizedBox(
                width: 480,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Toggle sections on/off or reorder their sequence on your resume.',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 12),
                    ...resume.sectionOrder.map((key) {
                      final isEnabled = resume.enabledSections[key] ?? true;
                      return ListTile(
                        dense: true,
                        title: Text(key.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                        leading: Checkbox(
                          value: isEnabled,
                          onChanged: (val) {
                            final map = Map<String, bool>.from(resume.enabledSections);
                            map[key] = val ?? false;
                            onResumeChanged(resume.copyWith(enabledSections: map));
                            setDialogState(() {});
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
