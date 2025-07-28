import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/core/theme/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? textKey;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double verticalPadding;
  final double borderRadius;
  final double? height;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key,
    this.textKey,
    this.child,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.verticalPadding = 14.0,
    this.borderRadius = 18.0,
    this.height = 50.0,
    this.textStyle,
  }) : assert(
         textKey != null || child != null,
         'textKey or child must be provided.',
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child:
            isLoading
                ? const CircularProgressIndicator(color: AppColors.white)
                : _buildButtonChild(context),
      ),
    );
  }

  Widget _buildButtonChild(BuildContext context) {
    if (child != null) {
      return child!;
    } else if (textKey != null) {
      return Text(
        textKey!.tr(),
        style:
            textStyle ??
            AppStyles.euclidCircularAMedium.copyWith(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 12.0,
            ),
      );
    }
    return const SizedBox.shrink();
  }
}
