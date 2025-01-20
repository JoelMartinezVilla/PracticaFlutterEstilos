import 'package:flutter/material.dart';
import 'cdk_theme_notifier.dart';
import 'cdk_theme.dart';
import 'cdk_picker_check_list.dart';
import 'cdk_dialogs_manager.dart';
import 'cdk_dialog_popover.dart';

class CDKButtonSelect extends StatefulWidget {
  final int selectedIndex;
  final bool isFlat;
  final bool isTranslucent;
  final List<String> options;
  final Function(int)? onSelected;

  const CDKButtonSelect({
    Key? key,
    required this.selectedIndex,
    required this.options,
    this.isFlat = false,
    this.isTranslucent = false,
    this.onSelected,
  }) : super(key: key);

  @override
  CDKButtonSelectState createState() => CDKButtonSelectState();
}

class CDKButtonSelectState extends State<CDKButtonSelect> {
  static const double _fontSize = 12.0;
  bool _isMouseOver = false;
  final GlobalKey _globalKey = GlobalKey();

  /// Method to show a popover list when the button is tapped.
  _showPopover(BuildContext context) {
    final GlobalKey<CDKDialogPopoverState> key = GlobalKey();

    // Show popover with selectable options.
    CDKDialogsManager.showPopover(
      key: key,
      context: context,
      anchorKey: _globalKey,
      type: CDKDialogPopoverType.center,
      isAnimated: false,
      isTranslucent: widget.isTranslucent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CDKPickerCheckList(
          options: widget.options,
          selectedIndex: widget.selectedIndex,
          onSelected: (int index) {
            key.currentState?.hide();
            widget.onSelected?.call(index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CDKTheme theme = CDKThemeNotifier.of(context)!.changeNotifier;

    BoxDecoration decoration;
    TextStyle textStyle;

    // Define XP-style shadow
    BoxShadow shadow = BoxShadow(
      color: Colors.grey.shade600,
      offset: const Offset(1, 1),
      blurRadius: 2,
    );

    BoxShadow highlight = BoxShadow(
      color: Colors.white,
      offset: const Offset(-1, -1),
      blurRadius: 2,
    );

    // Apply different styles based on state.
    if (_isMouseOver || !widget.isFlat) {
      decoration = BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFBFDFFF), Color(0xFF80BFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.grey.shade800),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [highlight, shadow],
      );
    } else {
      decoration = BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey.shade600),
        borderRadius: BorderRadius.circular(4.0),
      );
    }

    textStyle = TextStyle(
      fontSize: _fontSize,
      color: Colors.black,
      fontFamily: 'Tahoma',
    );

    return MouseRegion(
      onEnter: (PointerEvent details) {
        setState(() {
          _isMouseOver = true;
        });
      },
      onExit: (PointerEvent details) {
        setState(() {
          _isMouseOver = false;
        });
      },
      child: GestureDetector(
        onTapDown: (details) => _showPopover(context),
        child: IntrinsicWidth(
          child: DecoratedBox(
            key: _globalKey,
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 3, 4, 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style: textStyle,
                    child: Text(widget.options[widget.selectedIndex]),
                  ),
                  const SizedBox(width: 5),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.grey.shade600),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: _fontSize * 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
