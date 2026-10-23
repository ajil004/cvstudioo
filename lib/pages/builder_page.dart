import 'package:flutter/material.dart';
import '../models/resume_data.dart';
import '../models/template_info.dart';
import '../services/storage_service.dart';
import '../services/sample_data_service.dart';
import '../services/pdf_service.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/builder/form_sections.dart';
import '../widgets/builder/additional_sections_form.dart';
import '../widgets/preview/resume_preview_canvas.dart';

class BuilderPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const BuilderPage({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> with SingleTickerProviderStateMixin {
  ResumeData? _resume;
  bool _isLoading = true;
  TabController? _mobileTabController;

  @override
  void initState() {
    super.initState();
    _mobileTabController = TabController(length: 2, vsync: this);
    _loadResume();
  }

  Future<void> _loadResume() async {
    final resume = await StorageService.loadActiveResume();
    if (mounted) {
      setState(() {
        _resume = resume;
        _isLoading = false;
      });
    }
  }

  void _onDataChanged(ResumeData updated) {
    setState(() {
      _resume = updated;
    });
    // Auto-save to browser local storage
    StorageService.saveActiveResume(updated);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 980;

    return Scaffold(
      appBar: AppNavbar(
        activeRoute: '/builder',
        onToggleTheme: widget.onToggleTheme,
        isDark: widget.isDark,
      ),
      body: _isLoading || _resume == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 1. BUILDER TOP TOOLBAR
                _buildTopToolbar(isMobile),

                // 2. MAIN CONTENT (Side-by-side or mobile tab view)
                Expanded(
                  child: isMobile
                      ? _buildMobileContent()
                      : _buildDesktopContent(),
                ),
              ],
            ),
    );
  }

  Widget _buildTopToolbar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF131B2E) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: widget.isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          // Resume Title & Version Manager
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.description, size: 18, color: Color(0xFF2563EB)),
              const SizedBox(width: 8),
              InkWell(
                onTap: _openVersionManager,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    children: [
                      Text(
                        _resume!.resumeTitle.isNotEmpty ? _resume!.resumeTitle : 'My Resume',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.cloud_done_outlined, size: 12, color: Color(0xFF10B981)),
                    SizedBox(width: 4),
                    Text(
                      'Auto-saved',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF10B981)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Template Quick Selector Dropdown
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Template: ', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _resume!.templateId,
                    isDense: true,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                    items: TemplateInfo.allTemplates.map((t) {
                      return DropdownMenuItem<String>(
                        value: t.id,
                        child: Text(t.name),
                      );
                    }).toList(),
                    onChanged: (newId) {
                      if (newId != null) {
                        _onDataChanged(_resume!.copyWith(templateId: newId));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          // Management & Quick Tools
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_sweep_outlined, size: 18, color: Color(0xFFEF4444)),
                tooltip: 'Clear All Fields (Start Empty)',
                onPressed: _confirmClearAllFields,
              ),
              IconButton(
                icon: const Icon(Icons.settings_backup_restore, size: 18),
                tooltip: 'Load Example Profile',
                onPressed: _confirmLoadSample,
              ),
              IconButton(
                icon: const Icon(Icons.file_download_outlined, size: 18),
                tooltip: 'Backup / Export JSON',
                onPressed: _openJsonModal,
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.download, size: 16),
                label: const Text('Download PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
                onPressed: () => PdfService.downloadResumePdf(_resume!),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Scrollable Editor Form (50% width)
        Expanded(
          flex: 1,
          child: Container(
            color: widget.isDark ? const Color(0xFF0B0F19) : const Color(0xFFF8FAFC),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PersonalDetailsForm(
                    resume: _resume!,
                    onResumeChanged: _onDataChanged,
                  ),
                  SummaryForm(
                    resume: _resume!,
                    onResumeChanged: _onDataChanged,
                  ),
                  ExperienceForm(
                    resume: _resume!,
                    onResumeChanged: _onDataChanged,
                  ),
                  EducationForm(
                    resume: _resume!,
                    onResumeChanged: _onDataChanged,
                  ),
                  SkillsForm(
                    resume: _resume!,
                    onResumeChanged: _onDataChanged,
                  ),
                  ProjectsForm(
                    resume: _resume!,
                    onResumeChanged: _onDataChanged,
                  ),
                  AdditionalSectionsForm(
                    resume: _resume!,
                    onResumeChanged: _onDataChanged,
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),

        // Vertical divider
        Container(
          width: 1,
          color: widget.isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
        ),

        // Right Column: Live Sticky Resume Preview Canvas (50% width)
        Expanded(
          flex: 1,
          child: ResumePreviewCanvas(
            resume: _resume!,
            onResumeChanged: _onDataChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileContent() {
    return Column(
      children: [
        Container(
          color: widget.isDark ? const Color(0xFF131B2E) : Colors.white,
          child: TabBar(
            controller: _mobileTabController,
            labelColor: const Color(0xFF2563EB),
            indicatorColor: const Color(0xFF2563EB),
            tabs: const [
              Tab(icon: Icon(Icons.edit_note), text: 'Edit Details'),
              Tab(icon: Icon(Icons.visibility), text: 'Live Preview'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _mobileTabController,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    PersonalDetailsForm(
                      resume: _resume!,
                      onResumeChanged: _onDataChanged,
                    ),
                    SummaryForm(
                      resume: _resume!,
                      onResumeChanged: _onDataChanged,
                    ),
                    ExperienceForm(
                      resume: _resume!,
                      onResumeChanged: _onDataChanged,
                    ),
                    EducationForm(
                      resume: _resume!,
                      onResumeChanged: _onDataChanged,
                    ),
                    SkillsForm(
                      resume: _resume!,
                      onResumeChanged: _onDataChanged,
                    ),
                    ProjectsForm(
                      resume: _resume!,
                      onResumeChanged: _onDataChanged,
                    ),
                    AdditionalSectionsForm(
                      resume: _resume!,
                      onResumeChanged: _onDataChanged,
                    ),
                  ],
                ),
              ),
              ResumePreviewCanvas(
                resume: _resume!,
                onResumeChanged: _onDataChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openVersionManager() async {
    final metas = await StorageService.getSavedResumes();
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Saved Resume Versions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Wrap(
                    spacing: 8,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.note_add_outlined, size: 16),
                        label: const Text('New Empty Resume'),
                        onPressed: () async {
                          Navigator.pop(ctx);
                          final fresh = await StorageService.createNewResume();
                          if (!mounted) return;
                          setState(() => _resume = fresh);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Created a clean empty resume.')),
                          );
                        },
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.copy, size: 16),
                        label: const Text('Duplicate'),
                        onPressed: () async {
                          Navigator.pop(ctx);
                          final copy = await StorageService.duplicateResume(_resume!);
                          if (!mounted) return;
                          setState(() => _resume = copy);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Created duplicated version.')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...metas.map((m) {
                final isCurrent = m.id == _resume!.id;
                return ListTile(
                  dense: true,
                  leading: Icon(
                    isCurrent ? Icons.check_circle : Icons.description_outlined,
                    color: isCurrent ? const Color(0xFF2563EB) : null,
                  ),
                  title: Text(m.title, style: TextStyle(fontWeight: isCurrent ? FontWeight.w700 : FontWeight.normal)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 16),
                        tooltip: 'Rename',
                        onPressed: () {
                          Navigator.pop(ctx);
                          _renameModal(m.id, m.title);
                        },
                      ),
                      if (metas.length > 1)
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 16, color: Color(0xFFEF4444)),
                          tooltip: 'Delete',
                          onPressed: () async {
                            await StorageService.deleteResume(m.id);
                            Navigator.pop(ctx);
                            if (mounted) _loadResume();
                          },
                        ),
                    ],
                  ),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final loaded = await StorageService.loadResumeById(m.id);
                    if (loaded != null) {
                      setState(() => _resume = loaded);
                    }
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _renameModal(String id, String currentTitle) {
    final controller = TextEditingController(text: currentTitle);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename Resume'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Resume Name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                await StorageService.renameResume(id, newName);
                if (id == _resume!.id) {
                  setState(() => _resume = _resume!.copyWith(resumeTitle: newName));
                }
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmClearAllFields() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.delete_sweep_outlined, color: Color(0xFFEF4444)),
            SizedBox(width: 8),
            Text('Clear All Fields?'),
          ],
        ),
        content: const Text(
          'This will reset your resume form to start completely empty. Example text will display only as placeholder hints. Are you sure you want to clear everything?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final empty = ResumeData.empty().copyWith(
                id: _resume!.id,
                templateId: _resume!.templateId,
                resumeTitle: _resume!.resumeTitle,
              );
              _onDataChanged(empty);
              Navigator.pop(ctx);
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _confirmLoadSample() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Load Demo Profile?'),
        content: const Text(
          'This will populate your resume with a complete, realistic demo profile (Flutter Developer). Any unsaved changes to your active resume will be replaced.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final sample = SampleDataService.getSampleResume();
              _onDataChanged(sample);
              Navigator.pop(ctx);
            },
            child: const Text('Load Demo Profile'),
          ),
        ],
      ),
    );
  }

  void _openJsonModal() {
    final jsonStr = _resume!.toJsonString();
    final controller = TextEditingController(text: jsonStr);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('JSON Backup / Import'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Copy this JSON string to backup your resume, or paste an existing backup JSON string and click "Import".',
                style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 8,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
          ElevatedButton(
            onPressed: () {
              try {
                final imported = ResumeData.fromJsonString(controller.text.trim());
                _onDataChanged(imported);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Imported resume JSON successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invalid JSON format: $e')),
                );
              }
            },
            child: const Text('Import JSON'),
          ),
        ],
      ),
    );
  }
}
