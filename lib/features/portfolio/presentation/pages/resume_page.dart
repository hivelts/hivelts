import 'package:flutter/material.dart';

import '../../domain/entities/portfolio.dart';
import '../widgets/portfolio_state_view.dart';
import '../widgets/portfolio_tokens.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PortfolioStateView(
      builder: (context, state) {
        final portfolio = state.portfolio;
        final profile = portfolio!.profile;

        return Scaffold(
          backgroundColor: isDark
              ? colors.surfaceContainerLow.withValues(alpha: 0.8)
              : colors.surface.withValues(alpha: 0.72),
          body: Row(
            children: [
              Container(
                width: 224,
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
                decoration: BoxDecoration(
                  color: isDark
                      ? colors.surfaceContainerLowest.withValues(alpha: 0.46)
                      : colors.surfaceContainerLow.withValues(alpha: 0.52),
                  border: Border(right: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.35))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: TextStyle(color: colors.primary, fontSize: 20, fontWeight: FontWeight.w900, height: 1.15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.role,
                      style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 28),
                    _SidebarItem(icon: Icons.person_rounded, label: 'Sobre mi', selected: true),
                    const _SidebarItem(icon: Icons.work_rounded, label: 'Experiencia'),
                    const _SidebarItem(icon: Icons.bolt_rounded, label: 'Tecnologias'),
                    const _SidebarItem(icon: Icons.school_rounded, label: 'Educacion'),
                    const _SidebarItem(icon: Icons.mail_rounded, label: 'Contacto'),
                    const Spacer(),
                    _AvailabilityCard(location: profile.location, availability: profile.availability),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 40),
                  children: [
                    _IntroSection(profile: profile),
                    const SizedBox(height: 34),
                    const PortfolioSectionTitle(icon: Icons.work_rounded, title: 'Experiencia Profesional'),
                    ...portfolio.experience.map(
                      (job) => _TimelineItem(
                        title: job.role,
                        subtitle: job.company,
                        trailing: job.period,
                        bullets: job.highlights,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const PortfolioSectionTitle(icon: Icons.bolt_rounded, title: 'Tecnologias'),
                    _GlassPanel(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mobile & State Management',
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: portfolio.skills
                                .map((skill) => PortfolioBadge(label: skill, color: colors.primary))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    const PortfolioSectionTitle(icon: Icons.school_rounded, title: 'Educacion'),
                    ...portfolio.education.map(
                      (education) => _GlassPanel(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        education.degree,
                                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        education.institution,
                                        style: TextStyle(
                                          color: colors.primary,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PortfolioBadge(label: education.status, color: colors.primary),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'Certificaciones Relevantes',
                              style: TextStyle(
                                color: colors.onSurfaceVariant,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...education.certifications.map((item) => _Bullet(text: item)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    _ContactPanel(email: profile.email, phone: profile.phone),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IntroSection extends StatelessWidget {
  final Profile profile;

  const _IntroSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 112,
          height: 112,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.75),
              width: 4,
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 24, offset: const Offset(0, 12)),
            ],
          ),
          child: const Icon(Icons.person_rounded, color: Colors.white, size: 58),
        ),
        const SizedBox(width: 26),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, height: 1.12)),
              const SizedBox(height: 8),
              Text(
                profile.role,
                style: TextStyle(color: colors.primary, fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 14),
              Text(profile.summary, style: TextStyle(color: colors.onSurfaceVariant, fontSize: 16, height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _SidebarItem({required this.icon, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? colors.primary.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: selected ? colors.primary : colors.onSurfaceVariant),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: selected ? colors.primary : colors.onSurfaceVariant,
              fontSize: 12,
              fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailabilityCard extends StatelessWidget {
  final String location;
  final String availability;

  const _AvailabilityCard({required this.location, required this.availability});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.10) : Colors.white.withValues(alpha: 0.42)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_rounded, color: colors.primary, size: 16),
              const SizedBox(width: 6),
              Text(
                location.toUpperCase(),
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 10, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            availability,
            style: TextStyle(
              color: colors.onSurfaceVariant.withValues(alpha: 0.8),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final List<String> bullets;

  const _TimelineItem({required this.title, required this.subtitle, required this.trailing, required this.bullets});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(left: 8, bottom: 24),
      padding: const EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: colors.primary.withValues(alpha: 0.24), width: 2)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -27,
            top: 2,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: colors.surface, width: 2),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          style: TextStyle(color: colors.primary, fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.38),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      trailing,
                      style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...bullets.map((item) => _Bullet(text: item)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: colors.primary)),
          Expanded(
            child: Text(text, style: TextStyle(color: colors.onSurfaceVariant, height: 1.35, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  final Widget child;

  const _GlassPanel({required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? colors.surfaceContainer.withValues(alpha: 0.92) : Colors.white.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.48)),
        boxShadow: [
          BoxShadow(color: colors.shadow.withValues(alpha: 0.05), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: child,
    );
  }
}

class _ContactPanel extends StatelessWidget {
  final String email;
  final String phone;

  const _ContactPanel({required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: isDark ? colors.primaryContainer : colors.primary,
        borderRadius: BorderRadius.circular(18),
        border: isDark ? Border.all(color: Colors.white.withValues(alpha: 0.05)) : null,
        boxShadow: [
          BoxShadow(color: colors.primary.withValues(alpha: 0.22), blurRadius: 24, offset: const Offset(0, 12)),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '¿Trabajamos juntos?',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          const Text(
            'Contactame para nuevos proyectos o colaboraciones.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 18),
          _ContactRow(icon: Icons.mail_rounded, text: email, action: 'Enviar Email'),
          const SizedBox(height: 10),
          _ContactRow(icon: Icons.chat_rounded, text: phone, action: 'WhatsApp', accent: const Color(0xFF25D366)),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String action;
  final Color? accent;

  const _ContactRow({required this.icon, required this.text, required this.action, this.accent});

  @override
  Widget build(BuildContext context) {
    final color = accent ?? Colors.white;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
            child: Text(
              action,
              style: TextStyle(
                color: accent == null ? const Color(0xFF0058BC) : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
