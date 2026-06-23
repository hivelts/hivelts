import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';

import '../../core/os_state.dart';
import '../../shared/widgets/portfolio_app_factory.dart';

class MobileShell extends StatelessWidget {
  final OS platform;

  const MobileShell({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    final osState = context.watch<OSState>();
    final apps = portfolioApps(context, os: platform);
    final isIos = platform == OS.iOS;
    final primary = isIos ? const Color(0xFF0A84FF) : const Color(0xFF34A853);

    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isIos
                    ? const [Color(0xFF1C1C1E), Color(0xFF263B5E), Color(0xFF101014)]
                    : const [Color(0xFF101915), Color(0xFF193C32), Color(0xFF080C0A)],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      platform.name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    const Spacer(),
                    _PillButton(
                      label: osState.currentLocale.languageCode.toUpperCase(),
                      onTap: () => osState.setLocale(Locale(osState.currentLocale.languageCode == 'en' ? 'es' : 'en')),
                    ),
                    const SizedBox(width: 8),
                    _IconPill(
                      icon: osState.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      onTap: osState.toggleThemeMode,
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<OS>(
                      tooltip: 'Switch OS',
                      icon: const Icon(Icons.devices_rounded, color: Colors.white),
                      color: const Color(0xFF242428),
                      onSelected: osState.setOS,
                      itemBuilder: (_) => osState.supportedSystems
                          .map(
                            (system) => PopupMenuItem(
                              value: system,
                              child: Text(system.name, style: const TextStyle(color: Colors.white)),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 18,
                    physics: const NeverScrollableScrollPhysics(),
                    children: apps.map((app) {
                      return _MobileAppIcon(app: app, primary: primary, onTap: () => openPortfolioApp(context, app));
                    }).toList(),
                  ),
                ),
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(isIos ? 28 : 18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: Container(
                    width: isIos ? 170 : 220,
                    height: isIos ? 5 : 48,
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: isIos ? 0.75 : 0.14),
                      borderRadius: BorderRadius.circular(isIos ? 28 : 18),
                    ),
                    child: isIos
                        ? null
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.arrow_back_rounded, color: Colors.white),
                              Icon(Icons.circle_outlined, color: Colors.white),
                              Icon(Icons.crop_square_rounded, color: Colors.white),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileAppIcon extends StatelessWidget {
  final PortfolioAppDefinition app;
  final Color primary;
  final VoidCallback onTap;

  const _MobileAppIcon({required this.app, required this.primary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: app.id == 'projects' ? primary : app.color,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.22), blurRadius: 16, offset: const Offset(0, 8)),
              ],
            ),
            child: Icon(app.icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            app.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PillButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white24),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class _IconPill extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconPill({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
