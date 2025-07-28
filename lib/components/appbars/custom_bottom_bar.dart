import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/core/theme/app_styles.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      decoration: const BoxDecoration(color: Colors.black),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              context: context,
              icon: Icons.home_outlined,
              labelKey: 'home',
              index: 0,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildTab(
              context: context,
              icon: Icons.person,
              labelKey: 'profile',
              index: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required IconData icon,
    required String labelKey,
    required int index,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.transparent : AppColors.transparent,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: AppColors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.white : AppColors.white,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              labelKey.tr(),
              style: AppStyles.euclidCircularAMedium.copyWith(
                color: isSelected ? AppColors.white : AppColors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
