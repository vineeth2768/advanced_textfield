library custom_textfield;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

/// A customizable text field with support for password, date, and time pickers.
class CustomTextField extends StatefulWidget {
  final double? height;
  final String? labelText;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final String? prefixIconSvg;
  final String? suffixIconSvg;
  final VoidCallback? onSuffixIconPressed;
  final bool? isDate;
  final bool? isTime;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final Color? spreadColor;
  final Color? fillColor;
  final ValueChanged<String>? onSubmitted;

  const CustomTextField({
    super.key,
    this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIconSvg,
    this.suffixIconSvg,
    this.onSuffixIconPressed,
    this.isDate = false,
    this.isTime = false,
    this.inputFormatters,
    this.maxLines = 1,
    this.borderRadius = 8.0,
    this.textInputAction,
    this.spreadColor,
    this.height,
    this.onSubmitted,
    this.fillColor = Colors.white,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      widget.controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      final now = DateTime.now();
      widget.controller.text = DateFormat('hh:mm a').format(
        DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: widget.spreadColor != null
            ? [
                BoxShadow(
                  color: widget.spreadColor!.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        cursorColor: Colors.blue,
        readOnly: widget.isDate == true || widget.isTime == true,
        onTap: () {
          if (widget.isDate == true) _selectDate(context);
          if (widget.isTime == true) _selectTime(context);
        },
        onFieldSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          prefixIcon: widget.prefixIconSvg != null
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(widget.prefixIconSvg!,
                      width: 24, height: 24),
                )
              : null,
          suffixIcon: _buildSuffixIcon(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
                color: isFocused ? Colors.blue : Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: Colors.grey,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    } else if (widget.suffixIconSvg != null) {
      return IconButton(
        icon: SvgPicture.asset(widget.suffixIconSvg!, width: 24, height: 24),
        onPressed: widget.onSuffixIconPressed,
      );
    } else if (widget.isDate == true) {
      return IconButton(
        icon: const Icon(Icons.calendar_today, color: Colors.grey, size: 18),
        onPressed: () => _selectDate(context),
      );
    } else if (widget.isTime == true) {
      return IconButton(
        icon: const Icon(Icons.access_time, color: Colors.grey, size: 22),
        onPressed: () => _selectTime(context),
      );
    }
    return null;
  }
}
