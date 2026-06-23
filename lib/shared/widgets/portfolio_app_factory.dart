import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';
import 'package:hivelts/apps/settings_app.dart';
import 'package:hivelts/apps/terminal_app.dart';
import 'package:hivelts/core/os_state.dart';
import 'package:hivelts/features/portfolio/presentation/pages/contact_page.dart';
import 'package:hivelts/features/portfolio/presentation/pages/projects_page.dart';
import 'package:hivelts/features/portfolio/presentation/pages/resume_page.dart';
import 'package:hivelts/l10n/generated/app_localizations.dart';

class PortfolioAppDefinition {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final Widget content;

  const PortfolioAppDefinition({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
  });
}

List<PortfolioAppDefinition> portfolioApps(BuildContext context, {required OS os}) {
  final l10n = AppLocalizations.of(context)!;
  final storeTitle = os == OS.android
      ? 'Play Store'
      : os == OS.windows
      ? 'Microsoft Store'
      : l10n.appStore;

  return [
    PortfolioAppDefinition(
      id: 'projects',
      title: storeTitle,
      icon: Icons.storefront_rounded,
      color: os == OS.android ? const Color(0xFF34A853) : const Color(0xFF0A84FF),
      content: const ProjectsPage(),
    ),
    const PortfolioAppDefinition(
      id: 'resume',
      title: 'Resume',
      icon: Icons.picture_as_pdf_rounded,
      color: Color(0xFFE53935),
      content: ResumePage(),
    ),
    const PortfolioAppDefinition(
      id: 'contact',
      title: 'Contact',
      icon: Icons.mail_rounded,
      color: Color(0xFF5E5CE6),
      content: ContactPage(),
    ),
    PortfolioAppDefinition(
      id: 'settings',
      title: l10n.settings,
      icon: Icons.settings_rounded,
      color: const Color(0xFF8E8E93),
      content: const SettingsApp(),
    ),
    PortfolioAppDefinition(
      id: 'terminal',
      title: l10n.terminal,
      icon: Icons.terminal_rounded,
      color: const Color(0xFF111111),
      content: const TerminalApp(),
    ),
  ];
}

void openPortfolioApp(BuildContext context, PortfolioAppDefinition app) {
  context.read<OSState>().openApp(app.id, app.title, app.content, app.icon);
}
