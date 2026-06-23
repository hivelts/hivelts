import 'package:flutter_test/flutter_test.dart';

import 'package:hivelts/main.dart';

void main() {
  testWidgets('PortfolioOS boots into the desktop shell', (tester) async {
    await tester.pumpWidget(const PortfolioOSBootstrap());
    await tester.pump();

    expect(find.text('Hivelts'), findsOneWidget);
    expect(find.text('File'), findsOneWidget);
  });
}
