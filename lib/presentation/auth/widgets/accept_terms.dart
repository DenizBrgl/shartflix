import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shartflix/presentation/auth/widgets/custom_elevated_button.dart';
import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/core/theme/app_styles.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("terms_title".tr()),
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
          child: Center(
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "terms_conditions_heading".tr(),
                    style: AppStyles.montserratBold.copyWith(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "terms_content".tr(),
                  style: AppStyles.bodyText1.copyWith(color: AppColors.white70),
                ),
                const SizedBox(height: 24),
                Text(
                  "terms_continue_prompt".tr(),
                  style: AppStyles.bodyText1.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomElevatedButton(
          textKey: "accept_terms_button",
          onPressed: () => Navigator.pop(context, true),
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
        ),
      ),
    );
  }
}
