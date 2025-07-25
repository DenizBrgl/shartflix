import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/app_bloc_observer.dart';
import 'injection_container.dart' as di;
import 'presentation/auth/bloc/auth_bloc.dart';
import 'presentation/auth/pages/login_page.dart'; // Geçici olarak başlangıç

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized(); // Localization için
  await di.init(); // GetIt bağımlılık enjeksiyonu

  Bloc.observer = AppBlocObserver(); // Bloc event logger

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/lang', // assets/lang/en.json, tr.json
      fallbackLocale: const Locale('en'),
      child: const ShartflixApp(),
    ),
  );
}

class ShartflixApp extends StatelessWidget {
  const ShartflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
        // Diğer Bloc'lar buraya eklenir (HomeBloc, ProfileBloc vs.)
      ],
      child: MaterialApp(
        title: 'Shartflix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(), // Gerekirse custom theme entegre edilir
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: LoginPage(), // Geçici başlangıç sayfası
      ),
    );
  }
}
