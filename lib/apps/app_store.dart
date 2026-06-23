import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';
import '../core/os_state.dart';
import 'package:hivelts/l10n/generated/app_localizations.dart';

class AppStore extends StatelessWidget {
  const AppStore({super.key});

  @override
  Widget build(BuildContext context) {
    final os = context.watch<OSState>().currentOS;
    switch (os) {
      case OS.windows:
        return const _MicrosoftStore();
      case OS.linux:
        return const _UbuntuSoftware();
      default:
        return const _MacAppStore();
    }
  }
}

// ─────────────────────────── Datos compartidos ───────────────────────────
final _projects = [
  _Project(
    'E-Commerce App',
    'Flutter & Firebase',
    Icons.shopping_bag,
    const Color(0xFFFF6B35),
    '★ 4.9',
  ),
  _Project(
    'Fitness Tracker',
    'Health & Productivity',
    Icons.fitness_center,
    const Color(0xFF00C896),
    '★ 4.7',
  ),
  _Project(
    'Crypto Wallet',
    'Web3 & Blockchain',
    Icons.currency_bitcoin,
    const Color(0xFF9B59B6),
    '★ 4.8',
  ),
  _Project(
    'AI Chat App',
    'Gemini AI',
    Icons.smart_toy,
    const Color(0xFF4285F4),
    '★ 5.0',
  ),
];

class _Project {
  final String name, subtitle, rating;
  final IconData icon;
  final Color color;
  const _Project(this.name, this.subtitle, this.icon, this.color, this.rating);
}

// ─────────────────────────── macOS App Store ───────────────────────────
class _MacAppStore extends StatelessWidget {
  const _MacAppStore();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Row(
        children: [
          Container(
            width: 180,
            color: const Color(0xFFEEEEEE),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _macSideHeader('Discover'),
                _macSideItem(Icons.star_rounded, l10n.featuredProjects, true),
                _macSideItem(Icons.phone_iphone, 'Mobile', false),
                _macSideItem(Icons.web, 'Web', false),
                const Divider(height: 24, indent: 16, endIndent: 16),
                _macSideHeader('Library'),
                _macSideItem(Icons.download_done, 'Installed', false),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(32),
              children: [
                Text(
                  l10n.featuredProjects,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D1D1F),
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: _projects.map((p) => _macCard(p)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _macSideHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF888888),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _macSideItem(IconData icon, String label, bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: selected
            ? Colors.blue.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          size: 18,
          color: selected ? Colors.blue : Colors.black54,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.blue : const Color(0xFF1D1D1F),
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _macCard(_Project p) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: p.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(p.icon, size: 36, color: p.color),
          ),
          const SizedBox(height: 14),
          Text(
            p.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D1D1F),
            ),
          ),
          Text(
            p.subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 8),
          Text(
            p.rating,
            style: TextStyle(color: p.color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.withValues(alpha: 0.1),
                foregroundColor: Colors.blue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('GET'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Microsoft Store (Windows) ───────────────────────────
class _MicrosoftStore extends StatelessWidget {
  const _MicrosoftStore();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: Row(
        children: [
          Container(
            width: 220,
            color: const Color(0xFF252525),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Microsoft Store',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _winNavItem(Icons.home, 'Home', true),
                _winNavItem(Icons.apps, 'Apps', false),
                _winNavItem(Icons.videogame_asset, 'Gaming', false),
                _winNavItem(Icons.movie, 'Entertainment', false),
                const Divider(color: Colors.white12, height: 24),
                _winNavItem(Icons.download, 'Library', false),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Featured',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.featuredProjects,
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: _projects.map((p) => _winCard(p)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _winNavItem(IconData icon, String label, bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF0078D4).withValues(alpha: 0.25)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: selected ? const Color(0xFF0078D4) : Colors.white54,
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

  Widget _winCard(_Project p) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: p.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(p.icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 12),
          Text(
            p.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            p.subtitle,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 8),
          Text(
            p.rating,
            style: const TextStyle(color: Color(0xFFFFBD2E), fontSize: 12),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0078D4),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text('Get', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Ubuntu Software Center ───────────────────────────
class _UbuntuSoftware extends StatelessWidget {
  const _UbuntuSoftware();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Column(
        children: [
          // Top bar
          Container(
            color: const Color(0xFF2C001E),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _ubuntuTab('All', true),
                _ubuntuTab('Editors\' Picks', false),
                _ubuntuTab('Installed', false),
                const Spacer(),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search apps…',
                      hintStyle: const TextStyle(color: Colors.white38),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white38,
                        size: 18,
                      ),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  l10n.featuredProjects,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ..._projects.map((p) => _ubuntuCard(p)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ubuntuTab(String label, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE95420) : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  Widget _ubuntuCard(_Project p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A40),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: p.color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(p.icon, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  p.subtitle,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  p.rating,
                  style: const TextStyle(
                    color: Color(0xFFE95420),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE95420),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text('Install'),
          ),
        ],
      ),
    );
  }
}
