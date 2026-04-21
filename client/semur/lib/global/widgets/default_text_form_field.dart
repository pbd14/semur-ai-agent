import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semur/global/app_colors.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final String hintText;
  final String? labelText;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final String? initialValue;

  const DefaultTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    required this.hintText,
    required this.labelText,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.initialValue,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: AppColors.secondaryColor,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      initialValue: initialValue,
      readOnly: readOnly,
      decoration: const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            hintText: hintText,
            labelText: labelText,
            hintStyle: TextStyle(
              color: AppColors.primaryColor.withValues(alpha: 0.7),
            ),
            labelStyle: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
    );
  }
}
