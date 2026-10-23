import 'package:flutter/material.dart';
import '../../models/resume_data.dart';
import '../../models/template_info.dart';
import '../../templates/resume_widgets.dart';
import '../../services/pdf_service.dart';

class ResumePreviewCanvas extends StatefulWidget {
  final ResumeData resume;
  final ValueChanged<ResumeData> onResumeChanged;

  const ResumePreviewCanvas({
    super.key,
    required this.resume,
    required this.onResumeChanged,
  });

  @override
  State<ResumePreviewCanvas> createState() => _ResumePreviewCanvasState();
}

class _ResumePreviewCanvasState extends State<ResumePreviewCanvas> {
  double _zoomScale = 0.82; // Default desktop zoom
  bool _isGeneratingPdf = false;
  bool _showCustomizationPanel = false;

  // Available professional accent colors
  final List<Color> _accentColors = const [
    Color(0xFF1E3A8A), // Navy Slate
    Color(0xFF0F172A), // Deep Charcoal
    Color(0xFF2563EB), // Royal Blue
    Color(0xFF0284C7), // Sky Cyan
    Color(0xFF059669), // Emerald
    Color(0xFF4338CA), // Indigo
    Color(0xFF7C3AED), // Violet
    Color(0xFFD97706), // Amber
    Color(0xFFDC2626), // Crimson
    Color(0xFF334155), // Slate Gray
  ];

  final List<String> _fontFamilies = const [
    'Inter',
    'Roboto',
    'Merriweather',
    'Lato',
    'Poppins',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentTemplate = TemplateInfo.getById(widget.resume.templateId);

    return Container(
      color: isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
      child: Column(
        children: [
          // 1. TOP PREVIEW TOOLBAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                ),
              ),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                // Template Badge & Styling Button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        currentTemplate.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    TextButton.icon(
                      icon: Icon(
                        _showCustomizationPanel ? Icons.expand_less : Icons.tune,
                        size: 16,
                      ),
                      label: Text(_showCustomizationPanel ? 'Hide Styling' : 'Styling & Spacing'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () {
                        setState(() {
                          _showCustomizationPanel = !_showCustomizationPanel;
                        });
                      },
                    ),
                  ],
                ),

                // Accent Color Selector
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Color: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                    ..._accentColors.take(6).map((color) {
                      final isSelected = widget.resume.accentColorValue == color.toARGB32();
                      return GestureDetector(
                        onTap: () {
                          widget.onResumeChanged(
                            widget.resume.copyWith(accentColorValue: color.toARGB32()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.white : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: isSelected
                                ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 4, spreadRadius: 1)]
                                : null,
                          ),
                        ),
                      );
                    }),
                  ],
                ),

                // Zoom controls
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 16),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Zoom out',
                      onPressed: () {
                        setState(() {
                          _zoomScale = (_zoomScale - 0.1).clamp(0.4, 1.3);
                        });
                      },
                    ),
                    Text(
                      '${(_zoomScale * 100).round()}%',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 16),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Zoom in',
                      onPressed: () {
                        setState(() {
                          _zoomScale = (_zoomScale + 0.1).clamp(0.4, 1.3);
                        });
                      },
                    ),
                  ],
                ),

                // Primary Action: Download PDF
                ElevatedButton.icon(
                  icon: _isGeneratingPdf
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.download, size: 16),
                  label: const Text('Download PDF'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  onPressed: _isGeneratingPdf ? null : _handleDownloadPdf,
                ),
              ],
            ),
          ),

          // 2. EXPANDABLE CUSTOMIZATION PANEL (Font size, Margins, Font family)
          if (_showCustomizationPanel)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF131B2E) : const Color(0xFFF8FAFC),
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
                  ),
                ),
              ),
              child: Wrap(
                spacing: 24,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Font Size
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Text Size: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ChoiceChip(
                        label: const Text('Compact (90%)'),
                        selected: (widget.resume.fontSizeScale - 0.9).abs() < 0.05,
                        onSelected: (val) {
                          if (val) widget.onResumeChanged(widget.resume.copyWith(fontSizeScale: 0.9));
                        },
                      ),
                      const SizedBox(width: 4),
                      ChoiceChip(
                        label: const Text('Standard (100%)'),
                        selected: (widget.resume.fontSizeScale - 1.0).abs() < 0.05,
                        onSelected: (val) {
                          if (val) widget.onResumeChanged(widget.resume.copyWith(fontSizeScale: 1.0));
                        },
                      ),
                      const SizedBox(width: 4),
                      ChoiceChip(
                        label: const Text('Large (115%)'),
                        selected: (widget.resume.fontSizeScale - 1.15).abs() < 0.05,
                        onSelected: (val) {
                          if (val) widget.onResumeChanged(widget.resume.copyWith(fontSizeScale: 1.15));
                        },
                      ),
                    ],
                  ),

                  // Margins & Spacing
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Margins: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ChoiceChip(
                        label: const Text('Compact'),
                        selected: (widget.resume.spacingScale - 0.85).abs() < 0.05,
                        onSelected: (val) {
                          if (val) widget.onResumeChanged(widget.resume.copyWith(spacingScale: 0.85));
                        },
                      ),
                      const SizedBox(width: 4),
                      ChoiceChip(
                        label: const Text('Normal'),
                        selected: (widget.resume.spacingScale - 1.0).abs() < 0.05,
                        onSelected: (val) {
                          if (val) widget.onResumeChanged(widget.resume.copyWith(spacingScale: 1.0));
                        },
                      ),
                      const SizedBox(width: 4),
                      ChoiceChip(
                        label: const Text('Relaxed'),
                        selected: (widget.resume.spacingScale - 1.15).abs() < 0.05,
                        onSelected: (val) {
                          if (val) widget.onResumeChanged(widget.resume.copyWith(spacingScale: 1.15));
                        },
                      ),
                    ],
                  ),

                  // Font Family
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Font: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _fontFamilies.contains(widget.resume.fontFamily)
                                ? widget.resume.fontFamily
                                : 'Inter',
                            isDense: true,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                            items: _fontFamilies.map((f) {
                              return DropdownMenuItem<String>(
                                value: f,
                                child: Text(f),
                              );
                            }).toList(),
                            onChanged: (newFont) {
                              if (newFont != null) {
                                widget.onResumeChanged(widget.resume.copyWith(fontFamily: newFont));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // 3. LIVE DOCUMENT SCROLLER
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Center(
                child: Column(
                  children: [
                    // A4 Document Wrapper with visual page boundary simulation
                    Stack(
                      children: [
                        ResumeDocumentRenderer(
                          resume: widget.resume,
                          scale: _zoomScale,
                        ),
                        // Page 1 / Page 2 visual boundary indicator
                        Positioned(
                          top: 1123 * _zoomScale,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 1,
                            color: const Color(0xFFEF4444).withValues(alpha: 0.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  color: const Color(0xFFEF4444),
                                  child: const Text(
                                    'A4 Page 1 Boundary',
                                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Multi-page guidance hint
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Standard A4 Document Preview • Vector PDF automatically compiles across multiple pages without awkward splits',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDownloadPdf() async {
    setState(() => _isGeneratingPdf = true);
    try {
      await PdfService.downloadResumePdf(widget.resume);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Generated ${widget.resume.fullName.isNotEmpty ? widget.resume.fullName : "Resume"}.pdf successfully!',
            ),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate PDF: $e'),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGeneratingPdf = false);
      }
    }
  }
}
