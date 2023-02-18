import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hint;
  final IconData? prefix;

  AppTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.hint,
    this.prefix,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  OutlineInputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppTheme.appColor(context).primary,
        ),
      );

  OutlineInputBorder get focusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppTheme.appColor(context).primary,
          width: 2,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: widget.prefix != null
            ? Icon(
                widget.prefix,
                color: AppTheme.appColor(context).primary,
              )
            : null,
        hintText: widget.hint,
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: border,
      ),
    );
  }
}
