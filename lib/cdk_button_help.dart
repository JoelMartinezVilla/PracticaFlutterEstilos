import 'package:flutter/material.dart';

class CDKButtonHelp extends StatefulWidget {
  final double size;
  final VoidCallback? onPressed;

  const CDKButtonHelp({
    Key? key,
    this.onPressed,
    this.size =
        48.0, // Tamaño predeterminado más grande para parecerse al de XP
  }) : super(key: key);

  @override
  CDKButtonHelpState createState() => CDKButtonHelpState();
}

class CDKButtonHelpState extends State<CDKButtonHelp> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _isPressed
              ? const Color(0xFF004F9A)
              : const Color(0xFF0078D7), // Azul oscuro al presionar
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
              color: Colors.white, width: widget.size * 0.1), // Aro blanco
        ),
        child: Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          child: Text(
            '?',
            style: TextStyle(
              fontSize: widget.size / 1.5,
              color: Colors.white, // Interrogación blanca
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
