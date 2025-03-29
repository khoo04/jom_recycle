import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'firebase_options.dart';
import 'package:jom_recycle/common/theme/app_theme_provider.dart';
import 'package:jom_recycle/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:jom_recycle/common/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppThemeProvider>(
            create: (context) => AppThemeProvider()),
        //TODO: ADD PROVIDER IF NEEDS
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        title: 'Jom Recycle',
        debugShowCheckedModeBanner: false,
        theme: context.watch<AppThemeProvider>().themeData,
        //Only trigger when system theme is dark mode
        darkTheme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
