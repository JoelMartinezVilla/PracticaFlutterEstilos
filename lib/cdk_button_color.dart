import 'package:flutter/cupertino.dart';
import 'cdk.dart';

// Copyright © 2023 Albert Palacios. All Rights Reserved.
// Licensed under the BSD 3-clause license, see LICENSE file for details.

class CDKButtonColor extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color color;
  final bool enabled;

  const CDKButtonColor({
    Key? key,
    this.onPressed,
    required this.color,
    this.enabled = true,
  }) : super(key: key);

  @override
  CDKButtonColorState createState() => CDKButtonColorState();
}

class CDKButtonColorState extends State<CDKButtonColor> {
  // Flag to track if the button is currently pressed.
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    CDKTheme theme = CDKThemeNotifier.of(context)!.changeNotifier;
    Color colorBorder = const Color(0xFF003CA5); // Borde estilo Windows XP

    // Define styles and themes based on the button's state and style.
    BoxDecoration decoration;

    // Sombra del botón.
    BoxShadow shadow = BoxShadow(
      color: CDKTheme.black.withOpacity(0.1),
      spreadRadius: 0,
      blurRadius: 1,
      offset: const Offset(0, 1),
    );

    // Definición del estilo del botón.
    decoration = BoxDecoration(
      color: theme.backgroundSecondary0,
      border: Border.all(color: colorBorder, width: 2), // Borde azul
      boxShadow: [shadow],
    );

    return GestureDetector(
      onTapDown: !widget.enabled
          ? null
          : (details) => setState(() => _isPressed = true),
      onTapUp: !widget.enabled
          ? null
          : (details) => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        child: SizedBox(
          width: 24,
          height: 24,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: decoration,
                child: ClipRect(
                  child: CustomPaint(
                    painter: CDKUtilShaderGrid(7),
                    child: Container(
                      color: widget.color, // Color de fondo del botón.
                    ),
                  ),
                ),
              ),
              // Contenedor del borde azul.
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorBorder, width: 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
