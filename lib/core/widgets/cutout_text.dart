part of 'widgets.dart';

class HollowChipPainterWidget extends StatelessWidget {
  final String text;
  final Color color;

  const HollowChipPainterWidget({
    super.key,
    required this.text,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ChipPainter(text: text, color: color),
      child: const SizedBox(
        width: 60,
        height: 30,
      ),
    );
  }
}

class _ChipPainter extends CustomPainter {
  final String text;
  final Color color;

  _ChipPainter({
    required this.text,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());

    // 🟩 fondo del chip
    final bgPaint = Paint()..color = color;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(8),
    );

    canvas.drawRRect(rrect, bgPaint);

    // ✍️ medir texto
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final offset = Offset(
      (size.width - tp.width) / 2,
      (size.height - tp.height) / 2,
    );

    // escribir texto (solo referencia de posición)
    tp.paint(canvas, offset);

    // 🕳️ BORRAR texto (hueco real)
    final clearPaint = Paint()
      ..blendMode = BlendMode.clear;

    canvas.drawRect(Offset.zero & size, clearPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ChipPainter oldDelegate) {
    return oldDelegate.text != text || oldDelegate.color != color;
  }
}