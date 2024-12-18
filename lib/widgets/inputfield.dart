import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'divider.dart';

class AnswerInputWidget extends StatefulWidget {
  final String hintText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextInputType? keyboardType;
  final Function(String) onChanged;
  final bool? filled;
  final int? maxLines;
  final int? maxLength;
  final bool isCenter;
  final bool? hasDivider;
  final Color? dividerColor;
  final double? dividerThickness;
  final Icon? rightIcon;
  final TextEditingController? controller;
  final bool? enabled;
  final FocusNode? focusNode;
  const AnswerInputWidget({
    super.key,
    required this.hintText,
    this.fontSize = 18,
    this.fontWeight,
    this.textColor,
    this.keyboardType,
    required this.onChanged,
    this.filled,
    this.maxLines,
    this.isCenter = true,
    this.hasDivider = true,
    this.dividerColor,
    this.dividerThickness,
    this.maxLength,
    this.rightIcon,
    this.controller,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<AnswerInputWidget> createState() => _AnswerInputWidgetState();
}

class _AnswerInputWidgetState extends State<AnswerInputWidget> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(); // Use provided controller or create a new one
    _controller.addListener(onTextChanged);
  }

  void onTextChanged() {
    widget.onChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    // var hasDivider = true;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _controller,
          focusNode: widget.focusNode,
          autofocus: false,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          obscureText: false,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            counterText: '',
            isDense: true,
            hintStyle: GoogleFonts.nunito(
                color: widget.textColor ?? Colors.white,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight),
            hintText: widget.hintText,
            filled: widget.filled,
            border: InputBorder.none,
            suffixIcon: widget.rightIcon,
          ),
          textAlign: widget.isCenter ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.nunito(
              color: widget.textColor ?? Colors.white,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight),
        ),
        if (widget.hasDivider!)
          DividerWidget(
            thickness: widget.dividerThickness ?? 2,
            color: widget.dividerColor ?? Colors.green,
            padding: EdgeInsets.zero,
          )
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.removeListener(onTextChanged);
      _controller.dispose();
    }
    super.dispose();
  }
}
