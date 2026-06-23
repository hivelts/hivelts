import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';
import '../../core/os_state.dart';
import 'dart:ui';
import 'package:hivelts/l10n/generated/app_localizations.dart';

class MacMenuBar extends StatelessWidget {
  const MacMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    final osState = context.watch<OSState>();
    final isEn = osState.currentLocale.languageCode == 'en';
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.black.withValues(alpha: 0.45),
            child: Row(
              children: [
                // Left: Apple logo + App menus
                const Icon(Icons.apple, color: Colors.white, size: 15),
                const SizedBox(width: 16),
                const Text(
                  'Hivelts',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(width: 16),
                _menu('File'),
                _menu('View'),
                _menu('Help'),
                const Spacer(),

                // Right: Language pill (visible!) + OS switcher + icons + clock
                // Language switcher — always visible as a pill
                _langPill(isEn ? 'EN' : 'ES', () {
                  osState.setLocale(Locale(isEn ? 'es' : 'en'));
                }),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: osState.toggleThemeMode,
                  child: Icon(osState.isDarkMode ? Icons.dark_mode : Icons.light_mode, color: Colors.white, size: 15),
                ),
                const SizedBox(width: 10),

                // OS switcher icon
                PopupMenuButton<OS>(
                  tooltip: l10n.changeOS,
                  icon: const Icon(Icons.devices, color: Colors.white, size: 15),
                  color: const Color(0xFF2D2D2D),
                  onSelected: (v) => osState.setOS(v),
                  itemBuilder: (_) => osState.supportedSystems.map((system) => _osItem(system.name, system)).toList(),
                ),

                const Icon(Icons.wifi, color: Colors.white, size: 14),
                const SizedBox(width: 10),
                const Icon(Icons.battery_full, color: Colors.white, size: 14),
                const SizedBox(width: 10),
                Text(
                  '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menu(String label) => Padding(
    padding: const EdgeInsets.only(right: 14),
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
  );

  Widget _langPill(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  PopupMenuItem<OS> _osItem(String label, OS value) {
    return PopupMenuItem<OS>(
      value: value,
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
    );
  }
}
