import 'package:flutter/cupertino.dart';
import 'cdk_theme_notifier.dart';
import 'cdk_theme.dart';

class CDKButtonRadio extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final double size;
  final Widget child;

  const CDKButtonRadio({
    Key? key,
    this.isSelected = false,
    this.onSelected,
    this.size = 16.0,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CDKTheme theme = CDKThemeNotifier.of(context)!.changeNotifier;

    return GestureDetector(
      onTap: () {
        onSelected?.call(!isSelected);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: CDKButtonRadioPainter(
              colorAccent: theme.accent,
              colorAccent200: theme.accent200,
              colorBackgroundSecondary0: theme.backgroundSecondary0,
              isSelected: isSelected,
              hasAppFocus: theme.isAppFocused,
              size: size,
              isLightTheme: theme.isLight,
            ),
          ),
          const SizedBox(width: 4),
          Baseline(
            baseline: size / 1.5,
            baselineType: TextBaseline.alphabetic,
            child: child is Text
                ? Text(
                    (child as Text).data!,
                    style: (child as Text).style?.copyWith(fontSize: 14) ??
                        const TextStyle(fontSize: 14),
                  )
                : child,
          ),
        ],
      ),
    );
  }
}

class CDKButtonRadioPainter extends CustomPainter {
  final Color colorAccent;
  final Color colorAccent200;
  final Color colorBackgroundSecondary0;
  final bool isSelected;
  final bool hasAppFocus;
  final double size;
  final bool isLightTheme;

  CDKButtonRadioPainter({
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
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    Paint paint = Paint();

    // Outer circle
    paint.color = isLightTheme ? CDKTheme.grey : CDKTheme.grey600;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    canvas.drawCircle(center, radius, paint);

    // Inner circle (selected state)
    if (isSelected) {
      paint.color = CDKTheme.black;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(center, radius * 0.3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CDKButtonRadioPainter oldDelegate) {
    return oldDelegate.isSelected != isSelected ||
        oldDelegate.colorAccent != colorAccent ||
        oldDelegate.isLightTheme != isLightTheme;
  }
}
