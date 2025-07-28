import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/presentation/auth/widgets/custom_elevated_button.dart';
import 'package:shartflix/presentation/auth/widgets/custom_text_field.dart';
import 'package:shartflix/presentation/main/main_screen.dart';
import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/presentation/auth/bloc/auth_bloc.dart';
import 'package:shartflix/presentation/auth/bloc/auth_event.dart';
import 'package:shartflix/presentation/auth/bloc/auth_state.dart';
import 'package:shartflix/presentation/auth/pages/register_page.dart';
import 'package:shartflix/presentation/auth/widgets/social_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shartflix/core/theme/app_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: (Locale locale) {
              context.setLocale(locale);
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<Locale>>[
                  const PopupMenuItem<Locale>(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  const PopupMenuItem<Locale>(
                    value: Locale('tr'),
                    child: Text('Türkçe'),
                  ),
                ],
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is AuthSuccess) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("login_success".tr()),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "login_title".tr(),
                      style: const TextStyle(
                        fontFamily: AppStyles.euclidCircularA,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "login_description".tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppStyles.euclidCircularA,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      controller: _emailController,
                      hintKey: "email",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      hintKey: "password",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      obscureTextOverride: _obscurePassword,
                      onSuffixIconPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "forgot_password".tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 1.0,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomElevatedButton(
                      textKey: "login",
                      onPressed: () async {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        context.read<AuthBloc>().add(
                          LoginRequested(email: email, password: password),
                        );
                      },
                      isLoading: state is AuthLoading,
                    ),
                    const SizedBox(height: 24),
                    const SocialButtons(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "no_account".tr(),
                          style: const TextStyle(
                            fontFamily: AppStyles.euclidCircularA,
                            color: Colors.white70,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            "sign_up".tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: AppStyles.euclidCircularA,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
