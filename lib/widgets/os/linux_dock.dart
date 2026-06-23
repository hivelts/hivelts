import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/os_state.dart';
import '../../apps/app_store.dart';
import '../../apps/settings_app.dart';
import '../../apps/terminal_app.dart';
import 'package:hivelts/l10n/generated/app_localizations.dart';

class LinuxDock extends StatelessWidget {
  const LinuxDock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final apps = [
      {
        'id': 'appstore',
        'title': l10n.appStore,
        'icon': Icons.storefront,
        'color': Colors.orangeAccent,
      },
      {
        'id': 'settings',
        'title': l10n.settings,
        'icon': Icons.settings,
        'color': Colors.grey,
      },
      {
        'id': 'terminal',
        'title': l10n.terminal,
        'icon': Icons.terminal,
        'color': Colors.black,
      },
    ];

    return Positioned(
      top: 30, // Debajo de una barra superior
      bottom: 0,
      left: 0,
      child: Container(
        width: 60,
        color: const Color(0xFF2C001E).withValues(alpha: 0.9), // Ubuntu purple
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Apps
            ...apps.map((app) {
              return InkWell(
                onTap: () {
                  context.read<OSState>().openApp(
                    app['id'] as String,
                    app['title'] as String,
                    _getAppContent(app['id'] as String),
                    app['icon'] as IconData,
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    app['icon'] as IconData,
                    color: app['color'] as Color,
                    size: 30,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _getAppContent(String id) {
    switch (id) {
      case 'appstore':
        return const AppStore();
      case 'settings':
        return const SettingsApp();
      case 'terminal':
        return const TerminalApp();
      default:
        return const Center(child: Text('App no encontrada'));
    }
  }
}

class LinuxTopBar extends StatelessWidget {
  const LinuxTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final osState = context.watch<OSState>();
    final isEn = osState.currentLocale.languageCode == 'en';
    final l10n = AppLocalizations.of(context)!;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 30,
        color: const Color(0xFF111111).withValues(alpha: 0.95),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ubuntu',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatTime(DateTime.now()),
              style: const TextStyle(color: Colors.white),
            ),
          /*  PopupMenuButton<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 20,
              ),
              color: const Color(0xFF2D2D2D),
              onSelected: (value) {
                if (value == 'en' || value == 'es') {
                  osState.setLocale(Locale(value));
                } else {
                  osState.setOS(value);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: isEn ? 'es' : 'en',
                  child: Text(
                    l10n.changeLanguage,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'macOS',
                  child: Text(
                    'macOS',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                PopupMenuItem(
                  value: 'Windows',
                  child: Text(
                    'Windows',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.month}/${time.day} ${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}
