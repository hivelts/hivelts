import 'package:flutter/material.dart';
import 'package:hivelts/core/extensions.dart';
import 'package:hivelts/core/widgets/widgets.dart';
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
    final s = AppLocalizations.of(context)!;
    final now = DateTime.now();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: context.isDark
                ? const Color(0xFF333335).withValues(alpha: 0.60)
                : Colors.white.withValues(alpha: 0.10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Apple logo + App menus
                Icon(Icons.apple, color: context.darkOrLightColor, size: 20),
                const SizedBox(width: 16),
                MenuText('Hivelts OS'),
                const SizedBox(width: 16),
                MenuText(s.file),
                MenuText(s.view),
                MenuText(s.help),
                const Spacer(),
                LangPill(),

                const SizedBox(width: 10),
                GestureDetector(
                  onTap: osState.toggleThemeMode,
                  child: Icon(
                    osState.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: context.darkOrLightColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),

                // OS switcher icon
                PopupMenuButton<OS>(
                  tooltip: s.changeOS,
                  icon: Icon(Icons.devices, color: context.darkOrLightColor, size: 18),
                  onSelected: (v) => osState.setOS(v),
                  itemBuilder: (_) => osState.supportedSystems.map((system) => _osItem(system.name, system)).toList(),
                ),
                Text("100%", style: TextTheme.of(context).labelMedium),
                Transform.rotate(
                  angle: 90 * 3.14 / 180,
                  child: Icon(Icons.battery_std_sharp, color: context.darkOrLightColor, size: 18),
                ),
                const SizedBox(width: 10),
                Icon(Icons.wifi, color: context.darkOrLightColor, size: 18),
                const SizedBox(width: 10),
                Icon(Icons.search, color: context.darkOrLightColor, size: 18),
                const SizedBox(width: 10),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, _) {
                    return MenuText(now.hourAmPm, padding: EdgeInsets.zero);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<OS> _osItem(String label, OS value) {
    return PopupMenuItem<OS>(value: value, child: Text(label));
  }
}

class MenuText extends StatelessWidget {
  const MenuText(this.label, {super.key, this.padding = const EdgeInsets.only(right: 14)});

  final String label;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(label, style: TextTheme.of(context).labelMedium),
    );
  }
}

class LangPill extends StatelessWidget {
  const LangPill({super.key});

  @override
  Widget build(BuildContext context) {
    final osState = context.watch<OSState>();
    final textTheme = Theme.of(context).textTheme;

    final chipColor = (context.isDark ? Colors.white : Colors.black).withValues(alpha: 0.70);
    return GestureDetector(
      onTap: () => osState.localeSwitchEnEs(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: ShaderMask(
          blendMode: BlendMode.srcOut,
          shaderCallback: (bounds) {
            return LinearGradient(colors: [chipColor, chipColor]).createShader(bounds);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(osState.currentLocale.languageCode.toUpperCase(), style: textTheme.labelMedium),
          ),
        ),
      ),
    );
  }
}
