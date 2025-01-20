import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cdk_theme_notifier.dart';

enum CDKButtonStyle { action, normal, destructive }

class CDKButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final CDKButtonStyle style;
  final bool isLarge;
  final bool enabled;

  const CDKButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.style = CDKButtonStyle.normal,
    this.isLarge = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  CDKButtonState createState() => CDKButtonState();
}

class CDKButtonState extends State<CDKButton> {
  static const double _fontSize = 13.0;
  bool _isPressed = false;
  bool _isHovering = false;

  // Paleta de colores inspirada en Windows XP (tema Luna).
  final Color _xpBorderColor = const Color(0xFF7F9DB9);
  final Color _xpGradientStart = const Color(0xFFF2F2F2);
  final Color _xpGradientEnd = const Color(0xFFDCDCDC);

  final Color _xpHoverStart = const Color(0xFFE2ECF6);
  final Color _xpHoverEnd = const Color(0xFFC5D9F1);

  final Color _xpPressedStart = const Color(0xFFBCD0EE);
  final Color _xpPressedEnd = const Color(0xFFA2C0E8);

  final Color _xpDisabledBorder = const Color(0xFFB6B6B6);
  final Color _xpDisabledFill = const Color(0xFFF5F5F5); // Color más claro

  // Color destructivo (rojo) para el botón de estilo destructivo.
  final Color _xpDestructiveColor = const Color(0xFFCC3333);

  @override
  Widget build(BuildContext context) {
    CDKThemeNotifier? notifier = CDKThemeNotifier.of(context);
    final bool isLightTheme = notifier?.changeNotifier.isLight ?? true;

    BoxDecoration decoration;
    Color textColor = Colors.black;

    if (widget.style == CDKButtonStyle.destructive && widget.enabled) {
      decoration = BoxDecoration(
        gradient: null,
        color: _xpDestructiveColor,
        border: Border.all(color: _xpBorderColor, width: 1.0),
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: _buildXpShadow(),
      );
      textColor = Colors.white;
    } else if (!widget.enabled) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [_xpDisabledFill, _xpDisabledFill],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: _xpDisabledBorder, width: 1.0),
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: _buildXpShadow(),
      );
      textColor = Colors.grey.shade700;
    } else if (_isPressed) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [_xpPressedStart, _xpPressedEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: _xpBorderColor, width: 1.0),
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: _buildXpShadow(),
      );
      textColor = Colors.black;
    } else if (_isHovering) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [_xpHoverStart, _xpHoverEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: _xpBorderColor, width: 1.0),
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: _buildXpShadow(),
      );
      textColor = Colors.black;
    } else {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [_xpGradientStart, _xpGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: _xpBorderColor, width: 1.0),
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: _buildXpShadow(),
      );
      textColor = (widget.style == CDKButtonStyle.destructive)
          ? Colors.white
          : Colors.black;
    }

    final TextStyle textStyle = TextStyle(
      fontSize: _fontSize,
      color: textColor,
      fontFamily: 'Segoe UI',
    );

    return MouseRegion(
      onEnter: (_) {
        if (widget.enabled && !_isPressed) {
          setState(() {
            _isHovering = true;
          });
        }
      },
      onExit: (_) {
        if (widget.enabled && !_isPressed) {
          setState(() {
            _isHovering = false;
          });
        }
      },
      child: GestureDetector(
        onTapDown: !widget.enabled
            ? null
            : (details) => setState(() {
                  _isPressed = true;
                  _isHovering = false;
                }),
        onTapUp: !widget.enabled
            ? null
            : (details) => setState(() {
                  _isPressed = false;
                }),
        onTapCancel:
            !widget.enabled ? null : () => setState(() => _isPressed = false),
        onTap: !widget.enabled ? null : widget.onPressed,
        child: IntrinsicWidth(
          child: DecoratedBox(
            decoration: decoration,
            child: Container(
              margin: const EdgeInsets.all(1.0),
              decoration: (_isHovering && widget.enabled && !_isPressed)
                  ? BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 3.0),
                      borderRadius: BorderRadius.circular(3.0),
                    )
                  : null,
              child: Padding(
                padding: widget.isLarge
                    ? const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
                    : const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: DefaultTextStyle(
                  style: textStyle,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BoxShadow> _buildXpShadow() {
    return [
      BoxShadow(
        color: Colors.white.withOpacity(0.6),
        offset: const Offset(-1, -1),
        blurRadius: 1,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        offset: const Offset(1, 1),
        blurRadius: 2,
        spreadRadius: 0,
      ),
    ];
  }
}
