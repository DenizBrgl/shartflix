import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:shartflix/presentation/auth/bloc/auth_bloc.dart';
import 'package:shartflix/presentation/auth/bloc/auth_event.dart';
import 'package:shartflix/presentation/auth/bloc/auth_state.dart';
import 'package:shartflix/presentation/auth/widgets/accept_terms.dart';
import 'package:shartflix/presentation/auth/widgets/custom_elevated_button.dart';
import 'package:shartflix/presentation/auth/widgets/custom_text_field.dart';
import 'package:shartflix/presentation/auth/widgets/social_buttons.dart';
import 'package:shartflix/core/network/network_info.dart';

import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/core/theme/app_styles.dart';

final sl = GetIt.instance;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final hasConnection = await sl<INetworkInfo>().isConnected;
    if (!hasConnection) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("no_connection".tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("passwords_not_match".tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("accept_terms_warning".tr()),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
      RegisterRequested(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  void _navigateToTermsPage() async {
    final bool? accepted = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TermsPage()),
    );

    if (accepted != null) {
      setState(() {
        _termsAccepted = accepted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      "register_title".tr(),
                      style: AppStyles.loginTitleStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'register_description'.tr(),
                      style: AppStyles.bodyText1.copyWith(
                        color: AppColors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    CustomTextField(
                      controller: _nameController,
                      hintKey: 'name',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'name_empty_error'.tr() : null,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _emailController,
                      hintKey: 'email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email_empty_error'.tr();
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'invalid_email_error'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _passwordController,
                      hintKey: 'password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      obscureTextOverride: _obscurePassword,
                      onSuffixIconPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password_empty_error'.tr();
                        }
                        if (value.length < 6) {
                          return 'password_min_length_error'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintKey: 'confirm_password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      obscureTextOverride: _obscureConfirmPassword,
                      onSuffixIconPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'confirm_password_empty_error'.tr();
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _termsAccepted = newValue ?? false;
                            });
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>((
                            Set<MaterialState> states,
                          ) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.primary;
                            }
                            return Colors.white54;
                          }),
                          checkColor: AppColors.white,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: _navigateToTermsPage,
                            child: Text.rich(
                              TextSpan(
                                text: 'terms_part1'.tr(),
                                style: AppStyles.bodyText1.copyWith(
                                  color: AppColors.white70,
                                  fontSize: 13,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'terms_part2'.tr(),
                                    style: AppStyles.montserratBold.copyWith(
                                      color: AppColors.white,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.white,
                                      decorationThickness: 1.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'terms_part3'.tr(),
                                    style: AppStyles.bodyText1.copyWith(
                                      color: AppColors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("register_success".tr()),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return CustomElevatedButton(
                          textKey: "signup_button",
                          onPressed: () => _onRegisterPressed(context),
                          isLoading: state is AuthLoading,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    SocialButtons(),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "already_have_account".tr(),
                          style: AppStyles.bodyText1.copyWith(
                            color: AppColors.white70,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "go_login".tr(),
                            style: AppStyles.montserratBold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
