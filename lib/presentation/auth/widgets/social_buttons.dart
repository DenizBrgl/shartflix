import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .center, // ✅ Burası değişti: Butonları merkeze toplar
      children: const [
        SocialButton(icon: Icons.g_mobiledata), // Google icon
        SizedBox(width: 6), // ✅ Bu boşluklar artık daha etkili olacak
        SocialButton(icon: Icons.apple), // Apple icon
        SizedBox(width: 6),
        SocialButton(icon: Icons.facebook), // Facebook icon
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;

  const SocialButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color.fromARGB(76, 255, 255, 255),
          width: 1,
        ),
      ),
      child: Center(child: Icon(icon, color: Colors.white, size: 30)),
    );
  }
}
