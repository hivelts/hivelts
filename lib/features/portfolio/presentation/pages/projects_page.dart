import 'package:flutter/material.dart';

import '../widgets/portfolio_state_view.dart';
import '../widgets/portfolio_tokens.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return PortfolioStateView(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colors.surface,
          body: ListView(
            padding: const EdgeInsets.all(28),
            children: [
              const PortfolioSectionTitle(
                icon: Icons.apps_rounded,
                title: 'Projects Store',
              ),
              Wrap(
                spacing: 18,
                runSpacing: 18,
                children: state.portfolio!.projects.map((project) {
                  final accent = colorFromHex(project.accent);
                  return Container(
                    width: 250,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colors.outlineVariant.withValues(alpha: 0.45),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.widgets_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          project.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project.category,
                          style: TextStyle(color: colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 10),
                        Text(project.description),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project.technologies
                              .map(
                                (tech) =>
                                    PortfolioBadge(label: tech, color: accent),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Icon(Icons.star_rounded, color: accent, size: 18),
                            const SizedBox(width: 4),
                            Text(project.rating),
                            const Spacer(),
                            FilledButton(
                              onPressed: () {},
                              child: const Text('Open'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
