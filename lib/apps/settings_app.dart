import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';
import '../core/os_state.dart';
import 'package:hivelts/l10n/generated/app_localizations.dart';

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final os = context.watch<OSState>().currentOS;
    switch (os) {
      case OS.windows:
        return const _WinSettings();
      case OS.linux:
        return const _LinuxSettings();
      default:
        return const _MacSettings();
    }
  }
}

// ─────────────────────────── macOS System Settings ───────────────────────────
class _MacSettings extends StatelessWidget {
  const _MacSettings();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final osState = context.watch<OSState>();
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Row(
        children: [
          Container(
            width: 220,
            color: const Color(0xFF2D2D2D),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.white38),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white38,
                        size: 18,
                      ),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Divider(color: Colors.white12, height: 24),
                _macSideItem(
                  Icons.manage_accounts,
                  l10n.aboutMe,
                  Colors.blue,
                  true,
                ),
                _macSideItem(Icons.code, l10n.skills, Colors.orange, false),
                _macSideItem(
                  Icons.color_lens,
                  l10n.appearance,
                  Colors.purple,
                  false,
                ),
                _macSideItem(Icons.wifi, 'Network', Colors.teal, false),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.aboutMe,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _macCard(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 36,
                          backgroundColor: Color(0xFF4C84FF),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Hivelts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          l10n.bioText,
                          style: const TextStyle(
                            color: Colors.white60,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _macCard(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.location,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          l10n.remoteGlobal,
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _macCard(_SettingsControls(osState: osState)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _macSideItem(IconData icon, String label, Color c, bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? Colors.blue.withValues(alpha: 0.25)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(icon, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _macCard(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

// ─────────────────────────── Windows 11 Settings ───────────────────────────
class _WinSettings extends StatelessWidget {
  const _WinSettings();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final osState = context.watch<OSState>();
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: Row(
        children: [
          Container(
            width: 240,
            color: const Color(0xFF252525),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Find a setting',
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white38,
                      size: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                _winNavItem(Icons.person, l10n.aboutMe, true),
                _winNavItem(Icons.code, l10n.skills, false),
                _winNavItem(Icons.palette, l10n.appearance, false),
                _winNavItem(Icons.wifi, 'Network & internet', false),
                _winNavItem(Icons.security, 'Privacy & security', false),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFF0078D4),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hivelts',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Software Developer',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _winCard(l10n.professionalProfile, l10n.bioText),
                  const SizedBox(height: 12),
                  _winCard(l10n.location, l10n.remoteGlobal),
                  const SizedBox(height: 12),
                  _winPanel(_SettingsControls(osState: osState)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _winNavItem(IconData icon, String label, bool selected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF0078D4).withValues(alpha: 0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: selected ? const Color(0xFF0078D4) : Colors.white60,
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white70,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _winCard(String title, String body) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(color: Colors.white60, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _winPanel(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: child,
    );
  }
}

// ─────────────────────────── Linux GNOME Settings ───────────────────────────
class _LinuxSettings extends StatelessWidget {
  const _LinuxSettings();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final osState = context.watch<OSState>();
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF2C001E),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Row(
              children: [
                Icon(Icons.settings, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 220,
                  child: ListView(
                    children: [
                      _gnomeNavItem(Icons.person, l10n.aboutMe, true),
                      _gnomeNavItem(Icons.code, l10n.skills, false),
                      _gnomeNavItem(Icons.color_lens, l10n.appearance, false),
                      _gnomeNavItem(Icons.wifi, 'Network', false),
                    ],
                  ),
                ),
                const VerticalDivider(color: Colors.white12, width: 1),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 48,
                          backgroundColor: Color(0xFFE95420),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Hivelts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.bioText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white60,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _gnomeCard(l10n.location, l10n.remoteGlobal),
                        const SizedBox(height: 16),
                        _gnomePanel(_SettingsControls(osState: osState)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gnomeNavItem(IconData icon, String label, bool selected) {
    return Container(
      color: selected
          ? const Color(0xFFE95420).withValues(alpha: 0.2)
          : Colors.transparent,
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: selected ? const Color(0xFFE95420) : Colors.white60,
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white60,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _gnomeCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A40),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value, style: const TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  Widget _gnomePanel(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A40),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      child: child,
    );
  }
}

class _SettingsControls extends StatelessWidget {
  final OSState osState;

  const _SettingsControls({required this.osState});

  @override
  Widget build(BuildContext context) {
    final isEnglish = osState.currentLocale.languageCode == 'en';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PortfolioOS v1.0',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: osState.isDarkMode,
          onChanged: (_) => osState.toggleThemeMode(),
          title: const Text(
            'Light / Dark',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            osState.isDarkMode ? 'Dark mode' : 'Light mode',
            style: const TextStyle(color: Colors.white54),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _choiceChip(
              label: 'ES',
              selected: !isEnglish,
              onTap: () => osState.setLocale(const Locale('es')),
            ),
            const SizedBox(width: 8),
            _choiceChip(
              label: 'EN',
              selected: isEnglish,
              onTap: () => osState.setLocale(const Locale('en')),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: osState.supportedSystems.map((system) {
            return _choiceChip(
              label: system.name,
              selected: osState.currentOS == system,
              onTap: () => osState.setOS(system),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _choiceChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF0A84FF)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? const Color(0xFF0A84FF) : Colors.white12,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
