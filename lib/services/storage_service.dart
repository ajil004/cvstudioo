import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/resume_data.dart';

class ResumeMeta {
  final String id;
  final String title;
  final String templateId;
  final DateTime lastModified;

  ResumeMeta({
    required this.id,
    required this.title,
    required this.templateId,
    required this.lastModified,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'templateId': templateId,
        'lastModified': lastModified.toIso8601String(),
      };

  factory ResumeMeta.fromJson(Map<String, dynamic> json) => ResumeMeta(
        id: json['id'] as String,
        title: json['title'] as String? ?? 'Untitled Resume',
        templateId: json['templateId'] as String? ?? 'modern_professional',
        lastModified: json['lastModified'] != null
            ? DateTime.tryParse(json['lastModified'] as String) ?? DateTime.now()
            : DateTime.now(),
      );
}

class StorageService {
  static const String _currentResumeKey = 'cvstudio_active_resume';
  static const String _resumeListKey = 'cvstudio_saved_resumes_list';
  static const String _resumePrefix = 'cvstudio_resume_';

  /// Load current active resume, or initialize with clean empty resume
  static Future<ResumeData> loadActiveResume() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_currentResumeKey);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final loaded = ResumeData.fromJsonString(jsonStr);
        // If the stored resume was demo/sample data, reset to clean empty resume so all fields start empty
        if (loaded.id == 'sample_resume_01' ||
            loaded.id == 'demo_resume_01' ||
            loaded.email == 'ajilarun004@gmail.com' ||
            loaded.fullName == 'Ajil A' ||
            loaded.fullName == 'Ajil' ||
            (loaded.jobTitle == 'Flutter Developer' && (loaded.email == 'demo@example.com' || loaded.email.isEmpty)) ||
            loaded.phone.contains('+91') ||
            loaded.experience.any((e) => e.company == 'Nexus Tech Innovations' || e.company == 'Tech Innovations')) {
          final emptyResume = ResumeData.empty();
          await saveActiveResume(emptyResume);
          return emptyResume;
        }
        return loaded;
      } catch (e) {
        final emptyResume = ResumeData.empty();
        await saveActiveResume(emptyResume);
        return emptyResume;
      }
    }

    // First time user: initialize with clean empty resume
    final initialResume = ResumeData.empty();
    await saveActiveResume(initialResume);
    await saveResumeToList(initialResume);
    return initialResume;
  }

  /// Create a fresh empty resume
  static Future<ResumeData> createNewResume({String title = 'My Resume'}) async {
    final empty = ResumeData.empty().copyWith(resumeTitle: title);
    await saveActiveResume(empty);
    await saveResumeToList(empty);
    return empty;
  }

  /// Save the currently active resume
  static Future<void> saveActiveResume(ResumeData resume) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = resume.toJsonString();
    await prefs.setString(_currentResumeKey, jsonStr);
    await prefs.setString('$_resumePrefix${resume.id}', jsonStr);
    await _updateMetaList(resume);
  }

  /// Get list of saved resume versions
  static Future<List<ResumeMeta>> getSavedResumes() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_resumeListKey) ?? [];
    final List<ResumeMeta> metas = [];
    for (final item in rawList) {
      try {
        metas.add(ResumeMeta.fromJson(jsonDecode(item) as Map<String, dynamic>));
      } catch (_) {}
    }
    return metas;
  }

  /// Save resume to metadata list
  static Future<void> saveResumeToList(ResumeData resume) async {
    await _updateMetaList(resume);
  }

  static Future<void> _updateMetaList(ResumeData resume) async {
    final prefs = await SharedPreferences.getInstance();
    final metas = await getSavedResumes();
    final existingIndex = metas.indexWhere((m) => m.id == resume.id);

    final newMeta = ResumeMeta(
      id: resume.id,
      title: resume.resumeTitle.isNotEmpty ? resume.resumeTitle : 'Untitled Resume',
      templateId: resume.templateId,
      lastModified: DateTime.now(),
    );

    if (existingIndex >= 0) {
      metas[existingIndex] = newMeta;
    } else {
      metas.insert(0, newMeta);
    }

    final rawList = metas.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList(_resumeListKey, rawList);
  }

  /// Load a specific resume by ID
  static Future<ResumeData?> loadResumeById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('$_resumePrefix$id');
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final resume = ResumeData.fromJsonString(jsonStr);
        await prefs.setString(_currentResumeKey, jsonStr);
        return resume;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Create a new version/copy of a resume
  static Future<ResumeData> duplicateResume(ResumeData source, {String? newTitle}) async {
    final newId = UniqueId.generate();
    final duplicated = source.copyWith(
      id: newId,
      resumeTitle: newTitle ?? '${source.resumeTitle} (Copy)',
      lastModified: DateTime.now(),
    );
    await saveActiveResume(duplicated);
    return duplicated;
  }

  /// Rename a saved resume
  static Future<void> renameResume(String id, String newTitle) async {
    final resume = await loadResumeById(id);
    if (resume != null) {
      final updated = resume.copyWith(resumeTitle: newTitle);
      await saveActiveResume(updated);
    }
  }

  /// Delete a saved resume
  static Future<void> deleteResume(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_resumePrefix$id');

    final metas = await getSavedResumes();
    metas.removeWhere((m) => m.id == id);
    final rawList = metas.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList(_resumeListKey, rawList);
  }

  /// Clear all locally stored resume data
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    final metas = await getSavedResumes();
    for (final m in metas) {
      await prefs.remove('$_resumePrefix${m.id}');
    }
    await prefs.remove(_currentResumeKey);
    await prefs.remove(_resumeListKey);
  }
}
