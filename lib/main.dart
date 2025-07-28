import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shartflix/presentation/home/bloc/movie_bloc.dart';
import 'package:shartflix/presentation/main/main_screen.dart';
import 'package:shartflix/presentation/profile/bloc/profile_bloc.dart';
import 'core/utils/app_bloc_observer.dart';
import 'injection_container.dart' as di;
import 'presentation/auth/bloc/auth_bloc.dart';
import 'presentation/auth/pages/login_page.dart'; // Geçici olarak başlangıç

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized(); // Localization için
  await di.init(); // GetIt bağımlılık enjeksiyonu

  Bloc.observer = AppBlocObserver(); // Bloc event logger
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'auth_token');
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/lang', // assets/lang/en.json, tr.json
      fallbackLocale: const Locale('en'),
      child: ShartflixApp(isLoggedIn: token != null),
    ),
  );
}

class ShartflixApp extends StatelessWidget {
  final bool isLoggedIn;

  const ShartflixApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
        BlocProvider<ProfileBloc>(
          create: (_) => di.sl<ProfileBloc>(),
        ), // ✅ EKLE
        BlocProvider<MovieBloc>(create: (_) => di.sl<MovieBloc>()),
      ],
      child: MaterialApp(
        title: 'Shartflix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(), // Gerekirse custom theme entegre edilir
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home:
            isLoggedIn
                ? const MainScreen()
                : const LoginPage(), // ✅ Burada yönlendir
      ),
    );
  }
}
