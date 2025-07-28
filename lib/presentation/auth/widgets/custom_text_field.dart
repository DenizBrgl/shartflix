import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shartflix/core/theme/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintKey;
  final IconData? prefixIcon;
  final bool isObscure;
  final TextInputType keyboardType;
  final Color? fillColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final TextStyle? hintTextStyle;
  final TextStyle? inputTextStyle;
  final String? Function(String?)? validator;

  final bool isPassword;
  final bool? obscureTextOverride;
  final VoidCallback? onSuffixIconPressed;
  final IconData? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintKey,
    this.prefixIcon,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 18.0,
    this.hintTextStyle,
    this.inputTextStyle,
    this.isPassword = false,
    this.obscureTextOverride,
    this.onSuffixIconPressed,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final bool effectiveObscureText =
        isPassword ? (obscureTextOverride ?? isObscure) : isObscure;

    return TextFormField(
      controller: controller,
      obscureText: effectiveObscureText,
      keyboardType: keyboardType,
      style:
          inputTextStyle ??
          AppStyles.euclidCircularARegular.copyWith(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintKey.tr(),
        hintStyle:
            hintTextStyle ??
            AppStyles.euclidCircularARegular.copyWith(color: Colors.white70),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.white70) : null,
        suffixIcon: _buildSuffixIcon(),
        filled: true,
        fillColor: fillColor ?? Colors.grey.shade900,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? Colors.white.withOpacity(0.3),
            width: borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? Colors.white,
            width: borderWidth,
          ),
        ),

        errorStyle: AppStyles.euclidCircularARegular.copyWith(
          color: Colors.redAccent,
          fontSize: 12,
        ),
      ),
      validator: validator,
    );
  }

  Widget? _buildSuffixIcon() {
    if (isPassword) {
      return IconButton(
        icon: Icon(
          (obscureTextOverride ?? false)
              ? Icons.visibility_off
              : Icons.visibility,
          color: Colors.white70,
        ),
        onPressed: onSuffixIconPressed,
      );
    } else if (suffixIcon != null) {
      return IconButton(
        icon: Icon(suffixIcon, color: Colors.white70),
        onPressed: onSuffixIconPressed,
      );
    }
    return null;
  }
}
