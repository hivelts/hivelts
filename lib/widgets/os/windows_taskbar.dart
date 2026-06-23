import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';
import '../../core/os_state.dart';
import '../../shared/widgets/portfolio_app_factory.dart';
import 'package:hivelts/l10n/generated/app_localizations.dart';
import 'dart:ui';

class WindowsTaskbar extends StatefulWidget {
  const WindowsTaskbar({super.key});

  @override
  State<WindowsTaskbar> createState() => _WindowsTaskbarState();
}

class _WindowsTaskbarState extends State<WindowsTaskbar> {
  bool _showStartMenu = false;
  bool _showQuickSettings = false;

  @override
  Widget build(BuildContext context) {
    final osState = context.watch<OSState>();
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();

    return Stack(
      children: [
        // ────────── Start Menu ──────────
        if (_showStartMenu)
          Positioned(bottom: 50, left: 0, right: 0, child: Center(child: _buildStartMenu(context, l10n, osState))),

        // ────────── Quick Settings Panel ──────────
        if (_showQuickSettings) Positioned(bottom: 50, right: 0, child: _buildQuickSettings(context, osState, l10n)),

        // ────────── Taskbar ──────────
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 48,
                color: const Color(0xCCEAEAEA),
                child: Row(
                  children: [
                    // ── Left: System tray ──
                    const SizedBox(width: 12),
                    _trayIcon(Icons.keyboard_arrow_up, () {}),
                    _trayIcon(Icons.wifi, () {}),
                    _trayIcon(Icons.volume_up, () {}),
                    _trayIcon(Icons.battery_full, () {}),

                    const Spacer(),

                    // ── Center: Start + Apps ──
                    _winBtn(Icons.grid_view_rounded, const Color(0xFF0078D4), () {
                      setState(() {
                        _showStartMenu = !_showStartMenu;
                        _showQuickSettings = false;
                      });
                    }, active: _showStartMenu),
                    const SizedBox(width: 4),
                    _winBtn(Icons.search, Colors.black87, () {}),
                    const SizedBox(width: 4),
                    _winBtn(Icons.storefront, Colors.black87, () {
                      openPortfolioApp(context, portfolioApps(context, os: osState.currentOS)[0]);
                      setState(() => _showStartMenu = false);
                    }),
                    const SizedBox(width: 4),
                    _winBtn(Icons.settings, Colors.black87, () {
                      openPortfolioApp(context, portfolioApps(context, os: osState.currentOS)[3]);
                      setState(() => _showStartMenu = false);
                    }),
                    const SizedBox(width: 4),
                    _winBtn(Icons.terminal, Colors.black87, () {
                      openPortfolioApp(context, portfolioApps(context, os: osState.currentOS)[4]);
                      setState(() => _showStartMenu = false);
                    }),

                    const Spacer(),

                    // ── Right: Clock + Quick Settings ──
                    GestureDetector(
                      onTap: () => setState(() {
                        _showQuickSettings = !_showQuickSettings;
                        _showStartMenu = false;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: _showQuickSettings ? Colors.black12 : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '${now.day}/${now.month}/${now.year}',
                              style: const TextStyle(color: Colors.black54, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ────────────────────── Start Menu ──────────────────────
  Widget _buildStartMenu(BuildContext context, AppLocalizations l10n, OSState osState) {
    final apps = portfolioApps(context, os: osState.currentOS);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          width: 620,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 40, offset: const Offset(0, 10)),
            ],
            border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4)],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.black38, size: 18),
                    SizedBox(width: 10),
                    Text('Type here to search', style: TextStyle(color: Colors.black38, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Pinned section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pinned',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black87),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('All apps ›', style: TextStyle(fontSize: 13, color: Color(0xFF0078D4))),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(spacing: 12, runSpacing: 16, children: apps.map((a) => _startMenuItem(context, a)).toList()),

              const Divider(height: 32, color: Colors.black12),

              // User info + power
              Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFF0078D4),
                    child: Icon(Icons.person, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Hivelts',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black87),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.power_settings_new, color: Colors.black54),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _startMenuItem(BuildContext context, PortfolioAppDefinition app) {
    return GestureDetector(
      onTap: () {
        openPortfolioApp(context, app);
        setState(() => _showStartMenu = false);
      },
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: app.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(app.icon, color: app.color, size: 26),
            ),
            const SizedBox(height: 6),
            Text(
              app.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // ────────────────────── Quick Settings ──────────────────────
  Widget _buildQuickSettings(BuildContext context, OSState osState, AppLocalizations l10n) {
    final isEn = osState.currentLocale.languageCode == 'en';

    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.88),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 20)],
            border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quick Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 16),

              // Toggle tiles
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _quickTile(Icons.wifi, 'Wi-Fi', true),
                  _quickTile(Icons.bluetooth, 'Bluetooth', true),
                  _quickTile(Icons.do_not_disturb_on, 'Focus', false),
                  _quickTile(Icons.airplanemode_active, 'Flight', false),
                ],
              ),

              const Divider(height: 24, color: Colors.black12),

              // Language switcher
              const Text(
                'Language',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _langBtn('🇬🇧 EN', isEn, () {
                    osState.setLocale(const Locale('en'));
                  }),
                  const SizedBox(width: 8),
                  _langBtn('🇪🇸 ES', !isEn, () {
                    osState.setLocale(const Locale('es'));
                  }),
                ],
              ),

              const Divider(height: 24, color: Colors.black12),

              // OS switcher
              const Text(
                'Switch OS',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _osChip('🍎 macOS', osState.currentOS == OS.macOS, () {
                    osState.setOS(OS.macOS);
                    setState(() => _showQuickSettings = false);
                  }),
                  const SizedBox(width: 6),
                  _osChip('🪟 Win', osState.currentOS == OS.windows, () {
                    osState.setOS(OS.windows);
                    setState(() => _showQuickSettings = false);
                  }),
                  const SizedBox(width: 6),
                  _osChip('Android', osState.currentOS == OS.android, () {
                    osState.setOS(OS.android);
                    setState(() => _showQuickSettings = false);
                  }),
                  const SizedBox(width: 6),
                  _osChip('iOS', osState.currentOS == OS.iOS, () {
                    osState.setOS(OS.iOS);
                    setState(() => _showQuickSettings = false);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickTile(IconData icon, String label, bool active) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0078D4).withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: active ? const Color(0xFF0078D4) : Colors.black54),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: active ? const Color(0xFF0078D4) : Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _langBtn(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0078D4) : Colors.black.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: active ? Colors.white : Colors.black54),
        ),
      ),
    );
  }

  Widget _osChip(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0078D4).withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: active ? Border.all(color: const Color(0xFF0078D4), width: 1.5) : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? const Color(0xFF0078D4) : Colors.black54,
          ),
        ),
      ),
    );
  }

  // ────────────────────── Helpers ──────────────────────
  Widget _winBtn(IconData icon, Color color, VoidCallback onTap, {bool active = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: active ? Colors.black12 : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
      ),
    );
  }

  Widget _trayIcon(IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(icon, color: Colors.black87, size: 18),
        ),
      ),
    );
  }
}
