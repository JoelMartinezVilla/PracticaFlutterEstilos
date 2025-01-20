import 'package:flutter/material.dart';
import 'cdk_theme_notifier.dart';
import 'cdk_theme.dart';

class CDKButtonCheckBox extends StatelessWidget {
  final bool value;
  final double size;
  final ValueChanged<bool>? onChanged;

  const CDKButtonCheckBox({
    Key? key,
    required this.value,
    this.onChanged,
    this.size = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CDKTheme themeManager = CDKThemeNotifier.of(context)!.changeNotifier;

    double boxSize = size;

    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: CustomPaint(
        size: Size(boxSize, boxSize),
        painter: CDKButtonCheckBoxPainter(
          colorAccent: themeManager.accent,
          colorAccent200: themeManager.accent200,
          colorBackgroundSecondary0: themeManager.backgroundSecondary0,
          isSelected: value,
          hasAppFocus: themeManager.isAppFocused,
          size: boxSize,
          isLightTheme: themeManager.isLight,
        ),
      ),
    );
  }
}

class CDKButtonCheckBoxPainter extends CustomPainter {
  final Color colorAccent;
  final Color colorAccent200;
  final Color colorBackgroundSecondary0;
  final bool isSelected;
  final bool hasAppFocus;
  final double size;

  final bool isLightTheme;

  CDKButtonCheckBoxPainter({
    required this.colorAccent,
    required this.colorAccent200,
    required this.colorBackgroundSecondary0,
    required this.isSelected,
    required this.hasAppFocus,
    required this.size,
    required this.isLightTheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Rect squareRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );

    Paint paint = Paint();

    // Fondo blanco
    paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFFFFFFF); // Blanco puro
    canvas.drawRect(squareRect, paint);

    // Borde azul
    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xFF003CA5); // Azul estilo XP
    canvas.drawRect(squareRect, borderPaint);

    // Tick verde
    if (isSelected) {
      Paint checkPaint = Paint()
        ..color = const Color(0xFF00FF00) // Verde para el tick
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      // Coordenadas del tick
      Offset startLine1 = Offset(size.width * 0.20, size.height * 0.50);
      Offset endLine1 = Offset(size.width * 0.40, size.height * 0.75);
      Offset startLine2 = Offset(size.width * 0.40, size.height * 0.75);
      Offset endLine2 = Offset(size.width * 0.80, size.height * 0.25);

      canvas.drawLine(startLine1, endLine1, checkPaint);
      canvas.drawLine(startLine2, endLine2, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CDKButtonCheckBoxPainter oldDelegate) {
    return oldDelegate.isSelected != isSelected;
  }
}
