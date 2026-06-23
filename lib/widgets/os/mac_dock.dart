import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/os_state.dart';
import '../../shared/widgets/portfolio_app_factory.dart';
import 'dart:ui';

class MacDock extends StatefulWidget {
  const MacDock({super.key});

  @override
  State<MacDock> createState() => _MacDockState();
}

class _MacDockState extends State<MacDock> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final os = context.watch<OSState>().currentOS;
    final apps = portfolioApps(context, os: os);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF333335).withValues(alpha: 0.60)
                    : Colors.white.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: isDark ? 0.10 : 0.30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(apps.length, (index) {
                  final app = apps[index];
                  final isHovered = _hoveredIndex == index;

                  return MouseRegion(
                    onEnter: (_) => setState(() => _hoveredIndex = index),
                    onExit: (_) => setState(() => _hoveredIndex = null),
                    child: GestureDetector(
                      onTap: () {
                        openPortfolioApp(context, app);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: isHovered ? 60 : 50,
                        height: isHovered ? 60 : 50,
                        decoration: BoxDecoration(
                          color: app.color,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isHovered
                              ? [
                                  BoxShadow(
                                    color: app.color.withValues(alpha: 0.5),
                                    blurRadius: 10,
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          app.icon,
                          color: Colors.white,
                          size: isHovered ? 35 : 30,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
