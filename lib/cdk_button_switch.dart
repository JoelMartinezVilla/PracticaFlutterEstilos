import 'package:flutter/cupertino.dart';
import 'cdk_theme_notifier.dart';
import 'cdk_theme.dart';

class CDKButtonSwitch extends StatelessWidget {
  final bool value;
  final double size;
  final ValueChanged<bool>? onChanged;

  const CDKButtonSwitch({
    Key? key,
    required this.value,
    this.onChanged,
    this.size = 22.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CDKTheme theme = CDKThemeNotifier.of(context)!.changeNotifier;

    double backRadius = size * 6.0 / 24.0;
    double backHeight = size * 24.0 / 24.0;
    double backWidth = size * 50.0 / 24.0;
    double circleTop = size * 2.0 / 24.0;
    double circleMovement = size * 24.0 / 24.0;
    double circleSize = size * 20.0 / 24.0;

    final Color _xpGradientStart =
        value ? const Color(0xFF003CA5) : const Color(0xFFF2F2F2);
    final Color _xpGradientEnd =
        value ? const Color(0xFF0057D9) : const Color(0xFFDCDCDC);

    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: backHeight,
        width: backWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(backRadius),
          border: Border.all(color: const Color(0xFF003CA5), width: 1.5),
          gradient: LinearGradient(
            colors: [_xpGradientStart, _xpGradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              top: circleTop,
              left: value ? circleMovement : 2.0,
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(2),
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 51, 47, 47),
                      offset: Offset(1, 1),
                      blurRadius: 1.5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
