import 'package:flutter/material.dart';
import '../utils/responsive_layout.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('¡Hola! Soy', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 10),
          Text(
            'Hivelts.',
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(color: AppTheme.primaryColor),
          ),
          Text(
            'Construyo aplicaciones web modernas.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: isMobile ? double.infinity : 600,
            child: Text(
              'Soy un desarrollador de software enfocado en crear experiencias digitales fluidas, '
              'escalables y visualmente impresionantes utilizando tecnologías como Flutter, Dart y Web.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: AppTheme.backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Contáctame',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
