import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'cdk_theme_notifier.dart';
import 'cdk_theme.dart';
import 'package:flutter/material.dart';

// Copyright © 2023 Albert Palacios. All Rights Reserved.
// Licensed under the BSD 3-clause license, see LICENSE file for details.

class CDKFieldText extends StatefulWidget {
  final bool isRounded;
  final bool obscureText;
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? textSize;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final Function? onFocusChanged;
  final TextAlign textAlign;

  const CDKFieldText({
    Key? key,
    this.isRounded = false,
    this.obscureText = false,
    this.placeholder = '',
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.focusNode,
    this.textSize = 12,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.enabled = true,
    this.onFocusChanged,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  CDKFieldTextState createState() => CDKFieldTextState();
}

class CDKFieldTextState extends State<CDKFieldText> {
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_handleFocusChanged);
    _internalFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    setState(() {
      widget.onFocusChanged?.call(_internalFocusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    CDKTheme theme = CDKThemeNotifier.of(context)!.changeNotifier;
    return CustomPaint(
      painter: XPTextFieldPainter(),
      child: CupertinoTextField(
        textAlign: widget.textAlign,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        controller: widget.controller,
        focusNode: _internalFocusNode,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 4),
        decoration: BoxDecoration(
            border: Border.all(
          color: widget.enabled
              ? CDKTheme.grey200
              : theme.isLight
                  ? CDKTheme.grey70
                  : CDKTheme.grey700,
          width: 1,
        )),
        placeholder: widget.placeholder,
        style: TextStyle(
            fontSize: widget.textSize,
            color: widget.enabled
                ? theme.colorText
                : theme.isLight
                    ? CDKTheme.grey100
                    : CDKTheme.grey700),
        prefix: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, color: CDKTheme.grey),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}

class XPTextFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Bottom and right border (shadow)
    paint.color = Colors.grey[300]!;
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, size.height), paint);

    // Inner shadow line
    paint.strokeWidth = 1;
    paint.color = Colors.grey[500]!;
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
