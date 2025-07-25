import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kullanıcı Sözleşmesi"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
          child: Center(
            child: ListView(
              children: const [
                Center(
                  child: Text(
                    "Şartlar ve Koşullar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Bu uygulamayı kullanarak aşağıdaki şartları kabul etmiş olursunuz. "
                  "Verileriniz gizli tutulur. Kullanım amacı dışında kullanılmaz. "
                  "Detaylı bilgi ve tüm şartlar için lütfen uygulama geliştiricisi ile iletişime geçiniz.",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 24),
                Text(
                  "Devam etmek için lütfen aşağıdaki butona tıklayın.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Kabul Ediyorum"),
        ),
      ),
    );
  }
}
