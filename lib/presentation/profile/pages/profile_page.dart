import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Profil Sayfası',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
//https://github.com/Yoga3911/flutter_bloc_clean_architecture/blob/master/lib/src/widgets/loading_widget.dart