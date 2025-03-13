import 'package:flutter/material.dart';
import 'package:jom_recycle/app_layout.dart';
import 'package:jom_recycle/common/theme/app_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:jom_recycle/common/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
      title: 'Jom Recycle',
      debugShowCheckedModeBanner: false,
      theme: context.watch<AppThemeProvider>().themeData,
      //Only trigger when system theme is dark mode
      darkTheme: AppTheme.darkTheme,
      home: const AppLayout(),
    );
  }
}
