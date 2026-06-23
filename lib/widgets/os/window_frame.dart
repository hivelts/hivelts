import 'package:flutter/material.dart';
import 'package:hivelts/utils/enums.dart';
import 'package:provider/provider.dart';
import '../../core/os_state.dart';

class WindowFrame extends StatelessWidget {
  final OSWindow window;

  const WindowFrame({super.key, required this.window});

  @override
  Widget build(BuildContext context) {
    final osState = context.watch<OSState>();
    final currentOS = osState.currentOS;

    if (window.isMinimized) return const SizedBox.shrink();

    final width = window.isFullscreen ? MediaQuery.of(context).size.width : window.size.width;
    final height = window.isFullscreen ? MediaQuery.of(context).size.height - 30 : window.size.height;
    final top = window.isFullscreen ? 30.0 : window.position.dy;
    final left = window.isFullscreen ? 0.0 : window.position.dx;

    // Colores y radios por OS
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color titleBarColor = _titleBarColor(currentOS, isDark);
    final BorderRadius radius = window.isFullscreen
        ? BorderRadius.zero
        : BorderRadius.circular(currentOS == OS.macOS ? 12 : 8);

    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTapDown: (_) => context.read<OSState>().focusWindow(window.id),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: radius,
            boxShadow: window.isFocused
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))],
            border: Border.all(
              color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            children: [
              _buildTitleBar(context, currentOS, titleBarColor, radius),
              Expanded(
                child: ClipRRect(
                  borderRadius: window.isFullscreen
                      ? BorderRadius.zero
                      : BorderRadius.vertical(bottom: Radius.circular(currentOS == OS.macOS ? 12 : 8)),
                  child: window.content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _titleBarColor(OS os, bool isDark) {
    switch (os) {
      case OS.windows:
        return const Color(0xFF202020);
      case OS.android:
        return const Color(0xFF153D32);
      case OS.iOS:
        return const Color(0xFF2C2C2E);
      case OS.linux:
        return const Color(0xFF2C001E);
      default: // macOS
        return isDark ? const Color(0xFF1B1B1D) : const Color(0xFFFCF8FB);
    }
  }

  Widget _buildTitleBar(BuildContext context, OS os, Color barColor, BorderRadius radius) {
    final osPanUpdate = window.isFullscreen
        ? null
        : (DragUpdateDetails details) {
            context.read<OSState>().updateWindowPosition(window.id, window.position + details.delta);
          };

    return GestureDetector(
      onPanUpdate: osPanUpdate,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: barColor,
          borderRadius: window.isFullscreen
              ? BorderRadius.zero
              : BorderRadius.vertical(top: radius.topLeft == Radius.zero ? Radius.zero : radius.topLeft),
        ),
        child: os == OS.macOS
            ? _buildMacTitleBar(context)
            : os == OS.windows
            ? _buildWindowsTitleBar(context)
            : os == OS.android || os == OS.iOS
            ? _buildMobileTitleBar(context, os)
            : _buildLinuxTitleBar(context),
      ),
    );
  }

  // ──────────────────────── macOS ────────────────────────
  Widget _buildMacTitleBar(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        _macBtn(const Color(0xFFFF5F57), Icons.close, () => context.read<OSState>().closeWindow(window.id)),
        const SizedBox(width: 8),
        _macBtn(const Color(0xFFFFBD2E), Icons.minimize, () => context.read<OSState>().toggleMinimize(window.id)),
        const SizedBox(width: 8),
        _macBtn(const Color(0xFF28C840), Icons.fullscreen, () => context.read<OSState>().toggleFullscreen(window.id)),
        Expanded(
          child: Text(
            window.title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 60),
      ],
    );
  }

  Widget _macBtn(Color color, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }

  // ──────────────────────── Windows 11 ────────────────────────
  Widget _buildWindowsTitleBar(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Icon(window.icon, color: Colors.white70, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(window.title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ),
        _winBtn(
          Icons.remove,
          Colors.transparent,
          Colors.white,
          () => context.read<OSState>().toggleMinimize(window.id),
        ),
        _winBtn(
          window.isFullscreen ? Icons.fullscreen_exit : Icons.crop_square,
          Colors.transparent,
          Colors.white,
          () => context.read<OSState>().toggleFullscreen(window.id),
        ),
        _winBtn(Icons.close, Colors.red, Colors.white, () => context.read<OSState>().closeWindow(window.id)),
      ],
    );
  }

  Widget _winBtn(IconData icon, Color hoverBg, Color iconColor, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 46,
          height: 32,
          color: icon == Icons.close ? const Color(0xFFE81123).withValues(alpha: 0.0) : Colors.transparent,
          child: Icon(icon, color: iconColor, size: 16),
        ),
      ),
    );
  }

  // ──────────────────────── Linux / Ubuntu ────────────────────────
  Widget _buildLinuxTitleBar(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Text(
          window.title,
          style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        _linuxBtn(Icons.remove, const Color(0xFF555555), () => context.read<OSState>().toggleMinimize(window.id)),
        const SizedBox(width: 4),
        _linuxBtn(
          Icons.crop_square,
          const Color(0xFF555555),
          () => context.read<OSState>().toggleFullscreen(window.id),
        ),
        const SizedBox(width: 4),
        _linuxBtn(Icons.close, const Color(0xFFE95420), () => context.read<OSState>().closeWindow(window.id)),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildMobileTitleBar(BuildContext context, OS os) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Icon(window.icon, color: Colors.white70, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            window.title,
            style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        _linuxBtn(
          Icons.remove,
          Colors.white.withValues(alpha: 0.16),
          () => context.read<OSState>().toggleMinimize(window.id),
        ),
        const SizedBox(width: 4),
        _linuxBtn(
          window.isFullscreen ? Icons.fullscreen_exit : Icons.open_in_full,
          os == OS.android ? const Color(0xFF34A853) : const Color(0xFF0A84FF),
          () => context.read<OSState>().toggleFullscreen(window.id),
        ),
        const SizedBox(width: 4),
        _linuxBtn(Icons.close, const Color(0xFFFF453A), () => context.read<OSState>().closeWindow(window.id)),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _linuxBtn(IconData icon, Color bg, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 12),
        ),
      ),
    );
  }
}
