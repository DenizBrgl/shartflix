import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SocialButton(icon: Icons.g_mobiledata),
        SizedBox(width: 16),
        SocialButton(icon: Icons.apple),
        SizedBox(width: 16),
        SocialButton(icon: Icons.facebook),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;

  const SocialButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade900,
      radius: 22,
      child: Icon(icon, color: Colors.white),
    );
  }
}
