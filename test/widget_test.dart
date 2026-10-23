import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cvstudioo/main.dart';
import 'package:cvstudioo/pages/builder_page.dart';
import 'package:cvstudioo/pages/templates_page.dart';
import 'package:cvstudioo/pages/about_page.dart';
import 'package:cvstudioo/pages/contact_page.dart';
import 'package:cvstudioo/pages/privacy_page.dart';
import 'package:cvstudioo/pages/terms_page.dart';
import 'package:cvstudioo/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('CV Studio app loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CvStudioApp());
    await tester.pump();
    expect(find.text('CV Studio'), findsWidgets);
  });

  testWidgets('Templates Page displays template catalog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TemplatesPage(
          onToggleTheme: () {},
          isDark: false,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Templates'), findsWidgets);
  });

  testWidgets('Resume Builder starts with all fields empty by default', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final active = await StorageService.loadActiveResume();
    expect(active.fullName, isEmpty);
    expect(active.jobTitle, isEmpty);
    expect(active.email, isEmpty);
    expect(active.phone, isEmpty);
    expect(active.experience, isEmpty);
    expect(active.education, isEmpty);
    expect(active.technicalSkills, isEmpty);

    await tester.pumpWidget(
      MaterialApp(
        home: BuilderPage(
          onToggleTheme: () {},
          isDark: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ajil'), findsNothing);
    expect(find.text('demo@example.com'), findsNothing);
  });

  testWidgets('About Page displays mission, platform features, and navigation links', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AboutPage(
          onToggleTheme: () {},
          isDark: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Our Mission & Purpose'), findsOneWidget);
    expect(find.text('Who We Serve'), findsOneWidget);
    expect(find.text('Key Platform Features'), findsOneWidget);
  });

  testWidgets('Contact Page displays genuine email, contact form, and NO GitHub link', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContactPage(
          onToggleTheme: () {},
          isDark: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify contact header and official email
    expect(find.text('Contact CV Studio'), findsOneWidget);
    expect(find.text('ajilarun004@gmail.com'), findsOneWidget);

    // Verify GitHub link was removed as requested
    expect(find.textContaining('github.com'), findsNothing);

    // Verify form inputs
    expect(find.text('Send Us a Message'), findsOneWidget);
    expect(find.text('Send Message'), findsOneWidget);
  });

  testWidgets('Privacy Policy displays AdSense disclosures and does NOT contain the removed deletion card', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PrivacyPage(
          onToggleTheme: () {},
          isDark: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Privacy Policy'), findsWidgets);
    // Verify AdSense section is present
    expect(find.textContaining('Advertising, Google AdSense & Cookies Policy'), findsOneWidget);
    // Verify official contact email is present
    expect(find.textContaining('ajilarun004@gmail.com'), findsWidgets);
    // Verify the highlighted deletion card button is gone
    expect(find.text('Clear Locally Stored Resume Data'), findsNothing);
    expect(find.text('Clear All'), findsNothing);
  });

  testWidgets('Terms of Use displays legal terms, disclaimers, and contact email', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TermsPage(
          onToggleTheme: () {},
          isDark: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('1. Acceptance of Terms'), findsOneWidget);
    expect(find.textContaining('ajilarun004@gmail.com'), findsWidgets);
  });
}
