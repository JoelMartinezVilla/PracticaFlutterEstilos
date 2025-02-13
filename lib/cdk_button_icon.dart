import 'package:flutter/cupertino.dart';
import 'cdk_theme_notifier.dart';
import 'cdk_theme.dart';
import 'package:flutter/material.dart';

// Copyright Â© 2023 Albert Palacios. All Rights Reserved.
// Licensed under the BSD 3-clause license, see LICENSE file for details.

class CDKButtonIcon extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final bool isCircle;
  final bool isSelected;

  const CDKButtonIcon({
    Key? key,
    this.onPressed,
    this.icon = CupertinoIcons.bell_fill,
    this.size = 24.0,
    this.isCircle = false,
    this.isSelected = false,
  }) : super(key: key);

  @override
  CDKButtonIconState createState() => CDKButtonIconState();
}

class CDKButtonIconState extends State<CDKButtonIcon> {
  bool _isPressed = false;
  bool _isHovering = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  void _onMouseEnter(PointerEvent details) {
    setState(() => _isHovering = true);
  }

  void _onMouseExit(PointerEvent details) {
    setState(() => _isHovering = false);
  }

  @override
  Widget build(BuildContext context) {
    CDKTheme theme = CDKThemeNotifier.of(context)!.changeNotifier;

    final Color backgroundColor = widget.isSelected
        ? (_isPressed ? Colors.red.shade900 : Colors.red)
        : theme.isLight
            ? _isPressed
                ? CDKTheme.grey70
                : _isHovering
                    ? CDKTheme.grey50
                    : CDKTheme.transparent
            : _isPressed
                ? CDKTheme.grey
                : _isHovering
                    ? CDKTheme.grey600
                    : CDKTheme.transparent;

    final Color textColor = widget.isSelected
        ? Colors.white
        : theme.isLight
            ? theme.colorText
            : theme.colorText;

    return MouseRegion(
      onEnter: _onMouseEnter,
      onExit: _onMouseExit,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: widget.isSelected ? Colors.blue : Colors.transparent,
                width: 2),
            gradient: widget.isSelected
                ? LinearGradient(
                    colors: _isPressed
                        ? [Colors.red.shade900, Colors.red.shade700]
                        : [Colors.red.shade700, Colors.redAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Container(
            width: widget.size,
            height: widget.size,
            alignment: Alignment.center,
            child: widget.isSelected
                ? Icon(Icons.close,
                    color: Colors.white, size: widget.size * 0.75)
                : Icon(widget.icon, color: textColor, size: widget.size * 0.75),
          ),
        ),
      ),
    );
  }
}
