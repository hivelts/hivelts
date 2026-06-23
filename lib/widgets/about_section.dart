import 'package:flutter/material.dart';
import '../utils/responsive_layout.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '01. Sobre Mí',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Hola, mi nombre es Hivelts y disfruto crear cosas que viven en internet. '
                  'Mi interés en el desarrollo web empezó cuando decidí probar crear una '
                  'aplicación interactiva...\n\n'
                  'Hoy en día, tengo el privilegio de construir software moderno y accesible. '
                  'Mi enfoque principal está en construir productos inclusivos y experiencias '
                  'digitales atractivas.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 50),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const Center(child: Text('Foto / Avatar')),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
