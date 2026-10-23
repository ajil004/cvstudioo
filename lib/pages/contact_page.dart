import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';

class ContactPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const ContactPage({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _submittedSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    // Simulate sending client-side message
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _submittedSuccess = true;
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you! Your message has been sent. We will respond promptly.'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 850;

    return Scaffold(
      appBar: AppNavbar(
        activeRoute: '/contact',
        onToggleTheme: widget.onToggleTheme,
        isDark: widget.isDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Page Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 64,
                vertical: 48,
              ),
              color: widget.isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'SUPPORT & INQUIRIES',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2563EB),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Contact CV Studio',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.w900,
                          color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 640),
                        child: Text(
                          'Have questions, template recommendations, or feedback? We are here to help and continuously improve the CV Studio experience.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content Area: Contact Details & Message Form
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 64,
                vertical: 48,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Wrap(
                    spacing: 48,
                    runSpacing: 40,
                    children: [
                      // Left Column: Direct Contact Information Card
                      SizedBox(
                        width: isMobile ? double.infinity : 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Direct Contact Channels',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Reach out directly via email for inquiries, bug reports, and partnership opportunities.',
                              style: TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.5),
                            ),
                            const SizedBox(height: 24),

                            // Official Email Card
                            _contactCard(
                              icon: Icons.email_outlined,
                              title: 'Official Email',
                              value: 'ajilarun004@gmail.com',
                              actionLabel: 'Copy Email',
                              onAction: () {
                                Clipboard.setData(const ClipboardData(text: 'ajilarun004@gmail.com'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Email copied to clipboard!')),
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            // Operating Hours Card
                            _contactCard(
                              icon: Icons.schedule_outlined,
                              title: 'Support Hours',
                              value: 'Monday – Friday\n9:00 AM – 6:00 PM IST',
                              actionLabel: null,
                              onAction: null,
                            ),
                            const SizedBox(height: 16),

                            // Response Time Card
                            _contactCard(
                              icon: Icons.reply_outlined,
                              title: 'Response Time',
                              value: 'Typically within 24–48 business hours.',
                              actionLabel: null,
                              onAction: null,
                            ),
                            const SizedBox(height: 24),

                            // Privacy Note
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: widget.isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: widget.isDark ? const Color(0xFF334155) : const Color(0xFFBFDBFE),
                                ),
                              ),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.info_outline, color: Color(0xFF2563EB), size: 20),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'CV Studio respects candidate privacy. Contact messages are never shared or used for marketing.',
                                      style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xFF1E40AF)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right Column: Interactive Contact Form
                      SizedBox(
                        width: isMobile ? double.infinity : 520,
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: widget.isDark ? const Color(0xFF131B2E) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: widget.isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Send Us a Message',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Fill out the form below and we will get back to you as soon as possible.',
                                  style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                                ),
                                const SizedBox(height: 20),

                                if (_submittedSuccess) ...[
                                  Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFECFDF5),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFA7F3D0)),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.check_circle, color: Color(0xFF059669), size: 20),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'Message submitted successfully! Thank you for contacting CV Studio.',
                                            style: TextStyle(fontSize: 13, color: Color(0xFF065F46), fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                ],

                                // Name Field
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Full Name *',
                                    hintText: 'e.g. Alex Morgan',
                                    prefixIcon: Icon(Icons.person_outline, size: 20),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Email Field
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'Email Address *',
                                    hintText: 'e.g. alex@example.com',
                                    prefixIcon: Icon(Icons.email_outlined, size: 20),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!value.contains('@') || !value.contains('.')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Subject Field
                                TextFormField(
                                  controller: _subjectController,
                                  decoration: const InputDecoration(
                                    labelText: 'Subject *',
                                    hintText: 'e.g. Template Request / Feedback / Bug Report',
                                    prefixIcon: Icon(Icons.subject_outlined, size: 20),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter a subject';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Message Field
                                TextFormField(
                                  controller: _messageController,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    labelText: 'Message *',
                                    hintText: 'Write your message or inquiry here...',
                                    alignLabelWithHint: true,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter your message';
                                    }
                                    if (value.trim().length < 10) {
                                      return 'Message must be at least 10 characters long';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 24),

                                // Submit Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    icon: _isSubmitting
                                        ? const SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                          )
                                        : const Icon(Icons.send, size: 18),
                                    label: Text(_isSubmitting ? 'Sending...' : 'Send Message'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2563EB),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    onPressed: _isSubmitting ? null : _handleSubmit,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _contactCard({
    required IconData icon,
    required String title,
    required String value,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF131B2E) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF2563EB), size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                if (actionLabel != null && onAction != null) ...[
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: onAction,
                    child: Text(
                      actionLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
